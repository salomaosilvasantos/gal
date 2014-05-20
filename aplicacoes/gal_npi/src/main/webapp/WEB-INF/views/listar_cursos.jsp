<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="datatables" uri="http://github.com/dandelion/datatables"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title>Cursos</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page="fragments/htmlHead.jsp" />
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$.fn.dataTableExt.sErrMode = 'throw';
							$('#curso').dataTable(
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
		<jsp:include page="fragments/header.jsp" />
		<div style="text-align: center;">
			<label class="control-label" style="font-size: 20px;">Cursos</label>
		</div>

		<datatables:table id="curso" data="${cursos}" cdn="true" row="curso" theme="bootstrap3" cssClass="table table-striped">
			<datatables:column title="Nome">
				<c:out value="${curso.nome}"></c:out>
			</datatables:column>

			<datatables:column title="Codigo">
				<c:out value="${curso.codigo}"></c:out>
			</datatables:column>
			
			<datatables:column title="Sigla">
				<c:out value="${curso.sigla}"></c:out>
			</datatables:column>

			<datatables:column title="Editar">
				<a class="buttonAdd"
					href="<c:url value = "/${curso.codigo}/editCurso.htm"></c:url>">Editar</a>
			</datatables:column>

			<datatables:column title="Deletar">
				<a class="buttonAdd"
					href="<c:url value = "/${curso.codigo}/deleteCurso.htm"></c:url>">Deletar</a>
			</datatables:column>
		</datatables:table>

		<a class="buttonAdd" href="adicionarCurso.htm">Adicionar</a>
		<jsp:include page="fragments/footer.jsp" />
	</div>
</body>
</html>