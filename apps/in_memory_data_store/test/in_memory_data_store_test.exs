defmodule InMemoryDataStoreTest do
  use ExUnit.Case
  doctest InMemoryDataStore

  test "stores todos" do
    data_store = InMemoryDataStore.start()

    CreateTodo.new(data_store, %CreateTodo{number: 1, title: "write tests"})
    CreateTodo.new(data_store, %CreateTodo{number: 2, title: "write documentation"})

    todos = ListTodos.list_todos_not_done(data_store)

    assert length(todos) == 2

    InMemoryDataStore.stop(data_store)
  end

  test "ensures number is unique" do
    data_store = InMemoryDataStore.start()

    CreateTodo.new(data_store, %CreateTodo{number: 1, title: "write tests"})
    CreateTodo.new(data_store, %CreateTodo{number: 1, title: "write documentation"})

    todos = ListTodos.list_todos_not_done(data_store)

    assert length(todos) == 1

    [todo | _] = todos

    assert todo.title == "write tests"

    InMemoryDataStore.stop(data_store)
  end

  test "completes a todo" do
    data_store = InMemoryDataStore.start()

    CreateTodo.new(data_store, %CreateTodo{number: 1, title: "write tests"})
    CreateTodo.new(data_store, %CreateTodo{number: 2, title: "write documentation"})

    todos = ListTodos.list_todos_not_done(data_store)

    assert length(todos) == 2

    CompleteTodo.complete(data_store, %CompleteTodo{number: 1})

    todos = ListTodos.list_todos_not_done(data_store)

    assert length(todos) == 1

    [todo | _] = todos

    assert todo.title == "write documentation"

    InMemoryDataStore.stop(data_store)
  end
end
