defmodule LiveviewDemoWeb.CountersView do
  use Phoenix.LiveView

  def mount(_session, socket) do
    socket = assign(socket, counters: LiveviewDemo.Counters.all())

    if connected?(socket) do
      pid = self()
      LiveviewDemo.Counters.subscribe(fn counters -> send(pid, {:update, counters}) end)
    end

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <%= for n <- @counters do %>
      <div class="counter <%= status_class(n) %>"><%= n %></div>
    <% end %>
    """
  end

  def handle_info({:update, counters}, socket) do
    {:noreply, update(socket, :counters, fn _ -> counters end)}
  end

  def status_class(n) when n < 50, do: "ok"
  def status_class(n) when n < 90, do: "warning"
  def status_class(_n), do: "danger"
end
