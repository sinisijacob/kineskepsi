defmodule Kineskepsi.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Kineskepsi.Accounts.User

  schema "posts" do
    field :body, :string
    field :likes_count, :integer, default: 0
    field :repost_count, :integer, default: 0
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:body, :user_id])
    |> validate_required([:body, :user_id])
    |> validate_length(:body, min: 5, max: 200)
  end
end
