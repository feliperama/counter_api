class CreateGlobalCounters < ActiveRecord::Migration[5.2]
  def change
    create_table :global_counters do |t|
      t.string :name, null: false
      t.integer :value, default: 0
    end
  end
end
