defmodule Duper.Worker do

  # If this worker terminates normally, the supervisor won't restart it,
  # but will restart it if it fails.
  use GenServer, restart: :transient

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args)
  end

  def init(:no_args) do
    Process.send_after(self(), :do_one_file, 0)
    {:ok, nil}
  end

  def handle_info(:do_one_file, _) do
    Duper.PathFinder.next_path()
    |> add_result()
  end

  def add_result(nil) do
    Duper.Gatherer.done()
    {:noreply, nil}
  end

  def add_result(path) do
    Duper.Gatherer.result(path, hash_of_file_at(path))
    send(self(), :do_one_file)
    {:noreply, nil}
  end

  defp hash_of_file_at(path) do
    File.stream!(path, [], 1024 * 1024)
    |> Enum.reduce(
      :crypto.hash_init(:md5),
      fn (block, hash) ->
        :crypto.hash_update(hash, block)
      end
    )
    |> :crypto.hash_final()
  end
end
