defmodule Ecommerce.CatalogTest do
  use Ecommerce.DataCase
  import Ecommerce.Factory

  alias Ecommerce.Catalog

  @valid_attrs %{
    description: "some description",
    image: "http://placehold.it/600x300",
    name: "some name",
    price: "120.5"
  }
  @update_attrs %{
    description: "some updated description",
    image: "http://placehold.it/300x300",
    name: "some updated name",
    price: "456.7"
  }
  @invalid_attrs %{description: nil, image: nil, name: nil, price: nil}

  setup do
    %{product: insert(:product)}
  end

  describe "products" do
    alias Ecommerce.Catalog.Product

    test "list_products/0 returns all products", %{product: product} do
      assert Catalog.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id", %{product: product} do
      assert Catalog.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Catalog.create_product(@valid_attrs)
      assert product.description == "some description"
      assert product.image.file_name == "600x300"
      assert product.name == "some name"
      assert product.price == Decimal.new("120.5")
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product", %{product: product} do
      assert {:ok, %Product{} = product} = Catalog.update_product(product, @update_attrs)
      assert product.description == "some updated description"
      assert product.image.file_name == "300x300"
      assert product.name == "some updated name"
      assert product.price == Decimal.new("456.7")
    end

    test "update_product/2 with invalid data returns error changeset", %{product: product} do
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product(product, @invalid_attrs)
      assert product == Catalog.get_product!(product.id)
    end

    test "delete_product/1 deletes the product", %{product: product} do
      assert {:ok, %Product{}} = Catalog.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset", %{product: product} do
      assert %Ecto.Changeset{} = Catalog.change_product(product)
    end
  end
end
