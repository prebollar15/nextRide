defmodule NextRideWeb.AuthController do
    use NextRideWeb, :controller
    plug Ueberauth

    alias NextRide.Listings.Vehicles
    alias NextRide.Repo
    alias NextRide.Accounts.User
    alias NextRide.Accounts

    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
        user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
        changeset = User.changeset(%User{}, user_params)

        signin(conn, changeset)
    end

    defp insert_or_update_user(changeset) do
        case Repo.get_by(User, email: changeset.changes.email) do
            nil -> 
                Repo.insert(changeset)
            user -> 
                {:ok, user}
        end 
    end


    #Will return back an error or an error
    #Put the Session cookie(key of :user_id & add the user.id)
    defp signin(conn, changeset) do
        case insert_or_update_user(changeset) do
            {:ok, user} ->
                conn
                |> put_flash(:info, "Welcome back!")
                |> put_session(:user_id, user.id)
                |> redirect(to: Routes.vehicle_path(conn, :index))

            {:error, _reason} ->
                conn
                |> put_flash(:error, "Error signing in")
                |> redirect(to: Routes.vehicle_path(conn, :index))
        end
    end

    def signout(conn, _params) do
        conn
        |> configure_session(drop: true)
        |> redirect(to: Routes.vehicle_path(conn, :index))

    end

  end