defmodule Ecommerce.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset
  use Waffle.Ecto.Schema

  schema "products" do
    field :description, :string
    field :image, Ecommerce.Uploaders.Product.Type
    field :name, :string
    field :price, :decimal

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :image, :price, :description])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:name, :image, :price, :description])
  end
end
