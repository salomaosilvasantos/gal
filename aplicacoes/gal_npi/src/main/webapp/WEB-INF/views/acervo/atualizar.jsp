<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript" language="javascript">
function checkfile(sender) {
    var validExts = new Array(".xlsx", ".xls");
    var fileExt = sender.value;
    fileExt = fileExt.substring(fileExt.lastIndexOf('.'));
    if (validExts.indexOf(fileExt) < 0) {
    	document.getElementById('file').value = "";
      alert("O arquivo selecionado não é válido, os formatos válidos são:" +
               validExts.toString() + ".");
      return false;
    }
    else return true;
}
</script>
<head>
 
 <script type="text/javascript" src="assets/js/jquery-1.7.1.js"></script>
<title>Insert title here</title>
<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container">
		<jsp:include page="../fragments/header.jsp" />
	
		<form:form action="../acervo/upload" method="post" servletRelativeAction="../acervo/upload">
			<p>
				<label for="file">Arquivo para fazer upload</label> 
				<input type="file" name="file" multiple="multiple"/> 
				</script> 
				<input type="submit" name="submit" value="Upload" />
				
			</p>
		</form:form>
		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>
