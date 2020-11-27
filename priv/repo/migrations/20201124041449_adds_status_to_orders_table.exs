defmodule Ecommerce.Repo.Migrations.AddsStatusToOrdersTable do
  use Ecto.Migration
  alias Ecommerce.Store.Order.StatusEnum

  def change do
    StatusEnum.create_type
    alter table(:orders) do
      add :status, StatusEnum.type()
    end
  end
end
