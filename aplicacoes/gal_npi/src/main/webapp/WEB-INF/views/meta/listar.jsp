<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="datatables"
	uri="http://github.com/dandelion/datatables"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<!DOCTYPE html>
<html>
<head>
<title>Metas</title>
<jsp:include page="../fragments/htmlHead.jsp" />
<link href="<c:url value="../resources/css/gal.css" />" rel="stylesheet">
</head>
<body>
	<div id="container">

		<jsp:include page="../fragments/header.jsp" />

		<input id="idCurso" type="hidden" value="${idCurso}" /> <select
			id="seleciona">
			<option value="-1">Todos os Cursos</option>
			<c:forEach items="${cursos}" var="curso">
				<option value="${curso.id}">${curso.nome}</option>
			</c:forEach>
		</select>

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
			<label class="control-label" style="font-size: 20px;">Metas</label>
		</div>

		<c:if test="${empty resultados}">
			<div class="alert alert-warning" role="alert">Não há metas
				cadastrados.</div>
		</c:if>



		<c:if test="${not empty resultados}">

			<datatables:table id="resultadoTable" data="${resultados}" cdn="true"
				row="resultado" theme="bootstrap2" cssClass="table table-striped">


				<datatables:column title="Titulo">

					<c:out value="${resultado.titulo.nome}"></c:out>


				</datatables:column>

				<datatables:column title="Acervo">
					<c:out value="${resultado.titulo.acervo}"></c:out>
				</datatables:column>
				<c:forEach items="${resultado.metasCalculadas}" var="meta"
					varStatus="indice">

					<datatables:column class="color" title=" ${meta.nome} "
						cssCellStyle="background-color:${indice.count%2==0 ? '#EAEBFF' : '#D3D6FF'};">

						<fmt:formatNumber type="number" maxFractionDigits="1"
							value="${meta.calculo}"></fmt:formatNumber>

					</datatables:column>
					<datatables:column title="Déficit"
						cssCellStyle="background-color:${indice.count%2==0 ? '#EAEBFF' : '#D3D6FF'};">
						<c:if test="${(meta.calculo-resultado.titulo.acervo) >= 0}">
							<fmt:formatNumber type="number" maxFractionDigits="1"
								value="${meta.calculo-resultado.titulo.acervo}"></fmt:formatNumber>
						</c:if>
						<c:if test="${(meta.calculo-resultado.titulo.acervo) < 0}">
							<c:out value="0"></c:out>
						</c:if>
					</datatables:column>

					<datatables:column title="Meta Detalhada"
						cssCellStyle="background-color:${indice.count%2==0 ? '#EAEBFF' : '#D3D6FF'};">

						<c:if test="${(meta.calculo) > 0.1}">
							<div title="Detalhe da ${meta.nome}">
								<a class="btn btn-primary"
									href="<c:url value = "/meta/${resultado.titulo.id}/detalhe/${meta.nome}"></c:url>">
									<span class="glyphicon glyphicon-zoom-in"></span>
								</a>
							</div>
						</c:if>
						<c:if test="${(meta.calculo) <= 0.0}">
							<div title="Não possui metas">
								<button type="button" disabled class="btn btn-primary">
									<span class="glyphicon glyphicon-zoom-in"></span>
								</button>
							</div>
						</c:if>



					</datatables:column>


				</c:forEach>





			</datatables:table>

		</c:if>


		<jsp:include page="../fragments/footer.jsp" />
		<script type="text/javascript">
			function x() {
				alert("dfgsdfs");
			}
		</script>


	</div>
</body>
</html>