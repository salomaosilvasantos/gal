<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Cadastro de Curso</title>
	<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="../fragments/header.jsp" />
		<form:form action="/gal_npi/curso/adicionar.htm" method="post" modelAttribute="curso">
			<label for="codigo">Código:</label>
			<form:input type="text" name="codigo" id="codigo" path="codigo"/>
			<form:errors path="codigo" cssStyle="color:red"/>
			<br />
			<form:errors cssClass="error" path="codigo" />
			<label for="nome">Nome:</label>
			<form:input type="text" name="nome" id="nome" path="nome"/>
			<br />
			<form:errors cssClass="error" path="nome" />
			<label for="sigla">Sigla:</label>
			<form:input type="text" name="sigla" id="sigla" path="sigla"/>
			<br />
			<form:errors cssClass="error" path="sigla" />
			<input type="submit" value="Cadastrar">
		</form:form>
	</div>
</body>
</html>