defmodule Tickets2.Repo do
  use Ecto.Repo,
    otp_app: :tickets2,
    adapter: Application.get_env(:tickets2, __MODULE__)[:adapter]
end
