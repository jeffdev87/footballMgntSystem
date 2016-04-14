
<!--HEADER-->
<%@page import="java.sql.*, org.usp.database.*, org.usp.futebol.*" %>
<jsp:include page="config/header_restrito.jsp" />
<!--END OF HEADER-->
<!--MAINBOX-->
<div id="main_box">
	<div class="clsBottom">
		<div class="clsTop">
			<div class="clsCenter ">
				<!--SELSUBHEADER-->
				<jsp:include page="config/menu_topo.jsp" />
				<!--END OF SELSUBHEADER-->
				<!--CLSCENTERBOX-->
				<div class="clsCenter_box">
					<div class="clscenter_boxBottom">
						<div class="clscenter_boxTop">
							<div class="clscenter_boxCenter">
								<!--CONTENT-->
								<div class="content clearfix">
									<!--SIDEBAR1-->
									<div class="sidebar1 clsFloatLeft">
										<h3>Menu Principal</h3>
										<div class="inner_tb">
											<div class="inner_bb">
												<div class="inner_lb">
													<div class="inner_rb">
														<div class="inner_tlc">
															<div class="inner_trc">
																<div class="inner_blc">
																	<div class="inner_brc">
																		<div class="cls100_p">
																			<div id="selNews">
																				<ul>
																				<li><a href="gerencia_equipe.jsp?op=0"><span>Inserir</span></a></li>
																				<li><a href="gerencia_equipe.jsp?op=1"><span>Remover</span></a></li>
																				<li><a href="gerencia_equipe.jsp?op=2"><span>Atualizar</span></a></li>
																				</ul>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!--END OF SIDEBAR1-->
									<!--MAIN-->
									<div id="main" style="width: 700px">
										<div class="inner_tb">
											<div class="inner_bb">
												<div class="inner_lb">
													<div class="inner_rb">
														<div class="inner_tlc">
															<div class="inner_trc">
																<div class="inner_blc">
																	<div class="inner_brc">
																		<div class="cls100_p">
																			<div id="selWelcome">
																				<h2 style="text-align: center;">Gerenciamento de Equipes!</h2>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="inner_tb">
											<div class="inner_bb">
												<div class="inner_lb">
													<div class="inner_rb">
														<div class="inner_tlc">
															<div class="inner_trc">
																<div class="inner_blc">
																	<div class="inner_brc">
																		<div class="cls100_p">
																			<div id="selWelcome">
																				<jsp:include page="message.jsp"/>
																				<%
																					if(request.getParameter("op") != null){
																						int op = Integer.parseInt(request.getParameter("op"));
																						switch (op){
																							case 0:
																								%>
																								<div id="selContactForm">
																								<h2 style="font-size: medium; text-align: center;">Inserir<br/><br/></h2>
																								<form action="EquipeServlet" method="post">
																									<p>Nome do Clube:&nbsp;<select name="cnpjClube"><option value="-1">--Selecione--</option>
																									<%
																									Database db_insert = new Database();
																									ResultSet rs_insert = Clube.findAll(db_insert);
																									Clube clube_insert = null;
																									
																									while ((clube_insert = Clube.next(rs_insert)) != null) {
																										out.print("<option value=\""+clube_insert.getCnpjClube()+"\">"+clube_insert.getNomeClube()+"</option>");
																									}
																									db_insert.close();
																									%>
																									</select>
																									</p>																									
																									<p>Nome da Equipe:<br/><input type="text" class="clsText" name="nomeEq" /></p>
																									<p>Número de Jogadores:<br/><input type="text" class="clsText" name="nroJogadoresEq" /></p>
																									<p>Número de Títulos da Equipe:<br/><input type="text" class="clsText" name="nroTitulosEq" /></p>
																									<input type="hidden" class="clsText" name="operation" value="0" />
																									<p class="clsButtons">
																									<input type="reset" class="clsBut" value="Limpar" />
																									<input type="submit" class="clsBut" value="Enviar" />
																									</p>
																								</form>
																								</div>																								
																								<%
																								break;
																							case 1:
																								%>
																								<div id="selContactForm">
																								<h2 style="font-size: medium; text-align: center;">Remover<br/><br/></h2>
																								<form name="formEquipe" action="EquipeServlet" method="post">
																									<p style="text-align: center;">Ao escolher a op&ccedil;&atilde;o e clicar em Remover, os dados da Equipe serão excluidos permanentemente<br/></p>
																									<p>Nome do Clube:&nbsp;<select id="mySelect" name="cnpjClube" onchange="opcao();"><option value="-1">--Selecione--</option>
																									<%
																									Database db_remove = new Database();
																									ResultSet rs_remove = Clube.findAll(db_remove);
																									Clube clube_remove = null;
																									
																									while ((clube_remove = Clube.next(rs_remove)) != null) {
																										if(request.getParameter("selected") != null){
																											if(clube_remove.getCnpjClube().equals(request.getParameter("selected")))
																												out.print("<option selected=\"selected\" id=\""+clube_remove.getCnpjClube()+"\" value=\""+clube_remove.getNomeClube()+"\">"+clube_remove.getNomeClube()+"</option>");
																											else
																												out.print("<option id=\""+clube_remove.getCnpjClube()+"\" value=\""+clube_remove.getNomeClube()+"\">"+clube_remove.getNomeClube()+"</option>");
																										}
																										else
																											out.print("<option id=\""+clube_remove.getCnpjClube()+"\" value=\""+clube_remove.getNomeClube()+"\">"+clube_remove.getNomeClube()+"</option>");
																										
																									}
																									
																									%>
																									</select>
																									</p>
																									<input type="hidden" class="clsText" name="escolha" value="0"/>
																									<% if(request.getParameter("selected") != null)
																											out.print("<input type=\"hidden\" class=\"clsText\" name=\"cod\" value=\""+request.getParameter("selected")+"\"/>");
																									%>
																									<script type="text/javascript">
																										
																										function opcao(){
																											var x=document.getElementById("mySelect").selectedIndex;
																											var y=document.getElementsByTagName("option");
																											document.formEquipe.escolha.value = y[x].id;
																											document.formEquipe.action = "gerencia_equipe.jsp?op=1&selected="+y[x].id;
																											document.formEquipe.submit();
																										}
																									</script>
																									<p>Nome da Equipe:&nbsp;<select id="mySelect1" name="nomeEq"><option value="-1">--Selecione--</option>
																									<%
																									if(request.getParameter("escolha") != null){
																										db_remove = new Database();
																										out.print(request.getParameter("escolha"));
																										rs_remove = Equipe.findByClube(db_remove, request.getParameter("escolha"));
																										Equipe eq_remove = null;
																										
																										while ((eq_remove = Equipe.next(rs_remove)) != null) {
																											out.print("<option value=\""+eq_remove.getNomeEq()+"\">"+eq_remove.getNomeEq()+"</option>");
																										}
																										db_remove.close();	
																									}
																									
																									%>
																									</select>
																									</p>
																									<input type="hidden" class="clsText" name="operation" value="1" />
																									<p class="clsButtons">
																									<input type="submit" class="clsBut" value="Remover" />
																									</p>
																								</form>
																								</div>
																								<%
																								
																								break;
																							case 2:
																								%>
																								<div id="selContactForm">
																								<h2 style="font-size: medium; text-align: center;">Atualizar<br/><br/></h2>
																								<form name="formEquipe" action="EquipeServlet" method="post">
																									<p>Nome do Clube:&nbsp;<select id="mySelect" name="cnpjClube" onchange="opcao();"><option value="-1">--Selecione--</option>
																									<%
																									db_remove = new Database();
																									rs_remove = Clube.findAll(db_remove);
																									clube_remove = null;
																									
																									while ((clube_remove = Clube.next(rs_remove)) != null) {
																										if(request.getParameter("selected") != null){
																											if(clube_remove.getCnpjClube().equals(request.getParameter("selected")))
																												out.print("<option selected=\"selected\" id=\""+clube_remove.getCnpjClube()+"\" value=\""+clube_remove.getNomeClube()+"\">"+clube_remove.getNomeClube()+"</option>");
																											else
																												out.print("<option id=\""+clube_remove.getCnpjClube()+"\" value=\""+clube_remove.getNomeClube()+"\">"+clube_remove.getNomeClube()+"</option>");
																										}
																										else
																											out.print("<option id=\""+clube_remove.getCnpjClube()+"\" value=\""+clube_remove.getNomeClube()+"\">"+clube_remove.getNomeClube()+"</option>");
																										
																									}
																									
																									%>
																									</select>
																									</p>
																									<input type="hidden" class="clsText" name="escolha" value="0"/>
																									<% if(request.getParameter("selected") != null)
																											out.print("<input type=\"hidden\" class=\"clsText\" name=\"cod\" value=\""+request.getParameter("selected")+"\"/>");
																									%>
																									<script type="text/javascript">
																										
																										function opcao(){
																											var x=document.getElementById("mySelect").selectedIndex;
																											var y=document.getElementsByTagName("option");
																											document.formEquipe.escolha.value = y[x].id;
																											document.formEquipe.action = "gerencia_equipe.jsp?op=2&selected="+y[x].id;
																											document.formEquipe.submit();
																										}
																									</script>
																									<p>Nome da Equipe:&nbsp;<select id="mySelect1" name="nomeEq"><option value="-1">--Selecione--</option>
																									<%
																									if(request.getParameter("escolha") != null){
																										db_remove = new Database();
																										out.print(request.getParameter("escolha"));
																										rs_remove = Equipe.findByClube(db_remove, request.getParameter("escolha"));
																										Equipe eq_remove = null;
																										
																										while ((eq_remove = Equipe.next(rs_remove)) != null) {
																											out.print("<option value=\""+eq_remove.getNomeEq()+"\">"+eq_remove.getNomeEq()+"</option>");
																										}
																										db_remove.close();
																									}
																									
																									%>
																									</select>
																									</p>
																									<input type="hidden" class="clsText" name="operation" value="2" />
																									<p class="clsButtons">
																									<input type="button" class="clsBut" value="Mostrar" onclick="mostrar()"/>
																									</p>
																									
																									<script type="text/javascript">
																									function mostrar(){
																										var x=document.getElementById("mySelect").selectedIndex;
																										var y=document.getElementsByTagName("option");
																										document.formEquipe.action = "gerencia_equipe.jsp?op=2&selected="+y[x].id+"&m=yes";
																										document.formEquipe.submit();
																									}
																									</script>
																								
																								
																								<%
																									Database db_rem = new Database();
																									ResultSet rs_up = null;
																									
																									if(request.getParameter("m") != null){
																										String str = request.getParameter("m");
																										if(str.equals("yes")){
																											System.out.println(request.getParameter("cod")+request.getParameter("nomeEq"));
																											rs_up = Equipe.findByPrimaryKey(db_rem, request.getParameter("cod"), request.getParameter("nomeEq"));
																											rs_up.next();

																											out.print("<p>Cnpj:<br/><input type=\"hidden\" class=\"clsText\" name=\"cnpjClube1\" value=\""+rs_up.getString(1)+"\"/></p>");
																											out.print("<p>Nome do Clube:<br/><input type=\"text\" class=\"clsText\" name=\"nomeEq1\" value=\""+rs_up.getString(2)+"\"/></p>");
																											out.print("<p>Número de Jogadores:<br/><input type=\"text\" class=\"clsText\" name=\"nroJogadoresEq\" value=\""+rs_up.getInt(3)+"\" /></p>");
																											out.print("<p>Número de Títulos da Equipe:<br/><input type=\"text\" class=\"clsText\" name=\"nroTitulosEq\" value=\""+rs_up.getInt(4)+"\" /></p>");
																										}
																									}
																									
																									
																								%>
																									<input type="hidden" class="clsText" name="operation" value="2" />
																									<p class="clsButtons">
																									<input type="reset" class="clsBut" value="Limpar" />
																									<input type="submit" class="clsBut" value="Atualizar" />
																									</p>
																									</form>
																								</div>
																								<%
																								db_rem.close();
																								break;
																							case 3:
																								%>
																								<div id="selContactForm">
																								<form id="formImagem" name="formImagem" method="post" action="ClubeServlet" enctype="multipart/form-data">
																									<h2 style="font-size: medium; text-align: center;">Inserir</h2>
																									<p>Your Name:<br/>
																									<input type="text" class="clsText" id="tipoForm" name="tipoForm" value="imagem" />
																									</p>
																									<p>Your Email:<br/>
																									<input class="clsText" name="imagem" type="file" id="imagem" value="c:/"/>
																									</p>
																									<p class="clsButtons">
																									<input type="button" class="clsBut" value="Limpar" />
																									<input type="submit" id="upload" name="upload" value="Enviar" />
																									</p>
																								</form>
																								</div>																								
																								<%
																								break;
																							default:
																								out.print("<p>Op&ccedil;&atilde; Inv&aacute;lida</p>");
																						}
																					}else{
																						out.print("<p style=\"text-align: center;\"><br/><br/>Por favor, escolha uma op&ccedil;&atilde;o no menu ao lado<br/><br/><br/></p>");
																					}
																				%>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!--END OF MAIN-->
								</div>
								<!--END OF CONTENT-->
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
