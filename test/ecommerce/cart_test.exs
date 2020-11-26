defmodule Ecommerce.CartTest do
  use Ecommerce.DataCase

  alias Ecommerce.{Store, Store.Cart, Store.Order}
  import Ecommerce.Factory

  setup do
    user = insert(:account)
    order = insert(:order, user: user)
    products = insert_list(12, :product)

    order_with_products = insert(:order, user: user)

    Enum.each(0..3, fn _ ->
      [product | _] = Enum.shuffle(products)
      insert(:order_line, product: product)
    end)

    %{
      order: order,
      products: products,
      user: user,
      order_with_products: order_with_products
    }
  end

  describe "add_product/3" do
    test "should add product to order when setting quantity to 1", %{user: user} do
      product = insert(:product)

      {:ok, order} = Store.create_order(%{user: user})

      {:ok, updated_order} = Cart.add_product(order, product, 2)

      order_lines = Map.get(updated_order, :lines)

      order_line = Enum.at(order_lines, 0)

      assert length(updated_order.lines) == 1
      assert order_line.quantity == 2
    end
  end

  describe "update_product/3" do
    test "should update product quantity in order", %{user: user} do
      product = insert(:product)
      order = insert(:order, lines: [], user: user)
      insert(:order_line, order: order, product: product, quantity: 1)
      {:ok, updated_order} = Cart.update_product(order, product, 3)
      order_lines = Map.get(updated_order, :lines)
      order_line = Enum.at(order_lines, 0)

      assert length(order_lines) == 1
      assert order_line.quantity == 3
    end
  end

  describe "remove_product/2" do
    test "should remove product from order", %{user: user} do
      product = insert(:product)
      order = insert(:order, lines: [], user: user)
      insert(:order_line, order: order, product: product, quantity: 3)
      {:ok, updated_order} = Cart.remove_product(order, product)
      order_lines = Map.get(updated_order, :lines)
      assert length(order_lines) == 0
    end
  end

  describe "is_product_in_car?/2" do
    test "should return true when a product is in the cart", %{
      user: user,
      products: [product | _]
    } do
      changeset =
        Order.changeset(%Order{}, %{user: user, lines: [%{product_id: product.id, quantity: 1}]})

      assert true = Cart.is_product_in_car?(changeset, product)
    end

    test "should return false when a product is not in the cart", %{
      user: user,
      products: [product | _]
    } do
      changeset = Order.changeset(%Order{}, %{user: user})

      assert true = Cart.is_product_in_car?(changeset, product)
    end
  end
end
