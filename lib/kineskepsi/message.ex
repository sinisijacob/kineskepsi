defmodule Kineskepsi.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Kineskepsi.Repo

  schema "messages" do
    field :message, :string
    belongs_to :user, Kineskepsi.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message, :user_id])
    |> validate_required([:message, :user_id])
  end

  def recent_messages(limit \\ 10) do
    Repo.all(Kineskepsi.Message, limit: limit)
      |> Repo.preload(:user)
  end
end
