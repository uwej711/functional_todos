defmodule CreateTodoDataStore do
  @moduledoc """
  Define a data store that can store a new todo.
  """

  defprotocol DataStore do
    def create_todo(data_store, todo)
  end

end
