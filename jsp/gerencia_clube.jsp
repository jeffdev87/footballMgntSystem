
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
																				<li><a href="gerencia_clube.jsp?op=0"><span>Inserir</span></a></li>
																				<li><a href="gerencia_clube.jsp?op=1"><span>Remover</span></a></li>
																				<li><a href="gerencia_clube.jsp?op=2"><span>Atualizar</span></a></li>
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
																				<h2 style="text-align: center;">Gerenciamento de Clubes!</h2>
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
																				<%
																					if(request.getParameter("op") != null){
																						Database db = new Database();
																						ResultSet rs = Clube.findAll(db);
																						Clube clube = null;

																						int op = Integer.parseInt(request.getParameter("op"));
																						switch (op){
																							case 0:
																								%>
																								<div id="selContactForm">
																								<form id="formImagem" name="formImagem" method="post" action="ClubeServlet" enctype="multipart/form-data">
																									<h2 style="font-size: medium; text-align: center;">Inserir</h2>
																									<p>CNPJ<br/><input type="text" class="clsText" id="cnpjClube" name="cnpjClube"/></p>
																									<p>Nome<br/><input type="text" class="clsText" id="nomeClube" name="nomeClube"/></p>
																									<p>Apelido<br/><input type="text" class="clsText" id="apelidoClube" name="apelidoClube"/></p>
																									<p>Logo<br/><input class="clsText" name="imagem" type="file" id="imagem"/></p>
																									<input type="hidden" class="clsText" name="operation" value="0" />
																									<p class="clsButtons">
																									<input type="reset" class="clsBut" value="Limpar" />
																									<input type="submit" id="upload" name="upload" value="Enviar" />
																									</p>
																								</form>
																								</div>																								
																								<%
																								break;
																							case 1:
																								%>
																								<div id="selContactForm">
																								<form action="CampeonatoServlet" method="post">
																									<h2 style="font-size: medium; text-align: center;">Remover</h2>
																									<p style="text-align: center;"><br/>Ao escolher a op&ccedil;&atilde;o e clicar em Remover, os dados do Campeonato serão excluidos permanentemente<br/></p>
																									<p>Clube:&nbsp;<select name="idCamp"><option value="-1">--Selecione--</option>
																									<%
																									int i=0;
																									while ((clube = Clube.next(rs)) != null) {
																										i++;
																										out.print("<option value=\""+clube.getCnpjClube()+"\">"+clube.getApelidoClube()+"</option>");
																										session.setAttribute("idCamp"+i, clube.getCnpjClube());
																									}
																									session.setAttribute("nTuplas", i);
																									session.setAttribute("atual", 1);
																									db.close();
																									%>
																									</select>
																									<%
																									
																									//out.print("<input type=\"text\" class=\"clsText\" name=\"idCamp\" value=\""+session.getAttribute("idCamp"+session.getAttribute("atual"))+"\" />");
																									
																									//int atual = session.getAttribute("atual") + 1;
																										//session.setAttribute("atual", atual);
																									%>
																									</p>
																									<input type="hidden" class="clsText" name="operation" value="1" />
																									<p class="clsButtons">
																									<input type="button" name="next" value="Anterior" onclick=""/>&nbsp;
																									<input type="button" name="next" value="Proximo" onclick=""/>&nbsp;
																									<input type="submit" class="clsBut" value="Remover" />
																									</p>
																								</form>
																								</div>
																								<%
																								break;
																							case 2:
																								%>
																								<div id="selContactForm">
																								<form action="" method="post">
																									<h2 style="font-size: medium; text-align: center;">Atualizar</h2>
																									<p>Clube:&nbsp;<select name="id"><option value="-1">--Selecione--</option>
																									<%
																									while ((clube = Clube.next(rs)) != null) {
																										out.print("<option value=\""+clube.getCnpjClube()+"\">"+clube.getApelidoClube()+"</option>");
																									}
																									db.close();
																									%>
																									</select></p>
																								</form>
																								</div>
																								<%
																								break;
																							default:
																								out.print("<p>Op&ccedil;&atilde; Inv&aacute;lida</p>");
																						}
																					}else{
																						out.print("<p style=\"text-align: center;\"><br/>Por favor, escolha uma op&ccedil;&atilde;o no menu ao lado<br/><br/><br/></p>");
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
