<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Vincular Disciplina</title>
<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="../fragments/header.jsp" />

		<form:form servletRelativeAction="/integracao/adicionar" method="post"
			modelAttribute="integracao" role="form" class="form-horizontal">
			<form:input path="id_curriculo" type="hidden" />
			
			
<%-- 			<form:input path="id_curriculo" type="text" id="id_curriculo"/> --%>
			
			<div class="form-group">
				<label class="control-label" style="font-size: 20px;">Vincular
					Disciplina</label>
			</div>

			<div class="form-group">
				<label for="disciplina.codigo" class="col-sm-2 control-label">Código
					Disciplina</label>
				<div class="col-sm-10">
					<form:input id="disciplina" class="form-control"
						style="width: 150px;" placeholder="Código disciplina"
						path="disciplina.codigo" required="true" />
					<form:errors path="disciplina.codigo" cssClass="error" />
				</div>
			</div>

			<div class="form-group">
				<label for="quantidadeAlunos" class="col-sm-2 control-label">Quantidade
					alunos</label>
				<div class="col-sm-10">
					<form:input id="quantidadeAlunos" class="form-control numeros"
						style="width: 150px;" placeholder="Quantidade alunos"
						path="quantidadeAlunos" onkeypress="mascara(this,soNumeros)"
						required="true" />
					<form:errors path="quantidadeAlunos" cssClass="error" />
				</div>
			</div>

			<div class="form-group">
				<label for="semestreOferta" class="col-sm-2 control-label">Semestre
					oferta</label>
				<div class="col-sm-10">
					<form:input id="semestreOferta" class="form-control numeros"
						style="width: 150px;" placeholder="Semestre oferta"
						path="semestreOferta" onkeypress="mascara(this,soNumeros)"
						required="true" />
					<form:errors path="semestreOferta" cssClass="error" />
				</div>
			</div>



			<div class="controls">
				<input id="criar" class="btn btn-primary" type="submit"
					value="Adicionar" /> <a
					href="<c:url value="/curso/listar"></c:url>"
					class="btn btn-default">Cancelar</a>
			</div>


		</form:form>
		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>