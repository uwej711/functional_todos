defmodule ListTodos do
  @moduledoc """
  Logic to list all todos not done yet
  """

  defstruct [:number, :title, :due_date]

  @doc """
  List todos not done

  ## Examples

      iex> data_store = [%Todo{number: 1, title: "write tests", due_date: nil}]
      iex> ListTodos.list_todos_not_done(data_store)
      [%ListTodos{number: 1, title: "write tests", due_date: nil}]

  """
  def list_todos_not_done(data_store) do
    data_store
    |> ListTodosDataStore.DataStore.find_todos()
    |> Enum.filter(fn(todo) -> !todo.done end)
    |> Enum.map(&to_list_todo/1)
  end

  defp to_list_todo(%Todo{} = todo) do
    struct(%__MODULE__{}, Map.from_struct(todo) |> Map.delete(:done))
  end
end
