defmodule Console.Helpers do
  @moduledoc """
  Functions for all mix tasks
  """

  @directory "/tmp/todo/console"

  def storage() do
    %FileDataStorage{directory: @directory}
  end
end
