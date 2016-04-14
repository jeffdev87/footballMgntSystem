<!--HEADER-->
<%@page import="java.sql.*, org.usp.database.*, org.usp.futebol.*, org.usp.util.*, java.security.MessageDigest, java.math.BigInteger" %>
<jsp:include page="config/header.jsp" />
<!--END OF HEADER-->
<!--MAINBOX-->
<div id="main_box">
	<div class="clsBottom">
      <div class="clsTop">
			<div class="clsCenter ">
				<!--SELSUBHEADER-->
				
				<!--END OF SELSUBHEADER-->
				<!--CLSCENTERBOX-->
				<div class="clsCenter_box">
					<div class="clscenter_boxBottom">
						<div class="clscenter_boxTop">
							<div class="clscenter_boxCenter">
								<div id="selWelcome" align="center" style="margin:0px 350px 0px 350px;">
									
									<%
									String userm = request.getParameter("usermail");
									String userp = request.getParameter("userpass");
									String userpcr = userp;
									
									if (userp != null)
									{
										MessageDigest md = MessageDigest.getInstance("MD5");
										BigInteger hash = new BigInteger(1, md.digest(userp.getBytes()));
										userpcr = hash.toString(16);  
										while (userpcr.length() < 32) {  
											userpcr = "0" + userpcr;
										}
									}

									
									HttpSession sessao = request.getSession( true );
									String usuario = (String) sessao.getAttribute("username");

                                                                        


									if(usuario != null) {
										out.print("<br/><p style=\"margin-left: 70px; font-size:x-small;\" >Bem vindo, "+usuario+"</p></br>");
										%>
										<jsp:forward page="admin_home.jsp?manage=principal" /><%
									}
									else {
									
										if(userm != null) {
												try {
													Database db = new Database();
													AdmUser au = AdmUser.login(db,userm.toLowerCase(),userpcr);
													db.close();
													sessao.setAttribute("username", au.getName());
													sessao.setAttribute("usermail", au.getMail());
													sessao.setAttribute("userpass", au.getPass());
													
													sessao.setMaxInactiveInterval(5*60);
													out.println("<br/><p>Login realizado com sucesso!</p>");
													response.setHeader("Refresh","1");
												}
												catch (Exception e) {
													%>
														<h2>Administração</h2>
														<form name="login" action="#" method="post">
														<table style="border:0px; margin-right:50px;">
														<tr>
														<p style="text-align:center;">
														<td style="border:0px;">Email:</td><td style="border:0px;"><input type="text" name="usermail" /></td>
														</tr><tr>
														<td style="border:0px;">Senha:</td><td style="border:0px;"><input type="password" name="userpass" /></td></tr></p>
														</table>
														<input type="image" src="images/login.png" alt="Login" value="Login" />
														</form>
															
													<%
													out.print("<br/><p style=\"margin-left: 70px; font-size:x-small; color:#ff0000\">*Falha no login: "+e.getMessage()+"</p>");
													
												}
										}
										else {
										%>
											<h2>Administração</h2>
											<form name="login" action="#" method="post">
											<table style="border:0px; margin-right:50px;">
											<tr>
											<p style="text-align:center;">
											<td style="border:0px;">Email:</td><td style="border:0px;"><input type="text" name="usermail" /></td>
											</tr><tr>
											<td style="border:0px;">Senha:</td><td style="border:0px;"><input type="password" name="userpass" /></td></tr></p>
											<td style="border:0px;"></td><td style="border:0px;"><a href="retrieve.jsp" style="font-size:x-small;color:aaf">Esqueci minha senha</a></td>
											</table>
											<input type="image" src="images/login.png" alt="Login" value="Login" />
											</form>
										<% 
										}
									}
									
									
									
									%>   
								<!--END OF CONTENT-->
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--END OF CLSCENTERBOX--> 
			</div>
      </div>
	</div>
</div>
<!--END OF MAINBOX-->
<!--FOOTER-->
<jsp:include page="config/footer.jsp" />
<!--END OF FOOTER-->
