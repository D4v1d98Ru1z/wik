class CreateCollaborators < ActiveRecord::Migration
  def change
      create_table :collaborators do |t|
        t.references :user
        t.references :wiki
        t.timestamps
      end

      add_index :collaborators, :id, unique:  true
      add_index :collaborators, :user_id
      add_index :collaborators, :wiki_id
  end
end
