defmodule Ecommerce.Accounts.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :avatar, Ecommerce.Uploaders.Avatar.Type
    has_many :orders, Ecommerce.Store.Order

    pow_user_fields()
    timestamps()
  end

  def changeset(user, attributes \\ %{}) do
    user
    |> cast(attributes, [:email, :password])
    |> unique_constraint(:email)
    |> pow_changeset(attributes)
  end
end
