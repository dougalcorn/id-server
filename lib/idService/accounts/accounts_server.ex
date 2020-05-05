defmodule IdService.AccountsServer do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def get_user!(id) do
    GenServer.call(__MODULE__, {:get_user, id})
  end

  def handle_call({:get_user, id}, _from, state) do
    resource = IdService.Accounts.get_user!(id)
    {:reply, resource, %{}}
  end
end
