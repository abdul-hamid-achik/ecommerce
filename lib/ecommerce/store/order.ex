defmodule Ecommerce.Store.Order do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  @allowed_params []

  defenum(StatusEnum, :status, [:open, :paid, :sent, :delivered])

  schema "orders" do
    field :status, StatusEnum

    has_many :lines, Ecommerce.Store.OrderLine
    belongs_to :user, Ecommerce.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(order, attrs \\ %{})

  def changeset(order, attrs) do
    order
    |> cast(attrs, @allowed_params)
    |> validate_required([])
    |> cast_assoc(:lines)
    |> put_assoc(:user, Map.get(attrs, :user))
  end
end
