package seating.map


class Map {
	String name
	boolean enabled
	byte[] image
	String imageType
	
	// Overrides for this map
	boolean displayClassicStats
	boolean displayBYODStats
	String  message
	Integer messageX
	Integer messageY
	Integer messageFontSize
	String  messageColor
	Integer classicXpos
	Integer classicYpos
	Integer byodXpos
	Integer byodYpos
	Integer stationHeight
	Integer stationWidth
	Integer stationRadius
	Integer logoX
	Integer logoY
	Integer logoHeight
	Integer logoWidth
	Integer imageIdval
	
	static constraints = {
	  image(nullable:true, maxSize: 5*1024*1024 /* 5mb */)
	  imageType(nullable:true)
	  message(nullable:true)
	  messageX(nullable:true)
	  messageY(nullable:true)
	  messageFontSize(nullable:true)
	  messageColor(nullable:true)
	  classicXpos(nullable:true)
	  classicYpos(nullable:true)
	  byodXpos(nullable:true)
	  byodYpos(nullable:true)
	  stationHeight(nullable:true)
	  stationWidth(nullable:true)
	  stationRadius(nullable:true)
	  logoX(nullable:true)
	  logoY(nullable:true)
	  logoHeight(nullable:true)
	  logoWidth(nullable:true)
	  imageIdval(nullable:true)
  }
//	static hasMany = [section:Section]
}