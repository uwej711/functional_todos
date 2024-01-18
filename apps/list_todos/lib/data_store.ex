defmodule ListTodosDataStore do
  @moduledoc """
  Define a data store that can list stored todos.
  """

  defprotocol DataStore do
    def find_todos(data_store)
  end

end
