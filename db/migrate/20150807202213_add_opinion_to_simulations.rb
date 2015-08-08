class AddOpinionToSimulations < ActiveRecord::Migration
  def change
    add_column :simulations, :opinion, :string
  end
end
