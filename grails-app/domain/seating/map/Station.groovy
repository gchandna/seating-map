package seating.map

import seating.map.CWSSite;
import com.vmware.ie.englabs.state.StationState;
import com.vmware.ie.englabs.state.UCPType;

class Station {
	
	StationState state = StationState.UNASSIGNED
	Integer stationNumber
	String clientIP
	java.util.Date stationCreated
	StationMapping stationMapping
	String 	remoteAccessHost
	String	remoteAccessUsername
	String	remoteAccessPassword
	String	labIpAddress
	UCPType type
	Map map
	CWSSite site
	

    static constraints = {
    }
}
