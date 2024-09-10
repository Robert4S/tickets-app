defmodule Tickets2Web.TicketLive.New do
  alias Tickets2.Tickets
  use Tickets2Web, :live_view

  def mount(_params, _session, socket) do
    changeset = Tickets.Ticket.changeset(%Tickets.Ticket{})

    socket =
      socket
      |> assign(:ticket, to_form(changeset))

    {:ok, socket}
  end

  def handle_event("submit", %{"ticket" => ticket}, socket) do
    uid = socket.assigns.current_user.id
    ticket = Map.put(ticket, "user_id", uid)

    case Tickets.create_ticket(ticket) do
      {:ok, _ticket} ->
        new_socket =
          socket
          |> put_flash(:info, "Ticket created successfully")
          |> push_navigate(to: ~p"/tickets")

        {:noreply, new_socket}

      {:error, changeset} ->
        socket =
          socket
          |> assign(:ticket, to_form(changeset))

        {:noreply, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <h1 class="grow text-2xl font-bold mb-6">
      Add New Ticket
    </h1>
    <.form for={@ticket} phx-submit="submit">
      <div class="flex gap-2 items-end">
        <div class="grow">
          <.input field={@ticket[:title]} type="text" label="Title" />
        </div>
        <div class="grow">
          <.input field={@ticket[:body]} type="text" label="Body" />
        </div>
        <button class="bg-black border border-black hover:bg-gray-700 text-white font-bold py-2 px-3 rounded-md">
          Create new ticket
        </button>
      </div>
    </.form>
    """
  end
end
