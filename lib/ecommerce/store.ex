defmodule Ecommerce.Store do
  @moduledoc """
  The Store context.
  """

  import Ecto.Query, warn: false
  alias Ecommerce.{Store.Order, Store.OrderLine, Repo, Accounts.User}

  def get_or_create_order(%User{id: user_id} = _user) do
    Repo.one(from order in Order, where: order.user_id == ^user_id, order_by: order.created_at)
    |> IO.inspect()
  end

  @doc """
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders do
    Repo.all(Order)
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(%Order{} = order, attrs \\ %{}) do
    Order.changeset(order, attrs)
  end

  alias Ecommerce.Store.OrderLine

  @doc """
  Returns the list of order_lines.

  ## Examples

      iex> list_order_lines()
      [%OrderLine{}, ...]

  """
  def list_order_lines do
    Repo.all(OrderLine)
  end

  @doc """
  Gets a single order_line.

  Raises `Ecto.NoResultsError` if the Order line does not exist.

  ## Examples

      iex> get_order_line!(123)
      %OrderLine{}

      iex> get_order_line!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order_line!(id), do: Repo.get!(OrderLine, id)

  def get_order_line(order, product) do
    Repo.one(
      from ol in OrderLine,
        where: ol.order_id == ^order.id and ol.product_id == ^product.id
    )
    |> Repo.preload([:order, :product])
  end

  @doc """
  Creates a order_line.

  ## Examples

      iex> create_order_line(%{field: value})
      {:ok, %OrderLine{}}

      iex> create_order_line(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order_line(attrs \\ %{}) do
    %OrderLine{}
    |> OrderLine.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order_line.

  ## Examples

      iex> update_order_line(order_line, %{field: new_value})
      {:ok, %OrderLine{}}

      iex> update_order_line(order_line, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order_line(%OrderLine{} = order_line, attrs) do
    order_line
    |> OrderLine.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order_line.

  ## Examples

      iex> delete_order_line(order_line)
      {:ok, %OrderLine{}}

      iex> delete_order_line(order_line)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order_line(%OrderLine{} = order_line) do
    Repo.delete(order_line)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order_line changes.

  ## Examples

      iex> change_order_line(order_line)
      %Ecto.Changeset{data: %OrderLine{}}

  """
  def change_order_line(%OrderLine{} = order_line, attrs \\ %{}) do
    OrderLine.changeset(order_line, attrs)
  end
end
