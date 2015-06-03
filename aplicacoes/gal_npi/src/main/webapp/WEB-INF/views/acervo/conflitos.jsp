<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="datatables" uri="http://github.com/dandelion/datatables"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<script language="Javascript">
		function abrirEdicao(codigo)	{
			var isbnCampo = document.getElementById("isbn" + codigo);
			var tituloCampo = document.getElementById("titulo" + codigo);
			var codigoCampo = document.getElementById("codigo" + codigo);
			var tipoCampo = document.getElementById("tipo" + codigo);
			isbnCampo.removeAttribute("disabled");
			tituloCampo.removeAttribute("disabled");
			codigoCampo.removeAttribute("disabled");
			tipoCampo.removeAttribute("disabled");
		}
	</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Resolver Conflitos de Atualização de Acervo</title>
<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body><div id="container">
		<jsp:include page="../fragments/header.jsp" />
		
		<c:if test="${not empty info}">
			<div class="alert alert-info alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<c:out value="${info}"></c:out>
			</div>
		</c:if>
		
		<datatables:table id="exemplar" data="${exemplares}" cdn="true"
					row="exemplar" theme="bootstrap2" cssClass="table table-striped">
					
					<datatables:column title="Título do exemplar com conflito">
						<c:out value="${exemplar.titulo} "></c:out>
					</datatables:column>
				
					<datatables:column title="Código do exemplar com conflito">
						<c:out value="${exemplar.codigoExemplar} "></c:out>
					</datatables:column>
					
					<datatables:column title="Editar">
						<a class="btn btn-primary" href="<c:url value="../acervo/${exemplar.id }/editar" ></c:url>"><span class="glyphicon glyphicon-edit"></span></a>
					</datatables:column>
					
					<!-- href="<c:url value="/acervo/${exemplar.id }/salvar" ></c:url>" /////////////// href="<c:url value="/acervo/${exemplar.id }/editar" ></c:url>"-->
			</datatables:table>
		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>
