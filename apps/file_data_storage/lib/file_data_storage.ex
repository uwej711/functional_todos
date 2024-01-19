defmodule FileDataStorage do
  @moduledoc """
  Module to store todos in files in a directory.
  """

  defstruct [directory: "/tmp/todos"]

  def create_new(%__MODULE__{directory: directory}, %Todo{number: number} = todo) do
    ensure_directory(directory)
    case File.exists?(filename(directory, number)) do
      true -> {:error, :number_already_taken}
      _ -> File.write(filename(directory, number), serialize(todo))
    end
 end

  def list_files(directory) do
    Path.wildcard("#{directory}/*.todo")
  end

  def get_todo(path) do
    File.read!(path) |> deserialize
  end

  defp ensure_directory(directory) do
    unless File.exists?(directory) do
      File.mkdir_p!(directory)
    end
  end

  def filename(directory, number) do
    "#{directory}/#{number}.todo"
  end

  def serialize(todo) do
    todo |> :erlang.term_to_binary()
  end

  defp deserialize(binary_todo) do
    binary_todo |> :erlang.binary_to_term()
  end

  defimpl CreateTodoDataStore.DataStore, for: FileDataStorage do
    def create_todo(data_store, todo) do
      FileDataStorage.create_new(data_store, todo)
    end
  end

  defimpl ListTodosDataStore.DataStore, for: FileDataStorage do
    def find_todos(%FileDataStorage{directory: directory}) do
      directory |> FileDataStorage.list_files() |> Enum.map(&FileDataStorage.get_todo/1)
    end
  end

  defimpl CompleteTodoDataStore.DataStore, for: FileDataStorage do
    def find(%FileDataStorage{directory: directory}, number) do
      FileDataStorage.get_todo(FileDataStorage.filename(directory, number))
    end

    def update(%FileDataStorage{directory: directory}, %Todo{number: number} = todo) do
      File.write(FileDataStorage.filename(directory, number), FileDataStorage.serialize(todo))
    end
  end
end
