<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="datatables" uri="http://github.com/dandelion/datatables"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title>Editar Estrutura Curricular</title>
	<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
<div id="container" style="width: 1000px; margin: 0 auto;">
	<jsp:include page="../fragments/header.jsp" />
	<form:form modelAttribute="disciplina" id="reg" servletRelativeAction="/disciplina/editar" method="post" role="form" class="form-horizontal">
	</form:form>
</div>
</body>
</html>