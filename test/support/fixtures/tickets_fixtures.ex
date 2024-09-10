defmodule Tickets2.TicketsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tickets2.Tickets` context.
  """

  @doc """
  Generate a ticket.
  """
  def ticket_fixture(attrs \\ %{}) do
    {:ok, ticket} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> Tickets2.Tickets.create_ticket()

    ticket
  end
end
