defmodule KineskepsiWeb.PageController do
  use KineskepsiWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    redirect(conn, to: ~p"/posts")
    # render(conn, :home, layout: false)
  end
end
