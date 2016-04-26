class AddReadToMessages < ActiveRecord::Migration
  def change
  	add_column :messages, :read, :string
  end
end
