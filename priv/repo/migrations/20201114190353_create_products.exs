defmodule Ecommerce.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :image, :string
      add :price, :decimal
      add :description, :string

      timestamps()
    end

  end
end
