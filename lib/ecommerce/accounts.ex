defmodule Ecommerce.Accounts do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false

  use Pow.Ecto.Context,
    repo: Ecommerce.Repo,
    user: Ecommerce.Accounts.User

  alias Ecommerce.Repo
  alias Ecommerce.Accounts.User

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%User{}, ...]

  """
  def list_accounts do
    Repo.all(User)
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_account!(123)
      %User{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id), do: pow_get_by(id: id)

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %User{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}) do
    pow_create(attrs) |> IO.inspect()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %User{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%User{} = account, attrs) do
    pow_update(account, attrs)
  end

  @doc """
  Deletes a account.

  ## Examples

      iex> delete_account(account)
      {:ok, %User{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%User{} = account) do
    pow_delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{data: %User{}}

  """
  def change_account(%User{} = account, attrs \\ %{}) do
    User.changeset(account, attrs)
  end
end
