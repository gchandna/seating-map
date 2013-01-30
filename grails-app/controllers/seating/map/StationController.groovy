package seating.map

import grails.converters.JSON

class StationController {


    def index() {
        redirect(action: "list", params: params)
    }
	
	def list() {
		def stationList = Station.list( sort: "stationNumber", order: "asc", max: 50)
		def min = null
		def max = null
		def filter = null
		if(params.min &&  params.min.toString().isInteger()) min = params.min
		if(params.max &&  params.max.toString().isInteger()) max = params.max
		if(params.filter) filter = params.filter
		if(min&&max)
			stationList = Station.findAllByStationNumberBetween(min,max,[ sort: "stationNumber", order: "asc"])
			
		if(!min&&!max) {
			min	= "Min"
			max = "Max"
		}
		render (view: "/admin/station/list", model: [stations:stationList, min:min, max: max, sites:CWSSite.list()])
	}

	private def stationNotFound(stationId) {
		flash.error = "${message(code: 'admin.error.norecord.plural', args: [message(code: 'label.station'), stationId])}"
		redirect(controller: "adminStation", action: "list")
	}
	
	def addStation() {
		def site = null
		def type = UCPType.findByAbbr(params.type)
		def stationNumber = params.stationNumber
		def station = new Station(stationNumber:stationNumber,site:site,type:type,state:StationState.UNREGISTERED)

		if(params.site!='null')
		site = CWSSite.get(Long.parseLong(params.site))
		
		render station as Station
	}
	
	
	def deleteStation() {
		
		if(!params.id.isNumber()) {
			stationNotFound(params.id)
			return
		}
		def station = Station.findById(params.id)
			
		if(!station) {
			stationNotFound(params.id)
		} else {
		Station.executeUpdate("delete from Station s where s.id=:stationId",[stationId:Long.parseLong(params.id)])
		}
	}
	
	def search() {
		def resultJSON = []
		if(params.query.size() >0) {
			def searchResults = Station.findAllWhere(stationNumber:Integer.parseInt(params.query.toLowerCase().trim()))
			searchResults.each { station ->
				resultJSON.add([id:station.id, stationNumber: "station $station.stationNumber (${station.type.toString()})"])
			}
		}
		render resultJSON as JSON
	 }

}
