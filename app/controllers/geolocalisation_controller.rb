class GeolocalisationController < ApplicationController
# before_action :authenticate_user!
  def index
    elevators = Elevator.all
    @points_list = []

    Building.find_each do |building|

        address = building.address
        b = building.batteries.count
        b_ids = building.battery_ids
        c = Column.where(battery_id: b_ids).count
        c_ids = Column.where(battery_id: building.battery_ids).ids
        e = Elevator.where(column_id: c_ids).count

         nfloors = building.building_details.where("LOWER(info_key) like '%floor%'").first
         floors = nfloors ? nfloors.value : "Not available"

        add = " #{address.number_n_street}, #{address.city}, #{address.status}, #{address.postal_code}"

        @for_google = address.number_n_street + " " + address.city + " " + address.postal_code
        puts "for_google:#{@for_google}"
         @answer = JSON.parse(Faraday.get("https://maps.googleapis.com/maps/api/geocode/json?address=" + URI.escape(@for_google) + "&key=#{ENV["API_FOR_GMAP"]}").body)
        

         if @answer["status"] != "ZERO_RESULTS"
             #extract lat long
             @lat = @answer["results"] && @answer["results"][0] && @answer["results"][0]["geometry"] && @answer["results"][0]["geometry"]["location"] && @answer["results"][0]["geometry"]["location"]["lat"]
            @lng = @answer["results"] && @answer["results"][0] && @answer["results"][0]["geometry"] && @answer["results"][0]["geometry"]["location"] && @answer["results"][0]["geometry"]["location"]["lng"]

            @points_list << {name: building.admin_full_name, 
                lat: @lat, long: @lng, 
                address: add, floors: floors,
                client: building.admin_full_name, 
                battery: b, column: c, elevator: e,
                technician: building.tech_full_name}
        end
    end
  end
  
end
