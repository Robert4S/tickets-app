defmodule Tickets2.Repo do
  use Ecto.Repo,
    otp_app: :tickets2,
    adapter: Ecto.Adapters.SQLite3
end
