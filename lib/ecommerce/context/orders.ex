defmodule Ecommerce.Store.Orders do
  alias Ecommerce.Store.{Order}
  alias Ecto.Changeset

  @spec add_product_to_order(Changeset.t(), String.t()) :: Changeset.t()
  def add_product_to_order(order, product_id) do
    previous_lines = Map.get(order.changes, :lines, [])
    lines = [%{product_id: product_id, quantity: 1} | previous_lines]
    Order.changeset(order, Map.merge(order.changes, %{lines: lines}))
  end

  @spec remove_product_from_order(Changeset.t(), String.t()) :: Changeset.t()
  def remove_product_from_order(order, product_id) do
  end

  @spec increase_product_quantity_in_order(Changeset.t(), String.t()) :: Changeset.t()
  def increase_product_quantity_in_order(order, product_id) do
  end

  @spec decrease_product_quantity_in_order(Changeset.t(), String.t()) :: Changeset.t()
  def decrease_product_quantity_in_order(order, product_id) do
  end
end
