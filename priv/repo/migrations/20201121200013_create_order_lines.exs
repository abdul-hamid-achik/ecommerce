defmodule Ecommerce.Repo.Migrations.CreateOrderLines do
  use Ecto.Migration

  def change do
    create table(:order_lines) do
      add :quantity, :integer
      add :product_id, references(:products, on_delete: :nothing)
      add :order_id, references(:orders, on_delete: :nothing)

      timestamps()
    end

    create index(:order_lines, [:product_id])
    create index(:order_lines, [:order_id])
  end
end
