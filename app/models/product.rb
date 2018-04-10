require 'elasticsearch/persistence/model'

class Product
  include Elasticsearch::Persistence::Model

  attribute :category_id, Integer
  attribute :category_name, String
  attribute :identificator, Integer
  attribute :name, String
  attribute :brand_id, Integer
  attribute :brand_name, String
  attribute :code, Integer
  attribute :ean, String
  attribute :price, Integer

  validates :name, presence: true
  validates :price, presence: true

  def self.match_all_query(page = 1, per_page = 100)
    page ||= 1

    search(
      query: {
        match_all: {}
      },
      size: per_page,
      from: (page.to_i - 1) * per_page
    )
  end
end
