defmodule EcommerceWeb.PageLiveTest do
  use EcommerceWeb.ConnCase
  import Ecommerce.Factory
  import Phoenix.LiveViewTest
  alias Ecommerce.Catalog

  setup %{conn: conn} do
    user = insert(:account)
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :ecommerce)
    {:ok, authenticated_conn: conn}
  end

  setup do
    products = insert_list(12, :product)
    %{products: products}
  end

  test "disconnected and connected render", %{conn: conn} do
    assert {
             :error,
             {
               :redirect,
               %{
                 to: "/session/new?request_path=%2F"
               }
             }
           } = live(conn, "/")
  end

  describe "Catalog" do
    setup %{authenticated_conn: conn} do
      {:ok, conn: conn}
    end

    test "should show list of products", %{conn: conn, products: products} do
      {:ok, _view, html} = live(conn, "/")
      Enum.each(products, fn product -> assert html =~ "##{product.id}" end)
    end

    test "should show paginated list of products", %{conn: conn} do
      page = 1
      products = Catalog.products_base_query()
      paginated_products = Catalog.paginate(products, page)
      {:ok, _view, html} = live(conn, "/?page=#{page}")
      Enum.each(paginated_products.entries, fn product -> assert html =~ "##{product.id}" end)
    end

    test "should add product to cart when clicking button `add-to-cart`" do
    end

    test "should remove product from cart when clicking button `remove-from-car`" do
    end
  end

  @tag :wip
  describe "Cart" do
    test "should update order price on product quantity increase" do
    end

    test "should update order price on product quantity decrease" do
    end
  end
end
