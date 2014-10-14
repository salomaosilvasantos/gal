<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="./resources/css/ui-darkness/jquery-ui-1.10.3.custom.css" />
<script type="text/javascript" src="./jquery-2.0.1.min.js"></script>
<script type="text/javascript" src="./resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script>
	$(document).ready

</script>
<title>Insert title here</title>
</head>
<body>
	<center>
	<form action="CadastroUsuarioServlet" method="post">
		Nome:<input type="text" name="nome">
		Sobrenome:<input type="text" name="sobrenome">
		<input type="submit" name="Enviar">
		<br /><br />
		<a href="index.jsp">Voltar ao menu</a>
		
	</form>
	</center>
</body>
</html>