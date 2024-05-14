defmodule ChatWeb.ChatController do
    use N2O, with: [:kvs, :n2o, :nitro]
    use Nitro

    def send_notification(message) do
        event({:notification, message})
    end

    def handle_event({:notification, message}, socket) do
        room = Sample.Application.room()
        KVS.ensure(writer(id: room))
        N2O.reg({:topic, room})
        N2O.reg(N2O.sid())
        Nitro.clear(:history)
        Nitro.update(:send, button(id: :send, body: "Chat", postback: :chat, source: [:message]))
        Nitro.broadcast!(socket, :client, %{message: message})
        {:ok, socket}
    end

    def event(:chat) do
        chat(Nitro.q(:message))
    end

    def event({:client, {message}}, socket) do
        Nitro.reply!(socket, update_chat(message))
        {:ok, socket}
    end

    def update_chat({message}) do
        Nitro.insert_bottom(:history, message(body: [Nitro.jse(message)]))
    end

    def chat(message) do
        room = Sample.Application.room

        room
        |> KVS.writer()
        |> writer(args: {:msg, KVS.seq([], []), message})
        |> KVS.add()
        |> KVS.save()

        N2O.send({:topic, room}, N2O.client(data: {message}))
    end

end


defmodule ChatWeb.PageController do
    use Nitro

    def chat(conn, _params) do
        {:ok, conn, html_response(conn, :chat)}
    end

    defp html_response(conn, template) do
        Nitro.html_response(conn, template, [])
    end
end
