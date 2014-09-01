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
<title>Bibliografia</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../fragments/htmlHead.jsp" />
<head>

<title>jQuery: Customizable layout using drag and drop
	(examples) - 2. Saving and loading items</title>

</head>
<body class="dhe-body">
	<div id="center-wrapper">
		<div class="dhe-example-section" id="ex-2-1">
			<div class="dhe-example-section-header">
			</div>
			<div class="dhe-example-section-content">

				<div id="example-2-1">

					<p>
						<input type="submit" class="input-button" id="btn-get"
							value="Get items" />
					</p>

					<div class="column left first">
						<ul class="sortable-list" id="teste">	
								<c:forEach
									var="t" items="${titulo}">
									<li class="sortable-item" id="a">
									<c:out value="${t.nome}" />
									</li>
								</c:forEach>
						</ul>
					</div>

					<div class="column left">

						<ul class="sortable-list">	
								<c:forEach
									var="t" items="${basica}">
									<li class="sortable-item" id="${t.id}">
									<c:out value="${t.nome}" />
									</li>
								</c:forEach>
						</ul>

					</div>

					<div class="column left">

						<ul class="sortable-list">	
								<c:forEach
									var="t" items="${complementar}">
									<li class="sortable-item" id="${t.id}">
									<c:out value="${t.nome}" />
									</li>
								</c:forEach>
						</ul>

					</div>

				</div>

				<div class="clearer">&nbsp;</div>

			</div>
		</div>


	</div>

	<jsp:include page="../fragments/footer.jsp" />

	<!-- Example jQuery code (JavaScript)  -->
	<script type="text/javascript">
		$(document).ready(function() {

			// Get items
			function getItems(exampleNr) {
				var columns = [];

				$(exampleNr + ' ul.sortable-list').each(function() {
					if($(this).attr('id')!='teste'){ 
						columns.push($(this).sortable('toArray').join(','));
					}		
				});

				return columns.join('|');
			}

			// Example 2.1: Get items
			$('#example-2-1 .sortable-list').sortable({
				connectWith : '#example-2-1 .sortable-list'
			});

			$('#btn-get').click(function() {
				$.ajax({
				      url: 'disciplina/vincular',
				      type: 'POST'
				    });
				//alert(getItems('#example-2-1'));
			});

		});
	</script>
</body>
</html>






