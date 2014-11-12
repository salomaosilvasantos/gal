<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Início</title>
<jsp:include page="fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container">

		<jsp:include page="fragments/header.jsp" />
		<div id="informacao">
			<h3>Seja Bem-Vindo ao Sistema Gestão de Aquisição de Livros
				(GAL).</h3>
			<p>
				O GAL é um sistema de informação que cadastra títulos,
				bibliografias, cursos, disciplinas e acervo, para que baseado nesses
				dados <br /> e nas metas a serem atingidas, apoie a realização de
				análises e decisões sobre quais títulos serão pedidos no edital.
			</p>
		</div>


		<jsp:include page="fragments/footer.jsp" />
	</div>
</body>
</html>
