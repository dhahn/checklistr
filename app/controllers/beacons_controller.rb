class BeaconsController < ApplicationController
	def index
		@beacons = Beacon.all

		Person.where("updated_at < ?", 4.seconds.ago).destroy_all

		respond_to do |format|
			format.html
			format.json do 
				stuff = {}
				Beacon.all.each do |beacon|
					stuff[:major] = beacon.major
					stuff[:minor] = beacon.minor
					stuff[:people] = beacon.people.where("distance < 4").count
				end
				render json: stuff[:people].to_json
			end
		end
	end

	def person_enters
		beacon = Beacon.where(major: params[:major], minor: params[:minor]).first
		person = Person.where(beacon_id: beacon.id, name: params[:name]).first_or_initialize
		#distance in meters	
		person.distance = params[:distance]
		person.save
		person.touch

		beacon.people << person

		respond_to do |format|
		  format.json { render json: true }
		end
	end

end
