defmodule KineskepsiWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  def format_date(date) do
    to_string(date.year) <> "-"
    <> to_string(date.month) <> "-"
    <> to_string(date.day)
  end
end
