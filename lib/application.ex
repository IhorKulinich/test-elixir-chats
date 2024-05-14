defmodule Sample.Application do
  use Application

  def start(_type, _args) do
    :ok = KVS.start_link()
    room = "1"
    {:ok, room}
  end

  def room() do
    Application.get_env(:sample, :room)
  end
end