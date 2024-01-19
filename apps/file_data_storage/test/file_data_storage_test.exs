defmodule FileDataStorageTest do
  use ExUnit.Case
  doctest FileDataStorage

  setup do
    directory = "/tmp/todos"

    on_exit(fn -> File.rm_rf!(directory) end)

    {:ok, datastore: %FileDataStorage{directory: directory}}
  end

  test "creates a todo", context do
    todo = %Todo{number: 1, title: "write tests", due_date: nil}

    CreateTodoDataStore.DataStore.create_todo(context[:datastore], todo)

    assert File.exists?("/tmp/todos/1.todo")
  end

  test "lists all todo", context do
    todo1 = %Todo{number: 1, title: "write tests", due_date: nil}
    todo2 = %Todo{number: 2, title: "write documentation", due_date: nil}

    CreateTodoDataStore.DataStore.create_todo(context[:datastore], todo1)
    CreateTodoDataStore.DataStore.create_todo(context[:datastore], todo2)

    todos = ListTodosDataStore.DataStore.find_todos(context[:datastore])

    assert length(todos) == 2
  end

  test "finds a todo", context do
    todo = %Todo{number: 1, title: "write tests", due_date: nil}

    CreateTodoDataStore.DataStore.create_todo(context[:datastore], todo)

    todo = CompleteTodoDataStore.DataStore.find(context[:datastore], 1)

    assert todo.number == 1
    assert todo.title == "write tests"
  end

  test "updates a todo", context do
    todo = %Todo{number: 1, title: "write tests", due_date: nil}

    CreateTodoDataStore.DataStore.create_todo(context[:datastore], todo)

    CompleteTodoDataStore.DataStore.update(context[:datastore], %{todo | done: true})
    todo = CompleteTodoDataStore.DataStore.find(context[:datastore], 1)

    assert todo.number == 1
    assert todo.title == "write tests"
    assert todo.done
  end
end
