defmodule NextRide.Repo.Migrations.CreateVehicles do
  use Ecto.Migration

  def change do
    create table(:vehicles) do
      add :year, :integer
      add :make, :string
      add :model, :string
      add :trim, :string
      add :price, :integer
      add :city, :string
      add :zip, :integer
      add :description, :string

      timestamps()
    end

  end
end
