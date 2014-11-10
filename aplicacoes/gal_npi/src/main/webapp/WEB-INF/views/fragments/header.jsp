<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="page-header">
	<h1>
		GAL <small>Gestão de Aquisição de Livros</small>
	</h1>
</div>
<nav class="navbar navbar-default" role="navigation">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="<c:url value='/'/>">Início</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">Disciplina<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="<c:url value='/disciplina/adicionar'/>">Adicionar</a></li>
						<li class="divider"></li>
						<li><a href="<c:url value='/disciplina/listar'/>">Listar</a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">Curso<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="<c:url value='/curso/adicionar'/>">Adicionar</a></li>
						<li class="divider"></li>
						<li><a href="<c:url value='/curso/listar'/>">Listar</a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">Título<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="<c:url value='/titulo/adicionar'/>">Adicionar</a></li>
						<li class="divider"></li>
						<li><a href="<c:url value='/titulo/listar'/>">Listar</a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">Meta<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="<c:url value='/meta/configurar'/>">Configurar</a></li>
						<li class="divider"></li>
						<li><a href="<c:url value='/meta/listar'/>">Listar</a></li>
						<li class="divider"></li>

						<li class="dropdown-submenu"><a tabindex="-1" href="#">Download</a>
							<ul class="dropdown-menu">
								<li><a tabindex="-1" href="#">Opção 01</a></li>
								<li><a href="#">Opção 02</a></li>
								<li><a href="#">Opção 03</a></li>
							</ul></li>
					</ul></li>
				<li><a href="<c:url value='/contatos'/>">Contatos</a>
			</ul>



			<ul class="nav navbar-nav navbar-right">
				<li><a href="<c:url value="/logout" />">Sair <span
						class="glyphicon glyphicon-off"></span></a></li>
			</ul>
		</div>
	</div>
</nav>
