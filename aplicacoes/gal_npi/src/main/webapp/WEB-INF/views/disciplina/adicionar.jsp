<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Cadastro de Disciplina</title>
	<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="../fragments/header.jsp" />
		<form:form action="/gal_npi/disciplina/adicionar.htm" method="post"
			modelAttribute="disciplina">
			<label for="codigo">Código:</label>
			<form:input type="text" name="codigo" id="codigo" path="codigo"/>
			<br />
			<form:errors cssClass="error" path="codigo" />
			<label for="nome">Nome:</label>
			<form:input type="text" name="nome" id="nome" path="nome"/>
			<br />
			<form:errors cssClass="error" path="nome" />
			<input type="submit" value="Cadastrar">
			<a class="buttonAdd" href="/gal_npi/disciplina/listar.htm"><p class = "textoMenu">Voltar</p></a>
		</form:form>
	</div>
</body>
</html>