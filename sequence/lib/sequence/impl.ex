defmodule Sequence.Impl do
  @moduledoc """
  单纯业务逻辑，不涉及其他技术逻辑的实现。
  """

  def next_number(number) do
    number + 1
  end

  def increment(current_number, delta) do
    current_number + delta
  end
end

