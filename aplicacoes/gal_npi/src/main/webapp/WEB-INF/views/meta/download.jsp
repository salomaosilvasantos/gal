<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Download Meta Detalhada</title>
<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container">
		<jsp:include page="../fragments/header.jsp" />

		<table class="table table-striped sortable">
			<!-- here should go some titles... -->
			<tr>
				<th>Nome da Meta</th>
				<th>Link para Download da meta detalhada</th>
			</tr>
			<c:forEach items="${metas}" var="meta" varStatus="status">
				<tr>
					
					<td>${meta.nome}</td>
					<td>${meta.nome}</td>
					


				</tr>
			</c:forEach>
		</table>

		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>