<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Cadastro de Título</title>
	<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="../fragments/header.jsp" />
		<form:form action="/gal_npi/titulo/adicionar.htm" method="post" modelAttribute="titulo">
			<label for="nome">Nome:</label>
			<form:input type="text" path="nome"/>
			<br />
			<form:errors cssClass="error" path="nome" />
			
			<label for="nome">ISBN:</label>
			<form:input type="text" path="isbn"/>
			<br />
			<form:errors cssClass="error" path="isbn" />
			
			<label for="nome">Tipo:</label>
			<form:input type="text" path="tipo"/>
			<br />
			<form:errors cssClass="error" path="tipo" />
			
			<input type="submit" value="Cadastrar">
			<a class="buttonAdd" href="/gal_npi/titulo/listar.htm"><p class = "textoMenu">Voltar</p></a>
		</form:form>
	</div>
</body>
</html>