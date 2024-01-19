defmodule Mix.Tasks.Todos.List do
  @moduledoc """
  Mix tasks to list all todos
  """

  alias Console.Helpers

  @shortdoc "list todos: mix todos.list"
  def run(_) do
    Helpers.storage
    |> ListTodos.list_todos_not_done()
    |> Enum.each(fn todo -> IO.puts("Number: #{todo.number}, title: #{todo.title}") end)
  end
end
