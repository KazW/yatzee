defmodule YatzeeWeb.PageController do
  use YatzeeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
