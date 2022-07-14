defmodule YatzeeWeb.PwaController do
  use YatzeeWeb, :controller

  def manifest(conn, _params),
    do: render(conn, "manifest.json", %{conn: conn})
end
