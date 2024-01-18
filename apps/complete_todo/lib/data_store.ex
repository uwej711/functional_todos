defmodule CompleteTodoDataStore do
  @moduledoc """
  Datastore that updates a todo and sets it to done
  """

  defprotocol DataStore do
    def find(data_store, number)
    def update(data_store, todo)
  end

end
