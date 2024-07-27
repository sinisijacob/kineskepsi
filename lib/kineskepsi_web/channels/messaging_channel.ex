defmodule KineskepsiWeb.MessagingChannel do
  use KineskepsiWeb, :channel
  alias Kineskepsi.Message

  @impl true
  def join("messaging:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (messaging:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    user_id = socket.assigns.current_user.id
    payload = payload
      |> Map.put("user_id", user_id)
      |> Map.put("name", "User " <> to_string(user_id))
    spawn(fn -> save_message(payload) end)
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    Message.recent_messages()
      |> Enum.each(fn msg -> push(socket, "shout", %{
        name: "User " <> to_string(msg.user_id),
        message: msg.message
      }) end)
    {:noreply, socket}
  end

  defp save_message(message) do
    Message.changeset(%Message{}, message)
      |> Kineskepsi.Repo.insert
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    # TODO: add actual auth here.
    # Probably needs an actual payload to come in with token and channel
    # Then need to verify that user has access to that channel
    true
  end
end
