defmodule Tickets2.Repo.Migrations.AddUserToTickets do
  use Ecto.Migration

  def change do
    alter table(:tickets) do
      add :user_id, references(:users, on_delete: :nothing)
    end
  end
end
