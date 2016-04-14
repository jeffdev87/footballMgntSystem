package org.usp.futebol;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import org.omg.CORBA.Request;
import org.usp.util.InterceptorException;
import org.usp.util.Interceptor;

public class EquipeServlet extends HttpServlet implements ConfigServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String page = null;
		PrintWriter out = response.getWriter();


		int operation = Integer.parseInt(request.getParameter("operation"));
		Equipe eq = null;
		
		switch (operation) {
		case INSERT:
			page = "gerencia_equipe.jsp?msgEq=0";
			
			try{
				eq = new Equipe();
				
				if(request.getParameter("cnpjClube") != null)
					eq.setCnpjClube(request.getParameter("cnpjClube"));
				if(request.getParameter("nomeEq") != null)
					eq.setNomeEq(request.getParameter("nomeEq"));
				if(request.getParameter("nroJogadoresEq") != null)
					eq.setNroJogadoresEq(Integer.parseInt(request.getParameter("nroJogadoresEq")));
				if(request.getParameter("nroTitulosEq") != null)
					eq.setNroTitulosEq(Integer.parseInt(request.getParameter("nroTitulosEq")));
				
				Interceptor.filter(eq.getCnpjClube());
				Interceptor.filter(eq.getNomeEq());
				Interceptor.filter(eq.getNroJogadoresEq(), 11, 25);
		
				eq.insert();
								
			}catch (SQLException sqle) {
				System.err.println(sqle.getErrorCode());
				if(sqle.getErrorCode() == 1)
					page = "gerencia_equipe.jsp?msgEq=1";
				else if (sqle.getErrorCode() == 1407)
					page = "gerencia_equipe.jsp?msgEq=97";
			}catch (InterceptorException e) {
				System.err.println(e.getMessage());
				if(e.getMessage().equals("1"))
					page = "gerencia_equipe.jsp?msgEq=97";
				else if(e.getMessage().equals("2"))
					page = "gerencia_equipe.jsp?msgEq=98";
				else
					page = "gerencia_equipe.jsp?msgEq=99";
			}
			catch (Exception e1) {
				page = "gerencia_equipe.jsp?msgEq=99";
			}		
			break;
			
		case REMOVE:
			page = "gerencia_equipe.jsp?msgEq=3";
			try {
				out.print(request.getParameter("cod") +" "+request.getParameter("nomeEq"));
				eq = new Equipe(request.getParameter("cod"), request.getParameter("nomeEq"));
				out.print(eq.toString());
				eq.remove();
			} catch (Exception e) {
				page = "gerencia_equipe.jsp?msgEq=4";
			}
			break;
			
		case UPDATE:
			page = "gerencia_equipe.jsp?msgEq=5";
			
			
			try{
				eq = new Equipe();
				out.print(request.getParameter("nomeEq1"));
				if(request.getParameter("cnpjClube1") != null)
					eq.setCnpjClube(request.getParameter("cnpjClube1"));
				if(request.getParameter("nomeEq1") != null)
					eq.setNomeEq(request.getParameter("nomeEq1"));
				if(request.getParameter("nroJogadoresEq") != null)
					eq.setNroJogadoresEq(Integer.parseInt(request.getParameter("nroJogadoresEq")));
				if(request.getParameter("nroTitulosEq") != null)
					eq.setNroTitulosEq(Integer.parseInt(request.getParameter("nroTitulosEq")));
				
				Interceptor.filter(eq.getCnpjClube());
				Interceptor.filter(eq.getNomeEq());
				out.print(eq.toString());
				eq.update();
								
			}catch (SQLException sqle) {
				System.err.println(sqle.getErrorCode());
				if(sqle.getErrorCode() == 1)
					page = "gerencia_equipe.jsp?msgCamp=1";
				else if (sqle.getErrorCode() == 1407)
					page = "gerencia_equipe.jsp?msgCamp=97";
				else
					page = "gerencia_equipe.jsp?msgCamp=99";
					
			}catch (InterceptorException e) {
				System.err.println(e.getMessage());
				if(e.getMessage().equals("1"))
					page = "gerencia_equipe.jsp?msgCamp=97";
				else if(e.getMessage().equals("2"))
					page = "gerencia_equipe.jsp?msgCamp=98";
				else
					page = "gerencia_equipe.jsp?msgCamp=99";
			}
			catch (Exception e1) {
				page = "gerencia_equipe.jsp?msgCamp=99";
			}
		}
		response.sendRedirect(page);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
