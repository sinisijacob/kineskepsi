defmodule KineskepsiWeb.PostLive.Index do
  use KineskepsiWeb, :live_view

  alias KineskepsiWeb.UserAuth
  alias Kineskepsi.Timeline
  alias Kineskepsi.Timeline.Post
  alias Kineskepsi.Accounts
  alias Kineskepsi.Accounts.User

  @impl true
  def mount(_params, %{"user_token" => user_token}, socket) do
    if connected?(socket), do: Timeline.subscribe()
    socket = socket
      |> assign(:user_token, user_token)
      |> assign(:current_user, Accounts.get_user_by_session_token(user_token))
    {:ok, stream(socket, :posts, Timeline.list_posts())}
  end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Timeline.subscribe()
    {:ok, stream(socket, :posts, Timeline.list_posts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:post, Timeline.get_post!(id))
  end

  defp apply_action(socket, :new, _params) do
    %User{id: user_id} = socket.assigns.current_user

    socket
    |> assign(:page_title, "New Post")
    |> assign(:user_id, user_id)
    |> assign(:post, %Post{user_id: user_id})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Recent Posts")
    |> assign(:post, nil)
  end

  # TODO: Why do we need both of these handle_infos? That seems wrong.
  @impl true
  def handle_info({KineskepsiWeb.PostLive.FormComponent, {:saved, post}}, socket) do
    {:noreply, stream_insert(socket, :posts, post)}
  end

  @impl true
  def handle_info({:saved, post}, socket) do
    {:noreply, stream_insert(socket, :posts, post)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Timeline.get_post!(id)
    {:ok, _} = Timeline.delete_post(post)

    {:noreply, stream_delete(socket, :posts, post)}
  end

  @impl true
  def handle_event("open_chat", %{"id" => id}, socket) do


    {:noreply, push_event(socket, "open_chat_window", %{id: "foo"})}
  end
end
