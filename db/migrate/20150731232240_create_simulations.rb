class CreateSimulations < ActiveRecord::Migration
  def change
    create_table :simulations do |t|
  		t.integer :x_size
  		t.integer :y_size
  		t.string :verdict
  		t.string :arrangement 
    end

  	add_reference :simulations, :user, index: true    
  end
end
