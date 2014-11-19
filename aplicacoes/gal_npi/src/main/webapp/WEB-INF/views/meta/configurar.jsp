<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Configurar Meta</title>
<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container">
		<jsp:include page="../fragments/header.jsp" />
		
		<c:if test="${not empty error}">
			<div class="alert alert-danger alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<c:out value="${error}"></c:out>
			</div>
		</c:if>
		
		
		<div style="margin-top: 40px; font-size:17px; " >
		<p>
			<strong>Meta:</strong> Índice estabelecido pelo MEC de total de exemplares por quantidade de alunos por título.<br/>
			<strong>Quantidade de alunos:</strong> Quantidade estimada de alunos de uma disciplina para um determinado currículo.<br/><br/>
			
			<strong>Nome da meta:</strong> Um texto que identifica a meta. <br>
			<strong>Índice para cálculo de bibliografia básica:</strong> Valor para ser usado na fórmula de cálculo da meta para titulos de bibliografia básica. <br/>Resumidamente, é a quantidade de alunos por um exemplar. <strong>Ex:</strong> 6 alunos para um exemplar. <br/>
			<strong>Índice para cálculo de bibliografia complementar:</strong> Valor para ser usado na fórmula de cálculo da meta para títulos de bibliografia complementar.<br/>Resumidamente, é a quantidade de livros por disciplina. <strong>Ex:</strong> 2 livros para cada disciplina em que pertece a bibliografia complementar.<br/><br/>
		</p>
		</div>	
		
		<form:form servletRelativeAction="/meta/configurar" method="post" modelAttribute="metaForm" role="form">

			<table class="table table-striped sortable">
				<!-- here should go some titles... -->
				<tr>
					<th>Nome da Meta</th>
					<th>Indice Cálculo Bibliografia Básica</th>
					<th>Indice Cálculo Bibliografia Complementar</th>
				</tr>
				<c:forEach items="${metas}" var="meta" varStatus="status">
					<tr>
						<input type="hidden" name="metas[${status.index}].id" value="${meta.id}" />
						<td><input name="metas[${status.index}].nome"
							value="${meta.nome}" required="required"/></td>
						<td><input name="metas[${status.index}].indiceCalculoBasica"
							value="${meta.indiceCalculoBasica}" type="number" min="1" required="required" pattern="[1-9]+([\.|,][0-9]{2})?" step="0.01"
            title="Este número pode ser um inteiro ou um decimal com 2 casas."/></td>
						<td><input name="metas[${status.index}].indiceCalculoComplementar"
							value="${meta.indiceCalculoComplementar}" type="number" min="0" required="required" pattern="[0-9]+([\.|,][0-9]{2})?" step="0.01"
            title="Este número pode ser um inteiro ou um decimal com 2 casas."/></td>


					</tr>
				</c:forEach>
			</table>
			<br />
					
				<input class="btn btn-primary" type="submit" value="Configurar"/>
				<a href="<c:url value="/meta/listar"></c:url>" class="btn btn-default">Cancelar</a>
			
		</form:form>
		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>