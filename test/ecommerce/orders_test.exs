defmodule Ecommerce.Store.OrdersTest do
  use Ecommerce.DataCase
  import Ecommerce.Factory
  alias Ecommerce.{Store.Orders, Store.Order, Catalog.Product}
  alias Ecto.Changeset

  setup do
    # TODO: move this to a function
    user = insert(:account)
    order = insert(:order, user: user)
    products = insert_list(12, :product)

    order_with_products = insert(:order, user: user)

    Enum.each(0..3, fn _ ->
      [product | _] = Enum.shuffle(products)
      insert(:order_line, product: product)
    end)

    %{order: order, products: products, user: user, order_with_products: order_with_products}
  end

  describe "add_product_to_order/2" do
    test "should add product to order when receiving a changeset", %{
      products: [product | _],
      user: user
    } do
      changeset = Order.changeset(%Order{}, %{user: user})

      assert %Changeset{
               params:
                 %{
                   "lines" =>
                     [
                       %{
                         product_id: product_id,
                         quantity: quantity
                       }
                       | _
                     ] = lines
                 } = _params
             } = Orders.add_product_to_order(changeset, product.id)

      assert product_id == product.id
      assert quantity == 1
    end

    test "should add new product to order when receiving a order with existing order lines", %{
      order_with_products: order,
      products: products
    } do
      %Product{id: product_id} = products |> Enum.shuffle() |> Enum.at(-1)
      changeset = Order.changeset(order, %{})

      assert %Changeset{
               params:
                 %{
                   "lines" =>
                     [
                       %{
                         product_id: verify_product_id,
                         quantity: quantity
                       }
                       | _
                     ] = lines
                 } = _params,
               changes: changes
             } = Orders.add_product_to_order(changeset, product_id)

      assert product_id == verify_product_id
      assert quantity == 1
    end
  end

  describe "remove_product_from_order" do
  end

  describe "increase_product_quantity_in_order" do
  end

  describe "decrease_product_quantity_in_order" do
  end
end
