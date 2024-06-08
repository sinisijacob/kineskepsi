defmodule KineskepsiWeb.PostLive.PostComponent do
  use KineskepsiWeb, :live_component

  def render(assigns) do
    ~H"""
    <div id={"post-" <> Integer.to_string(@post.id)} class="post">
      <div class="row">
        <div class="column column-10">
          <div class="post-avatar"></div>
          </div>
        </div>
        <div class="column column-90 post-body">
          <b>@<%= @post.username %></b> - <%= if @post.inserted_at === @post.updated_at do @post.inserted_at else @post.updated_at end%>
          <br/>
          <div class="post-body">
            <%= @post.body %>
          </div>
          <nav class="level is-mobile">
            <div class="level-left">
              <a class="level-item" phx-click="repost" phx-target="{@myself}">
                <span class="icon is-small"><i class="fas fa-arrows-retweet"></i><%= @post.repost_count %></span>
              </a>
              <a class="level-item" phx-click="like" phx-target="{@myself}">
                <span class="icon is-small"><i class="fas fa-heart"></i><%= @post.likes_count %></span>
              </a>
            </div>
          </nav>
          <div class="media-right">
            <.link patch={~p"/posts/#{@post}/show/edit"}>
              <.button>✏️</.button>
            </.link>
          </div>
      </div>
    </div>
  """
  end

  def handle_event("like", _, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
