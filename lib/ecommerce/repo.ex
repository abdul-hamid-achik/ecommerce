defmodule Ecommerce.Repo do
  use Ecto.Repo,
    otp_app: :ecommerce,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
