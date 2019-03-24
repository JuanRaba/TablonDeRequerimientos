class AddPopularityToRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :popularity, :integer, default: 0
  end
end
