defmodule Tickets2Web.PageController do
  use Tickets2Web, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    if conn.assigns[:current_user] do
      redirect(conn, to: ~p"/tickets")
    else
      redirect(conn, to: ~p"/users/log_in")
    end
  end
end
