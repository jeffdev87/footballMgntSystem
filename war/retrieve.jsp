<%@page import="java.sql.*, org.usp.database.*, org.usp.futebol.*, org.usp.util.*, java.security.MessageDigest, java.math.BigInteger, org.apache.commons.mail.*; " %>

<%

	HttpSession sessao = request.getSession( true );

	Database db = new Database();
	try {
		String mailf = request.getParameter("mailf");
		if(!mailf.equals("")) {
			
				ResultSet rs = AdmUser.findByPrimaryKey(db, mailf);
				AdmUser au = AdmUser.next(rs);
				String debug = au.getPass();
		
			try {
				SimpleEmail email = new SimpleEmail();     
				  String userMail = "ppwsoccer@yahoo.com.br";     
				  String userName = "PW SoccerClub";
				  String userPassword = "a1234567890";     
				   
					 email.setHostName("smtp.mail.yahoo.com.br");     
					 email.setFrom(userMail, userName);     
			  
					 email.setMsg("Recuperação de senha, digite no browser: http://localhost:8080/sistema/retrieve_action.jsp?p="+au.getPass());     
					 email.setSubject("Recuperação de senha");     
			  
					 email.setSSL(true);  
					 email.setTLS(true); // utiliza TLS na encriptação    
					 email.setSmtpPort(465);     
					 email.setAuthentication(userMail, userPassword);     
			  
					 email.addTo(au.getMail(),au.getName());     
					 email.send();
					 out.print("Cheque seu email!");
					 
			}
			catch (Exception e) {
				out.print("Erro");
			}
		}
	}
	catch (Exception e) {
			String mailf = request.getParameter("mailf");

		%>
						<h2>Informe seu email para recuperar a senha:</h2><br/>
			<form name="retrievemail" method="post">Email:<input type="text" name="mailf"/><input type="submit" value="Recuperar"/></form>
		<%
		if(mailf != null) {
			out.print("<br/><p style=\"color:red\">Email nao registrado no sistema!</p>");
		}
		
	}
	db.close();
%>