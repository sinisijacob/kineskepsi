defmodule Kineskepsi.UsersToChatRooms do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users_to_chat_rooms" do

    belongs_to :user, Kineskepsi.Accounts.User
    belongs_to :chat_room, Kineskepsi.ChatRoom

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(users_to_chat_rooms, attrs) do
    users_to_chat_rooms
    |> cast(attrs, [])
    |> validate_required([])
  end
end
