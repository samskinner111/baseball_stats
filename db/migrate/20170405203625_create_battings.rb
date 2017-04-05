class CreateBattings < ActiveRecord::Migration[5.0]
  def change
    create_table :battings do |t|
      t.string :player_id
      t.integer :year
      t.string :league
      t.string :team
      t.integer :G
      t.integer :at_bats
      t.integer :R
      t.integer :hits
      t.integer :doubles
      t.integer :triples
      t.integer :home_runs
      t.integer :rbi
      t.integer :SB
      t.integer :CS

      t.timestamps
    end
  end
end
