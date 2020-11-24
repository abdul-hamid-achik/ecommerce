defmodule Ecommerce.Components.Cart do
  use EcommerceWeb, :live_component

  def mount(socket) do
    {:ok, assign(socket, form: nil)}
  end
end
