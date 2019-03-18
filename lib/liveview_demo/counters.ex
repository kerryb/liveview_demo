defmodule LiveviewDemo.Counters do
  use GenServer

  def start_link(number_of_counters) do
    GenServer.start_link(__MODULE__, number_of_counters, name: __MODULE__)
  end

  @impl true
  def init(number_of_counters) do
    counters = Enum.shuffle(1..number_of_counters)
    schedule_update()
    {:ok, %{counters: counters, subscribers: []}}
  end

  def all do
    GenServer.call(__MODULE__, :all)
  end

  def subscribe(callback) do
    GenServer.cast(__MODULE__, {:subscribe, callback})
  end

  @impl true
  def handle_call(:all, _from, state) do
    {:reply, state.counters, state}
  end

  @impl true
  def handle_cast({:subscribe, callback}, state) do
    {:noreply, %{state | subscribers: [callback | state.subscribers]}}
  end

  @impl true
  def handle_info(:update, state) do
    updated_counters = state.counters |> Enum.map(&maybe_change/1)
    notify(state.subscribers, updated_counters)
    schedule_update()
    {:noreply, %{state | counters: updated_counters}}
  end

  defp schedule_update do
    Process.send_after(__MODULE__, :update, 10)
  end

  defp maybe_change(counter) do
    (counter + :random.uniform() * 2 - 1) |> round() |> max(0) |> min(100)
  end

  defp notify(subscribers, counters) do
    subscribers |> Enum.each(& &1.(counters))
  end
end
