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
<body >
	<div id="container" style="width: 1000px; margin: 0 auto;">

		<jsp:include page="../fragments/header.jsp" />
		<div id="center-wrapper">
			<div class="dhe-example-section" id="ex-2-1">
				<div class="dhe-example-section-header"></div>
				<div class="dhe-example-section-content">

					<div id="example-2-1">

						<p>
							<input type="submit" class="input-button" id="btn-get"
								value="Vincular" />
						</p>

						<div class="column left first">
							<ul class="sortable-list" id="teste">
								<c:forEach var="t" items="${titulo}">
									<li class="sortable-item" id="${t.id}"><c:out
											value="${t.nome}" /></li>
								</c:forEach>
							</ul>
						</div>

						<div class="column left">

							<ul class="sortable-list">
								<c:forEach var="t" items="${basica}">
									<li class="sortable-item" id="${t.id}"><c:out
											value="${t.nome}" /></li>
								</c:forEach>
							</ul>

						</div>

						<div class="column left">

							<ul class="sortable-list">
								<c:forEach var="t" items="${complementar}">
									<li class="sortable-item" id="${t.id}"><c:out
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
		<!-- Example jQuery code (JavaScript)  -->
		<script type="text/javascript">
			$(document).ready(
					function() {

						// Get items
						function getItems(exampleNr) {
							var columns = [];

							$(exampleNr + ' ul.sortable-list').each(
									function() {
										if ($(this).attr('id') != 'teste') {
											columns.push($(this).sortable(
													'toArray').join(','));
										}
									});

							return columns.join("A");
						}

						// Example 2.1: Get items
						$('#example-2-1 .sortable-list').sortable({
							connectWith : '#example-2-1 .sortable-list'
						});

						$('#btn-get').click(
								function() {

									var data = {
										endereco : getItems('#example-2-1'),
										idDiciplina:"${disciplina.id}"
									};

									$.get('/gal_npi/disciplina/teste', data)
											.success(function(data) {
												//console.log(data);  
											});

									//alert(getItems('#example-2-1'));
								});

					});
		</script>
</body>
</html>






