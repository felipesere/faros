defmodule Faros.Health.ControllerTest do
  use Faros.ConnCase
  use Faros.RepositoryCase
  alias Faros.Health.Controller

  defmodule Fakes do
    defmacro fake_repo([name: name, up: up]) do
      quote do
        defmodule unquote(name) do
          def __adapter__, do: Faros.Health.ControllerTest.unquote(name).unquote(name)
          def config, do: nil

          defmodule unquote(name) do
            def storage_up(_), do: unquote(up)
          end
        end
      end
    end
  end

  test "database ok if storage is brought up" do
    require Fakes

    Fakes.fake_repo([name: FakeRepo, up: :ok])
    assert Controller.db_check(FakeRepo) == true
  end

  test "database ok if storage is already up" do
    require Fakes

    Fakes.fake_repo([name: AlreadyUp, up: {:error, :already_up}])
    assert Controller.db_check(AlreadyUp) == true
  end

  test "database error when storage fails" do
    require Fakes

    Fakes.fake_repo([name: Failing, up: {:error, :something}])
    assert Controller.db_check(Failing) == false
  end

  test "sets 200 if there are no errors" do
    input = %{ foo: true }
    assert Controller.to_status(input) == 200
  end

  test "sets 500 if there are errors" do
    input = %{ foo: false }
    assert Controller.to_status(input) == 500
  end

  test "sets 500 if there are any errors" do
    input = %{ foo: true, bar: false }
    assert Controller.to_status(input) == 500
  end
end
