$(document).ready(function() {
	$("#erro").css('visibility', 'hidden');
	
	$("#tipoBuscaTitulo").change(function(){
		autoCompleteTitulos();
	});
	
	$("#janelaModal").dialog({	 
		 draggable: false,
		 closeOnEscape: true,
		 autoOpen: false,
		 show: {
		 effect: "clip",
		 duration: 1000
		 },
		 height: 320,
		 width: 570
		 
	});
	
	$("#btnbuscarTitulos").click(function(){
		if($("#tipoBuscaTitulo").val() == "false"){
			$("#erro").css('visibility', 'hidden');

			$.ajax({
				type: "get",
				url: "./ListarTitulosServlet",
				dataType: "json",
				success: function(result){
						var aux=0;
						$.each(result, function(key, val){
						if($("#buscar").val() == val.nome){
							$("#tabela").find("tr:gt(0)").remove();
							$("#tabela").last().append("<tr><td id=\"valisbn\">" + val.isbn + "</td><td id=\"valnome\">" 
									+ val.nome + "</td><td id=\"valtipo\">" + val.tipo + 
									"</td><td id=\"alinhareditar\"><a id=\"revelador\" href=\"#\" onclick=\"abrirModal(\'" + val.isbn + "\',\'" + val.nome + "\',\'" + val.tipo + "\');\">" +
									"<span class=\"ui-icon ui-icon-pencil\" style=\"display:inline-block\">" +
									"</span></a></td><td id=\"alinhardeletar\">" +
									"<a href=\"javascript:;\" onclick=deletarTitulo(\'" + val.isbn + "\');><span class=\"ui-icon ui-icon-trash\" style=\"display:inline-block\">" +
									"</span></a></td></tr>");
							aux++;
						}
					});
					if(aux==0){
						$("#tabela").find("tr:gt(0)").remove();
						ListarTitulos();
						$("#erro").css('visibility', 'visible');

					}
				}
			});
		}else{
			$("#erro").css('visibility', 'hidden');

			$.ajax({
				type: "get",
				url: "./ListarTitulosServlet",
				dataType: "json",
				success: function(result){
					var aux=0;
					$.each(result, function(key, val){
						if($("#buscar").val() == val.isbn){
							$("#tabela").find("tr:gt(0)").remove();
							$("#tabela").last().append("<tr><td id=\"valisbn\">" + val.isbn + "</td><td id=\"valnome\">" 
									+ val.nome + "</td><td id=\"valtipo\">" + val.tipo + 
									"</td><td id=\"alinhareditar\"><a id=\"revelador\" href=\"#\" onclick=\"abrirModal(\'" + val.isbn + "\',\'" + val.nome + "\',\'" + val.tipo + "\');\">" +
									"<span class=\"ui-icon ui-icon-pencil\" style=\"display:inline-block\">" +
									"</span></a></td><td id=\"alinhardeletar\">" +
									"<a href=\"javascript:;\" onclick=deletarTitulo(\'" + val.isbn + "\');><span class=\"ui-icon ui-icon-trash\" style=\"display:inline-block\">" +
									"</span></a></td></tr>");
							aux++;
						}
					});
					if(aux==0){
						$("#tabela").find("tr:gt(0)").remove();
						ListarTitulos();
						$("#erro").css('visibility', 'visible');

					}
				}
			});
		}		
	});

});

/*function ListarTitulos() {
	$.ajax({
		type: "get",
		url: "./ListarTitulosServlet",
		dataType: "json",
		success: function(result){
			$("#tabela").find("tr:gt(0)").remove();
			$.each(result, function(key, val){
				$("#tabela").last().append("<tr><td id=\"valisbn\" class=\".font_conteudo\">" + val.isbn + "</td><td id=\"valnome\">" 
						+ val.nome + "</td><td id=\"valtipo\"	>" + val.tipo + 
						"</td><td id=\"alinhareditar\"><a id=\"revelador\" href=\"#\" onclick=\"abrirModal(\'" + val.isbn + "\',\'" + val.nome + "\',\'" + val.tipo + "\');\">" +
						"<span class=\"ui-icon ui-icon-pencil\" style=\"display:inline-block\">" +
						"</span></a></td><td id=\"alinhardeletar\">" +
						"<a href=\"javascript:;\" onclick=deletarTitulo(\'" + val.isbn + "\');><span class=\"ui-icon ui-icon-trash\" style=\"display:inline-block\">" +
						"</span></a></td></tr>");
			});
		}
	});
	autoCompleteTitulos();	
}*/

function ListarTitulos() {
	$.ajax({
		type: "get",
		url: "./ListarTitulosServlet",
		dataType: "json",
		success: function(result){
			$("#tabela").find("tr:gt(0)").remove();
			$.each(result, function(key, val){
				$("#tabela").last().append("<tr><td id=\"valisbn\" class=\".font_conteudo\">" + val.isbn + "</td><td id=\"valnome\">" 
						+ val.nome + "</td><td id=\"valtipo\"	>" + val.tipo + 
						"</td><td id=\"alinhareditar\"><a id=\"revelador\" href=\"#\" onclick=\"abrirModal(\'" + val.isbn + "\',\'" + val.nome + "\',\'" + val.tipo + "\');\">" +
						"<img src=\"resources/img/lapis1.png\" alt=\"icone1\" title=\"Editar\" width=\"34px\" height=\"40px\" style=\"display:inline-block\" />" +
						"</a><a href=\"#\" onclick=deletarTitulo(\'" + val.isbn + "\');><img src=\"resources/img/lixeira1.png\" alt=\"remover\" title=\"Remover\" width=\"40px\" height=\"40px\" style=\"display:inline-block\" />" +
						"</a></td></tr>");
			});
		}
	});
	autoCompleteTitulos();	
}


function autoCompleteTitulos(){
	
	var nomesLivros = [];
	
	var ISBNLivros = [];
	
	if($("#tipoBuscaTitulo").val() == "false"){
		$.ajax({
			type: "get",
			url: "./ListarTitulosServlet",
			dataType: "json",
			success: function(result){
				$.each(result, function(key, val){
					nomesLivros.push(val.nome);
				});
			}
		});
		$("#buscar").autocomplete({
			source: nomesLivros
		});
	}else{
		$.ajax({
			type: "get",
			url: "./ListarTitulosServlet",
			dataType: "json",
			success: function(result){
				$.each(result, function(key, val){
					ISBNLivros.push(val.isbn);
				});
			}
		});
		$("#buscar").autocomplete({
			source: ISBNLivros
		});
	}
}

function abrirModal(isbn, nome, tipo){
	$("#legenda").html("Editando ISBN: "+ isbn);
	$("#janelaModal").parent().css('position', 'Fixed').end().dialog( "open" );
	$("#isbn").val(isbn);
	$("#nome").val(nome);
	$("#tipo").val(tipo);
	$("#isbn_atual").val(isbn);
	
	$.alert(nome);
}

function chamarServletDeletarTitulo(isbn){
	$.ajax({
		type: "get",
		url: "./deletarTitulosServlet",
		data: { isbn:isbn },
		success: function(data){ alert(data); ListarTitulos();}
		
	});
}

function deletarTitulo(isbn){
	$("#notificacao_titulo").dialog({ 
		modal: true,
		options: "oi",
		buttons: [ { text: "Ok", click: function(){ chamarServletDeletarTitulo(isbn); $( this ).dialog( "close" );}  },
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


function validarEdicaoTitulo(form){
	
	//ISBN
	if(form.isbn.value == ""){
		$("#msg_isbn_listar").css("display","inline");
		$("#msg_nome_titulo").css("display","none");
		form.isbn.focus();
		validar = false;
		return false;
	}
	
	if(form.nome.value == ""){
		$("#msg_isbn_listar").css("display","none");
		$("#msg_nome_titulo").css("display","inline");
		form.nome.focus();
		validar = false;
		return false;
}
}

