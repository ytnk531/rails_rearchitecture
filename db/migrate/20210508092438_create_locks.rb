class CreateLocks < ActiveRecord::Migration[6.1]
  def change
    create_table :locks do |t|
      t.string :uid
      t.string :session_id

      t.timestamps
    end
  end
end
