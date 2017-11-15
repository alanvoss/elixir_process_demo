defmodule QuickAgent do
  def new do
    spawn(__MODULE__, :state, [%{}])
  end

  def get(pid) do
    send(pid, {self(), :get})
    receive do
      {:ok, state} -> state
    end
  end

  def set(pid, k, v) do
    send(pid, {self(), :set, k, v})
    receive do
      {:ok, state} -> state
    end
  end

  def state(state) do
    receive do
      {pid, :get} ->
        send(pid, {:ok, state})
        state(state)
      {pid, :set, k, v} ->
        new_state = Map.put(state, k, v)
        send(pid, {:ok, new_state})
        state(new_state)
    end
  end
end
