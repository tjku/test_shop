require 'httparty'
require 'csv'

# rubocop:disable Metrics/BlockLength
namespace :db do
  desc 'Import Products from given URL'
  task import_products: [:environment] do
    url = 'https://dl.dropboxusercontent.com/s/r2k6ruty1syrj8k/produkty.csv'
    response = HTTParty.get(url)
    content = CSV.parse(response.body)

    content.drop(1).each do |row|
      next unless row.count == 7

      p = Product.new

      # Set category
      category = create_category(row[0])
      p.category_id = category.id
      p.category_name = row[0]

      p.identificator = row[1].to_i
      p.name = row[2]

      # Set brand
      brand = Brand.find_or_create_by(name: row[3])
      p.brand_id = brand.id
      p.brand_name = row[3]

      p.code = row[4]
      p.ean = row[5]
      p.price = row[6].to_i

      p.save
    end
  end

  private

  def create_category(str)
    names = str.split('>').map(&:strip)

    return if names.empty?

    head = nil
    names.each do |name|
      head = if head.nil?
               Category.find_or_create_by(name: name)
             else
               head.children.find_or_create_by(name: name)
             end
    end
    head
  end
end
# rubocop:enable Metrics/BlockLength
