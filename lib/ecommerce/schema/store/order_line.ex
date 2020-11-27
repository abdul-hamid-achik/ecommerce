defmodule Ecommerce.Store.OrderLine do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecommerce.{Store.Order, Catalog.Product}

  @required [:quantity, :product_id]

  schema "order_lines" do
    field :quantity, :integer
    belongs_to :order, Order
    belongs_to :product, Product

    timestamps()
  end

  @doc false
  def changeset(order_line, attrs) do
    order_line
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
