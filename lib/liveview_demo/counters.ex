defmodule LiveviewDemo.Counters do
  def all do
    1..100 |> Enum.shuffle()
  end
end
