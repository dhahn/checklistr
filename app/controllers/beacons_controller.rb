class BeaconsController < ApplicationController
	def index
		@beacons = Beacon.all
	end

	def person_enters
		beacon = Beacon.where(uuid: params[:uuid]).first
		beacon.people << Person.where(beacon_id: beacon.id, name: params[:name] ).first_or_create

		respond_to do |format|
		  format.json { render json: true }
		end
	end

end
