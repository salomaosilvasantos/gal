<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="datatables" uri="http://github.com/dandelion/datatables"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title>Títulos</title>
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
			<label class="control-label" style="font-size: 20px;">Títulos</label>
		</div>
		
		<c:if test="${empty titulos}">
			<div class="alert alert-warning" role="alert">Não há títulos cadastrados.</div>
		</c:if>
		
		<c:if test="${not empty titulos}">
			<datatables:table id="titulo" data="${titulos}" cdn="true"
				row="titulo" theme="bootstrap2" cssClass="table table-striped">
				<datatables:column title="Nome">
					<c:out value="${titulo.nome}"></c:out>
				</datatables:column>
	
				<datatables:column title="ISBN">
					<c:out value="${titulo.isbn}"></c:out>
				</datatables:column>
	
				<datatables:column title="Tipo">
					<c:out value="${titulo.tipo}"></c:out>
				</datatables:column>
	
				<datatables:column title="Editar">
					<a class="btn btn-primary" href="<c:url value = "/titulo/${titulo.id}/editar"></c:url>">
						<span class="glyphicon glyphicon-edit"></span>
					</a>
				</datatables:column>
	
				<datatables:column title="Excluir">
					<a id="excluir" class="btn btn-danger" data-toggle="modal" data-target="#confirm-delete" href="#" data-href="<c:url value="/titulo/${titulo.id}/excluir" ></c:url>">
						<span class="glyphicon glyphicon-trash"></span>
					</a>
				</datatables:column>
			</datatables:table>
		</c:if>

		<jsp:include page="../fragments/footer.jsp" />
	</div>
	<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                Excluir
	            </div>
	            <div class="modal-body">
	                Tem certeza de que deseja excluir esse título?
	            </div>
	            <div class="modal-footer">
	                <a href="#" class="btn btn-danger">Excluir</a>
	                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
	            </div>
	        </div>
	    </div>
	</div>
</body>
</html>