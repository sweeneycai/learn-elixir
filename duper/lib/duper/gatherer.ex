defmodule Duper.Gatherer do
  @moduledoc """

  """
  use GenServer

  @me Gatherer

  def start_link(worker_count) do
    GenServer.start_link(__MODULE__, worker_count, name: @me)
  end

  def done() do
    GenServer.cast(@me, :done)
  end

  def result(path, hash) do
    GenServer.cast(@me, {:result, path, hash})
  end

  @doc """
  初始化 Gatherer。当 Gatherer 完成初始化之后，再添加 worker，否则在初始化之前 worker 发送的消息可能会丢失。
  此处调用 `self()` 有返回值即表示当前线程 Gatherer 完成了初始化。
  """
  def init(worker_count) do
    Process.send_after(self(), :kickoff, 0)
    {:ok, worker_count}
  end

  def handle_info(:kickoff, worker_count) do
    1..worker_count
    |> Enum.each(fn _ -> Duper.WorkerSupervisor.add_worker() end)
    {:noreply, worker_count}
  end

  def handle_cast(:done, _worker_count = 1) do
    report_results()
    System.halt(0)
  end

  def handle_cast(:done, worker_count) do
    # TODO Log here
    {:noreply, worker_count - 1}
  end

  def handle_cast({:result, path, hash}, worker_count) do
    Duper.Results.add_hash_for(path, hash)
    {:noreply, worker_count}
  end

  defp report_results() do
    IO.puts("Results:\n")
    Duper.Results.find_duplicates()
    |> Enum.each(&IO.inspect/1)
  end
end
