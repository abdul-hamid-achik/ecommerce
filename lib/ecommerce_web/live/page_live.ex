defmodule EcommerceWeb.PageLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.{Catalog, Store}

  @impl true
  def mount(_params, _session, socket) do
    products = Catalog.list_products()
    {:ok, assign(socket, query: "", results: %{}, products: products)}
  end

  @impl true
  def handle_event("add-product", %{"product_id" => product_id}, socket) do
    IO.inspect(product_id)

    order = fetch_order(socket)
    updated_order = Store.add_product(order, product_id)
    {:noreply, assign(socket, order: updated_order)}
  end

  defp fetch_order(%{assigns: %{order: nil}} = _socket) do
    Store.create_order()
  end

  defp fetch_order(%{assigns: %{order: order}} = _socket) do
    order
  end
end
