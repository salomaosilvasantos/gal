<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="datatables" uri="http://github.com/dandelion/datatables"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title>Cursos</title>
	<jsp:include page="../fragments/htmlHead.jsp" />
</head>
<body>
	<div id="container" style="width: 1000px; margin: 0 auto;">
		<jsp:include page="../fragments/header.jsp" />
		
		<c:if test="${not empty error}">
			<div class="alert alert-danger alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<c:out value="${error}"></c:out>
			</div>
		</c:if>
		<c:if test="${not empty info}">
			<div class="alert alert-info alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<c:out value="${info}"></c:out>
			</div>
		</c:if>
		
		<div id="button-add">
			<a href="<c:url value="/curso/adicionar" ></c:url>">
				<button class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span> Adicionar</button>
			</a>
		</div>
		
		<div style="text-align: center; margin-bottom: 30px;">
			<label class="control-label" style="font-size: 20px;">Cursos</label>
		</div>

		<div class="panel-group" id="accordion">
			<c:forEach items="${cursos}" var="curso">
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="panel-title" style="float: left;">
							<a data-toggle="collapse" data-parent="#selection" href="#collapse${curso.id}">
								<c:out value="${curso.nome}"></c:out>
							</a>
							
						</div>
						<div style="float: right;">
							<a id="excluir" style="float: right;" class="btn btn-danger" data-toggle="modal" data-target="#confirm-delete" href="#" data-href="<c:url value="/curso/${curso.id}/excluir" ></c:url>">
								<span class="glyphicon glyphicon-trash"></span> Excluir
							</a>
							<a id="editar" href="<c:url value="/curso/${curso.id }/editar" ></c:url>">
								<button class="btn btn-primary"><span class="glyphicon glyphicon-edit"></span> Editar</button>
							</a>
						</div>
					</div>
									
					<div id="collapse${curso.id}" class="panel-collapse collapse">
						<div class="panel-body">
							<ul class="nav nav-tabs" role="tablist">
								<c:forEach items="${curso.curriculos}" var="curriculo" varStatus="ct">
									<c:if test="${ct.index == 0}">
										<c:set var="act" value="active"></c:set>
									</c:if>
									<c:if test="${ct.index != 0}">
										<c:set var="act" value=""></c:set>
									</c:if>
									<li class="${act }"><a href="#${curriculo.anoSemestre }" role="tab" data-toggle="tab">${curriculo.anoSemestre}</a></li>
								</c:forEach>
							</ul>
							<div class="tab-content">
								<c:forEach items="${curso.curriculos}" var="curriculo" varStatus="count">
									<c:if test="${count.index == 0}">
										<c:set var="active" value="active"></c:set>
									</c:if>
									<c:if test="${count.index != 0}">
										<c:set var="active" value=""></c:set>
									</c:if>
									<div class="tab-pane ${active }" id="${curriculo.anoSemestre }">
										<div class="panel panel-default">
											<datatables:table id="estrutura${curso.id}"
												data="${curriculo.curriculos}" cdn="true" row="integracao"
												theme="bootstrap2" cssClass="table table-striped">
												<datatables:column title="Disciplina">
													<c:out value="${integracao.disciplina.nome}"></c:out>
												</datatables:column>
		
												<datatables:column title="Quantidade aluno">
													<c:out value="${integracao.quantidadeAlunos}"></c:out>
												</datatables:column>
		
												<datatables:column title="Semestre oferta">
													<c:out value="${integracao.semestreOferta}"></c:out>
												</datatables:column>
											</datatables:table>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<jsp:include page="../fragments/footer.jsp" />
	</div>
	<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                Excluir
	            </div>
	            <div class="modal-body">
	                Tem certeza de que deseja excluir esse curso?
	            </div>
	            <div class="modal-footer">
	                <a href="#" class="btn btn-danger">Excluir</a>
	                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
	            </div>
	        </div>
	    </div>
	</div>
</body>
</html>


