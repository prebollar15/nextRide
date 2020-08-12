defmodule NextRideWeb.VehicleController do
  use NextRideWeb, :controller

  alias NextRide.Listings
  alias NextRide.Listings.Vehicle
  alias NextRide.Repo

  plug NextRideWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_vehicle_owner when action in [:update, :edit, :delete]

  def index(conn, _params) do
    vehicles = Listings.list_vehicles()
    render(conn, "index.html", vehicles: vehicles)
  end

  def new(conn, _params) do
    changeset = Listings.change_vehicle(%Vehicle{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"vehicle" => vehicle_params}) do
    
    changeset = conn.assigns[:user]
    |> Ecto.build_assoc(:topics)
    |> Vehicle.changeset(vehicle_params)
    
    case Repo.insert(changeset)do
      {:ok, vehicle} ->
        conn
        |> put_flash(:info, "Vehicle created successfully.")
        |> redirect(to: Routes.vehicle_path(conn, :show, vehicle))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    vehicle = Listings.get_vehicle!(id)
    render(conn, "show.html", vehicle: vehicle)
  end

  def edit(conn, %{"id" => id}) do
    vehicle = Listings.get_vehicle!(id)
    changeset = Listings.change_vehicle(vehicle)
    render(conn, "edit.html", vehicle: vehicle, changeset: changeset)
  end

  def update(conn, %{"id" => id, "vehicle" => vehicle_params}) do
    vehicle = Listings.get_vehicle!(id)

    case Listings.update_vehicle(vehicle, vehicle_params) do
      {:ok, vehicle} ->
        conn
        |> put_flash(:info, "Vehicle updated successfully.")
        |> redirect(to: Routes.vehicle_path(conn, :show, vehicle))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", vehicle: vehicle, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    vehicle = Listings.get_vehicle!(id)
    {:ok, _vehicle} = Listings.delete_vehicle(vehicle)

    conn
    |> put_flash(:info, "Vehicle deleted successfully.")
    |> redirect(to: Routes.vehicle_path(conn, :index))
  end

  def check_vehicle_owner(conn, _params) do
    %{params: %{"id" => vehicle_id}} = conn

    if Repo.get(Vehicle, vehicle_id).user_id == conn.assigns.user.id do
      conn

    else
      conn
      |> put_flash(:error, "You cannot edit that vehicle")
      |> redirect(to: Routes.vehicle_path(conn, :index))
      |> halt()
    end
  end 
end
