defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true
  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "should be able to create an user" do
      params = %{
        name: "teste",
        email: "teste@email.com",
        nickname: "testinho",
        password: "123456",
        age: 27
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "teste", age: 27, id: ^user_id} = user
    end

    test "should not be able to create an user using invalid params" do
      params = %{
        name: "teste",
        email: "teste@email.com",
        nickname: "teste",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
