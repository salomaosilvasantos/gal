<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Configurar Meta</title>
<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="../fragments/header.jsp" />
		
		<form:form servletRelativeAction="/meta/configurar" method="post" modelAttribute="metaForm" role="form">

			<table class="table table-striped sortable">
				<!-- here should go some titles... -->
				<tr>
					<th>Nome da Meta</th>
					<th>Indice Cálculo Básico</th>
					<th>Indice Cálculo Complementar</th>
				</tr>
				<c:forEach items="${metas}" var="meta" varStatus="status">
					<tr>
						<input type="hidden" name="metas[${status.index}].id"
							value="${meta.id}" />
						<td><input name="metas[${status.index}].nome"
							value="${meta.nome}" /></td>
						<td><input name="metas[${status.index}].indiceCalculoBasica"
							value="${meta.indiceCalculoBasica}" /></td>
						<td><input name="metas[${status.index}].indiceCalculoComplementar"
							value="${meta.indiceCalculoComplementar}" /></td>


					</tr>
				</c:forEach>
			</table>
			<br />
			
			
				<input class="btn btn-primary" type="submit" value="Configurar"/>
				<a href="<c:url value="/meta/listar"></c:url>" class="btn btn-default">Cancelar</a>
			



		</form:form>
		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>