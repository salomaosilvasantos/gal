<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="pt-br">

<jsp:include page="fragments/headTag.jsp" />

<body>

	<header class="container">

		<h1 id="inicio">Protótipo Disciplina</h1>

	</header>


	<div class="containerPrincipal">

		<aside class="leftBox">
			<p>Menu</p>
		</aside>

			<a class="buttonAdd" href="adicionarDisciplina.htm"></a>

		<section id="detalhesDisciplina">
			<p>
				Saudações, agora são
				<c:out value="${model.now}" />
			</p>
			<br /> <br />		

			<table id="tabelaDisciplinas">
				<tr class = "rows">
					<th class = "colsRight">Código Disciplina</th>
					<th class = "colsRight">Nome Disciplina</th>
					<th class ="colsRight">Ações</th>
				</tr>

				<c:forEach items="${model.products}" var="prod">
    		    
					<tr class = "rows" id = "<c:out value="${prod.id}"></c:out>">
						
						<th class = "colsRight" id = "<c:out value="${prod.id}"></c:out>"><c:out value="${prod.code}"></c:out>
						</th>
						
						<th class = "colsLeft" id = "<c:out value="${prod.id}"></c:out>"><c:out value="${prod.nome}"></c:out></th>
						<th class ="colsRight">
						
						  <a class = "buttonTable" href ="<c:url value = "/${prod.id}/editDisciplina.htm"></c:url>"></a>
						  <a class = "buttonTable" href ="<c:url value = "/${prod.id}/deleteDisciplina.htm"></c:url>"></a>
						  <a class = "buttonTable" href =""></a>
						
						</th>
					</tr>
				
				</c:forEach>

			</table>

		</section>

	</div>


</body>
</html>