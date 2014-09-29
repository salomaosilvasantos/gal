<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Adicionar Integração Curricular</title>
<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="../fragments/header.jsp" />
		<form:form servletRelativeAction="/integracao/adicionar" method="post"
			modelAttribute="integracao" role="form" class="form-horizontal">
			<div class="form-group" style="text-align: center;">
				<label class="control-label" style="font-size: 20px;">Adicionar
					Integracao Curricular</label>		
			</div>
			<div class="form-group">
				<label for="codigo" class="col-sm-1 control-label">Quantidade de Alunos</label>
				
			</div>


			<div class="controls">
				<input id="criar" class="btn btn-primary" type="submit"
					value="Adicionar" /> <a
					href="<c:url value="/disciplina/listar"></c:url>"
					class="btn btn-default">Cancelar</a>
			</div>

		</form:form>
		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>