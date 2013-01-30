package com.vmware.ie.englabs.state;

/**
 * Represent the state of a station
 * @author Dave Shanley (dshanley@vmware.com)
 *
 */
public enum StationState {

	UNREGISTERED("unregistered"),
	UNASSIGNED("unassigned"),
	ASSIGNED("assigned"),
	AUTHENTICATED("authenticated"),
	ACTIVE("active"),
	ENTITLING("entitling"),
	PROVISIONING("provisioning"),
	CLEANING_UP("cleaning_up"),
	DISABLED("disabled"),
	PRIVATE("private");
	
	String value;
	
	StationState(String value) {
		this.value = value;
	}
	    
	public static StationState findByAbbr(String abbr){
	    for(StationState v : StationState.values()){
	        if( v.toString().equals(abbr)){
	            return v;
	        } 
	    }
	    return null;
	}
	
}
