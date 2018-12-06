defmodule Explorer.Chain.Import.ValidationRewards do
  @moduledoc """
  Bulk imports `t:Explorer.Chain.Block.ValidationReward.t/0`.
  """

  alias Ecto.{Changeset, Multi}
  alias Explorer.Chain.Block.ValidationReward
  alias Explorer.Chain.Import

  @behaviour Import.Runner

  # milliseconds
  @timeout 60_000

  @type imported :: [ValidationReward.t()]

  @impl Import.Runner
  def ecto_schema_module, do: ValidationReward

  @impl Import.Runner
  def option_key, do: :validation_rewards

  @impl Import.Runner
  def imported_table_row do
    %{
      value_type: "[#{ecto_schema_module()}.t()]",
      value_description: "List of `t:#{ecto_schema_module()}.t/0`s"
    }
  end

  @impl Import.Runner
  def run(multi, changes_list, %{timestamps: timestamps} = options) do
    insert_options =
      options
      |> Map.put_new(:timeout, @timeout)
      |> Map.put(:timestamps, timestamps)

    Multi.run(multi, option_key(), fn _ -> insert(changes_list, insert_options) end)
  end

  @impl Import.Runner
  def timeout, do: @timeout

  @spec insert([map()], %{required(:timeout) => timeout}) :: {:ok, [ValidationReward.t()]} | {:error, [Changeset.t()]}
  defp insert(changes_list, %{timeout: timeout, timestamps: timestamps}) when is_list(changes_list) do
    Import.insert_changes_list(
      changes_list,
      for: ecto_schema_module(),
      returning: true,
      timeout: timeout,
      timestamps: timestamps
    )
  end
end
