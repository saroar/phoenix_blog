defmodule Blog.PostsController do
  use Blog.Web, :controller

  plug :action

  def index(conn, _params) do
    posts = Blog.Repo.all(Blog.Post)
    render conn, "index.html", posts: posts
  end

  def show(conn, %{ "id" => id}) do
    post = Blog.Post |> Blog.Repo.get(id)
    render conn, "show.html", post: post
  end

  def new(conn, _params) do
    post = %Blog.Post{title: "",content: ""}
    render conn, "new.html", post: post
  end

  def create(conn, params) do
    post = %Blog.Post{
      title: params["post"]["title"],
      content: params["post"]["content"]
    }
    Blog.Repo.insert!(post)
    redirect conn, to: "/posts"
  end

  def edit(conn, %{ "id" => id }) do
    post = Blog.Post |> Blog.Repo.get(id)
    render conn, "edit.html", post: post
  end

  def update(conn, %{ "id" => id, "post" => %{ "title" => title, "content" => content } }) do
    post = Blog.Post |> Blog.Repo.get(id)
    %{
      post |
      title: title,
      content: content
    } |> Blog.Repo.update!

    conn |> redirect(to: post_path(conn, :show, post))
  end

  def delete(conn, %{ "id" => id }) do
    post = Blog.Post
    |> Blog.Repo.get(id)
    |> Blog.Repo.delete!

    conn |> redirect(to: posts_path(conn, :index))
  end
end
