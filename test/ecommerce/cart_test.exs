defmodule Ecommerce.CartTest do
  use Ecommerce.DataCase

  alias Ecommerce.Store
  alias Ecommerce.Store.Cart
  import Ecommerce.Factory

  setup do
    account = insert(:account)
    %{account: account}
  end

  describe "add_product/3" do
    test "should add product to order when setting quantity to 1", %{account: account} do
      product = insert(:product)

      {:ok, order} = Store.create_order(%{user: account})

      {:ok, updated_order} = Cart.add_product(order, product, 2)

      order_lines = Map.get(updated_order, :lines)

      order_line = Enum.at(order_lines, 0)

      assert length(updated_order.lines) == 1
      assert order_line.quantity == 2
    end
  end

  describe "update_product/3" do
    test "should update product quantity in order", %{account: account} do
      product = insert(:product)
      order = insert(:order, lines: [], user: account)
      insert(:order_line, order: order, product: product, quantity: 1)
      {:ok, updated_order} = Cart.update_product(order, product, 3)
      order_lines = Map.get(updated_order, :lines)
      order_line = Enum.at(order_lines, 0)

      assert length(order_lines) == 1
      assert order_line.quantity == 3
    end
  end

  describe "remove_product/2" do
    test "should remove product from order", %{account: account} do
      product = insert(:product)
      order = insert(:order, lines: [], user: account)
      insert(:order_line, order: order, product: product, quantity: 3)
      {:ok, updated_order} = Cart.remove_product(order, product)
      order_lines = Map.get(updated_order, :lines)
      assert length(order_lines) == 0
    end
  end
end
