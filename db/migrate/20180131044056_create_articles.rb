class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
	  t.string :title
	  t.string :description
	  t.string :author
	  t.references :user

      t.timestamps
    end
  end
end
