# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ecommerce.Repo.insert!(%Ecommerce.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import Ecommerce.Factory

Ecommerce.Accounts.create_account(%{
  email: "abdulachik@gmail.com",
  password: "password",
  password_confirmation: "password",
  password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash("password")
})

insert_list(30, :product)
insert_list(5, :account)
