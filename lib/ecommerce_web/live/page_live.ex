defmodule EcommerceWeb.PageLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.{Catalog, Store, Store.Cart, Store.Order, Store.OrderLine}
  alias EcommerceWeb.Credentials

  @impl true
  def mount(_params, session, socket) do
    products = Catalog.list_products()
    current_user = Credentials.get_user(socket, session)
    changeset = Order.changeset(%Order{lines: []}, %{user: current_user}) |> IO.inspect()
    {:ok, assign(socket, changeset: changeset, current_user: current_user, products: products)}
  end

  @impl true
  def handle_event(
        "add-product",
        %{"product_id" => product_id},
        %{assigns: %{changeset: order}} = socket
      ) do
    product = Catalog.get_product!(product_id)

    order_line =
      OrderLine.changeset(%OrderLine{}, %{
        product: product,
        order: order,
        quantity: 1
      })

    changeset = Order.changeset(order, %{lines: [order_line]})
    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("validate", _params, _socket) do
  end

  def handle_event("save", _params, _socket) do
  end
end
