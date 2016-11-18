defmodule State do
  def get_storer do
    spawn(State, :state_storer, [%{}])
  end

  def get(pid, key) do
    send(pid, {:get, key, self()})
    receive do
      value -> value
    end
  end

  def set(pid, key, value) do
    send(pid, {:set, key, value})
    value
  end

  def state_storer(map) do
    receive do
      {:get, key, caller} ->
        send caller, Map.get(map, key)
        state_storer(map)
      {:set, key, value} ->
        state_storer(Map.put(map, key, value))
    end
  end
end
