
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
																				<li><a href="gerencia_camp.jsp?op=0"><span>Inserir</span></a></li>
																				<li><a href="gerencia_camp.jsp?op=1"><span>Remover</span></a></li>
																				<li><a href="gerencia_camp.jsp?op=2"><span>Atualizar</span></a></li>
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
																				<h2 style="text-align: center;">Gerenciamento de Campeonatos!</h2>
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
																								<form action="CampeonatoServlet" method="post">
																									<p>Nome:<br/><input type="text" class="clsText" name="nomeCamp" /></p>
																									<p>Ano:<br/><input type="text" class="clsText" name="anoCamp" /></p>
																									<p>Divis&atilde;o:<br/><input type="text" class="clsText" name="divisaoCamp" /></p>
																									<p>Abrang&ecirc;cia:<br/>
																									<select name="abrangenciaCamp">
																										<option value="Regional">Regional</option>
																										<option value="Municipal">Municipal</option>
																										<option value="Nacional">Regional</option>
																										<option value="Internacional">Internacional</option>
																									</select></p>
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
																								<form action="CampeonatoServlet" method="post">
																									<p style="text-align: center;">Ao escolher a op&ccedil;&atilde;o e clicar em Remover, os dados do Campeonato serão excluidos permanentemente<br/></p>
																									<p>Campeonato:&nbsp;<select name="idCamp"><option value="-1">--Selecione--</option>
																									<%
																									Database db_insert = new Database();
																									
																									
																									
																									ResultSet rs_insert = Campeonato.findAll(db_insert);
																									Campeonato camp_insert = null;
																									
																									while ((camp_insert = Campeonato.next(rs_insert)) != null) {
																										out.print("<option value=\""+camp_insert.getIdCamp()+"\">"+camp_insert.getNomeCamp()+"</option>");
																									}
																									db_insert.close();
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
																								<form action="gerencia_camp.jsp?op=2" method="post" name="form1">	
																									<%
																									Database db_remove = new Database();
																									ResultSet rs_remove = null;
																									int pesq = 0;
																									int corrente = 1;
																									
																									if(request.getParameter("escondido") != null)
																										corrente = Integer.parseInt(request.getParameter("escondido"));
																									
																									if(request.getParameter("search_op") != null){
																										pesq = Integer.parseInt(request.getParameter("search_op"));
																										if(pesq == 1){
																											int id = Integer.parseInt(request.getParameter("pesquisa"));
																											rs_remove = Campeonato.findByPrimaryKey(db_remove, id);
																											rs_remove.next();
																											
																										}
																										else if(pesq == 2){
																											String name = request.getParameter("pesquisa");
																											rs_remove = Campeonato.findByName(db_remove,name);
																											rs_remove.next();
																											
																										}
																										else{
																											rs_remove = Campeonato.findAll(db_remove);
																										}
																										
																									}else
																										rs_remove = Campeonato.findAll(db_remove);
																									
																									if(pesq == 0){
																										if(corrente < 1)
																											corrente = 1;
																										
																										rs_remove.last();
																										
																										int linha = rs_remove.getRow();
																										
																										if(corrente <= linha)
																											rs_remove.absolute(corrente);
																										else{
																											rs_remove.absolute(linha);
																											corrente = linha;
																										}
																									}
																									%>
																									<table style="color: #000000;">
																										<tr><td>Pesquisa:</td><td colspan="2"><input type="text" class="clsText" name="pesquisa" /></td></tr>
																										<tr>
																											<td>Por:</td><td>ID&nbsp;<input type="radio" name="search_op" value="1" /></td><td>Nome&nbsp;<input type="radio" name="search_op" value="2" /></td>
																											<td>
																											<input type="hidden" class="clsBut" name="opcao" value="<%= pesq %>">
													                                    		<input type="button" class="clsBut" value="Buscar" onclick="search()"></td>
													                                    	</tr>
																									</table>
																									<br/>
																									<p>ID:<br/><input type="text" class="clsText" name="idCamp" value="<%= rs_remove.getString(1) %>" readonly="readonly" /></p>
																									<p>Nome:<br/><input type="text" class="clsText" name="nomeCamp" value="<%= rs_remove.getString(2) %>" /></p>
																									<p>Ano:<br/><input type="text" class="clsText" name="anoCamp" value="<%= rs_remove.getString(3) %>" /></p>
																									<p>Divis&atilde;o:<br/><input type="text" class="clsText" name="divisaoCamp" value="<%= rs_remove.getString(4) %>" /></p>
																									<input type="hidden" class="clsText" name="abrangencia" value="<%= rs_remove.getString(5) %>" />
													                                    <p>Abrang&ecirc;cia:<br/>
																									<select name="abrangenciaCamp">
																										<option id="op0" value="Regional">Regional</option>
																										<option id="op1" value="Municipal">Municipal</option>
																										<option id="op2" value="Nacional">Nacional</option>
																										<option id="op3" value="Internacional">Internacional</option>
																									</select></p>
													                                    <script type="text/javascript">
																										var ab = document.form1.abrangencia.value.toUpperCase();
																										
																										if(ab == "REGIONAL"){
																											document.getElementById("op0").selected=true;
																										}
																										else if(ab == "MUNICIPAL"){
																											document.getElementById("op1").selected=true;
																										}
																										else if(ab == "NACIONAL"){
																											document.getElementById("op2").selected=true;
																										}
																										else if(ab == "INTERNACIONAL"){
																											document.getElementById("op3").selected=true;
																										}
																										else{
																											document.getElementById("op0").selected=true;
																										}
																									</script>
													                                    <input type="hidden" class="clsText" name="operation" value="2" />
													                                    <p class="clsButtons">
													                                    <input type="hidden" class="clsBut" name="escondido" value="<%= corrente %>">
													                                    <input type="button" class="clsBut" value="Anterior" onclick="movePrevious()">&nbsp;
													                                    <input type="button" class="clsBut" value="Próximo" onclick="moveNext()">&nbsp;
													                                    <input type="button" class="clsBut" value="Atualizar" onclick="submitButton()">
													                                    </p>
																									</form>
																									<script type="text/javascript">
																										function moveNext(){
																											var contador = 0;
																											contador = parseInt(document.form1.escondido.value) + 1;
																											document.form1.escondido.value = contador;
																											document.form1.submit();
																										}
																										function movePrevious(){
																											var contador = 0;
																											contador = parseInt(document.form1.escondido.value) - 1;
																											document.form1.escondido.value = contador;
																											document.form1.submit();
																										}
																										function search(){
																											document.form1.search_op.value = 1;
																											document.form1.submit();
																										}
																										function submitButton(){
																											document.form1.action = "CampeonatoServlet";
																											document.form1.submit();
																										}
																									</script>
																								</div>
																								<%
																								db_remove.close();
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
