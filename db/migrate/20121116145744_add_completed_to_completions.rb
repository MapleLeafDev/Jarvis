class AddCompletedToCompletions < ActiveRecord::Migration
  def change
    add_column :completions, :completed, :string

  end
end
