package com.vmware.ie.englabs.state;

/**
 * Determine type for the UCP (cadillac or BYOD)
 * @author Dave Shanley (dshanley@vmware.com)
 *
 */
public enum UCPType {
	
	ADMIN("admin"),
	CADILLAC("cadillac"),
	BYOD("byod"),
	PUBLIC("public"),
	ENG("eng"),
	THIRDPARTY("thirdparty");
	
	String type;
	
	UCPType(String type) {
		this.type = type;
		
	}
	
	public static UCPType findByAbbr(String abbr){
	    for(UCPType v : UCPType.values()){
	        if( v.toString().equals(abbr)){
	            return v;
	        } 
	    }
	    return null;
	}
	
}
