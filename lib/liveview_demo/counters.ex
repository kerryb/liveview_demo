defmodule LiveviewDemo.Counters do
  use GenServer

  def start_link(number_of_counters) do
    GenServer.start_link(__MODULE__, number_of_counters, name: __MODULE__)
  end

  @impl true
  def init(number_of_counters) do
    schedule_update()
    {:ok, 1..number_of_counters |> Enum.shuffle()}
  end

  def all do
    GenServer.call(__MODULE__, :all)
  end

  @impl true
  def handle_call(:all, _from, counters) do
    {:reply, counters, counters}
  end

  @impl true
  def handle_info(:update, counters) do
    schedule_update()
    {:noreply, update(counters)}
  end

  defp schedule_update do
    Process.send_after(__MODULE__, :update, 10)
  end

  defp update(counters) do
    counters |> Enum.map(&maybe_change/1)
  end

  defp maybe_change(counter) do
    (counter + Enum.random(-10..10) / 10) |> round() |> Integer.mod(100)
  end
end
