<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="datatables"
	uri="http://github.com/dandelion/datatables"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Atualização do Acervo</title>
<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container">
		<jsp:include page="../fragments/header.jsp" />
		<div class="form-group" style="text-align: center;">
			<label class="control-label" style="font-size: 20px;">Atualizar
				Acervo</label>
		</div>
		<form:form id="adicionarAcervoForm" role="form"
			modelAttribute="atualizacaoAcervo"
			servletRelativeAction="/acervo/upload" method="POST"
			cssClass="form-horizontal" enctype="multipart/form-data">
			<div id="container">
				<h3>Período do delta</h3>
				<div>
					<h4>Inicio do periodo</h4>
					<form:input id="inicioPeridoDelta" path="inicioPeridoDelta"
						cssClass="data" />
					<br>
					<form:errors path="inicioPeridoDelta" cssClass="error" />

					<h4>Término do periodo</h4>
					<form:input id="finalPeridoDelta" path="finalPeridoDelta"
						cssClass="data" />
					<br>
					<form:errors path="finalPeridoDelta" cssClass="error" />

					<h4>Arquivo com o delta do novo acervo</h4>
					<input type="file" name="file" id="arquivo"
						accept="application/vnd.ms-excel    xls"> <br>
					<form:errors path="arquivo" cssClass="error" />

				</div>
				<br> 
				<input type="submit" name="submit" class="btn btn-primary" value="Atualizar" /> <a href="<c:url value="/"></c:url>"
					class="btn btn-default">Cancelar</a> <a></a>
				
				<div style="text-align: center;">
					<label class="control-label" style="font-size: 16px;">Atualizações Anteriores</label>
				</div>
				
				<datatables:table id="atualizacao" data="${atualizacoesRealizadas}"
					cdn="true" row="atualizacao" theme="bootstrap2"
					cssClass="table table-striped">
					<datatables:column title="Inicio">
						<c:out value="${atualizacao.inicioPeridoDelta}"></c:out>
					</datatables:column>
					<datatables:column title="Final">
						<c:out value="${atualizacao.finalPeridoDelta}"></c:out>
					</datatables:column>
					<datatables:column title="Arquivo">
						<a href="<c:url value="/acervo/download/${atualizacao.id}"/>">Download
						</a>
					</datatables:column>
				</datatables:table>

			</div>
		</form:form>
		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>
