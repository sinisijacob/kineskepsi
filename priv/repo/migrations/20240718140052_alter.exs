defmodule Kineskepsi.Repo.Migrations.Alter do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :title, :text
      add :blurb, :string
      modify :body, :text
      # TODO:
      # Thumbnail
      # Tags
    end
  end
end
