package org.usp.util;

import java.util.regex.*;

public class Interceptor {

	public static void filter(String str, boolean sqlinjection) 
		throws Exception {
		filter(str);
		if (sqlinjection) {
			if (str.indexOf("--") != -1)
				throw new Exception("Starting SQL");
			if (str.indexOf("insert into") != -1)
				throw new Exception("Inserting");
		}
	}

	public static void filterEmail(String email) 
		throws Exception {
		if (email.indexOf("@") == -1)
			throw new Exception("There is no at :)");
		if (email.indexOf("'") != -1) {
			throw new Exception("Caractere invalido!");
		}
		
	}
	public static void filter(String str) throws InterceptorException {
		if (str == null)
			throw new InterceptorException("1");
	}

	public static void filter(int var, int start, int end) throws InterceptorException {
		if((var < start)||(var > end))
			throw new InterceptorException("2");
	}
}
