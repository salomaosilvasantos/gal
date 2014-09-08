<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="datatables"
	uri="http://github.com/dandelion/datatables"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>Detalhe da Meta</title>
<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
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

		<div style="text-align: center;">
			<label class="control-label" style="font-size: 20px;"></label>
		</div>

		<c:if test="${empty metaCalculada}">
			<div class="alert alert-warning" role="alert">Não há metas
				cadastrados.</div>
		</c:if>

		<c:if test="${not empty metaCalculada}">
			<datatables:table id="resultado" data="${metaCalculada.detalhePar}" cdn="true"
				row="par" theme="bootstrap2" cssClass="table table-striped">

				<datatables:column title="Nome do Curso">
					<c:out value="${par.curso}"></c:out>
				</datatables:column>
				<datatables:column title="Nome da Disciplina">
					<c:out value="${par.disciplina}"></c:out>
				</datatables:column>
				<datatables:column title="Tipo Bibliografia">
					<c:out value="${par.tipoBibliografia}"></c:out>
				</datatables:column>
				<datatables:column title="Curriculo">
					<c:out value="${par.curriculo}"></c:out>
				</datatables:column>
				<datatables:column title="Cálculo Individual">
					<c:out value="${par.calculo}"></c:out>
				</datatables:column>
				
				
				

			</datatables:table>
		</c:if>

		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>