<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

    <spring:url value="/resources/javascript/javascript.js" var="javascriptJs"/>
	<script type="text/javascript" src="${javascriptJs}"></script>

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
	        <c:out value="${disciplina.codigoDisciplina}"></c:out>
	    </datatables:column>
	    
	    <datatables:column title="Editar">
	       <a class="buttonAdd" href="<c:url value = "/${disciplina.id}/editDisciplina.htm"></c:url>">Editar Disciplina</a>
	    </datatables:column>
	    
	    <datatables:column title="Deletar">

        <c:url value = "/deleteDisciplina.htm" var = "delete"></c:url>
        
	    	<form:form id = "deletePerson" action="${delete}" method ="post" onsubmit="return verifyDelete(this.code.value)">
	    		
	    		<input name = "code" value ="${disciplina.codigoDisciplina}"  type = "hidden"/>
	    		<input name = "id" value ="${disciplina.id}"  type = "hidden"/>
	    		<input type = "submit" value="Deletar"/>

	    	</form:form>

	     </datatables:column>
	     
	</datatables:table>
	
	<a class="buttonAdd" href="adicionarDisciplina.htm">Adicionar Disciplina</a>			 
	
</body>
</html>