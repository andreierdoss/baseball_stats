require 'smarter_csv'
require 'pry'

class Seeder

  attr_accessor :source, :type

  def initialize( options={} )
    @source = options[:source]
    @type = options[:type]
  end

  def populate
    SmarterCSV.process(@source, {key_mapping: @type.csv_to_mongo_keys}) do |array|
      @type.create(array.first)
      # @type.collection.insert(array) - with chunk_size: 1000 would speed up insertion, but it doesn't run before_create callbacks
    end
  end
end
