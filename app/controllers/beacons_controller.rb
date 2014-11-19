class BeaconsController < ApplicationController
	def index
		@beacons = Beacon.all
	end

	def person_enters
		beacon = Beacon.where(major: params[:major], minor: params[:minor]).first
		person = Person.where(beacon_id: beacon.id, name: params[:name]).first_or_initialize
		#distnace in meters	
		person.distance = params[:distance]
		person.save

		beacon.people << person

		respond_to do |format|
		  format.json { render json: true }
		end
	end

end
