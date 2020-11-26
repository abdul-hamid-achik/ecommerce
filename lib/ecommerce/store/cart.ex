defmodule Ecommerce.Store.Cart do
  import Ecto.Query, warn: false
  alias Ecommerce.{Repo, Store, Catalog.Product}

  @spec add_product(Order.t(), Product.t(), number()) ::
          {:ok, Order.t()} | {:error, Ecto.Changeset.t()} | {:error, any()}
  def add_product(order, product, quantity) do
    case Store.create_order_line(%{
           order: order,
           product: product,
           quantity: quantity
         }) do
      {:ok, _order_line} ->
        {:ok, Repo.preload(order, :lines)}

      error ->
        error
    end
  end

  @spec update_product(Order.t(), Product.t(), number()) ::
          {:ok, Order.t()} | {:error, Ecto.Changeset.t()} | {:error, any()}
  def update_product(order, product, quantity) do
    with order_line <- Store.get_order_line(order, product),
         {:ok, _order_line} <-
           Store.update_order_line(order_line, %{quantity: quantity}),
         updated_order <- Store.get_order!(order.id) do
      {:ok, Repo.preload(updated_order, :lines)}
    else
      error -> error
    end
  end

  @spec remove_product(Order.t(), Product.t()) ::
          {:ok, Order.t()} | {:error, Ecto.Changeset.t()} | {:error, any()}
  def remove_product(order, product) do
    with order_line <- Store.get_order_line(order, product),
         {:ok, _order_line} <- Store.delete_order_line(order_line) do
      {:ok, Repo.preload(order, :lines)}
    else
      error -> error
    end
  end

  @spec is_product_in_car?(Ecto.Changeset.t(), Product.t()) :: boolean()
  def is_product_in_car?(
        %{
          changes: %{
            lines: [
              %Ecto.Changeset{
                changes:
                  %{
                    product_id: product_id
                  } = _changes
              }
            ]
          }
        } = _changeset,
        %Product{id: verify_product_id} = _product
      )
      when verify_product_id == product_id,
      do: true

  def is_product_in_car?(
        _changeset,
        _product
      ),
      do: false
end
