<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=iso-8859-1"
    pageEncoding="iso-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 
    Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <title>Editar Disciplina</title>
    
<jsp:include page="fragments/headTag.jsp" />
		
    <body>
 
        <form:form modelAttribute="disciplina" id="reg" action="editDisciplinaForm.htm" method = "post" >
        <h2>Editar Disciplina </h2>
        
		 <form:label path="nome">Nome:</form:label><br>
		 <form:input path="nome"/><br>
		 
		  <form:label path="codigoDisciplina">Codigo:</form:label><br>
		 <form:input path="codigoDisciplina"/><br>
		 
		<form:errors path="*" cssClass="errorBox" element="div" />
		
		<input type="submit" value="Submit" />
 		
 		<a class="buttonAdd" href="/gal_npi/listar_disciplinas.htm"><p class = "textoMenu">Voltar</p></a>
 	   
 	   </form:form>
 
    </body>