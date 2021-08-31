class InfectionReports < ActiveRecord::Migration[6.0]
  def change
    create_table :infection_reports do |t|
      t.references  :survivor, index: true, foreign_key: true
      t.references :reporter, references: :survivors, index: true
      t.timestamps
    end
  end
end
