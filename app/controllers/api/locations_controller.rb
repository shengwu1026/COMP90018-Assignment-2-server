class Api::LocationsController < ApplicationController

    before_action :validate_triangulate_params, only: :triangulate

    def index
        locations = Location.all
        render_records locations
    end

    def show
        location = Location.find params[:id]
        render_response location, displayable_keys
    end

    def update
        location = Location.find params[:id]
        location.assign_attributes(location_params)

        location.save ?
            render_204
            : render_error(location)
    end

    # get location for little brother chip
    def fetch
        location = Location.find_by_little_brother_chip_id params[:little_brother_chip_id]

        unless location
            location = Location.new
        end

        render_response location, displayable_keys
    end

    # latest little brother chip's location
    # creates new or updates existing location
    def triangulate
        location = Location.find_by_little_brother_chip_id params[:little_brother_chip_id]

        # create location if doesn't exist, infer lot from strongest beacon
        unless location
            b = sanitized_beacons.first

            beacon_from_db = Beacon.where(manufacturer_uuid: b[:uuid])
              .where(major: b[:major])
              .where(minor: b[:minor])
              .first

            location = Location.new(
                lot: beacon_from_db.lot,
                little_brother_chip: LittleBrotherChip.find(params[:little_brother_chip_id]))
        end

		# update beacon activity times
        beacons = sanitized_beacons.map{|b|
            # find beacon using its manufacturer properties
            beacon_from_db = Beacon.where(manufacturer_uuid: b[:uuid])
              .where(major: b[:major])
              .where(minor: b[:minor])
              .first

            # beacon does not exist in db
            record_not_found("Beacon uuid #{b[:uuid]}") and return if beacon_from_db.nil?

            beacon_from_db.update_attributes(last_activity: Time.now) 
            beacon_from_db }

		nearest_beacon = beacons.first
		lot = nearest_beacon.lot
		
		location.assign_attributes(
			lot_id: lot.id,
			coordinates: params[:coordinates] )

        location.save ?
            render_204
            : render_error(location)
    end

    def destroy
        Location.find(params[:id]).destroy

        render_204
    end

    def create
        location = Location.new location_params

        location.save ?
            render_response(location, displayable_keys)
            : render_error(location)
    end

    private
        def location_params
            params.require(:location).permit :little_brother_chip_id, :lot_id, {coordinates: [:x, :y]}
        end

        def validate_triangulate_params
            begin
                raise "Parameters must have `beacons` key" unless params[:beacons]

                params[:beacons].map{|b|
                    raise "Beacon parameters within `beacons` must have `distance_from_phone` key" unless b[:distance_from_phone] }

                params[:beacons].map{|b|
                    raise "Beacon parameters within `beacons` must have `uuid` key" unless b[:uuid] }

                params[:beacons].map{|b|
                    raise "Beacon parameters within `beacons` must have `major` key" unless b[:major] }

                params[:beacons].map{|b|
                    raise "Beacon parameters within `beacons` must have `minor` key" unless b[:minor] }
            rescue => e
                render_error_message(e)
            end
        end

        def sanitized_beacons
            params[:beacons].map{|b|
                { uuid: b[:uuid], major: b[:major], minor: b[:minor], distance_from_phone: b[:distance_from_phone] } }
                .sort{|beacon_info| beacon_info[:distance_from_phone] }
        end

        def displayable_keys
            %w(id little_brother_chip_id lot_id coordinates)
        end

end
