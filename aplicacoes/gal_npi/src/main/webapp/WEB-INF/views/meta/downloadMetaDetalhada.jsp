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
		<c:if test="${not empty error}">
			<div class="alert alert-danger alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<c:out value="${error}"></c:out>
			</div>
		</c:if>
		<c:if test="${not empty info}">
			<div class="alert alert-info alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<c:out value="${info}"></c:out>
			</div>
		</c:if>
		<table class="table table-striped sortable">
			<!-- here should go some titles... -->
			<tr>
				<th>Nome da Meta</th>
				<th>Link para Download da meta detalhada</th>
			</tr>
			<c:forEach items="${metas}" var="meta">
				<tr>

					<td>${meta.nome}</td>
					<td><a href="<c:url value='/meta/downloadMetaDetalhada/${meta.nome}'/>">Download Detalhado ${meta.nome}</a></td>

				</tr>
			</c:forEach>
		</table>

		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>