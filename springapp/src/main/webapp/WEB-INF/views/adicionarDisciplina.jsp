<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cadastro de Disciplinas</title>
</head>
<body>
	<form action="inserirDisciplina.htm" method="post">
		Código da Disciplina: <input type="text" name="code"/><br/>
		<form:errors path="disciplinas.codDisciplina" cssStyle="color:red"/>
	
		Nome da Disciplina: <input type="text" name="nome"/><br/>
		<form:errors path="disciplinas.nomeDisciplina" cssStyle="color:red"/>
		<input type="submit" value="Cadastrar">
	</form>
</body>
</html>