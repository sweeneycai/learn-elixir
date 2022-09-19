defmodule Duper.Results do
  @moduledoc """
  `Results` server, wraps an Elixir map as a duper result.
  This module can hold duper's state, we can add a kv value, and find duplicates through this.
  """
  use GenServer

  @me __MODULE__

  # Outer API
  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: @me)
  end

  def add_hash_for(path, hash) do
    GenServer.cast(@me, {:add, path, hash})
  end

  def find_duplicates() do
    GenServer.call(@me, :find_duplicates)
  end

  # Server Implementation
  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:add, path, hash}, results) do
    # if we find a key, then update this key with it's relevent paths, otherwise we add this key to our results.
    results = Map.update(
      results,
      hash,
      [path],
      fn existing -> [path | existing] end
    )
    {:noreply, results}
  end

  def handle_call(:find_duplicates, _from, results) do
    # find duplicates from our results
    {:reply, hashes_with_more_than_one_path(results), results}
  end

  defp hashes_with_more_than_one_path(results) do
    results
    |> Enum.filter(fn {_hash, paths} -> length(paths) > 1 end)
    |> Enum.map(&elem(&1, 1))
  end

end
