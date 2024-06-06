defmodule KineskepsiWeb.PostLive.PostComponent do
  use KineskepsiWeb, :live_component

  def render(assigns) do
    ~H"""
    <div id="post-{@post.id}" class="post">
      <div class="row">
        <div class="column column-10">
          <div class="post-avatar"></div>
          </div>
        </div>
        <div class="column column-90 post-body">
          <b>@<%= @post.username %></b>
          <br/>
          <div class="post-body">
            <%= @post.body %>
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
