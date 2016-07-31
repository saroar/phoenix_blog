defmodule Blog.Post do
  use Blog.Web, :model
  import Ecto.Query

  schema "posts" do
    field :title, :string
    field :content, :string

    timestamps
  end
  
end
