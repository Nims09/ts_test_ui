class RemoveVerdictFromSimulation < ActiveRecord::Migration
  def change
  	remove_column :simulations, :verdict, :string
  end
end
