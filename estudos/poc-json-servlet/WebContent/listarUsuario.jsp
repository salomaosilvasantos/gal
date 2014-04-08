<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./resources/css/ui-darkness/jquery-ui-1.10.3.custom.css" />
<script type="text/javascript" src="./jquery-2.0.1.min.js"></script>
<script type="text/javascript" src="./resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		
		$.ajax({
			url:'ListaUsuarioServlet',
			type:'post',
			dataType:'json',
			success: function(data) {  
				$('<div>').attr("id","accordion").appendTo('body');
					for(var i=0;i<data.length;i++){
						$('<h3>').attr("id","a"+i+"").text(data[i][0]).appendTo('#accordion');
						$('<a>').appendTo("#a"+i+"");
						$('<div>').text(data[i][1]).appendTo('#accordion');
								
					}
					$("#accordion").accordion({collapsible:true});
					$("<a>").attr("href","index.jsp").text("Voltar ao menu").appendTo("body");
				}
				   
		});  	
		
	})
</script>
</head>
<body>

<b>Usuarios:</b><br />


</body>
</html>