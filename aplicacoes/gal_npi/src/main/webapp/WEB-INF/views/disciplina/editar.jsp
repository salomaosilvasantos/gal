<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
    
<!DOCTYPE html>
<html>
<head>

    <title>Editar Disciplina</title>
    
<jsp:include page="../fragments/headTag.jsp" />
		
    <body>
 
        <form:form modelAttribute="disciplina" id="reg" action="/gal_npi/disciplina/editar.htm" method = "post" >
        <h2>Editar Disciplina </h2>
        
		 <form:input path="id" type="hidden"/>
		 <form:label path="nome">Nome:</form:label><br>
		 <form:input path="nome"/><br>
		 
		  <form:label path="codigo">Codigo:</form:label><br>
		 <form:input path="codigo"/><br>
		 
		<form:errors path="*" cssClass="errorBox" element="div" />
		
		<input type="submit" value="Submit" />
 		
 		<a class="buttonAdd" href="/gal_npi/disciplina/listar.htm"><p class = "textoMenu">Voltar</p></a>
 	   </form:form>
 
    </body>