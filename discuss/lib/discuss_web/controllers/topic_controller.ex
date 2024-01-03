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
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created!")
        |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  @spec update(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    db_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(db_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated!")
        |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: db_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id)
    |> Repo.delete!()

    conn
    |> put_flash(:info, "Topic deleted!")
    |> redirect(to: "/")
  end
end
