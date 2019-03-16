defmodule LiveviewDemo.Counters do
  use GenServer

  def start_link(number_of_counters) do
    GenServer.start_link(__MODULE__, number_of_counters, name: __MODULE__)
  end

  @impl true
  def init(number_of_counters) do
    {:ok, 1..number_of_counters |> Enum.shuffle()}
  end

  def all do
    GenServer.call(__MODULE__, :all)
  end

  @impl true
  def handle_call(:all, _from, counters) do
    {:reply, counters, counters}
  end
end
