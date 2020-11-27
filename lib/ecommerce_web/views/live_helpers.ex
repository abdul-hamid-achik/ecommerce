defmodule EcommerceWeb.LiveHelpers do
  alias Ecommerce.{Catalog, Catalog.Product}

  def get_product_name(product_id) do
    %Product{name: name} = Catalog.get_product!(product_id)
    name
  end
end
