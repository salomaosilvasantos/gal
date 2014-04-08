$(document).ready(function() {
	$("#erro").css('visibility', 'hidden');
	
	$("#tipoBuscaDisciplina").change(function(){
		autoCompleteDisciplinas();
	});
	
	
	$("#janelaModalDisciplina").dialog({
		 draggable: false,
		 closeOnEscape: true,
		 autoOpen: false,
		 show: {
			 effect: "clip",
			 duration: 1000
		 },
		 show: {
			 effect: "clip",
			 duration: 1000
			 },
		 height: 350,
		 width: 560
	});
	
	$("#botaoListarTodasDisciplinas").click(function(){
		ListarDisciplinas();
	});
	
	$("#btnbuscarDisciplinas").click(function(){
		if($("#tipoBuscaDisciplina").val() == "false"){
			$("#erro").css('visibility', 'hidden');
		$.ajax({
			type: "get",
			url: "./ListarDisciplinasServlet",
			dataType: "json",
			success: function(result){
				var aux=0;
				$.each(result, function(key, val){
					if($("#buscar").val() == val.nome){
						$("#tabela").find("tr:gt(0)").remove();
						$("#tabela").last().append("<tr><td>" + val.codigo + "</td><td>" + val.nome + 
								"</td><td>" + val.semestre_oferta +"</td><td>"+ val.quantidade_aluno + 
								"</td><td id=\"alinhareditar\"><a id=\"reveladorDisciplina\" href=\"#\" onclick=\"abrirModalDisciplina(\'" + val.codigo + "\',\'" + val.nome + "\');\">" +
								"<span class=\"ui-icon ui-icon-pencil\" style=\"display:inline-block\">" +
								"</span></a>" + "<td id=\"alinhareditar\"><a id=\"reveladorDisciplinaVincular\" href=\"#\" onclick=\"abrirModalDisciplinaVincular(\'" + val.codigo + "\',\'" + val.nome + "\',\'" + val.id_d + "\');\">" +
								"<span class=\"ui-icon ui-icon-note\" style=\"display:inline-block\">" +
								"</span></a>" + "</td><td id=\"alinhardeletar\">" +
								"<a href=\"javascript:;\" onclick=deletarDisciplina(\'" + val.codigo + "\');><span class=\"ui-icon ui-icon-trash\" style=\"display:inline-block\"></span></a></td></tr>");
						aux++;
					}
				});
				if(aux==0){
					$("#tabela").find("tr:gt(0)").remove();
					ListarDisciplinas();
					$("#erro").css('visibility', 'visible');
				}
			}
		});
		}else{
			$("#erro").css('visibility', 'hidden');
			$.ajax({
				type: "get",
				url: "./ListarDisciplinasServlet",
				dataType: "json",
				success: function(result){
					var aux=0;
					$.each(result, function(key, val){
						if($("#buscar").val() == val.codigo){
							$("#tabela").find("tr:gt(0)").remove();
							$("#tabela").last().append("<tr><td>" + val.codigo + "</td><td>" + val.nome + 
									"</td><td>" + val.semestre_oferta +"</td><td>"+ val.quantidade_aluno + 
									"</td><td id=\"alinhareditar\"><a id=\"reveladorDisciplina\" href=\"#\" onclick=\"abrirModalDisciplina(\'" + val.codigo + "\',\'" + val.nome + "\');\">" +
									"<span class=\"ui-icon ui-icon-pencil\" style=\"display:inline-block\">" +
									"</span></a>" + "<td id=\"alinhareditar\"><a id=\"reveladorDisciplinaVincular\" href=\"#\" onclick=\"abrirModalDisciplinaVincular(\'" + val.codigo + "\',\'" + val.nome + "\',\'" + val.id_d + "\');\">" +
								"<span class=\"ui-icon ui-icon-note\" style=\"display:inline-block\">" + "</td><td id=\"alinhardeletar\">" +
								"<a href=\"javascript:;\" onclick=deletarDisciplina(\'" + val.codigo + "\');><span class=\"ui-icon ui-icon-trash\" style=\"display:inline-block\"></span></a></td></tr>");
							aux++;
						}
					});
					if(aux==0){
						$("#tabela").find("tr:gt(0)").remove();
						ListarDisciplinas();
						$("#erro").css('visibility', 'visible');

					}
				}
			});
		}
	});
});

/*function ListarDisciplinas() {
	$.ajax({
		type : "get",
		url : "./ListarDisciplinasServlet",
		dataType : "json",
		success : function(result) {
			$("#tabela").find("tr:gt(0)").remove();
			$.each(result, function(key, val) {
				$("#tabela").last().append("<tr><td>" + val.codigo + "</td><td>" + val.nome + 
						"</td><td>" + val.semestre_oferta +"</td><td>"+ val.quantidade_aluno +"</td><td id=\"alinhareditar\"><a id=\"reveladorDisciplina\" href=\"#\" onclick=\"abrirModalDisciplina(\'" + val.codigo + "\',\'" + val.nome + "\',\'" + val.semestre_oferta + "\',\'" + val.quantidade_aluno + "\');\">" +
						"<span class=\"ui-icon ui-icon-pencil\" style=\"display:inline-block\">" +
						"</span></a>" + "<td id=\"alinhareditar\"><a id=\"reveladorDisciplinaVincular\" href=\"#\" onclick=\"abrirModalDisciplinaVincular(\'" + val.codigo + "\',\'" + val.nome + "\',\'" + val.id_d + "\');\">" +
								"<span class=\"ui-icon ui-icon-note\" style=\"display:inline-block\">" +"</td><td id=\"alinhardeletar\">" +
						"<a href=\"javascript:;\" onclick=deletarDisciplina(\'" + val.codigo + "\');><span class=\"ui-icon ui-icon-trash\" style=\"display:inline-block\"></span></a></td></tr>");
				});
		}
	});
	
	autoCompleteDisciplinas();
}*/

function ListarDisciplinas() {
	$.ajax({
		type : "get",
		url : "./ListarDisciplinasServlet",
		dataType : "json",
		success : function(result) {
			$("#tabela").find("tr:gt(0)").remove();
			$.each(result, function(key, val) {
				$("#tabela").last().append("<tr><td>" + val.codigo + "</td><td>" + val.nome + 
						"</td><td>" + val.semestre_oferta +"</td><td>"+ val.quantidade_aluno +"</td>"+"<td id=\"alinhareditar\"><a id=\"reveladorDisciplina\" href=\"#\" onclick=\"abrirModalDisciplina(\'" + val.codigo + "\',\'" + val.nome + "\',\'" + val.semestre_oferta + "\',\'" + val.quantidade_aluno + "\');\">" +
						"<img src=\"resources/img/lapis1.png\" alt=\"Editar\" title=\"Editar\" width=\"34px\" height=\"40px\" style=\"display:inline\" />" +
						"</a>" + "<a id=\"reveladorDisciplinaVincular\" href=\"#\" onclick=\"abrirModalDisciplinaVincular(\'" + val.codigo + "\',\'" + val.nome + "\',\'" + val.id_d + "\');\">" +"<img src=\"resources/img/livro1.png\" alt=\"vincular\" title=\"Vincular\" width=\"35px\" height=\"35px\" style=\"display:inline\" />" +
						"<a href=\"#\" onclick=deletarDisciplina(\'" + val.codigo + "\');><img src=\"resources/img/lixeira1.png\" alt=\"remover\" title=\"Remover\" width=\"40px\" height=\"40px\" style=\"display:inline\" /></a></td></tr>");
				});
		}
	});
	
	autoCompleteDisciplinas();
}

function autoCompleteDisciplinas(){
	
	var nomesDisciplinas = [];
	
	var CodigoDisciplinas = [];
		
	if($("#tipoBuscaDisciplina").val() == "false"){
		$.ajax({
			type: "get",
			url: "./ListarDisciplinasServlet",
			dataType: "json",
			success: function(result){
				$.each(result, function(key, val){
					nomesDisciplinas.push(val.nome);
				});
			}
		});
		$("#buscar").autocomplete({
			source: nomesDisciplinas
		});
	}
	else{
		$.ajax({
			type: "get",
			url: "./ListarDisciplinasServlet",
			dataType: "json",
			success: function(result){
				$.each(result, function(key, val){
					CodigoDisciplinas.push(val.codigo);
				});
			}
		});
		$("#buscar").autocomplete({
			source: CodigoDisciplinas
		});
	}	
}

function abrirModalDisciplina(codigo, nome, semestre_oferta, quantidade_aluno){
	$("#legenda").html("Editando Código: "+ codigo);
	$("#janelaModalDisciplina").parent().css('position', 'Fixed').end().dialog( "open" );
	$("#codigo").val(codigo);
	$("#semestre_oferta").val(semestre_oferta);
	$("#quantidade_aluno").val(quantidade_aluno);
	$("#nome_disciplina").val(nome);
	$("#codigo_atual").val(codigo);
}

function chamarServletDeletarDisciplina(codigo){
	$.ajax({
		type: "get",
		url: "./deletarDisciplinaServlet",
		data: { codigo:codigo },
		success: function(data){ alert(data); ListarDisciplinas();}
		
	});
}

function deletarDisciplina(codigo){
	
	$("#notificacao").dialog({ 
		draggable: true,
		modal: true,
		options: true,
		buttons: [ { text: "Ok", click: function(){ chamarServletDeletarDisciplina(codigo); $( this ).dialog( "close" );}  },
	    { text: "Cancelar", click: function() { $( this ).dialog( "close" );}  } ]
	});
}

function isNum(v)

{
   var ValidChars = "0123456789";
   var IsNumber=true;
   var Char;

 
   for (var i = 0; i < v.length && IsNumber == true; i++) 
      { 
      Char = v.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
         {
         IsNumber = false;
         }
      }
   return IsNumber;
   
}


function validarEdicaoDisciplina(form){
	
	//código
	if(form.codigo.value == ""){
		$("#msg_codigo").css("display","inline");
		$("#msg_nome").css("display","none");
		$("#msg_quantidade").css("display","none");
		form.codigo.focus();
		validar = false;
		return false;
	}
	
	//nome
	if(form.nome_disciplina.value == ""){
		$("#msg_nome").css("display","inline");
		$("#msg_codigo").css("display","none");
		$("#msg_quantidade").css("display","none");
		form.nome_disciplina.focus();
		validar = false;
		return false;
	}
	
	//quantidade
	var quantidade = parseInt(form.quantidade_aluno.value);
	if (quantidade < 0 || !isNum(form.quantidade_aluno.value )){
		$("#msg_quantidade").css("display","inline");
		$("#msg_nome").css("display","none");
		$("#msg_codigo").css("display","none");
		form.quantidade_aluno.focus();
		validar = false;
		return false;
	}
}

function validarVincularBibliografia(form){
	alert("oi oi");
	if(form.Basica.value == "" && form.Complementar.value == ""){
		
		$("#notificacao_vincular").dialog();
		return false;
	}
}

