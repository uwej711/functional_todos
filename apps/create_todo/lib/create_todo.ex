defmodule CreateTodo do
  @moduledoc """
  Functionality needed to create a todo.
  """

  @enforce_keys [:number, :title]
  defstruct [:number, :title, :due_date]

  @doc """
  Create a todo

  ## Examples

      iex> data_store = []
      iex> todo = %CreateTodo{number: 2, title: "title"}
      iex> CreateTodo.new(data_store, todo)
      :ok

  """
  def new(data_store, %CreateTodo{} = create_todo) do
    CreateTodoDataStore.DataStore.create_todo(data_store, to_todo(create_todo))
    :ok
  end

  defp to_todo(create_todo) do
    struct(%Todo{number: nil, title: nil, due_date: nil}, Map.from_struct(create_todo) |> Map.put(:due_date, nil))
  end
end
