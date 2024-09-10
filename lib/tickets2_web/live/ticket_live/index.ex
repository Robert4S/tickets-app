defmodule Tickets2Web.TicketLive.Index do
  alias Tickets2.Tickets
  use Tickets2Web, :live_view

  def mount(_params, _session, socket) do
    uid = socket.assigns.current_user.id

    socket =
      socket
      |> assign(:tickets, Tickets.list_tickets(uid))

    {:ok, socket}
  end

  def handle_event("delete_ticket", %{"id" => id}, socket) do
    uid = socket.assigns.current_user.id

    case Tickets.get_ticket(id) do
      {:ok, ticket} ->
        {:ok, _} = Tickets.delete_ticket(ticket)

        socket =
          socket
          |> assign(:tickets, Tickets.list_tickets(uid))
          |> put_flash(:info, "Ticket '#{ticket.title}' successfully marked as completed.")

        {:noreply, socket}

      {:error, _reason} ->
        socket =
          socket
          |> put_flash(:error, "Ticket does not exist in database")
          |> assign(:tickets, Tickets.list_tickets(uid))

        {:noreply, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <div class="flex gap-2">
      <h1 class="grow text-2xl font-bold">Current Tickets</h1>
      <.link
        navigate={~p"/dick"}
        class="bg-black border border-black hover:bg-gray-700 text-white font-bold py-2 px-3 rounded-md"
      >
        I'm feeling lucky
      </.link>
      <.link
        navigate={~p"/tickets/new"}
        class="bg-black border border-black hover:bg-gray-700 text-white font-bold py-2 px-3 rounded-md"
      >
        Add Ticket
      </.link>
    </div>

    <div class="space-y-4 mt-4">
      <%= for ticket <- @tickets do %>
        <div class="flex items-stretch bg-white shadow rounded-lg border border-gray-200">
          <div class="flex-grow p-4">
            <h2 class="text-lg font-semibold"><%= ticket.title %></h2>
            <p class="mt-2"><%= ticket.body %></p>
          </div>
          <div class="flex items-center flex-shrink-0">
            <button
              phx-click="delete_ticket"
              phx-value-id={ticket.id}
              class="bg-gray-300 hover:bg-green-200 text-white px-4 py-2 rounded-r-lg h-full px-4 py-2"
            >
              Mark as done
            </button>
          </div>
        </div>
      <% end %>
    </div>
    """
  end
end
