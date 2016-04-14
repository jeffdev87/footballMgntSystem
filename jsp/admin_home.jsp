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
				<%
                                
                                        HttpSession sessao = request.getSession( true );

                                        Database db = new Database();

                                        String logoutcheck = request.getParameter("logout");
                                        if(logoutcheck != null) {
                                                out.print("<p>Fez logout!</p>");
                                                sessao.invalidate();
                                                %>
                                                <jsp:forward page="admin.jsp" />
                                                <%
                                        }

                                        boolean update = false;

                                        String cnamecheck = request.getParameter("namevalue");
                                        if(cnamecheck != null) {
                                            sessao.setAttribute("username", cnamecheck);
                                            update = true;
                                        }
										

										String cpasscheck = request.getParameter("passvalue");
                                        if(cpasscheck != null) {
											MessageDigest md = MessageDigest.getInstance("MD5");
											BigInteger hash = new BigInteger(1, md.digest(cpasscheck.getBytes()));
											String passcript = hash.toString(16);  
											while (passcript.length() < 32) {  
												passcript = "0" + passcript;
											}

											sessao.setAttribute("newpass", passcript);
											update = true;
                                        }


									String action = request.getParameter("manage");
									
									
									
									String username = (String) sessao.getAttribute("username");
									String usermail = (String) sessao.getAttribute("usermail");
									String userpass = (String) sessao.getAttribute("userpass");
									String newpass = (String) sessao.getAttribute("newpass");
									
									AdmUser au = new AdmUser(usermail, userpass, username);
									
									try {
                                                                            AdmUser.login(db, au.getMail(), au.getPass());
                                                                        }
									catch (Exception e) {
                                                                            %> <jsp:forward page="admin.jsp"/> <%
                                                                        }

                                                                        if(update == true){
																			au.setName(username);
																			if(newpass != null) {
																				au.setPass(newpass);
																				sessao.setAttribute("userpass",newpass);
																			}
                                                                            au.update(db);
																			update = false;
                                                                        }
									
										%>
								
										<form name="logout" action="#" method="post">
										<input type="hidden" name="logout" />
										<input type="image" src="images/logout.png" align="right" alt="Logout" value="Logout" />
										</form>
										<br/><br/>
										<%
									
										
										
									
									%>
									
									
									<!-- PARTE ONDE GERENCIA O MENU -->
									
									
									
									
									
									<div id="subHeader" class="clearfix">
										<div id="selSubHeader">
											<ul class="clearfix">
												<%
												try {
													if(action.equals("contas") || action.equals("passchange") || action.equals("namechange")) {
														out.print("<li class=\"clsActive\"");
													}
													else out.print("<li>");
													
													out.print("<a href=\"admin_home.jsp?manage=contas\"> Conta </a></li>");
													
													out.print("<li>");
													
													out.print("<a href=\"gerencia_equipe.jsp\"> Equipes </a></li>");
													
													out.print("<li>");
													
													out.print("<a href=\"gerencia_clube.jsp\"> Clubes </a></li>");
													
													out.print("<li>");
													
													out.print("<a href=\"gerencia_camp.jsp\"> Campeonatos </a></li>");
													
													if(action.equals("principal")) {
														out.print("<li class=\"clsActive\"");
													}
													else out.print("<li>");
													out.print("<a href=\"admin_home.jsp?manage=principal\"> Principal </a></li>");
													
													if(!(action.equals("principal")) && !(action.equals("menu1")) && !(action.equals("menu2")) && !(action.equals("contas")) && !(action.equals("passchange")) && !(action.equals("namechange"))) {
														%> <jsp:forward page="admin.jsp" /> <%
													}
														
												}
												catch (Exception e) {
													%>
														<jsp:forward page="admin.jsp" />
													<%
												}
													
												%>
											</ul>
										</div>
									</div>
									
									
									
									
									
									<!-- FIM DA PARTE GERENCIA MENU -->
									
									
									
									
									
				<div class="clsCenter_box">
					<div class="clscenter_boxBottom">
						<div class="clscenter_boxTop">
							<div class="clscenter_boxCenter">
								<div id="selWelcome" align="center">
									
									
									<%
									
									
									if(action.equals("principal")) {
										out.print("<h2>Área do administrador</h2>");
										out.print("<br/><p>Bem vindo, "+username+".<br/>Utilize o menu de navegação acima para gerenciar o sistema.</p>");
									}
									
									if((action.equals("contas")) || (action.equals("passchange")) || (action.equals("namechange"))) {
										out.print("<h2>Perfil de "+username+"</h2>");
										out.print("<p>Email: "+au.getMail()+"</p>");
										
										if(action.equals("namechange")) {
										%>
											<form action="admin_home.jsp" name="cname" method="post">
												<p>Nome: <input type="text" name="namevalue" value="<%out.print(au.getName());%>"><input type="submit" value="Alterar"></p>
											</form>
										<%
										}
										else{
											out.print("<p>Nome: "+au.getName()+"&nbsp;&nbsp;&nbsp;<a href=\"admin_home.jsp?manage=namechange\" style=\"font-size:x-small; color:#aaf\" >Alterar</a></p>");
										}
										
										if(action.equals("passchange")) {
										%>
											<form action="admin_home.jsp" name="cpass" method="post">
												<p>Senha: <input type="text" name="passvalue"><input type="submit" value="Alterar"></p>
											</form><%
										}
										else{
											%>
												<p>Senha: <a href="admin_home.jsp?manage=passchange" style="font-size:x-small; color:#aaf" >Alterar</a></p>
											<%
										}
									}

									db.close();
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
