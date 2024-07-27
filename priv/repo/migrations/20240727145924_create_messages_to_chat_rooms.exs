defmodule Kineskepsi.Repo.Migrations.CreateMessagesToChatRooms do
  use Ecto.Migration

  def change do
    create table(:messages_to_chat_rooms) do
      add :message_id, references(:messages, on_delete: :nothing)
      add :chat_room_id, references(:chat_rooms, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:messages_to_chat_rooms, [:message_id])
    create index(:messages_to_chat_rooms, [:chat_room_id])
  end
end
