<%@page import="java.sql.*, org.usp.database.*, org.usp.futebol.*" %>
<%@ page contentType="text/html; charset=ISO-8859-1" %>
	<!--HEADER-->
		<jsp:include page="config/header.jsp" />
	<!--END OF HEADER-->		  
			<%
				Database db = new Database();
			   ResultSet rs = null;
				int campCod = Integer.parseInt(request.getParameter("campCod"));
				String campNome = request.getParameter("campNome");
				
				try {
					CallableStatement sp;
					String call = "{call futebolApp.atualizaCamp}";
					sp = db.prepareCall(call);
					sp.executeUpdate();
				} catch (Exception e) {
				}
			%>
			<form name = "escondido" action = "campeonatos.jsp?campCod=<%=campCod%>&campNome=<%=campNome%>" method = "post">
				<input type = "hidden" id = "1" name = "opcaoCons" value = "0">
				<input type = "hidden" id = "6" name = "tipoConsArt" value = "0">
				<input type = "hidden" id = "7" name = "clubeCons" value = "Campeonato">
			</form>
	    	<!--MAINBOX-->
	  		<div id="main_box">	
				<div class="clsBottom">
					<div class="clsTop">
						<div class="clsCenter">
						
							<!--SELSUBHEADER-->
								<jsp:include page="config/menu_topo.jsp" />
							<!--END OF SELSUBHEADER--> 
							
							<!--CLSCENTERBOX-->
							<div class="clsCenter_box">
								<div class="clscenter_boxBottom">
									<div class="clscenter_boxTop">
										<div class="clscenter_boxCenter">
											<div class="clsBanner">
											</div>
										
											<!--CONTENT-->
											<div class="content clearfix">
												<!-- SIDEBAR2-->
												<div class="sidebar2 clsFloatRight">
													<h3>Última Partida</h3>
													<div class="inner_tb">
														<div class="inner_bb">
															<div class="inner_lb">
																<div class="inner_rb">
																	<div class="inner_tlc">
																		<div class="inner_trc">
																			<div class="inner_blc">
																				<div class="inner_brc">
																					<div class="cls100_p">
																						<div id="selMatches">
																							<p><a href="#"><img src="images/VS.jpg" alt="" /></a></p>
																							<p>
																								<span style = "color:#006400;">
																									<%
																										rs = Partida.selectUltimaPartida(db, campCod);
																									   Partida part = null;
																									   if ((part = Partida.nextPart(rs))!= null) {
																										   out.print("<font><b>" + part.getApelidoClubeM() + " X " + part.getApelidoClubeV() + "</b></font><br><br>");
																										   out.print("Dia: " + part.getDataHoraPartida());
																										   out.print("<br> <br> Horário: " + part.getHoraPart());
																										   out.print("<br> <br> Estádio: " + part.getNomeEst());
																									   }
																									%>
																								</span>
																							</p>
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
												<!--END OF SIDEBAR2--> 
												
												<!--MAIN-->
												<div id="main">
													<div class="inner_tb">
														<div class="inner_bb">
															<div class="inner_lb">
																<div class="inner_rb">
																	<div class="inner_tlc">
																		<div class="inner_trc">
																			<div class="inner_blc">
																				<div class="inner_brc">
																					<div class="cls100_p">
																						<div id="selIndoor">
																							<p style = "text-align:center;">
																							   <script type="text/javascript">
																								   function mudaCor(id) {
																								   	elem = document.getElementById(id);
																								   	elem.style.background = "red";
																								   }
																								   function voltaCor(id) {
																									   elem = document.getElementById(id);
																									   elem.style.background = "#228B22";
																									}

																									function setarOpcao (id) {
																										elem = document.getElementById("1");
																										elem.value = id;
																										document.escondido.submit();
																									}
																							   </script>
																							   <table>
																							   	<thead>
																					   				<tr class="column1">
																											<th id = "2" scope="col" style = "background:#228B22;"><a href = "#" onMouseMove = "mudaCor(2);" onMouseOut = "voltaCor(2);" onClick = "setarOpcao (2);" style = "font-size:medium; color:#FFFFF0"> Classificação </a></th> 
																											<th id = "3" scope="col" style = "background:#228B22;"><a href = "#" onMouseMove = "mudaCor(3);" onMouseOut = "voltaCor(3);" onClick = "setarOpcao (3);" style = "font-size:medium; color:#FFFFF0"> Jogos </a></th>
																											<th id = "4" scope="col" style = "background:#228B22;"><a href = "#" onMouseMove = "mudaCor(4);" onMouseOut = "voltaCor(4);" onClick = "setarOpcao (4);" style = "font-size:medium; color:#FFFFF0"> Resultados </a></th>
																											<th id = "5" scope="col" style = "background:#228B22;"><a href = "#" onMouseMove = "mudaCor(5);" onMouseOut = "voltaCor(5);" onClick = "setarOpcao (5);" style = "font-size:medium; color:#FFFFF0"> Artilharia </a></th>
																											<th id = "8" scope="col" style = "background:#228B22;"><a href = "#" onMouseMove = "mudaCor(8);" onMouseOut = "voltaCor(8);" onClick = "setarOpcao (8);" style = "font-size:medium; color:#FFFFF0"> Relatório </a></th>
																										</tr>
																							   	</thead>
																							   </table>
																						   </p>
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
													<% if (Integer.parseInt(request.getParameter("opcaoCons")) == 0) { %>
														<div class="inner_tb">
															<div class="inner_bb">
																<div class="inner_lb">
																	<div class="inner_rb">
																		<div class="inner_tlc">
																			<div class="inner_trc">
																				<div class="inner_blc">
																					<div class="inner_brc">
																						<div class="cls100_p">
																							<div id="selIndoor">			
																								<p style = "text-align:center;">
																									<font size = 3 color = #006400> Selecione alguma das opções acima! </font>
																								</p>
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
													<% } %>
													<% if (Integer.parseInt(request.getParameter("opcaoCons")) == 2) { %>
														<div class="inner_tb">
															<div class="inner_bb">
																<div class="inner_lb">
																	<div class="inner_rb">
																		<div class="inner_tlc">
																			<div class="inner_trc">
																				<div class="inner_blc">
																					<div class="inner_brc">
																						<div class="cls100_p">
																							<div id="selIndoor">			
																								<h2>CLASSIFICAÇÃO</h2>
																								<div class="clscommon clearfix">		
																									<p style = "text-align:center;">
																										<table>
																											<caption> <font size = 3> Classificação do <% out.print(request.getParameter("campNome")); %></font> </caption> 
																											<thead>
																												<tr class="column1">
																													<th scope="col"> Clube </th> 
																													<th scope="col"> Equipe </th>
																													<th scope="col"> SG </th>	 
																													<th scope="col"> NE </th>
																													<th scope="col"> NV </th> 
																													<th scope="col"> ND </th>
																													<th scope="col"> PG </th>
																												</tr>	
																											</thead>
																											<%
																												rs = Classificacao.selectByIdCamp(db, campCod);
																												Classificacao classificacao = null;
																												while ((classificacao = Classificacao.nextClass(rs)) != null) {
																													out.println("<tr>");
																													out.println("<td style = \"padding:10px 30px; background:#F0F8FF;\"><b><font color = \"#000000\">" + classificacao.getNomeClube() + "</font></b></td>");
																													out.println("<td>" + classificacao.getNomeEq() + "</td>");
																													out.println("<td><b><font color = \"#8B0000\">" + classificacao.getSaldoGols() + "</font></b></td>");
																													out.println("<td><b><font color = \"#8B0000\">" + classificacao.getPontosEmpate() + "</font></b></td>");
																													out.println("<td><b><font color = \"#B22222\">" + classificacao.getPontosVitoria() + "</font></b></td>");
																													out.println("<td><b><font color = \"#B22222\">" + classificacao.getPontosDerrota() + "</font></b></td>");
																													out.println("<td><b><font color = \"#8B0000\">" + classificacao.getPontosGanhos() + "</font></b></td>");
																													out.println("</tr>");
																												}
																											%>
																											<tr>
																												<td colspan="7" style = "text-align:left; background:#A9A9A9; color:#F0F8FF;">
																													PG - pontos ganhos; NV - vitórias; NE - empates; <br> 
																													ND - derrotas; SG - saldo de gols
																												</td>
																											</tr>	
																										</table>
																									</p>
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
													<% } %>
													<% if (Integer.parseInt(request.getParameter("opcaoCons")) == 3) {%>	
														<div class="inner_tb">
															<div class="inner_bb">
																<div class="inner_lb">
																	<div class="inner_rb">
																		<div class="inner_tlc">
																			<div class="inner_trc">
																				<div class="inner_blc">
																					<div class="inner_brc">
																						<div class="cls100_p">
																							<div id="selIndoor">
																								<h2>JOGOS</h2>
																								<div class="clscommon clearfix">		
																									<p style = "text-align:center;">
																										<table> 	
																											<caption> <font size = 3> Partidas previstas do <% out.print(request.getParameter("campNome")); %> </font></caption> 
																											<thead>
																												<tr class="column1">
																													<th scope="col"> Partida </th> 
																													<th scope="col"> Data </th>
																													<th scope="col"> Hora </th>	
																													<th scope="col"> Clube Mandante </th> 
																													<th scope="col"> Clube Visitante </th>
																													<th scope="col"> Estádio </th> 
																												</tr>	
																											</thead>
																											<%
																											   rs = Partida.selectPartidasNaoRealizadas(db, campCod);
																												part = null;
																												while ((part = Partida.nextPart(rs)) != null) {
																													out.println("<tr>");
																													out.println("<td style = \"padding:10px 30px; background:#F0F8FF;\"><b><font color = \"#000000\">" + part.getNroPartida() + "</font></b></td>");
																													out.println("<td>" + part.getDataHoraPartida() + "</td>");
																													out.println("<td>" + part.getHoraPart() + "</td>");
																													out.println("<td><b><font color = \"#8B0000\">" + part.getApelidoClubeM() + "</font></b></td>");
																													out.println("<td><b><font color = \"#8B0000\">" + part.getApelidoClubeV() + "</font></b></td>");
																													out.println("<td><b>" + part.getNomeEst() + "</b></td>");
																													out.println("</tr>");
																												}
																											%>
																										</table>
																									</p>
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
													<% } %>	
													<% if (Integer.parseInt(request.getParameter("opcaoCons")) == 4) { %>																								
														<div class="inner_tb">
															<div class="inner_bb">
																<div class="inner_lb">
																	<div class="inner_rb">
																		<div class="inner_tlc">
																			<div class="inner_trc">
																				<div class="inner_blc">
																					<div class="inner_brc">
																						<div class="cls100_p">
																							<div id="selIndoor">
																									<h2>RESULTADOS</h2>
																								<div class="clscommon clearfix">		
																									<p style = "text-align:center;">
																										<table> 
																											<caption> <font size = 3> Resultados das Partidas do <% out.print(request.getParameter("campNome")); %> </font></caption> 
																											<thead>
																												<tr class="column1"> 
																													<th scope="col"> Partida </th>
																													<th scope="col"> Data </th>  
																													<th scope="col"> Hora </th>
																													<th scope="col"> CM </th>	
																													<th scope="col"> CV </th> 
																													<th scope="col"> Gols CM </th>
																													<th scope="col"> Gols CV </th>
																													<th scope="col"> Estádio </th>  
																												</tr>	
																											</thead>
																											<% 
																												Res res = null;
																												rs = Res.selectByIdCamp(db, campCod);
																												while ((res = Res.nextRes(rs)) != null) {
																													out.println("<tr>");
																													out.println("<td style = \"background:#F0F8FF;\"><b><font color = \"#000000\">" + res.getNroPartida() + "</font></b></td>");
																													out.println("<td>" + res.getDataHoraPartida() + "</td>");
																													out.println("<td>" + res.getHoraPart() + "</td>");
																													out.println("<td>" + res.getApelidoClubeMandante() + "</td>");
																													out.println("<td>" + res.getApelidoClubeVisitante() + "</td>");
																													out.println("<td><b><font color = \"#8B0000\">" + res.getGolsMandante() + "</font></b></td>");
																													out.println("<td><b><font color = \"#8B0000\">" + res.getGolsVisitante() + "</font></b></td>");
																													out.println("<td>" + res.getNomeEst() + "</td>");
																													out.println("</tr>");
																												}
																												db.close();
																											%> 
																											<tr>
																												<td colspan="8" style = "text-align:left; background:#A9A9A9; color:#F0F8FF;">
																													CM - clube mandante; CV - clube visitante
																												</td>
																											</tr>	
																										</table>													
																									</p>
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
													<% }%>
													<% if (Integer.parseInt(request.getParameter("opcaoCons")) == 5) { %>
														<div class="inner_tb">
															<div class="inner_bb">
																<div class="inner_lb">
																	<div class="inner_rb">
																		<div class="inner_tlc">
																			<div class="inner_trc">
																				<div class="inner_blc">
																					<div class="inner_brc">
																						<div class="cls100_p">
																							<div id="selIndoor">
																								<script type="text/javascript">
																							   	function mudarTipoConsArtilharia () {
																										elem = document.getElementById("6");
																										elem2 = document.getElementById("7");
																										
																										index = document.getElementById("clubes").selectedIndex;
																										y = document.getElementsByTagName("option");
																										
																										elem2.value = y[index].text;
																										elem.value = 1;
																										setarOpcao (5);
																										
																										document.escondido.submit();
																									}	
																									</script>	
																									<p style = "text-align:left;">
																										<a href = "#" onClick = "mudarTipoConsArtilharia ();" style = "font-size:medium; color:#006400"> Faça essa consulta por time </a>
																										&nbsp;&nbsp;&nbsp;
																										<select id="clubes">
																											<% 
																												Campeonato camp = null;	
																												rs = Campeonato.findClubes(db, campCod);
																												while ((camp = Campeonato.nextClubes(rs)) != null) {
																													out.println("<option value=\""+camp.getApelidoClube()+"\">"+camp.getApelidoClube()+"</option>");
																												}
																											%>
																										</select>
																										
																									</p>
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
																							<div id="selIndoor">			
																								<h2>Artilharia do <% out.println(request.getParameter("clubeCons")); %></h2>
																								<div class="clscommon clearfix">		
																									<p style = "text-align:center;">
																										<table>
																											<caption> <font size = 3> Artilheiros do <% out.print(request.getParameter("campNome")); %> </font></caption> 
																											<thead>
																												<tr class="column1">
																													<th scope="col"> Jogador </th> 
																													<th scope="col"> Clube </th>
																													<th scope="col"> Gols </th>	 
																												</tr>	
																											</thead>
																											<%
																												if (Integer.parseInt(request.getParameter("tipoConsArt")) == 0)
																											   	rs = Participa.selectArtilheirosCamp(db, campCod);
																												else	
																													rs = Participa.selectArtilheirosCampTime(db, campCod, request.getParameter("clubeCons"));
																											
																												Participa participa = null;
																												while ((participa = Participa.nextPart(rs)) != null) {
																													out.println("<tr>");
																													out.println("<td style = \"padding:.5em 2em;\"><b><font size = 2>" + participa.getApelidoMembro() + "</font></b></td>");
																													out.println("<td style = \"padding:.5em 2em;\"><b><font size = 2>" + participa.getApelidoClube() + "</font></b></td>");
																													out.println("<td style = \"padding:.5em 2em;\"><b><font color = \"#B22222\" size = 2>" + participa.getSomaGols() + "</font></b></td>");
																													out.println("</tr>");
																												}
																											%>
																										</table>
																									</p>
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
													<% } %>
													<% if (Integer.parseInt(request.getParameter("opcaoCons")) == 8) { %>
														<div class="inner_tb">
															<div class="inner_bb">
																<div class="inner_lb">
																	<div class="inner_rb">
																		<div class="inner_tlc">
																			<div class="inner_trc">
																				<div class="inner_blc">
																					<div class="inner_brc">
																						<div class="cls100_p">
																							<div id="selIndoor">			
																								<p style = "text-align:center;">
																									<font size = 3 color = #006400> Relatório do <% out.print(request.getParameter("campNome")); %> </font>
																									<table>
																										<%
																											CallableStatement sp2;
																											String relat = "{call futebolApp.relatorioCamp(?,?,?,?,?,?,?,?,?,?,?,?)}";
																											try {
																												sp2 = db.prepareCall(relat);
																												
																												sp2.registerOutParameter(2,Types.VARCHAR);
																												sp2.registerOutParameter(3,Types.INTEGER);
																												sp2.registerOutParameter(4,Types.INTEGER);
																												sp2.registerOutParameter(5,Types.INTEGER);
																												sp2.registerOutParameter(6,Types.INTEGER);
																												sp2.registerOutParameter(7,Types.INTEGER);
																												sp2.registerOutParameter(8,Types.INTEGER);
																												sp2.registerOutParameter(9,Types.VARCHAR);
																												sp2.registerOutParameter(10,Types.VARCHAR);
																												sp2.registerOutParameter(11,Types.INTEGER);
																												sp2.registerOutParameter(12,Types.VARCHAR);
																												sp2.setInt(1, campCod);
																												sp2.executeUpdate();
																												out.println("<tr style = \"padding:.6em 3em;\"><td style = \"background:#F0F8FF;\"><b>ANO: </b></td> <td style = \"font-size:small; color:#008000;\">" + sp2.getString(2) + "</tr></td>");
																												out.println("<tr><td style = \"background:#F0F8FF;\"><b>DIVISÃO:</b> </td> <td style = \"font-size:small; color:#008000;\">" + sp2.getInt(3) + "</tr></td>");
																												out.println("<tr><td style = \"background:#F0F8FF;\"><b>TOTAL DE GOLS: </b></td> <td style = \"font-size:small; color:#008000;\">" + sp2.getInt(4) + "</tr></td>");
																												out.println("<tr><td style = \"background:#F0F8FF;\"><b>GOLS CONTRA: </b></td><td style = \"font-size:small; color:#008000;\">" + sp2.getInt(5) + "</tr></td>");
																												out.println("<tr><td style = \"background:#F0F8FF;\"><b>MÉDIA DE GOLS: </b></td><td style = \"font-size:small; color:#008000;\">" + sp2.getInt(6) + "</tr></td>");
																												out.println("<tr><td style = \"background:#F0F8FF;\"><b>CARTÕES AMARELOS: </b></td><td style = \"font-size:small; color:#008000;\">" + sp2.getInt(7) + "</tr></td>");
																												out.println("<tr><td style = \"background:#F0F8FF;\"><b>CARTÕES VERMELHOS: </b></td><td style = \"font-size:small;color:#008000; \">" + sp2.getInt(8) + "</tr></td>");
																												out.println("<tr><td style = \"background:#F0F8FF;\"><b>CLUBE VENCEDOR: </b></td><td style = \"font-size:small;color:#008000; \">" + sp2.getString(9) + "</tr></td>");
																												out.println("<tr><td style = \"background:#F0F8FF;\"><b>EQUIPE: </b></td><td style = \"font-size:small; color:#008000;\">" + sp2.getString(10) + "</tr></td>");
																												out.println("<tr><td style = \"background:#F0F8FF;\"><b>NÚMERO DE VITÓRIAS: </b></td><td style = \"font-size:small; color:#008000;\">" + sp2.getInt(11) + "</tr></td>");
																												out.println("<tr><td style = \"background:#F0F8FF;\"><b>TÉCNICO: </b></td><td style = \"font-size:small; color:#008000;\">" + sp2.getString(12) + "</tr></td>");
																											} catch (Exception e2) {
																											}
																										%>
																									</table>
																								</p>
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
													<% } %>
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
	   <% db.close(); %>
		<jsp:include page="config/footer.jsp" />
	<!--END OF FOOTER-->