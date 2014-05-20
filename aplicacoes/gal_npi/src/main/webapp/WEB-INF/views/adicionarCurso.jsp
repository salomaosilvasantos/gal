<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Cadastro de Curso</title>
	<jsp:include page="fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="fragments/header.jsp" />
		<form:form action="inserirCurso.htm" method="post"
			modelAttribute="curso">
			<label for="cod">Código:</label>
			<form:input type="text" name="codigo" id="codigo" path="codigo"/>
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
			<a class="buttonAdd" href="listar_cursos.htm"><p class="textoMenu">Voltar</p></a>
		</form:form>
	</div>
</body>
</html>