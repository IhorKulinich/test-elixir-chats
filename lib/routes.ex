defmodule Sample.Routes do
    use N2O, with: [:kvs, :n2o, :nitro]
    use Nitro
    # import Nitro.Router

    # get "/index", Sample.Routes, :index
    # get "/chat/:chat_id", ChatWeb.ChatController, :chat
    # get "/", Sample.Routes, :index_redirect

    def routes do
        [
          {"/index", :get, &index/1},
          {"/chat/:chat_id", :get, &chat/2},
          {"/", :get, &index_redirect/1}
        ]
    end

    def index(conn) do
        html_response("index.html")
    end

    def index_redirect(conn) do
        conn
        |> Nitro.Conn.put_status(302)
        |> Nitro.Conn.put_resp_header("location", "/index")
        |> Nitro.Conn.send_resp(302, "")
    end

    defp html_response(template, assigns \\ %{}) do
        Nitro.html_response(template, assigns, [])
    end

    def chat(conn, %{params: %{"chat_id" => chat_id}}) do
        chat_data = get_chat_data(chat_id)
        html_response("chat.html", chat_data: chat_data)
    end

    defp get_chat_data(chat_id) do
        chat_data = %{id: chat_id, messages: KVS.all(chat_id).messages}
    end
end
