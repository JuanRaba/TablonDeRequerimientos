class AddScoreToRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :score, :integer, default: 0
  end
end
