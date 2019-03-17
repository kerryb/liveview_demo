defmodule LiveviewDemoWeb.PageController do
  use LiveviewDemoWeb, :controller

  def index(conn, _params) do
    Phoenix.LiveView.Controller.live_render(conn, LiveviewDemoWeb.CountersView, session: %{})
  end
end
