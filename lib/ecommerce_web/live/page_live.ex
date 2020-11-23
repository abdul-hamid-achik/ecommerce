defmodule EcommerceWeb.PageLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.{Catalog, Store, Store.Cart}

  @impl true
  def mount(_params, _session, socket) do
    products = Catalog.list_products()
    {:ok, assign(socket, query: "", results: %{}, products: products)}
  end

  @impl true
  def handle_event("add-product", %{"product_id" => product_id}, socket) do
    product = Catalog.get_product!(product_id)
    order = fetch_order(socket)
    updated_order = Cart.add_product(order, product, 1)
    {:noreply, assign(socket, order: updated_order)}
  end

  defp fetch_order(%{assigns: %{order: nil, current_user: user}} = _socket) do
    Store.create_order(%{user: user})
  end

  defp fetch_order(%{assigns: %{order: order}} = _socket) do
    order
  end
end
