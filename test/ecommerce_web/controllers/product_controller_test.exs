defmodule EcommerceWeb.ProductControllerTest do
  use EcommerceWeb.ConnCase
  import Ecommerce.Factory

  alias Ecommerce.Catalog

  @create_attrs %{
    description: "some description",
    image: "http://placehold.it/300x300",
    name: "some name",
    price: "120.5"
  }
  @update_attrs %{
    description: "some updated description",
    image: "http://placehold.it/600x300",
    name: "some updated name",
    price: "456.7"
  }
  @invalid_attrs %{description: nil, image: nil, name: nil, price: nil}

  setup %{conn: conn} do
    user = insert(:account)
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :ecommerce)
    {:ok, conn: conn}
  end

  def fixture(:product) do
    {:ok, product} = Catalog.create_product(@create_attrs)
    product
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Products"
    end
  end

  describe "new product" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :new))
      assert html_response(conn, 200) =~ "New Product"
    end
  end

  describe "create product" do
    test "redirects to show when data is valid", %{conn: authed_conn} do
      conn = post(authed_conn, Routes.product_path(authed_conn, :create), product: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.product_path(conn, :show, id)

      conn = get(authed_conn, Routes.product_path(authed_conn, :show, id))
      assert html_response(conn, 200) =~ "some name"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Product"
    end
  end

  describe "edit product" do
    setup [:create_product]

    test "renders form for editing chosen product", %{conn: conn, product: product} do
      conn = get(conn, Routes.product_path(conn, :edit, product))
      assert html_response(conn, 200) =~ "Edit Product"
    end
  end

  describe "update product" do
    setup [:create_product]

    test "redirects when data is valid", %{conn: authed_conn, product: product} do
      conn =
        put(authed_conn, Routes.product_path(authed_conn, :update, product),
          product: @update_attrs
        )

      assert redirected_to(conn) == Routes.product_path(conn, :show, product)

      conn = get(authed_conn, Routes.product_path(authed_conn, :show, product))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, product: product} do
      conn = put(conn, Routes.product_path(conn, :update, product), product: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Product"
    end
  end

  describe "delete product" do
    setup [:create_product]

    test "deletes chosen product", %{conn: authed_conn, product: product} do
      conn = delete(authed_conn, Routes.product_path(authed_conn, :delete, product))
      assert redirected_to(conn) == Routes.product_path(conn, :index)

      assert_error_sent 404, fn ->
        get(authed_conn, Routes.product_path(authed_conn, :show, product))
      end
    end
  end

  defp create_product(_) do
    product = fixture(:product)
    %{product: product}
  end
end
