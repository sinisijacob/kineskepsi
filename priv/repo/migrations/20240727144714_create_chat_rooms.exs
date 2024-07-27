defmodule Kineskepsi.Repo.Migrations.CreateChatRooms do
  use Ecto.Migration

  def change do
    create table(:chat_rooms) do
      add :name, :string
      add :uuid, :binary

      timestamps(type: :utc_datetime)
    end
  end
end
