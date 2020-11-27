defmodule EcommerceWeb.PageLive do
  use EcommerceWeb, :live_view
  alias Ecommerce.{Catalog, Store.Order, Store.Orders, Catalog.Product}
  alias EcommerceWeb.Credentials

  def get_product_name(product_id) do
    %Product{name: name} = Catalog.get_product!(product_id)
    name
  end

  @impl true
  def mount(_params, session, socket) do
    products = Catalog.list_products()
    current_user = Credentials.get_user(socket, session)
    changeset = Order.changeset(%Order{lines: []}, %{user: current_user})

    {:ok,
     assign(socket,
       changeset: changeset,
       current_user: current_user,
       products: products
     )}
  end

  @impl true
  def handle_event(
        "add-product",
        %{"product_id" => product_id},
        %{assigns: %{changeset: order}} = socket
      ) do
    {:noreply, assign(socket, changeset: Orders.add_product_to_order(order, product_id))}
  end

  def handle_event(
        "remove-product",
        %{"product_id" => product_id},
        %{assigns: %{changeset: changeset}} = socket
      ) do
    {:noreply, assign(socket, changeset: Orders.remove_product_from_order(changeset, product_id))}
  end

  def handle_event(
        "increase-product-quantity",
        %{"product_id" => product_id} = _params,
        %{assigns: %{changeset: %{params: %{"lines" => lines}} = changeset}} = socket
      ) do
    changeset =
      Order.changeset(changeset, %{
        lines:
          Enum.map(lines, fn line ->
            if product_id == line.product_id do
              Map.put(line, :quantity, line.quantity + 1)
            end
          end)
      })

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event(
        "decrease-product-quantity" = _params,
        %{"product_id" => product_id},
        %{assigns: %{changeset: %{params: %{"lines" => lines}} = changeset}} = socket
      ) do
    changeset =
      Order.changeset(changeset, %{
        lines:
          Enum.map(lines, fn line ->
            if product_id == line.product_id do
              Map.put(line, :quantity, line.quantity - 1)
            end
          end)
      })

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("validate", _params, _socket) do
  end

  def handle_event("save", _params, _socket) do
  end
end
