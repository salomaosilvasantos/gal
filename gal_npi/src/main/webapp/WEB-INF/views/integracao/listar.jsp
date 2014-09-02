<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="datatables" uri="http://github.com/dandelion/datatables"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title>Integração Curricular</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="../fragments/header.jsp" />
		<div style="text-align: center;">
			<label class="control-label" style="font-size: 20px;">Integração Curricular</label>
		</div>

		<datatables:table id="integracao" data="${integracao}" cdn="true" row="integ" theme="bootstrap2" cssClass="table table-striped">
			<datatables:column title="Disciplina">
				<c:out value="${integ.disciplina.id}"></c:out>
			</datatables:column>

			<datatables:column title="Estrutura curricular">
				<c:out value="${integ.estruturaCurricular.id}"></c:out>
			</datatables:column>
			
			<datatables:column title="Semestre oferta">
				<c:out value="${integ.semestreOferta}"></c:out>
			</datatables:column>
			
			<datatables:column title="Quant. Alunos">
				<c:out value="${integ.quantidadeAlunos}"></c:out>
			</datatables:column>

			<datatables:column title="Editar">
				<a class="buttonAdd" href="<c:url value = "/disciplina/${disciplina.id}/editar"></c:url>">Editar</a>
			</datatables:column>

			<datatables:column title="Deletar">
				<a class="buttonAdd" href="<c:url value = "/disciplina/${disciplina.id}/excluir"></c:url>">Deletar</a>
			</datatables:column>
		</datatables:table>

		<a class="buttonAdd" href="/gal_npi/disciplina/adicionar">Adicionar</a>
		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>