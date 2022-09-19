defmodule Duper.WorkerSupervisor do
  @moduledoc """
  *worker* 的监督者，可以监督任意数量的子任务。本质上是一个 *WorkerSupervisor*。
  """
  use DynamicSupervisor

  @me WorkerSupervisor

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :no_args, name: @me)
  end

  def init(:no_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def add_worker() do
    {:ok, _pid} = DynamicSupervisor.start_child(@me, Duper.Worker)
  end
end
