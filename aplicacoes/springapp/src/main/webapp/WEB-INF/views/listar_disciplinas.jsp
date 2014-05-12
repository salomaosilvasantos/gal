<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="datatables" uri="http://github.com/dandelion/datatables" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="<c:url value="/resource-bootstrap/css/bootstrap-combined.min.css" />" rel="stylesheet"/>
<link href="<c:url value="/resource-bootstrap/css/jquery.dataTables.css" />" rel="stylesheet"/>
<script src="<c:url value="/resource-bootstrap/js/jquery.dataTables.js"/>"></script>
<script src="<c:url value="/resource-bootstrap/js/jquery-latest.min.js"/>"></script>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Disciplinas</title>
</head>
<body>

	<h1>Listagem de Disciplinas</h1>
	
	<datatables:table id="vets" data="${disciplinas}" cdn="true" row="disciplina" theme="bootstrap2" cssClass="table table-striped">
	    
	    <datatables:column title="Nome">
	        <c:out value="${disciplina.nome}"></c:out>
	    </datatables:column>
	    
	    <datatables:column title="Codigo">
	        <c:out value="${disciplina.code}"></c:out>
	    </datatables:column>
	    
	    <datatables:column title="Editar">
	        <!--  <button class = "btn btn-primary"  href ="<c:url value = "/${disciplina.id}/editDisciplina.htm"></c:url>"></button>-->
	       <a class="buttonAdd" href="<c:url value = "/${disciplina.id}/editDisciplina.htm"></c:url>">Editar Disciplina</a>
<!-- 	       <input type="button" class="btn" value="Editar"  /> -->
	    </datatables:column>
	    
	    <datatables:column title="Deletar">
	         <a class="buttonAdd" href="<c:url value = "/${disciplina.id}/deleteDisciplina.htm"></c:url>">Deletar Disciplina</a>
	    </datatables:column>
	</datatables:table>
	
	<aside class="leftBox"> <a class="buttonAdd" href="adicionarDisciplina.htm"><p class = "textoMenu">Adicionar Disciplina</p></a> </aside>			 
	
</body>
</html>