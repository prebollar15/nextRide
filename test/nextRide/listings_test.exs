defmodule NextRide.ListingsTest do
  use NextRide.DataCase

  alias NextRide.Listings

  describe "vehicles" do
    alias NextRide.Listings.Vehicle

    @valid_attrs %{city: "some city", description: "some description", make: "some make", model: "some model", price: 42, trim: "some trim", year: 42, zip: 42}
    @update_attrs %{city: "some updated city", description: "some updated description", make: "some updated make", model: "some updated model", price: 43, trim: "some updated trim", year: 43, zip: 43}
    @invalid_attrs %{city: nil, description: nil, make: nil, model: nil, price: nil, trim: nil, year: nil, zip: nil}

    def vehicle_fixture(attrs \\ %{}) do
      {:ok, vehicle} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Listings.create_vehicle()

      vehicle
    end

    test "list_vehicles/0 returns all vehicles" do
      vehicle = vehicle_fixture()
      assert Listings.list_vehicles() == [vehicle]
    end

    test "get_vehicle!/1 returns the vehicle with given id" do
      vehicle = vehicle_fixture()
      assert Listings.get_vehicle!(vehicle.id) == vehicle
    end

    test "create_vehicle/1 with valid data creates a vehicle" do
      assert {:ok, %Vehicle{} = vehicle} = Listings.create_vehicle(@valid_attrs)
      assert vehicle.city == "some city"
      assert vehicle.description == "some description"
      assert vehicle.make == "some make"
      assert vehicle.model == "some model"
      assert vehicle.price == 42
      assert vehicle.trim == "some trim"
      assert vehicle.year == 42
      assert vehicle.zip == 42
    end

    test "create_vehicle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Listings.create_vehicle(@invalid_attrs)
    end

    test "update_vehicle/2 with valid data updates the vehicle" do
      vehicle = vehicle_fixture()
      assert {:ok, %Vehicle{} = vehicle} = Listings.update_vehicle(vehicle, @update_attrs)
      assert vehicle.city == "some updated city"
      assert vehicle.description == "some updated description"
      assert vehicle.make == "some updated make"
      assert vehicle.model == "some updated model"
      assert vehicle.price == 43
      assert vehicle.trim == "some updated trim"
      assert vehicle.year == 43
      assert vehicle.zip == 43
    end

    test "update_vehicle/2 with invalid data returns error changeset" do
      vehicle = vehicle_fixture()
      assert {:error, %Ecto.Changeset{}} = Listings.update_vehicle(vehicle, @invalid_attrs)
      assert vehicle == Listings.get_vehicle!(vehicle.id)
    end

    test "delete_vehicle/1 deletes the vehicle" do
      vehicle = vehicle_fixture()
      assert {:ok, %Vehicle{}} = Listings.delete_vehicle(vehicle)
      assert_raise Ecto.NoResultsError, fn -> Listings.get_vehicle!(vehicle.id) end
    end

    test "change_vehicle/1 returns a vehicle changeset" do
      vehicle = vehicle_fixture()
      assert %Ecto.Changeset{} = Listings.change_vehicle(vehicle)
    end
  end
end
