defmodule Ecommerce.Store.OrderLine do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecommerce.{Store.Order, Catalog.Product}

  schema "order_lines" do
    field :quantity, :integer
    belongs_to :order, Order
    belongs_to :product, Product

    timestamps()
  end

  @doc false
  def changeset(order_line, attrs) do
    order_line
    |> cast(attrs, [:quantity])
    |> put_assoc(:order, Map.get(attrs, :order, order_line.order))
    |> put_assoc(:product, Map.get(attrs, :product, order_line.product))
    |> validate_required([:quantity])
  end
end
