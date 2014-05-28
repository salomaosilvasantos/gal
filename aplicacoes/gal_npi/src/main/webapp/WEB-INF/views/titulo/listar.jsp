<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="datatables" uri="http://github.com/dandelion/datatables"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title>Títulos</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page="../fragments/htmlHead.jsp" />
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$.fn.dataTableExt.sErrMode = 'throw';
							$('#titulo').dataTable(
								{
									"sPaginationType" : "full_numbers",
									"oLanguage" : {
										"sEmptyTable" : "Nenhum registro encontrado na tabela",
										"sInfo" : "Mostrar _START_ até _END_ do _TOTAL_ registros",
										"sInfoEmpty" : "Mostrar 0 até 0 de 0 Registros",
										"sInfoFiltered" : "(Filtrar de _MAX_ total registros)",
										"sInfoPostFix" : "",
										"sInfoThousands" : ".",
										"sLengthMenu" : "Mostrar _MENU_ registros por pagina",
										"sLoadingRecords" : "Carregando...",
										"sProcessing" : "Processando...",
										"sZeroRecords" : "Nenhum registro encontrado",
										"sSearch" : "Pesquisar",
										"oPaginate" : {
											"sNext" : "Proximo",
											"sPrevious" : "Anterior",
											"sFirst" : "Primeiro",
											"sLast" : "Ultimo"
										},
										"oAria" : {
											"sSortAscending" : ": Ordenar colunas de forma ascendente",
											"sSortDescending" : ": Ordenar colunas de forma descendente"
										}
									}
								}
							);
	
						});
	</script>
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="../fragments/header.jsp" />
		<a class="btn btn-primary" href="/gal_npi/titulo/adicionar.htm">Adicionar</a>
		<div style="text-align: center;">
			<label class="control-label" style="font-size: 20px;">Títulos</label>
		</div>

		<datatables:table id="titulo" data="${titulos}" cdn="true" row="titulo" theme="bootstrap2" cssClass="table table-striped">
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
				<a class="buttonAdd" href="<c:url value = "/titulo/${titulo.id}/editar.htm"></c:url>">Editar</a>
			</datatables:column>

			<datatables:column title="Excluir">
				<a class="buttonAdd" href="<c:url value = "/titulo/${titulo.id}/excluir.htm"></c:url>">Excluir</a>
			</datatables:column>
		</datatables:table>

		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>