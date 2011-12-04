class Location < ActiveRecord::Base
  has_many :events

  serialize :total
  serialize :rate

  acts_as_api


  api_accessible :location do |template|
    template.add :state_name, :as => :estado
    template.add :total
    template.add :rate, :as => :tasa
    template.add :latitude
    template.add :longitude
  end


end
