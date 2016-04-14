package org.usp.util;

public class InterceptorException extends java.lang.Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String message;
	
	public InterceptorException() {
	}
	
	public InterceptorException(String message) {
		super(message);
		this.message = message;
	}
	
	public String getMessage(){  
		return this.message;  
	}

}
