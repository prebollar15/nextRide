defmodule NextRide.Repo.Migrations.AddUserIdtoVehicles do
  use Ecto.Migration

  def change do
    alter table(:vehicles) do
      add :user_id, references(:users)
    end 
  end
end
