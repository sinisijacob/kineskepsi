defmodule Kineskepsi.Repo.Migrations.CreateUsersToChatRooms do
  use Ecto.Migration

  def change do
    create table(:users_to_chat_rooms) do
      add :user_id, references(:users, on_delete: :nothing)
      add :chat_room_uuid, references(:chat_rooms, type: :uuid, column: :id, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:users_to_chat_rooms, [:user_id])
    create index(:users_to_chat_rooms, [:chat_room_uuid])
  end
end
