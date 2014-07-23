<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Editar Título</title>

	<jsp:include page="../fragments/htmlHead.jsp" />

<script type="text/javascript">
	$(document).ready(
			function() {
				$('div:has(span.error)').find('span.error').css('color',
						'#a94442');
				$('div:has(span.error)').find('span.error').parent().parent()
						.addClass('has-error has-feedback');
			});
</script>
</head>

<body>

	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="../fragments/header.jsp" />
		<form:form action="/gal_npi/titulo/editar" method="post" modelAttribute="titulo" role="form" class="form-horizontal">
			<form:input path="id" type="hidden" />
			<div class="form-group" style="text-align: center;">
				<label class="control-label" style="font-size: 20px;">Editar Título</label>
			</div>
			<div class="form-group">
			    <label for="nome" class="col-sm-1 control-label">Nome</label>
			    <div class="col-sm-8">
			    	<form:input id="nome" class="form-control" placeholder="Nome" path="nome"/>
			    	<form:errors path="nome" cssClass="error" />
			    </div>
			</div>
			<div class="form-group">
			    <label for="isbn" class="col-sm-1 control-label">Isbn</label>
			    <div class="col-sm-8">
			    	<form:input id="isbn" class="form-control" placeholder="Isbn" path="isbn"/>
			    	<form:errors path="isbn" cssClass="error" />
			    </div>
			</div>
			<div class="form-group">
			    <label for="tipo" class="col-sm-1 control-label">Tipo</label>
			    <div class="col-sm-8">
			    	<form:input id="tipo" class="form-control" placeholder="Tipo" path="tipo"/>
			    	<form:errors path="tipo" cssClass="error" />
			    </div>
			</div>
			<a class="btn btn-primary" href="/gal_npi/titulo/listar">Voltar</a>
			<div class="btn-group">
				<input id="criar" class="btn btn-primary" type="submit" value="Editar"/>
			</div>
		</form:form>
		<jsp:include page="../fragments/footer.jsp" />
	</div>

</body>
</html>