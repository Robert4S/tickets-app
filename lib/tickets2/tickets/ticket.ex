defmodule Tickets2.Tickets.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tickets" do
    field :title, :string
    field :body, :string
    belongs_to :user, Tickets2.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ticket, attrs \\ %{}) do
    ticket
    |> cast(attrs, [:title, :body, :user_id])
    |> validate_required([:title, :body, :user_id])
  end
end
