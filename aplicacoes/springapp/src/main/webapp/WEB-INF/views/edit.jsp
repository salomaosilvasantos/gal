<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 
    Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.simpletablestyle,  td {
     padding:10px;
}
</style>
		<title>Edit</title>
</head>
    <body>
 
        <form:form commandName="editDisciplina" id="reg" action="editDisciplinaForm.htm" >
        <h2>Editar Disciplina </h2>
        
         <form:label path="id">ID:</form:label><br>
		 <form:input path="id" disabled="true"/><br>
	
		 <form:label path="nome">Nome:</form:label><br>
		 <form:input path="nome"/><br>
		 <form:errors class="invalid" path="nome" />
		 
		  <form:label path="code">Codigo:</form:label><br>
		 <form:input path="code"/><br>
		 
		
		<input type="submit" value="Submit" />
 		<a class="buttonAdd" href="listar_disciplinas.htm"><p class = "textoMenu">Voltar</p></a>
 	   </form:form>
 
    </body>