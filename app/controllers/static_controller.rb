class StaticController < ApplicationController
    def index
        # render a very big json
        render html: "<pre>#{JSON.pretty_generate(
            users: User.all.map{|u| u.attributes},
            little_brother_chips: LittleBrotherChip.all.map{|l| l.attributes},
            buildings: Building.all.map{|b| b.attributes},
            lots: Lot.all.map{|l| l.attributes},
            beacons: Beacon.all.map{|b| b.attributes},
            locations: Location.all.map{|l| l.attributes}
        )}</pre>".html_safe
    end
end
