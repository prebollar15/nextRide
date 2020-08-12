defmodule NextRideWeb.PageController do
  use NextRideWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
