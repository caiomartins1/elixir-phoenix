defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.{Topic, Repo}

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render(conn, :index, topics: topics)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    conn
    |> render(:new, changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic created!")
        |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
