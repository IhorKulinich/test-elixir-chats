defmodule Sample.Routes do
    use N2O, with: [:kvs, :n2o, :nitro]
    import Nitro.Router

    get "/index", Sample.Routes, :index
    get "/chat/:chat_id", ChatWeb.ChatController, :chat
    get "/", Sample.Routes, :index_redirect

    match _ do
        send_resp(conn, 404, "Not Found")
    end

    def index(socket) do
        {:ok, render(socket, "index.html")}
    end

    def index_redirect(conn, _) do
        conn
        |> redirect(to: "/index")
    end

    def chat(socket, %{params: %{"chat_id" => chat_id}}) do
        chat_data = get_chat_data(chat_id)
        {:ok, render(socket, "chat.html", chat_data: chat_data)}
    end

    def handle_event("open_chat", %{"chat_id" => chat_id}, socket) do
        chat_data = get_chat_data(chat_id)
        {:noreply, render(socket, "chat.html", chat_data: chat_data)}
    end

    defp get_chat_data(chat_id) do
        chat_data = %{id: chat_id, messages: KVS.all(chat_id).messages}
    end
end
