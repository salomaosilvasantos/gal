<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Adicionar Integração Curricular</title>
<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="../fragments/header.jsp" />
		<form:form servletRelativeAction="/integracao/adicionar" method="post"
			modelAttribute="integracao" role="form" class="form-horizontal">
			<div class="form-group" style="text-align: center;">
				<label class="control-label" style="font-size: 20px;">Adicionar
					Integracao Curricular</label>
					
					
<!-- 		integracao.setDisciplina(integracao.getDisciplina()); -->
<!-- 		integracao.setEstruturaCurricular(integracao.getEstruturaCurricular()); -->
<!-- 		integracao.setQuantidadeAlunos(integracao.getQuantidadeAlunos()); -->
<!-- 		integracao.setSemestreOferta(integracao.getSemestreOferta()); -->
<!-- 		integracao.setId_curriculo(integracao.getId_curriculo()); -->
<!-- 		integracao.setId_disciplina(integracao.getId_disciplina()); -->
		
<!-- 			</div> -->
<!-- 			<div class="form-group"> -->
<!-- 				<label for="codigo" class="col-sm-1 control-label">Código</label> -->
<!-- 				<div class="col-sm-10"> -->
<%-- 					<form:input id="codigo" class="form-control" placeholder="Código" --%>
<%-- 						path="codigo" /> --%>
<%-- 					<form:errors path="codigo" cssClass="error" /> --%>
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class="form-group"> -->
<!-- 				<label for="nome" class="col-sm-1 control-label">Nome</label> -->
<!-- 				<div class="col-sm-10"> -->
<%-- 					<form:input id="nome" class="form-control" placeholder="Nome" --%>
<%-- 						path="nome" /> --%>
<%-- 					<form:errors path="nome" cssClass="error" /> --%>
<!-- 				</div> -->
<!-- 			</div> -->

<!-- 			<div class="controls"> -->
<!-- 				<input id="criar" class="btn btn-primary" type="submit" -->
<!-- 					value="Adicionar" /> <a -->
<%-- 					href="<c:url value="/disciplina/listar"></c:url>" --%>
<!-- 					class="btn btn-default">Cancelar</a> -->
<!-- 			</div> -->

		</form:form>
		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>