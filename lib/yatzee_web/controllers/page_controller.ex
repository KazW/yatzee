defmodule YatzeeWeb.PageController do
  use YatzeeWeb, :controller

  def index(conn, _params),
    do: render(conn, "index.html")

  def splash(conn, _params),
    do: render(conn, "splash.html")
end
