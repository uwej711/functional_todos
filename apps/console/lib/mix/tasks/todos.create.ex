defmodule Mix.Tasks.Todos.Create do
  @moduledoc """
  Mix tasks to create a todo
  """

  alias Console.Helpers

  @shortdoc "create a todo: mix todos.create 1 'write tests'"
  def run([number | [ title |_ ]]) do
    todo = %CreateTodo{number: number, title: title}
    CreateTodo.new(Helpers.storage, todo)
  end
end
