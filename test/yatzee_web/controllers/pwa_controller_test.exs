defmodule YatzeeWeb.PwaControllerTest do
  use YatzeeWeb.ConnCase

  test "GET /pwa/manifest.json", %{conn: conn} do
    conn = get(conn, "/pwa/manifest.json")
    assert json_response(conn, 200)["data"] == []
  end
end
