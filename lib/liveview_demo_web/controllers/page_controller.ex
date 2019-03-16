defmodule LiveviewDemoWeb.PageController do
  use LiveviewDemoWeb, :controller

  def index(conn, _params) do
    conn
    |> assign(:counters, LiveviewDemo.Counters.all())
    |> render("index.html")
  end
end
