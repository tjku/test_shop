class Category < ApplicationRecord
  acts_as_tree order: "name"

  validates :name, presence: true
end
