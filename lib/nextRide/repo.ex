defmodule NextRide.Repo do
  use Ecto.Repo,
    otp_app: :nextRide,
    adapter: Ecto.Adapters.Postgres
end
