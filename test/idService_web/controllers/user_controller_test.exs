defmodule IdServiceWeb.UserControllerTest do
  use IdServiceWeb.ConnCase

  alias IdService.Accounts
  alias IdService.Accounts.User

  @create_attrs %{email: "email@example.com", password: "some password", password_confirmation: "some password"}
  @update_attrs %{email: "updated@example.com", password: "some updated password", password_confirmation: "some updated password"}
  @invalid_attrs %{email: nil, password: "short", password_confirmation: "short"}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"jwt" => token} = json_response(conn, 200)
      assert {:ok, %{id: id, email: email}, _claims} = IdService.Guardian.resource_from_token(token)


      jwt_conn = build_conn() |> Plug.Conn.put_req_header("authorization", "Bearer: #{token}")
      conn = get(jwt_conn, Routes.user_path(conn, :show))

      assert %{
               "id" => id,
               "email" => email,
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
