<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="page-header">
  <h1>GAL <small>Gestão de Aquisição de Livros</small></h1>
</div>
<nav class="navbar navbar-default" role="navigation">
	<div class="container-fluid">
		<div class="navbar-header">
	      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="<c:url value='/'/>">Home</a>
	    </div>
	    
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	    	<ul class="nav navbar-nav">
		        <li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Disciplina<b class="caret"></b></a>
		          <ul class="dropdown-menu">
		            <li><a href="<c:url value='/adicionarDisciplina.htm'/>">Cadastrar</a></li>
		            <li class="divider"></li>
		            <li><a href="<c:url value='/listar_disciplinas.htm'/>">Listar</a></li>
		          </ul>
		        </li>
		        <li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Curso<b class="caret"></b></a>
		          <ul class="dropdown-menu">
		            <li><a href="<c:url value='/adicionarCurso.htm'/>">Cadastrar</a></li>
		            <li class="divider"></li>
		            <li><a href="<c:url value='/listar_cursos.htm'/>">Listar</a></li>
		          </ul>
		        </li>
		        <li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Título<b class="caret"></b></a>
		          <ul class="dropdown-menu">
		            <li><a href="#">Cadastrar</a></li>
		            <li class="divider"></li>
		            <li><a href="<c:url value='/titulo/list'/>">Listar</a></li>
		          </ul>
		        </li>
		        <li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Estrutura Curricular<b class="caret"></b></a>
		          <ul class="dropdown-menu">
		            <li><a href="#">Cadastrar</a></li>
		            <li class="divider"></li>
		            <li><a href="<c:url value='/estrutura/listar.htm'/>">Listar</a></li>
		          </ul>
		        </li>
		        <li><a href="#">Metas</a></li>
		      </ul>
	    </div>
	</div>
</nav>