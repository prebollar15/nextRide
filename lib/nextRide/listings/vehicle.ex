defmodule NextRide.Listings.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vehicles" do
    field :city, :string
    field :description, :string
    field :make, :string
    field :model, :string
    field :price, :integer
    field :trim, :string
    field :year, :integer
    field :zip, :integer
    belongs_to :user, NextRide.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, [:year, :make, :model, :trim, :price, :city, :zip, :description])
    |> validate_required([:year, :make, :model, :trim, :price, :city, :zip, :description])
  end
end
