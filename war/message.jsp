<%@page
	import="java.util.*,java.sql.*,org.usp.database.*,org.usp.futebol.*"%>
<%
	if (request.getParameter("msgCamp") != null) {
		int msg = Integer.parseInt(request.getParameter("msgCamp"));

		switch (msg) {
			case 0: {
				out.print("<p style=\"text-align: center; color: #00aa00;\"><br/>Campeonato Cadastrado com Sucesso</p>");
				break;
			}
	
			case 1: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>Campeonato J� Cadastrado</p>");
				break;
			}
	
			case 2: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>N�o foi poss�vel Inserir o Campeonato. Por favor, tente novamente</p>");
				break;
			}

			case 3: {
				out.print("<p style=\"text-align: center; color: #00aa00;\"><br/>Campeonato Removido com Sucesso</p>");
				break;
			}
	
			case 4: {
				out.print("<p style=\"text-align: center; color: #00aa00;\"><br/>N�o foi poss�vel Remover o Campeonato. Por favor, tente novamente</p>");
				break;
			}

			case 5: {
				out.print("<p style=\"text-align: center; color: #00aa00;\"><br/>Campeonato Atualizado com Sucesso</p>");
				break;
			}
		
			case 6: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>N�o foi poss�vel Atualizar o Campeonato. Por favor, tente novamente</p>");
				break;
			}

			case 97: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>Todos os Campos s�o obrigat�rios. Por favor, preencha todos os Campos</p>");
				break;
			}

			case 98: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>Campos Inv�lido</p>");
				break;
			}

			case 99: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>Erro ao realizar a opera��o. Por favor, tente novamente</p>");
				break;
			}
		}
	}

	if (request.getParameter("msgClu") != null) {
		int msg = Integer.parseInt(request.getParameter("msgClu"));
	
		switch (msg) {
			case 0: {
				out.print("<p style=\"text-align: center; color: #00aa00;\"><br/>Clube Cadastrado com Sucesso</p>");
				break;
			}
	
			case 1: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>Clube J� Cadastrado</p>");
				break;
			}
	
			case 2: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>N�o foi poss�vel Inserir o Clube. Por favor, tente novamente</p>");
				break;
			}
	
			case 3: {
				out.print("<p style=\"text-align: center; color: #00aa00;\"><br/>Clube Removido com Sucesso</p>");
				break;
			}
	
			case 4: {
				out.print("<p style=\"text-align: center; color: #00aa00;\"><br/>N�o foi poss�vel Remover o Clube. Por favor, tente novamente</p>");
				break;
			}
	
			case 5: {
				out.print("<p style=\"text-align: center; color: #00aa00;\"><br/>Clube Atualizado com Sucesso</p>");
				break;
			}
		
			case 6: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>N�o foi poss�vel Atualizar o Clube. Por favor, tente novamente</p>");
				break;
			}
	
			case 97: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>Todos os Campos s�o obrigat�rios. Por favor, preencha todos os Campos</p>");
				break;
			}
	
			case 98: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>Campos Inv�lido</p>");
				break;
			}
	
			case 99: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>Erro ao realizar a opera��o. Por favor, tente novamente</p>");
				break;
			}
		}
	}

	if (request.getParameter("msgEq") != null) {
		int msg = Integer.parseInt(request.getParameter("msgEq"));
	
		switch (msg) {
			case 0: {
				out.print("<p style=\"text-align: center; color: #00aa00;\"><br/>Equipe Cadastrada com Sucesso</p>");
				break;
			}
	
			case 1: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>Equipe J� Cadastrada</p>");
				break;
			}
	
			case 2: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>N�o foi poss�vel Inserir a Equipe. Por favor, tente novamente</p>");
				break;
			}
	
			case 3: {
				out.print("<p style=\"text-align: center; color: #00aa00;\"><br/>Equipe Removida com Sucesso</p>");
				break;
			}
	
			case 4: {
				out.print("<p style=\"text-align: center; color: #00aa00;\"><br/>N�o foi poss�vel Remover a Equipe. Por favor, tente novamente</p>");
				break;
			}
	
			case 5: {
				out.print("<p style=\"text-align: center; color: #00aa00;\"><br/>Equipe Atualizada com Sucesso</p>");
				break;
			}
		
			case 6: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>N�o foi poss�vel Atualizar a Equipe. Por favor, tente novamente</p>");
				break;
			}
	
			case 97: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>Todos os Campos s�o obrigat�rios. Por favor, preencha todos os Campos</p>");
				break;
			}
	
			case 98: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>Campos Inv�lido</p>");
				break;
			}
	
			case 99: {
				out.print("<p style=\"text-align: center; color: #ff0000;\"><br/>Erro ao realizar a opera��o. Por favor, tente novamente</p>");
				break;
			}
		}
	}
	
	
	
%>