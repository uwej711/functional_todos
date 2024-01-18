defmodule Todo do
  @moduledoc """
  The module `Todo` contains the definition of the data structure of a todo.
  """

  @enforce_keys [:number, :title, :due_date]
  defstruct number: nil, title: nil, due_date: nil, done: false
end
