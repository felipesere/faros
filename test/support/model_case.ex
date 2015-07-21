defmodule Lighthouse.ModelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Lighthouse.Repo
      import Lighthouse.ModelCase
    end
  end

  setup tags do
    unless tags[:async] do
      Ecto.Adapters.SQL.restart_test_transaction(Lighthouse.Repo, [])
    end

    :ok
  end

  @doc """
  Helper for returning list of errors in model when passed certain data.

  ## Examples

  Given a User model that has validation for the presence of a value for the
  `:name` field and validation that `:password` is "safe":

      iex> errors_on(%User{}, password: "password")
      [{:password, "is unsafe"}, {:name, "is blank"}]

  You would then write your assertion like:

      assert {:password, "is unsafe"} in errors_on(%User{}, password: "password")
  """
  def errors_on(model, data) do
    model.__struct__.changeset(model, data).errors
  end
end
