class AddWikiToCollaborators < ActiveRecord::Migration
  def change
    add_reference :collaborators, :wiki, index: true, foreign_key: true
  end
end
