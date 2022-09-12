defmodule SupSequence.Server do
  use GenServer

  @me __MODULE__

  #####
  # External API
  def start_link(_) do
    GenServer.start_link(@me, nil, name: @me)
  end

  def next_number do
    GenServer.call(@me, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(@me, {:increment_number, delta})
  end

  def set_number(number) do
    GenServer.cast(@me, {:set, number})
  end

  #####
  # Internel server implementation
  def init(_) do
    initial_state =
      if is_nil(SupSequence.Stash.get()) do
        0
      else
        SupSequence.Stash.get()
      end

    {:ok, initial_state}
  end

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, current_number + delta}
  end

  def handle_cast({:set, number}, _current_number) do
    {:noreply, number}
  end

  def terminate(_reason, current_number) do
    SupSequence.Stash.update(current_number)
  end
end
