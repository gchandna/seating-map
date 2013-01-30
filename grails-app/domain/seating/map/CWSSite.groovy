package seating.map

/**
 * Domain to represent a site/data center that is managed by CWS.
 * @author Dave Shanley <dshanley@vmware.com>
 *
 */
class CWSSite {
	
	String siteName
	String siteId
	Integer capacity  = 0
	boolean allowBYOD = false
	boolean allowCadillac = true
	
	
	boolean active = false
	
    static constraints = {
	}
	
}
