<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Adicionar Disciplina</title>
	<jsp:include page="../fragments/htmlHead.jsp" />
	<script type="text/javascript">
		$( document ).ready(function() {
			$('div:has(span.error)').find('span.error').css('color', '#a94442');
			$('div:has(span.error)').find('span.error').parent().parent().addClass('has-error has-feedback');
		});
	</script>
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="../fragments/header.jsp" />
		<form:form action="/gal_npi/disciplina/adicionar.htm" method="post" modelAttribute="disciplina" role="form" class="form-horizontal">
			<div class="form-group" style="text-align: center;">
				<label class="control-label" style="font-size: 20px;">Adicionar Disciplina</label>
			</div>
			<div class="form-group">
			    <label for="codigo" class="col-sm-1 control-label">Código</label>
			    <div class="col-sm-8">
			    	<form:input id="codigo" class="form-control" placeholder="Código" path="codigo"/>
			    	<form:errors path="codigo" cssClass="error" />
			    </div>
			</div>
			<div class="form-group">
			    <label for="nome" class="col-sm-1 control-label">Nome</label>
			    <div class="col-sm-8">
			    	<form:input id="nome" class="form-control" placeholder="Nome" path="nome"/>
			    	<form:errors path="nome" cssClass="error" />
			    </div>
			</div>
			<div class="btn-group">
				<input id="criar" class="btn btn-primary" type="submit" value="Adicionar"/>
			</div>
		</form:form>
	</div>
</body>
</html>