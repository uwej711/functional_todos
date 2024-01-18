defmodule ListTodosTest do
  use ExUnit.Case
  doctest ListTodos

  defimpl ListTodosDataStore.DataStore, for: List do
    def find_todos(list) do
      list
    end
  end

  test "returns all todos not done" do
    todos = [
      %Todo{number: 1, title: "write tests", due_date: NaiveDateTime.utc_now(), done: true},
      %Todo{number: 2, title: "write documentation", due_date: NaiveDateTime.utc_now |> NaiveDateTime.add(1, :day)}
    ]

    todos_not_done = ListTodos.list_todos_not_done(todos)

    assert length(todos_not_done) == 1
    [todo | _] = todos_not_done
    assert todo.number == 2
  end
end
