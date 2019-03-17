defmodule LiveviewDemoWeb.PageView do
  use LiveviewDemoWeb, :view

  def status_class(n) when n < 50, do: "ok"
  def status_class(n) when n < 90, do: "warning"
  def status_class(_n), do: "danger"
end
