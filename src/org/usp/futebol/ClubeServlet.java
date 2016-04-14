package org.usp.futebol;

import java.io.*;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import org.usp.util.*;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;

import org.usp.util.Interceptor;

public class ClubeServlet extends HttpServlet implements ConfigServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int operation = -1;
		Clube clube = null;
		String page = null;
		String cnpjClube = null;
		String nomeClube = null;
		String apelidoClube = null;
		String logoClube = null;
		PrintWriter out = response.getWriter();

		boolean isMultiPart = FileUpload.isMultipartContent(request);
		
		if (isMultiPart) {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);

			try {
				List items = upload.parseRequest(request);
				Iterator iter = items.iterator();
				while (iter.hasNext()) {
					FileItem item = (FileItem) iter.next();
					if (item.getFieldName().equals("cnpjClube"))
						cnpjClube = item.getString();
					if (item.getFieldName().equals("nomeClube"))
						nomeClube = item.getString();
					if (item.getFieldName().equals("apelidoClube"))
						apelidoClube = item.getString();
					if (item.getFieldName().equals("operation"))
						operation = Integer.parseInt(item.getString());
					if (!item.isFormField()) {
						if (item.getName().length() > 0) {
							logoClube = inserirImagemDiretorio(item);
						}
					}
				}
			} catch (FileUploadException ex) {
				ex.printStackTrace();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		
		switch (operation) {
		case INSERT:
			page = "gerencia_clube.jsp?msgClu=0";
			clube = new Clube();

			try{
				
				clube.setCnpjClube(cnpjClube);
				clube.setNomeClube(nomeClube);
				clube.setApelidoClube(apelidoClube);
				clube.setLogoClube(logoClube);
				System.out.println(clube.toString());
				
				Interceptor.filter(cnpjClube);
				Interceptor.filter(nomeClube);
				Interceptor.filter(apelidoClube);

				clube.insert();
								
			}catch (SQLException sqle) {
				System.err.println(sqle.getErrorCode());
				if(sqle.getErrorCode() == 1)
					page = "gerencia_clube.jsp?msgClu=1";
				else if (sqle.getErrorCode() == 1407)
					page = "gerencia_clube.jsp?msgClu=97";
				else
					page = "gerencia_clube.jsp?msgClu=99";
			}catch (InterceptorException e) {
				System.err.println(e.getMessage());
				if(e.getMessage().equals("1"))
					page = "gerencia_clube.jsp?msgClu=97";
				else if(e.getMessage().equals("2"))
					page = "gerencia_clube.jsp?msgClu=98";
				else
					page = "gerencia_clube.jsp?msgClu=99";
			}
			catch (Exception e1) {
				page = "gerencia_clube.jsp?msgClu=99";
			}		
			break;
			
		case REMOVE:
			page = "gerencia_clube.jsp?msgClu=3";
			System.out.println("Teste");
			try {
				
				
				clube = new Clube(cnpjClube);
				System.out.println(cnpjClube);
				System.out.println(clube.toString());
				//clube.remove();
			} catch (Exception e) {
				page = "gerencia_clube.jsp?msgClu=4";
			}
			break;
			
		case UPDATE:
			page = "message.jsp?id=4";
			try {
				clube = new Clube(request.getParameter("cnpjClube"));
				/*
				camp.setIdCamp(Integer.parseInt(request.getParameter("idCamp")));
				camp.setNomeCamp(request.getParameter("nomeCamp"));
				camp.setAnoCamp(Integer.parseInt(request.getParameter("anoCamp")));
				camp.setDivisaoCamp(Integer.parseInt(request.getParameter("divisaoCamp")));
				camp.setAbrangenciaCamp(request.getParameter("abrangenciaCamp"));
				camp.setCnpjClubeVence(Integer.parseInt(request.getParameter("cnpjClubeVence")));
				camp.setNomeEqVence(request.getParameter("nomeVence"));
				camp.setPontosVitoria(Integer.parseInt(request.getParameter("pontosVitoria")));
				camp.setPontosEmpate(Integer.parseInt(request.getParameter("pontosEmpate")));
				camp.update();
				*/
			} catch (Exception e) {
				page = "message.jsp?id=5";
			}
			break;
		}
		//response.sendRedirect(page);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	private String inserirImagemDiretorio(FileItem item) throws IOException {

		// Pega o diretório /image dentro do diretório atual de onde a
		// aplicação está rodando
		

		String caminho = getServletContext().getRealPath("/image") + "/";

		// Cria o diretório caso ele não exista
		File diretorio = new File(caminho);
		if (!diretorio.exists()) {
			diretorio.mkdir();
		}

		// Mandar o arquivo para o diretório informado
		String nome = item.getName();
		String arq[] = nome.split("\\\\");
		for (int i = 0; i < arq.length; i++) {
			nome = arq[i];
		}

		File file = new File(diretorio, nome);
		FileOutputStream output = new FileOutputStream(file);
		InputStream is = item.getInputStream();
		byte[] buffer = new byte[2048];
		int nLidos;
		while ((nLidos = is.read(buffer)) >= 0) {
			output.write(buffer, 0, nLidos);
		}

		output.flush();
		output.close();
		return (caminho+nome);
		// Guarda no banco de dados o endereço para recuperação da imagem
	}

}
