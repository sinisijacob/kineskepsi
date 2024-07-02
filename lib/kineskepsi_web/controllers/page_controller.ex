defmodule KineskepsiWeb.PageController do
  use KineskepsiWeb, :controller

  def home(conn, _params) do
    # Redirect to posts from home
    redirect(conn, to: ~p"/posts")
  end
end
