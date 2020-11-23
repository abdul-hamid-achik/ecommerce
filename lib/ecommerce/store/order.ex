defmodule Ecommerce.Store.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @allowed_params []

  schema "orders" do
    has_many :lines, Ecommerce.Store.OrderLine
    belongs_to :user, Ecommerce.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, @allowed_params)
    |> cast_assoc(:lines)
    |> validate_required([])
    |> put_assoc(:user, Map.get(attrs, :user))
  end
end