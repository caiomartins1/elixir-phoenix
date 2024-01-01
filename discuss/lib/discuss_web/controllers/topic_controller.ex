defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Topic

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    conn
    |> render(:new, changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    IO.inspect(topic)
    conn
  end
end
