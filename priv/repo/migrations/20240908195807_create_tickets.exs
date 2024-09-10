defmodule Tickets2.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :title, :text
      add :body, :text

      timestamps(type: :utc_datetime)
    end
  end
end
