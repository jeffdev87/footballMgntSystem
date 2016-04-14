<%@page import="java.sql.*, org.usp.database.*, org.usp.futebol.*, org.usp.util.*, java.security.MessageDigest, java.math.BigInteger, org.apache.commons.mail.*; " %>
	
	<%

	  SimpleEmail email = new SimpleEmail();     
      String userMail = "ppwsoccer@yahoo.com.br";     
      String userName = "ppwsoccer@yahoo.com.br";     
      String userPassword = "a1234567890";     
           
             email.setHostName("smtp.mail.yahoo.com.br");     
             email.setFrom(userMail);     
      
             email.setMsg("Testando envio de e-mail em Java");     
             email.setSubject("teste de email");     
      
             email.setSSL(true);  
             email.setTLS(true); // utiliza TLS na encriptação    
             email.setSmtpPort(465);     
             email.setAuthentication(userName, userPassword);     
      
             email.addTo("gasparsigma@gmail.com");     
             email.send();     
             out.print("Email enviado com sucesso!");     
          
       
	  
	%>