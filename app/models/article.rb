class Article < ApplicationRecord
  validates_presence_of :external_id, :title, :body
end
