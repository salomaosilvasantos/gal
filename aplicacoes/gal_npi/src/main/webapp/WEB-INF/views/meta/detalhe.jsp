<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="datatables"
	uri="http://github.com/dandelion/datatables"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


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

		<div style="text-align: left;">
			<label class="control-label" style="font-size: 17px;">Título:
				${titulo.nome}</label>
		</div>
		<br>

		<div style="text-align: right;">
			<input class="btn btn-default" onclick="goBack()"
				style="font-weight: bold;" value="Voltar" />

		</div>



		<div style="text-align: left;">
			<label class="control-label" style="font-size: 15px;">Metas
				de semestres pares.</label>
		</div>

		<c:if test="${empty metaCalculada.detalhePar}">
			<div class="alert alert-warning" role="alert">Título não vinculado à disciplina de semestre par.</div>
		</c:if>

		<c:if test="${not empty metaCalculada.detalhePar}">

			<table class="table table-striped sortable">
				<!-- here should go some titles... -->
				<tr>
					<th>Curso</th>
					<th>Disciplina</th>
					<th>Bibliografia</th>
					<th>Curriculo</th>
					<th>Meta individual</th>
				</tr>
				<c:forEach items="${metaCalculada.detalhePar}" var="par">
					<tr>
						<td><c:out value="${par.curso}" /></td>
						<td><c:out value="${par.disciplina}" /></td>
						<td><c:out value="${par.tipoBibliografia}" /></td>
						<td><c:out value="${par.curriculo}" /></td>
						<td><fmt:formatNumber type="number" maxFractionDigits="1"
								value="${par.calculo}" /></td>
					</tr>
				</c:forEach>
			</table>
			<br>
			<br>
		</c:if>

		<div style="text-align: left;">
			<label class="control-label" style="font-size: 15px;">Metas
				de semestres impares.</label>
		</div>

		<c:if test="${empty metaCalculada.detalheImpar}">
			<div class="alert alert-warning" role="alert">Título não vinculado à disciplina de semestre impar.</div>
		</c:if>

		<c:if test="${not empty metaCalculada.detalheImpar}">

			<table class="table table-striped sortable">
				<!-- here should go some titles... -->
				<tr>
					<th>Curso</th>
					<th>Disciplina</th>
					<th>Bibliografia</th>
					<th>Curriculo</th>
					<th>Meta individual</th>
				</tr>
				<c:forEach items="${metaCalculada.detalheImpar}" var="impar">
					<tr>
						<td><c:out value="${impar.curso}" /></td>
						<td><c:out value="${impar.disciplina}" /></td>
						<td><c:out value="${impar.tipoBibliografia}" /></td>
						<td><c:out value="${impar.curriculo}" /></td>
						<td><fmt:formatNumber type="number" maxFractionDigits="1"
								value="${impar.calculo}"></fmt:formatNumber></td>
					</tr>
				</c:forEach>
			</table>

		</c:if>

		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>