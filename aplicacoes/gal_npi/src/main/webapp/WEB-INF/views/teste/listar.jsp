<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="datatables" uri="http://github.com/dandelion/datatables"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title>Metas</title>
	<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="../fragments/header.jsp" />
		
		<c:if test="${not empty error}">
			<div class="alert alert-danger alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<c:out value="${error}"></c:out>
			</div>
		</c:if>
		<c:if test="${not empty info}">
			<div class="alert alert-info alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<c:out value="${info}"></c:out>
			</div>
		</c:if>
		
		<div id="button-add">
			<a href="<c:url value="/titulo/adicionar" ></c:url>">
				<button class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span> Adicionar</button>
			</a>
		</div>
		
		<div style="text-align: center;">
			<label class="control-label" style="font-size: 20px;">Metas</label>
		</div>
		
		<c:if test="${empty resultados}">
			<div class="alert alert-warning" role="alert">Não há metas cadastrados.</div>
		</c:if>
		
		<c:if test="${not empty resultados}">
			<datatables:table id="resultado" data="${resultados}" cdn="true"
				row="resultado" theme="bootstrap2" cssClass="table table-striped">
				
				<datatables:column title="Nome do Título">
					<c:out value="${resultado.titulo.nome}"></c:out>
				</datatables:column>
				
				<datatables:column title="Meta">
					<c:out value="${resultado.metaCalculada.nome}"></c:out>
				</datatables:column>
				
				<datatables:column title="Meta valor">
					<c:out value="${resultado.metaCalculada.calculo}"></c:out>
				</datatables:column>
	
	
			</datatables:table>
		</c:if>

		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>