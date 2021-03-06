defmodule MessengerBot.Web.RendererTest do
  use ExUnit.Case
  alias MessengerBot.ConnHelper
  alias MessengerBot.Model.Error
  alias MessengerBot.Web.Renderer

  doctest Renderer

  setup do
    {:ok, conn: ConnHelper.build_conn()}
  end

  test ".send_ok", %{conn: conn} do
    conn = Renderer.send_ok(conn)
    assert conn.resp_body == "[]"
    assert conn.state == :sent
    assert conn.status == 200
  end

  test ".send_error", %{conn: conn} do
    error = %Error{code: :unauthorized, details: %{foo: "bar"}}
    conn = Renderer.send_error(conn, error)
    assert conn.resp_body == "{\"errors\":{\"foo\":\"bar\"}}"
    assert conn.state == :sent
    assert conn.status == 401
  end
end
