defmodule CompleteTodo do
  @moduledoc """
  Code to complete a todo.
  """

  @enforce_keys [:number]
  defstruct [:number]

  @doc """
  Complete a todo.

  ## Examples

      iex> data_store = [%Todo{number: 2, title: "write documentation", due_date: nil, done: false}]
      iex> todo = %CompleteTodo{number: 2}
      iex> CompleteTodo.complete(data_store, todo)
      :ok

  """
  def complete(data_store, %CompleteTodo{number: number} = _complete_todo) do
    todo = CompleteTodoDataStore.DataStore.find(data_store, number)
    CompleteTodoDataStore.DataStore.update(data_store, %{todo | done: true})
    :ok
  end
end
