<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<title>Contatos</title>
<jsp:include page="fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="fragments/header.jsp" />

		<div style="margin-top: 100px; text-align: center; font-weight: bold;">
			<p>Atendimento: Sala 1 - Segunda a Quinta - Manhã</p>
			<p>Contatos:</p>
			<p>André: andre.luisfs01@gmail.com</p>
			<p>Vieira: vieirajf@gmail.com</p>
			<p>Prof. Camilo: camilo@es.ufc.br</p>


		</div>

		<jsp:include page="fragments/footer.jsp" />
	</div>

</body>
</html>


