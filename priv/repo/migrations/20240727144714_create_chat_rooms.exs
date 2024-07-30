defmodule Kineskepsi.Repo.Migrations.CreateChatRooms do
  use Ecto.Migration

  def change do
    create table(:chat_rooms, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :post_id, references(:posts)

      timestamps(type: :utc_datetime)
    end
  end
end
