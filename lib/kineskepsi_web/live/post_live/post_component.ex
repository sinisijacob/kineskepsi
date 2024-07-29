defmodule KineskepsiWeb.PostLive.PostComponent do
  use KineskepsiWeb, :live_component
  import KineskepsiWeb.LiveHelpers, only: [format_date: 1]

  def render(assigns) do
    ~H"""
    <div id={"post-" <> Integer.to_string(@post.id)} class="post">
      <div class="row">
        <div class="column column-10">
          <div class="post-avatar"></div>
          </div>
        </div>
        <div class="column column-90 post-body">
          <b><%= @post.title %></b> - @<%= @post.user.id %>
          <br/>
          <%= if @post.inserted_at === @post.updated_at do format_date(@post.inserted_at) else format_date(@post.updated_at) <> " (Edited)" end%>
          <br/>
          <div class="post-body">
            <%= @post.blurb %>
          </div>
          <nav class="level is-mobile">
            <div class="level-left">
              <a class="level-item" phx-click="open_chat" phx-value-id="{@post.}">
                <span class="icon is-small"><.icon name="hero-chat-bubble-oval-left-ellipsis-solid" class="mt-0.5 h-8 w-8 flex-none" /><%= @post.repost_count %></span>
              </a>
              <a class="level-item" phx-click="like" phx-target="{@myself}">
                <span class="icon is-small"><.icon name="hero-heart-solid" type="full" class="mt-0.5 h-8 w-8 flex-none" /><%= @post.likes_count %></span>
              </a>
            </div>
          </nav>
        <%= if @current_user != nil and @current_user.id === @post.user.id do %>
          <div class="media-right">
            <.link patch={~p"/posts/#{@post}/show/edit"}>
              <.button>✏️</.button>
            </.link>
          </div>
        <% end %>
      </div>
    </div>
  """
  end
end
