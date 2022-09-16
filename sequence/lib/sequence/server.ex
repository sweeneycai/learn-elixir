defmodule Sequence.Server do
  @moduledoc """
  单纯服务器逻辑，不涉及业务逻辑的实现。
  """

  use GenServer
  alias Sequence.Impl

  def init(initial_number) do
    {:ok, initial_number}
  end

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, Impl.next_number(current_number)}
  end

  def handle_cast({:increment, delta}, current_number) do
    {:noreply, Impl.increment(current_number, delta)}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect(state)}'"}]]
  end
end
