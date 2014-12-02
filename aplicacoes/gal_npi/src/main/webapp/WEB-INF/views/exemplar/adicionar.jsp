<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<title>Adicionar Exemplar</title>
	<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container">
		<jsp:include page="../fragments/header.jsp" />
		<form:form servletRelativeAction="/exemplar/${titulo.id}/adicionar" method="post" modelAttribute="exemplar" role="form" class="form-horizontal">
			<form:input path="id" type="hidden" />
			<div class="form-group" style="text-align: center;">
				<label class="control-label" style="font-size: 20px;">Adicionar Exemplar</label>
			</div>
			
			<div class="form-group">
			    <label for="codigoExemplar" class="col-sm-2 control-label">Codigo do Exemplar</label>
			    <div class="col-sm-10">
			    	<form:input id="codigoExemplar" class="form-control" placeholder="codigoExemplar" path="codigoExemplar"/>
			    	<form:errors path="codigoExemplar" cssClass="error" />
			    </div>
			</div>
			<div class="controls">
				<input id="criar" class="btn btn-primary" type="submit" value="Adicionar"/>
				<a href="<c:url value="/exemplar/${titulo.id}/listar"></c:url>" class="btn btn-default">Cancelar</a>
			</div>
		</form:form>
		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>

