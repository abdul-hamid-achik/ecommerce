defmodule Ecommerce.Factory do
  use ExMachina.Ecto, repo: Ecommerce.Repo
  alias Ecommerce.{Catalog.Product, Accounts.User}

  def product_factory do
    %Product{
      name: Faker.Commerce.product_name(),
      image: Faker.Internet.image_url(),
      price: Faker.Commerce.price(),
      description: Faker.Lorem.paragraph(1..2)
    }
  end

  def account_factory do
    %User{
      email: Faker.Internet.email(),
      password: "password"
    }
  end
end
