defmodule Kineskepsi.MessagesToChatRooms do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages_to_chat_rooms" do

    field :message_id, :id
    field :chat_room_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(messages_to_chat_rooms, attrs) do
    messages_to_chat_rooms
    |> cast(attrs, [])
    |> validate_required([])
  end
end
