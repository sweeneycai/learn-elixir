defmodule Sequence do
  @moduledoc """
  API 层定义。暴露给外部的接口。
  """

  @server Sequence.Server

  def start_link(current_number) do
    GenServer.start_link(@server, current_number, name: @server)
  end

  def next_number do
    GenServer.call(@server, :next_number)
  end

  def increment(delta) do
    GenServer.cast(@server, {:increment, delta})
  end
end
