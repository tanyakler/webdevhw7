defmodule EventsWeb.Helpers do
  def have_current_user?(conn) do
    conn.assigns[:current_user] != nil
  end
  def current_user_id?(conn, user_id) do
    user = conn.assigns[:current_user]
    user && user.id == user_id
  end
  def current_user_id(conn) do
    user = conn.assigns[:current_user]
    user && user.id
  end
  def rsvpcounts(conn) do
    post = conn.assigns[:post]
    invites = post.invites
    y = to_string(Enum.count(invites, fn i -> i.response == "Yes" || "yes" end))
    n = to_string(Enum.count(invites, fn i -> i.response == "No" || "no" end))
    m = to_string(Enum.count(invites, fn i -> i.response == "Maybe" || "maybe" end))
    na = to_string(Enum.count(invites, fn i -> i.response == "n/a" end))
    y <> " yes -" <> n <> " no -" <> m <> " maybe -" <> na <> " no response "
  end
  def invited?(conn, post) do
    invites = post.invites
    email = conn.assigns[:current_user].email
    hasInvite = Enum.count(invites, fn u -> u.email == email end)
    if hasInvite > 0 do
      true
    else
      false
    end
  end
end
