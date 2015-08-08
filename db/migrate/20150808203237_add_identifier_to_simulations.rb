class AddIdentifierToSimulations < ActiveRecord::Migration
  def change
    add_column :simulations, :identifier, :string
  end
end
