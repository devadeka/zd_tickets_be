class ChangeExternalIdOfArticlesToBigint < ActiveRecord::Migration[5.2]
  def change
    change_column :articles, :external_id, :bigint
  end
end
