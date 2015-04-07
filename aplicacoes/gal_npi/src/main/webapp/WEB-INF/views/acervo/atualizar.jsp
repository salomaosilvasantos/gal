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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<form action="/acervo/upload" method="post"
		enctype="multipart/form-data">
		<p>
			<label for="file">Arquivo para fazer upload</label> 
			 <input type="file" id="file" onchange="checkfile(this);" />
			<input type="submit" name="submit" value="Upload" />
		</p>
	</form>
	<div id="container">
		<jsp:include page="../fragments/header.jsp" />
	
		<form action="/acervo/upload" method="post"
			enctype="multipart/form-data">
			<p>
				<label for="file">Arquivo para fazer upload</label> 
				<input type="file" name="file" /> 
				<input type="submit" name="submit" value="Upload" />
			</p>
		</form>
		<jsp:include page="../fragments/footer.jsp" />
	</div>
</body>
</html>
