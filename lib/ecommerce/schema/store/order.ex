defmodule Ecommerce.Store.Order do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  @required [:user_id]

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
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> cast_assoc(:lines)
  end
end
