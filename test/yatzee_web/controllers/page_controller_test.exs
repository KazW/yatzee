defmodule YatzeeWeb.PageControllerTest do
  use YatzeeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Petal"
  end

  test "GET /splash", %{conn: conn} do
    conn = get(conn, "/splash")
    assert html_response(conn, 200) =~ "Splash"
  end
end
