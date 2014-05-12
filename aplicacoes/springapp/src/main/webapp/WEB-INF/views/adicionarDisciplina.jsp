<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cadastro de Disciplinas</title>
</head>
<body>
	<form:form action="inserirDisciplina.htm" method="post"
		modelAttribute="disciplina">
		<label for="code">Código da Disciplina:</label>
		<input type="text" name="code" id="code" />
		<br />
		<form:errors cssClass="error" path="code" />
		<label for="code">Nome da Disciplina:</label>
		<input type="text" name="nome" id="nome" />
		<br />
		<form:errors cssClass="error" path="nome" />
		<input type="submit" value="Cadastrar">
		<a class="buttonAdd" href="listar_disciplinas.htm"><p class = "textoMenu">Voltar</p></a>
	</form:form>
</body>
</html>