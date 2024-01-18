defmodule CompleteTodoTest do
  use ExUnit.Case
  doctest CompleteTodo

  defimpl CompleteTodoDataStore.DataStore, for: List do
    def find(data_store, number) do
      data_store
      |> Enum.find(fn (todo) -> number == todo.number end)
    end

    def update(_data_store, todo) do
      assert todo.done == true
    end
  end

  test "sets a todo to done" do
    data_store = [%Todo{number: 2, title: "write tests", due_date: nil}]
    complete_todo = %CompleteTodo{number: 2}

    CompleteTodo.complete(data_store, complete_todo)
  end
end
