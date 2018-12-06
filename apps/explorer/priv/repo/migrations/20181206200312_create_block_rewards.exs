defmodule Explorer.Repo.Migrations.CreateBlockRewards do
  use Ecto.Migration

  def change do
    create table(:block_rewards, primary_key: false) do
      add(:address_hash, :bytea, null: false)
      add(:block_number, :bigint, null: false)
      add(:reward, :numeric, precision: 100, null: false)

      timestamps(null: false, type: :utc_datetime)
    end
  end
end
