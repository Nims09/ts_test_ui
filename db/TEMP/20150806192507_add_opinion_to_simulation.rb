class AddOpinionToSimulation < ActiveRecord::Migration
  def change
    add_column :simulations, :opinion, :hash
  end
end
