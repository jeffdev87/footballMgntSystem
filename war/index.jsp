<!--HEADER-->
<%@page import="java.sql.*, org.usp.database.*, org.usp.futebol.*, org.usp.util.*, java.util.*" %>
<%@ page contentType="text/html; charset=ISO-8859-1" %>  
<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="java.net.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.axis.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import="org.jfree.chart.labels.*" %>
<%@ page  import="org.jfree.chart.plot.*" %>
<%@ page  import="org.jfree.chart.renderer.category.*" %>
<%@ page  import="org.jfree.chart.urls.*" %>
<%@ page  import="org.jfree.data.category.*" %>
<%@ page  import="org.jfree.data.general.*" %>
<%@ page  import="org.jfree.data.jdbc.*" %>
<jsp:include page="config/header.jsp" />
<!--END OF HEADER-->
<form name = "escondido" action = "index.jsp" method = "post">
	<input type = "hidden" id = "1" name = "opcaoCons" value = "0">
</form>
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
								<div class="clsBanner"></div>
								<!--CONTENT-->
								<div class="content clearfix">
									<!--SIDEBAR1-->
									<div class="sidebar1 clsFloatLeft">
										<h3>Campeonatos</h3>
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
																				<%
                                                                                    Database db = null;
                                                                                    ResultSet rs = null;     
                                                                                    Campeonato camp = null;
                                                                                    try {
																					db = new Database();
																					rs = Campeonato.findAll(db);
																					camp = null;
																					while ((camp = Campeonato.next(rs)) != null)
																						out.print("<li><span><a href=\"campeonatos.jsp?campCod="+camp.getIdCamp()+"&campNome="+camp.getNomeCamp()+"&opcaoCons=0&tipoConsArt=0&clubeCons=Campeonato"+"\">"+camp.getNomeCamp()+"</a></span></li>");
                                                                                    }
                                                                                    catch (Exception ex) {
                                                                                        System.out.println("bla");
                                                                                    }
																				%>
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
										<h3>Clubes</h3>
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
																				<%
                                                                                    if (rs != null) {  
																					    rs = Clube.findAll(db);
																					    Clube clube = null;
																					    while ((clube = Clube.next(rs)) != null)
																						    out.print("<li><span>"+clube.getNomeClube()+"<span><li>");
                                                                                    }
																				%>
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
									<!-- SIDEBAR2-->
									<div class="sidebar2 clsFloatRight">
										<h3>Últimas notícias</h3>
										<div class="inner_tb">
											<div class="inner_bb">
												<div class="inner_lb">
													<div class="inner_rb">
														<div class="inner_tlc">
															<div class="inner_trc">
																<div class="inner_blc">
																	<div class="inner_brc">
																		<div class="cls100_p">
																			<div id="selservice">
																				<ul>
																					<%
																						WebRobot noticias = new WebRobot();
																						URL url = new URL("http://rss.esporte.uol.com.br/ultimas/index.xml");
																						URLConnection uc = url.openConnection();
		
																						Scanner read = new Scanner(uc.getInputStream());
																						FileWriter fw = new FileWriter("uolRss.xml");
																						BufferedWriter ps = new BufferedWriter(fw);
		
																						while (read.hasNext()) {
																							ps.write(read.nextLine());
																						}
		
																						ps.close();
																						fw.close();
		
																					   InputStream in = 
																							new BufferedInputStream(
																								new FileInputStream(new File("uolRss.xml")));
																					   noticias.readXML(in);
																						Vector <News> vetNoticias;
																						vetNoticias = noticias.getNews();
																						Iterator<News> it = vetNoticias.iterator(); 
																						while (it.hasNext()) {
																							out.println("<li><a href = \""+ it.next().getUrl() +"\">" + it.next().getTitle() + "</a></li>");
																						}
																					%>
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
																								<th id = "2" scope="col" style = "background:#228B22;"><a href = "#" onMouseMove = "mudaCor(2);" onMouseOut = "voltaCor(2);" onClick = "setarOpcao (2);" style = "font-size:medium; color:#FFFFF0"> Estatísticas </a></th> 
																								<th id = "3" scope="col" style = "background:#228B22;"><a href = "#" onMouseMove = "mudaCor(3);" onMouseOut = "voltaCor(3);" onClick = "setarOpcao (3);" style = "font-size:medium; color:#FFFFF0"> Clubes </a></th>
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
										<% if (request.getParameter("opcaoCons") == null) { %>
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
																					<font size = "3" color = "#006400"> Selecione alguma das opções acima! </font>
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
										<% if (request.getParameter("opcaoCons") != null) { %>
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
																				<p style = "text-align:center;">
																					<h2>Gráfico</h2>
																					<p style = "text-align:center;"> <font size = 3 color = #006400>Análise das faltas cometidas pelos jogadores:</font></p>
																				   <% JFreeChart pieChart = null;
										
																				      final String QUERY_JOGADOR_FALTAS =
																				    	  "SELECT M.nomeMembro, SUM (P.nroFaltas)"  + 
																				          		 
																				   	  " FROM Participa P JOIN Jogador J ON P.cpfJogador = J.cpfJogador AND " + 
																				                                      "P.cnpjClube = J.cnpjClube AND " +
																				                                      "P.nomeEq = J.nomeEq AND " +
																				                                      "P.dataInicJog = J.dataInicJog JOIN Clube Cl ON Cl.cnpjClube = P.cnpjClube, " +
																				        										  "Membro M, Campeonato Camp " +
																				   	  "WHERE J.cpfJogador = M.cpfMembro AND P.idCamp = Camp.idCamp " +
																				   	  "GROUP BY (P.idCamp, Camp.nomeCamp, Cl.nomeClube, M.nomeMembro) " +
																				   	  "HAVING SUM(P.nroFaltas) > 0 " +
																				   	  "ORDER BY P.idCamp ASC, SUM(P.nroFaltas) DESC";
										
																				      final String TITLE = "Faltas por jogadores";
										
																				      try
																				      {
																				         PieDataset pieDataset =
																				            new JDBCPieDataset(db.getConnection(), QUERY_JOGADOR_FALTAS);
										
																				         pieChart = ChartFactory.createPieChart( TITLE, pieDataset, true,//legend displayed
																				                                                 true,//tooltips displayed
																				                                                 false); //no URLs
																				      }
																				      catch (SQLException sqlEx)    // checked exception
																				      {
																				         System.err.println("Error trying to acquire JDBCPieDataset.");
																				         System.err.println("Error Code: " + sqlEx.getErrorCode());
																				         System.err.println("SQLSTATE:   " + sqlEx.getSQLState());
																				         sqlEx.printStackTrace();
																				      }
																					   try
																				      {
																				         ChartUtilities.writeChartAsPNG(new FileOutputStream("../webapps/jcharts/pieChart.png"), pieChart, 800, 600);
																				      }
																				      catch (IOException ioEx)
																				      {
																				         System.err.println("Error writing PNG file " + "../webapps/jcharts/pieChart.png");
																				      }
																					%>
																					<br> 
																						<img style = "padding:.3em 3.35em;" align="middle" src="../jcharts/pieChart.png" WIDTH="400" HEIGHT="300" BORDER="0" USEMAP="#chart">
																					<br>
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
										<% } %>
										<% if (request.getParameter("opcaoCons") != null) { %>
										<% if (Integer.parseInt(request.getParameter("opcaoCons")) == 3) { %>
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
																					<font size = "3" color = "#006400"> Selecione alguma das opções acima! </font>
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
