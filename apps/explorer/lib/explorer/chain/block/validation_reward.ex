defmodule Explorer.Chain.Block.ValidationReward do
  @moduledoc """
  Represents the total reward given to an address in a block.
  """

  use Explorer.Schema

  alias Explorer.Chain.Block.ValidationReward
  alias Explorer.Chain.Hash.Address
  alias Explorer.Chain.{Block, Wei}

  @required_attrs ~w(address_hash block_number reward)a

  @typedoc """
  The validation reward given related to a block.

  * `:block_number` - Number of the block validation
  * `:address_hash` - Hash of address who received the reward
  * `:reward` - Validation reward given in Wei
  """
  @type t :: %ValidationReward{
          block_number: Block.block_number(),
          address_hash: Address.t(),
          reward: Wei.t()
        }

  @primary_key false
  schema "validation_rewards" do
    field(:block_number, :integer)
    field(:address_hash, Address)
    field(:reward, Wei)

    timestamps()
  end

  def changeset(%__MODULE__{} = reward, attrs) do
    reward
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
  end
end
