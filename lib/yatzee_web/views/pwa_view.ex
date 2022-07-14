defmodule YatzeeWeb.PwaView do
  use YatzeeWeb, :view

  def render("manifest.json", %{conn: conn}),
    do: %{
      short_name: "Yatzee",
      name: "Yatzee",
      description: "Score keeping for the game of Yatzee.",
      scope: "/",
      start_url: Routes.page_path(conn, :splash),
      display: "standalone",
      orientation: "portrait",
      theme_color: "#000000",
      background_color: "#000000",
      icons: [
        %{
          src: Routes.static_path(conn, "/icons/yatzee-dice.svg"),
          sizes: "48x48 72x72 96x96 128x128 256x256 512x512",
          type: "image/svg+xml",
          purpose: "any"
        },
        %{
          src: Routes.static_path(conn, "/icons/yatzee-dice-512.png"),
          sizes: "512x512",
          type: "image/png"
        },
        %{
          "src" => Routes.static_path(conn, "/icons/maskable/x48.png"),
          "sizes" => "48x48",
          "type" => "image/png",
          "purpose" => "maskable"
        },
        %{
          "src" => Routes.static_path(conn, "/icons/maskable/x72.png"),
          "sizes" => "72x72",
          "type" => "image/png",
          "purpose" => "maskable"
        },
        %{
          "src" => Routes.static_path(conn, "/icons/maskable/x96.png"),
          "sizes" => "96x96",
          "type" => "image/png",
          "purpose" => "maskable"
        },
        %{
          "src" => Routes.static_path(conn, "/icons/maskable/x128.png"),
          "sizes" => "128x128",
          "type" => "image/png",
          "purpose" => "maskable"
        },
        %{
          "src" => Routes.static_path(conn, "/icons/maskable/x192.png"),
          "sizes" => "192x192",
          "type" => "image/png",
          "purpose" => "maskable"
        },
        %{
          "src" => Routes.static_path(conn, "/icons/maskable/x384.png"),
          "sizes" => "384x384",
          "type" => "image/png",
          "purpose" => "maskable"
        },
        %{
          "src" => Routes.static_path(conn, "/icons/maskable/x512.png"),
          "sizes" => "512x512",
          "type" => "image/png",
          "purpose" => "maskable"
        }
      ]
    }
end
