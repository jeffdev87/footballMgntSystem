package org.usp.futebol;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.usp.util.Interceptor;
import org.usp.util.InterceptorException;

public class CampeonatoServlet extends HttpServlet implements ConfigServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String page = null;
		PrintWriter out = response.getWriter();

		int operation = Integer.parseInt(request.getParameter("operation"));
		Campeonato camp = null;

		switch (operation) {
		case INSERT:
			page = "gerencia_camp.jsp?msgCamp=0";

			try {
				camp = new Campeonato();

				if (request.getParameter("nomeCamp") != null)
					camp.setNomeCamp(request.getParameter("nomeCamp"));
				if (request.getParameter("anoCamp") != null)
					camp.setAnoCamp(Integer.parseInt(request
							.getParameter("anoCamp")));
				if (request.getParameter("divisaoCamp") != null)
					camp.setDivisaoCamp(Integer.parseInt(request
							.getParameter("divisaoCamp")));
				if (request.getParameter("abrangenciaCamp") != null)
					camp.setAbrangenciaCamp(request
							.getParameter("abrangenciaCamp"));

				Interceptor.filter(camp.getNomeCamp());
				Interceptor.filter(camp.getAnoCamp(), 1900, 2050);
				Interceptor.filter(camp.getDivisaoCamp(), 1, 3);
				Interceptor.filter(camp.getAbrangenciaCamp());

				camp.insert();

			} catch (SQLException sqle) {
				System.err.println(sqle.getErrorCode());
				if (sqle.getErrorCode() == 1)
					page = "gerencia_camp.jsp?msgCamp=1";
				else if (sqle.getErrorCode() == 1407)
					page = "gerencia_camp.jsp?msgCamp=97";
			} catch (InterceptorException e) {
				System.err.println(e.getMessage());
				if (e.getMessage().equals("1"))
					page = "gerencia_camp.jsp?msgCamp=97";
				else if (e.getMessage().equals("2"))
					page = "gerencia_camp.jsp?msgCamp=98";
				else
					page = "gerencia_camp.jsp?msgCamp=99";
			} catch (Exception e1) {
				page = "gerencia_camp.jsp?msgCamp=99";
			}
			break;

		case REMOVE:
			page = "gerencia_camp.jsp?msgCamp=3";
			try {
				camp = new Campeonato(Integer.parseInt(request
						.getParameter("idCamp")));
				camp.remove();
			} catch (Exception e) {
				page = "gerencia_camp.jsp?msgCamp=4";
			}
			break;

		case UPDATE:
			page = "gerencia_camp.jsp?msgCamp=5";

			try {
				camp = new Campeonato();

				if (request.getParameter("idCamp") != null)
					camp.setIdCamp(Integer.parseInt(request
							.getParameter("idCamp")));
				if (request.getParameter("nomeCamp") != null)
					camp.setNomeCamp(request.getParameter("nomeCamp"));
				if (request.getParameter("anoCamp") != null)
					camp.setAnoCamp(Integer.parseInt(request
							.getParameter("anoCamp")));
				if (request.getParameter("divisaoCamp") != null)
					camp.setDivisaoCamp(Integer.parseInt(request
							.getParameter("divisaoCamp")));
				if (request.getParameter("abrangenciaCamp") != null)
					camp.setAbrangenciaCamp(request
							.getParameter("abrangenciaCamp"));

				Interceptor.filter(camp.getNomeCamp());
				Interceptor.filter(camp.getAnoCamp(), 1900, 2050);
				Interceptor.filter(camp.getDivisaoCamp(), 1, 3);
				Interceptor.filter(camp.getAbrangenciaCamp());

				camp.update();

			} catch (SQLException sqle) {
				System.err.println(sqle.getErrorCode());
				if (sqle.getErrorCode() == 1)
					page = "gerencia_camp.jsp?msgCamp=1";
				else if (sqle.getErrorCode() == 1407)
					page = "gerencia_camp.jsp?msgCamp=97";
			} catch (InterceptorException e) {
				System.err.println(e.getMessage());
				if (e.getMessage().equals("1"))
					page = "gerencia_camp.jsp?msgCamp=97";
				else if (e.getMessage().equals("2"))
					page = "gerencia_camp.jsp?msgCamp=98";
				else
					page = "gerencia_camp.jsp?msgCamp=99";
			} catch (Exception e1) {
				page = "gerencia_camp.jsp?msgCamp=99";
			}
		}
		response.sendRedirect(page);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
