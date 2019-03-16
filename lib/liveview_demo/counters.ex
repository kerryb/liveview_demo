defmodule LiveviewDemo.Counters do
  use GenServer

  def start_link(number_of_counters) do
    GenServer.start_link(__MODULE__, number_of_counters)
  end

  @impl true
  def init(number_of_counters) do
    {:ok, 1..100 |> Enum.shuffle()}
  end

  def all do
    1..100 |> Enum.shuffle()
  end
end
