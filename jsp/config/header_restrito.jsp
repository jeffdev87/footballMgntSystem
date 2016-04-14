<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
			<!--[if IE ]>
			<link href="css/iefix.css" rel="stylesheet" type="text/css" />
			<![endif]-->
			<title> Futebol </title>
			<link rel="stylesheet" type="text/css" href="css/common.css" />
			<link rel="stylesheet" type="text/css" href="css/innerpage.css"/>
		</head>
	<body>
		<!--TOP-->
	   <div id="top">
		   <ul>
		      <li><a href="#main">Skip to main content</a></li>
		      <li><a href="#selSubHeader">Skip to Navigation Links</a></li>
		      <li><a href="#footer">Skip to Footer</a></li>
		   </ul>
	   </div>
		<!--END OF TOP-->
		
		<!--CONTAINER-->
		<div id="container">
	
			<!--HEADER-->
			<div id="header" class="clearfix">
			  <!--LEFT HEADER-->
			  <div id="selLeftHeader" class="clsFloatLeft">
			    <div id="selLogo">
			      <h1><a href="index.html">comapny logo</a></h1>
			    </div>
			  </div>
			  <!--END OF LEFT HEADER-->
			  <!--RIGHT HEADER-->
			  <div id="selRightHeader" class="clsFloatRight">
			  </div>
			  <!--END OF RIGHT HEADER-->
			</div>
			
			<%
				//Verifica se esta logado
				HttpSession sessao = request.getSession( true );
				String usuario = (String) sessao.getAttribute("username");

													


				if(usuario == null) {
					
					%>
					<jsp:forward page="admin_home.jsp?manage=principal" />
					<%
				}
				//Usuario esta logado	
				%>
				<form name="logout" action="admin_home.jsp" method="post">
				<input type="hidden" name="logout" />
				<input type="image" src="images/logout.png" align="right" alt="Logout" value="Logout" />
				</form>
			<!--END OF HEADER-->