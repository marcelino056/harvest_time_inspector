class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.references :issue_type, null: false, foreign_key: true
      t.references :issuer, :trackable, polymorphic: true, index: true
      t.string :comment
      t.datetime :solved_at

      t.timestamps
    end
  end
end
