defmodule Tickets2Web.TicketLive.Dick do
  use Tickets2Web, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:text, "Click here")
      |> assign(:other_text, "Юрец педик")
      |> assign(:button_class, "w-32 h-12 transition-all duration-1000")
      |> assign(
        :other_class,
        "text-7xl text-black font-bold w-full h-80 pride-flag transition-all duration-1000 opacity-1"
      )
      |> assign(:wanted_event, "click clicked")

    {:ok, socket}
  end

  def handle_event("clicked", _, socket) do
    current_class = socket.assigns[:button_class]
    new_class = socket.assigns[:other_class]
    text = socket.assigns[:text]
    other_text = socket.assigns[:other_text]

    socket =
      socket
      |> assign(:text, other_text)
      |> assign(:other_text, text)
      |> assign(:button_class, new_class)
      |> assign(:other_class, current_class)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex items-center justify-center">
      <.button class={@button_class} phx-click="clicked" phx-mounted={JS.remove_class("opacity-1")}>
        <%= @text %>
      </.button>
    </div>
    """
  end
end
