defmodule Kineskepsi.ChatRoom do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Kineskepsi.Repo

  @primary_key {:uuid, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :uuid}

  schema "chat_rooms" do
    field :name, :string
    has_many :users_to_chat_rooms, Kineskepsi.UsersToChatRooms
    has_many :users,
      through: [:users_to_chat_rooms, :user]
    has_one :post, Kineskepsi.Post

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(chat_room, attrs) do
    chat_room
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def assert_chatroom(chat_opener_id, post_id) do
    # need to see if there's already a chat room that contains:
    # the current user
    # the post identified by the id
    # user can chat with themselves?
    query = from c in ChatRoom,
              join: p in assoc(c, :post),
              join: u_t_c in assoc(c, :users_to_chat_rooms),
              join: u in assoc(u_t_c, :user),
              where:
                p.id == ^post_id and
                u.id == ^chat_opener_id
    cr = Repo.one(query)
    if cr == nil do
      # user = Accounts.get_user!(attrs["user_id"])

      # %ChatRoom{}
      # |> Post.changeset(attrs)
      # |> Ecto.Changeset.put_assoc(:user, user)
      # |> Repo.insert()
      # |> broadcast(:saved)
    end
  end
end
