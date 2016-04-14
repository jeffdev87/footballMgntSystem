package org.usp.util;

public class LoginException extends Exception {

	private String msgerr;

	public LoginException(String msg) { 
		
		this.msgerr = msg;
	}
	
	public String getMsgerr() {
		return this.msgerr;
	}

}