<%@page import="java.sql.*, org.usp.database.*, org.usp.futebol.*, org.usp.util.*, java.security.MessageDigest, java.math.BigInteger;" %>


<%
	String pass = request.getParameter("p");
	String mail = request.getParameter("m");
	String nova = request.getParameter("o");
	
	HttpSession sessao = request.getSession( true );
	
	if(mail == null)
	{
	%>
		<form name="retrievemail" method="post">
			Email:<input type="text" name="m"/><br/>
			Nova Senha:<input type="password" name="o"/><br/>
			<input type="hidden" name="p" value="<%out.print(pass);%>"></input>
		<input type="submit" value="Alterar"/></form>
	<%
	}
	else
	{
		try {
			Database db = new Database();
			AdmUser au = AdmUser.login(db,mail.toLowerCase(),pass);
			
			
			
			MessageDigest md = MessageDigest.getInstance("MD5");
			BigInteger hash = new BigInteger(1, md.digest(nova.getBytes()));
			String nnova = hash.toString(16);  
			while (nnova.length() < 32) {  
				nnova = "0" + nnova;
			}
			

			au.setPass(nnova);
			
			
			au.update(db);
			db.close();
			out.print("Senha alterada com sucesso!");
		}
		catch (Exception e) {
			out.print("<br/><br/><p style=\"color:red;\">Inválido!</p>");
		}
	}
%>