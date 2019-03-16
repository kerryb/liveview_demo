defmodule LiveviewDemoWeb.PageController do
  use LiveviewDemoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
