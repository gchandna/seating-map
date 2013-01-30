package seating.map


class Visual {
	String eventName
	boolean State
	//static hasMany = [stations:Station]
	
}

public enum State {
	ACTIVE("active"),
	DISABLED("disabled"),

	String state;
	
	State(String state) {
		this.state = state;
	}
}

