<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="datatables" uri="http://github.com/dandelion/datatables"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body><div id="container">
		<jsp:include page="../fragments/header.jsp" />
		
		<datatables:table id="exemplar" data="${exemplares}" cdn="true"
					row="exemplar" theme="bootstrap2" cssClass="table table-striped">
					<datatables:column title="ISBN">
						<input value="${exemplar.titulo.isbn}"></input>
					</datatables:column>
				
					<datatables:column title="Titulo">
						<input value="${exemplar.titulo.nome}"></input>
					</datatables:column>
		
					<datatables:column title="Codigo">
						<input value="${exemplar.codigoExemplar}"></input>
					</datatables:column>
					
					<datatables:column title="Tipo">
						<input value="${exemplar.titulo.tipo}"></input>
					</datatables:column>
					
					<datatables:column title="Salvar">
						<a class="btn btn-success" href="<c:url value="/acervo/${exemplar.id }/salvar" ></c:url>"><span class="glyphicon glyphicon-link"></span></a>
					</datatables:column>
				
					<datatables:column title="Editar">
						<a class="btn btn-primary" href="<c:url value="/acervo/${exemplar.id }/editar" ></c:url>"><span class="glyphicon glyphicon-edit"></span></a>
					</datatables:column>
	
					<datatables:column title="Excluir">
						<a id="excluir" class="btn btn-danger" data-toggle="modal" data-target="#confirm-delete" href="#" data-href="<c:url value="/acervo/${exemplar.id}/excluir" ></c:url>">
						<span class="glyphicon glyphicon-trash"></span>
						</a>
					</datatables:column>
			</datatables:table>
		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>