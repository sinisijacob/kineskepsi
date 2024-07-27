defmodule Kineskepsi.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :blurb, :string
    field :body, :string
    field :likes_count, :integer, default: 0
    field :repost_count, :integer, default: 0
    belongs_to :user, Kineskepsi.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :blurb, :body, :user_id])
    |> validate_required([:title, :blurb, :body, :user_id])
    |> validate_length(:title, min: 5, max: 50)
    |> validate_length(:blurb, min: 50, max: 500)
    |> validate_length(:body, min: 500, max: 80000)
  end
end
