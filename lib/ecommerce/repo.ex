defmodule Ecommerce.Repo do
  use Ecto.Repo,
    otp_app: :ecommerce,
    adapter: Ecto.Adapters.Postgres
end
