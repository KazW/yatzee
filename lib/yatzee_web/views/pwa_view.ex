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
          src: Routes.static_path(conn, "/images/yatzee-dice.svg"),
          sizes: "48x48 72x72 96x96 128x128 256x256 512x512",
          type: "image/svg+xml",
          purpose: "any"
        },
        %{
          src: Routes.static_path(conn, "/images/yatzee-dice.png"),
          sizes: "512x512",
          type: "image/png"
        }
      ]
    }
end
