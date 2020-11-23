defmodule Ecommerce.Factory do
  use ExMachina.Ecto, repo: Ecommerce.Repo
  alias Ecommerce.{Catalog.Product, Accounts.User, Store.Order, Store.OrderLine}

  def product_factory do
    %Product{
      name: Faker.Commerce.product_name(),
      image: Faker.Internet.image_url(),
      price: Faker.Commerce.price(),
      description: Faker.Lorem.paragraph(1..2)
    }
  end

  def order_factory do
    %Order{
      lines: [],
      user: insert(:account)
    }
  end

  def order_line_factory do
    %OrderLine{
      product: insert(:product),
      order: insert(:order, user: insert(:account)),
      quantity: 1
    }
  end

  def account_factory do
    %User{
      email: Faker.Internet.email(),
      password: "password"
    }
  end
end
