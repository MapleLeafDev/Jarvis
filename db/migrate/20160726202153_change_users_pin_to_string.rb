class ChangeUsersPinToString < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.change :pin, :string
    end
  end
end
