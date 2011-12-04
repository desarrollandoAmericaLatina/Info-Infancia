# -*- encoding : utf-8 -*-
require 'csv'

namespace :load do

  task :mortalidad => :environment do
    dates = ["2000", "2004", "2005", "2006", "2007", "2008", "2009" ]
    dates_total = {"2000" => 0, "2004" => 0, "2005" => 0, "2006" => 0, "2007" => 0, "2008" => 0, "2009" => 0}
    dates_rate = {"2000" => 0, "2004" => 0, "2005" => 0, "2006" => 0, "2007" => 0, "2008" => 0, "2009" => 0}
    csv_file = "#{Rails.root}/lib/resources/Mortalidad-infantil.txt"
    CSV.foreach(csv_file, :col_sep => ",") do |row|
      location = Location.new(state_name: row[0].force_encoding("UTF-8"))

      lat_long = row[15].split(",")
      location.latitude = lat_long[0]
      location.longitude = lat_long[1]

      row[1..7].each_with_index do |element, index|
         dates_total[dates[index]] = element
      end
      location.total = dates_total

      row[8..14].each_with_index do |element, index|
        dates_rate[dates[index]] = element
      end
      location.rate = dates_rate

      if location.save
        location.total.each do |range|
          range[1].to_i.times do
            event = location.events.create!(created_at: ("#{range[0]}-01-01 -0500").to_date, latitude: location.latitude, longitude: location.longitude)
          end
        end
        p "Location: #{location.state_name}"
      else
        p location.errors
      end

    end
  end

end