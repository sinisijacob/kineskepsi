defmodule Kineskepsi.Repo do
  use Ecto.Repo,
    otp_app: :kineskepsi,
    adapter: Ecto.Adapters.Postgres
end
