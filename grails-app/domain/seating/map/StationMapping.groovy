package seating.map

//import com.vmware.ie.englabs.domain.Station


class StationMapping {
		
		
		Integer x
		Integer y
		Integer rotation
		Map map

		static belongsTo = [station:Station]
	
		static constraints = {	
			map(nullable: true)	
			x(range:0..9999, nullable: true)
			y(range:0..9999, nullable: true)
			rotation(range:0..360, nullable: true)
		}
	
   
}

