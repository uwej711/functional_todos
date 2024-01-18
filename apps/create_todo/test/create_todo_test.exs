defmodule CreateTodoTest do
  use ExUnit.Case
  doctest CreateTodo

  defimpl CreateTodoDataStore.DataStore, for: List do
    def create_todo(list, create_todo) do
      [create_todo | list]
    end
  end

  test "creates a todo" do
    data_store = []
    create_todo = %CreateTodo{number: 1, title: "write documentation"}

    result = CreateTodo.new(data_store, create_todo)

    assert result == :ok
  end
end
