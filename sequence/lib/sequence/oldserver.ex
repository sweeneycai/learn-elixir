defmodule Sequence.OldServer do
  use GenServer

  #####
  # External API

  def start_link(current_number) do
    GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment, delta})
  end

  #####
  # GenServer Implementation

  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_call(action, _from, current_state) do
    case action do
      :next_number ->
        {:reply, current_state, current_state + 1}
      :pop ->
        {:reply, hd(current_state), tl(current_state)}
      {:set, value} ->
        {:reply, value, value}
      {:push, value} ->
        {:reply, [value | current_state], [value | current_state]}
    end
  end

  def handle_cast({:increment, delta}, current_state) do
    {:noreply, current_state + delta}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'state', "My current state is '#{inspect(state)}'"}]]
  end
end
