defmodule YatzeeWeb.Plugs.ServiceWorkerAllowed do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default),
    do: put_resp_header(conn, "Service-Worker-Allowed", "/")

  def static_call(%Plug.Conn{request_path: "/assets/sw" <> _}),
    do: %{"Service-Worker-Allowed" => "/"}

  def static_call(_),
    do: %{}
end
