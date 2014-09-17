<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="datatables"
	uri="http://github.com/dandelion/datatables"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<title>Vincular Bibliografia</title>
<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="../fragments/header.jsp" />
		<input id="disciplinaId" type="hidden" value="${disciplina.id}"/>
		<div id="center-wrapper">
			<div class="dhe-example-section" id="ex-2-1">
				<div class="dhe-example-section-header"></div>
				<div class="dhe-example-section-content">
					<div id="example-2-1">

						<p id="nomeDisciplina">${disciplina.codigo} - ${disciplina.nome}</p>
						<p>
							<a class="btn btn-success" id="btn-get"
								href="<c:url value="/disciplina/listar" ></c:url>">Vincular</a>
						</p>
						<div class="column left first">
							<label style="font-size: 16px;">Básica</label>
							<ul class="sortable-list" id="basica">

								<c:forEach var="t" items="${basica}">
									<li class="sortable-item" id="${t.id}" style="font-size: 12px;"><c:out
											value="${t.nome}" /></li>
								</c:forEach>
							</ul>

						</div>


						<div class="column left">
							<label style="font-size: 16px;">Complementar</label>
							<ul class="sortable-list" id="complementar">
								<c:forEach var="t" items="${complementar}">
									<li class="sortable-item" id="${t.id}" style="font-size: 12px;"><c:out
											value="${t.nome}" /></li>
								</c:forEach>
							</ul>

						</div>

						<div class="column left">
							<label style="font-size: 16px;">Acervo</label> <input type="text"
								id="txtBusca" placeholder="Buscar acervo..." />
							<ul class="sortable-list" id="acervo">
								<c:forEach var="t" items="${titulo}">
									<li class="sortable-item" id="${t.id}" data-l="acervo" style="font-size: 12px;"><c:out
											value="${t.nome}" /></li>
								</c:forEach>
							</ul>
						</div>

					</div>

					<div class="clearer">&nbsp;</div>

				</div>
			</div>


		</div>

		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>






