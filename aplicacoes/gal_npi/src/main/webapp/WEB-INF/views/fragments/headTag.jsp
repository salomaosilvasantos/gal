<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	
    <spring:url value="/resources/css/springapp.css" var="springappCss"/>
    <link href="${springappCss}" rel="stylesheet"/>
    
    
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
    <spring:url value="/resources/javascript/javascript.js" var="javascriptJs"/>
	<script type="text/javascript" src="${javascriptJs}"></script>
	
	
</head>