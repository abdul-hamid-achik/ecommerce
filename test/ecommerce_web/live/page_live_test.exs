defmodule EcommerceWeb.PageLiveTest do
  use EcommerceWeb.ConnCase

  import Phoenix.LiveViewTest
  @tag :wip
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
end
