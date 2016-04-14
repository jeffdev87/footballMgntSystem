package org.usp.futebol;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.usp.util.*;

public class UserServlet extends HttpServlet implements ConfigServlet {
	public void doGet(HttpServletRequest request, 
		HttpServletResponse response) 
		throws ServletException, IOException {

		String page = null;
		PrintWriter out = response.getWriter();

		out.print("Teste Bozo");
		out.print(request.getParameter("campCod"));
	}
	public void doPost(HttpServletRequest request, 
		HttpServletResponse response) 
		throws ServletException, IOException {
		doGet(request, response);
	}
}
