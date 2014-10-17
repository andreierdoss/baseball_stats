require 'mongoid'

class Player
  include Mongoid::Document
  field :first_name, type: String
  field :last_name, type: String
  field :external_id, type: String
  has_many :battings

  def self.csv_to_mongo_keys
    {playerid: :external_id, birthyear: nil, namefirst: :first_name, namelast: :last_name}
  end

  def name
    [first_name, last_name].join(' ')
  end
end
