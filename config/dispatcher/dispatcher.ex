defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  # match "/themes/*path" do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end

  match "/snippets/*path" do
    Proxy.forward conn, path, "http://snippets/"
  end

  match "/verkeersbordcombinaties/*path" do
    Proxy.forward conn, path, "http://resource/verkeersbordcombinaties/"
  end

  match "/maatregelconcepten/*path" do
    Proxy.forward conn, path, "http://resource/maatregelconcepten/"
  end

  match "/verkeersbordconcepten/*path" do
    Proxy.forward conn, path, "http://resource/verkeersbordconcepten/"
  end

  match "/verkeersbordcategorieen/*path" do
    Proxy.forward conn, path, "http://resource/verkeersbordcategorieen/"
  end

  match "/verkeersbordconcept-status-codes/*path" do
    Proxy.forward conn, path, "http://resource/verkeersbordconcept-status-codes/"
  end

  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
