defmodule InMemoryDataStore do

  defstruct [:agent]

  def start() do
    {:ok, agent} = Agent.start_link(fn -> Map.new() end)
    %__MODULE__{agent: agent}
  end

  def stop(%__MODULE__{agent: agent}) do
    Agent.stop(agent)
  end

  def get(%__MODULE__{agent: agent}, number) do
    Agent.get(agent, &Map.get(&1, number))
  end

  def put_new(%__MODULE__{agent: agent}, %Todo{number: number} = todo) do
    Agent.get_and_update(agent, &store_todo_by_number(&1, number, todo))
  end

  def put(%__MODULE__{agent: agent}, %Todo{number: number} = todo) do
    Agent.update(agent, &Map.put(&1, number, todo))
  end

  def values(%__MODULE__{agent: agent}) do
    Agent.get(agent, &Map.values(&1))
  end

  defp store_todo_by_number(map, number, todo) do
    case Map.fetch(map, number) do
      {:ok, _} -> {{:error, :number_already_taken}, map}
      _ -> {:ok, Map.put(map, number, todo)}
    end
  end

  defimpl CreateTodoDataStore.DataStore, for: InMemoryDataStore do
    def create_todo(data_store, todo) do
      InMemoryDataStore.put_new(data_store, todo)
    end
  end

  defimpl ListTodosDataStore.DataStore, for: InMemoryDataStore do
    def find_todos(data_store) do
      InMemoryDataStore.values(data_store)
    end
  end

  defimpl CompleteTodoDataStore.DataStore, for: InMemoryDataStore do
    def find(data_store, number) do
      InMemoryDataStore.get(data_store, number)
    end

    def update(data_store, todo) do
      InMemoryDataStore.put(data_store, todo)
    end
  end
end
