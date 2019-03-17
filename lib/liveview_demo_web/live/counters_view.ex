defmodule LiveviewDemoWeb.CountersView do
  use Phoenix.LiveView

  def mount(_session, socket) do
    {:ok, assign(socket, counters: LiveviewDemo.Counters.all())}
  end

  def render(assigns) do
    ~L"""
    <%= for n <- @counters do %>
      <div class="counter <%= status_class(n) %>"><%= n %></div>
    <% end %>
    """
  end

  def status_class(n) when n < 50, do: "ok"
  def status_class(n) when n < 90, do: "warning"
  def status_class(_n), do: "danger"
end
