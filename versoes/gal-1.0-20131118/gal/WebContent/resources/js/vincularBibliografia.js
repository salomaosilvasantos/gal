$(document).ready(function() {
	$(document).tooltip();
	$("#janelaModalDisciplinaVincular").dialog({
		 draggable: false,
		 closeOnEscape: true,
		 autoOpen: false,
		 show: {
		 effect: "clip",
		 duration: 1000
		 },
		 height: 620,
		 width: 950
	});
	
//	var form = $("#vincularBibliografia");
//    form.submit(function (ev) {
//    	ev.preventDefault();
//    });
	$("#vincular").click(function (ev) {
		ev.preventDefault();
		var titulosParaVincular = []; 
	    $('#selecionarBasica option').each(function() {
	    	titulosParaVincular.push({
	       		titulo_id: $(this).val(),
	       		titulo_tipo: 'Básica'
	       		});
	    });
	    
	    $('#selecionarComplementar option').each(function() {
	       	titulosParaVincular.push({
	       		titulo_id: $(this).val(),
	       		titulo_tipo: 'Complementar'
	       		});
	    });
	    
	    var paraVincular = {id_disciplina: $("#id_disciplina").val(), titulos: titulosParaVincular};
	    $.ajax({
			type: "post",
			url: "./VincularBibliografia",
			data: paraVincular,
			success: function(result){
				alert(result);
			}
		});
	});
		
	$("#selecionarBibliografia").click(function(ev){
		$("#selecionarBasica").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");
		$("#selecionarComplementar").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");
	});
	$("#selecionarComplementar").click(function(ev){
		$("#selecionarBasica").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");
		$("#selecionarBibliografia").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");
	});
	$("#selecionarBasica").click(function(ev){
		$("#selecionarBibliografia").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");
		$("#selecionarComplementar").attr('selectedIndex', '-1').find("option:selected").removeAttr("selected");
	});
});

function ListarVincular() {
	$.ajax({
		type: "get",
		url: "./ListarTitulosServlet",
		dataType: "json",
		success: function(result){
			$.each(result, function(key, val){
				$("#selecionarBibliografia").last().append("<option name=\"" + val.nome + "\" title=\"" + val.nome + "\" value=\"" + val.id_t + "\">" + val.nome + "</option>");
			});
		}
	});	
}

function abrirModalDisciplinaVincular(codigo, nome, id_d){
	var basicas = [];
	var complementares = [];
	
	$("#id_disciplina").val(id_d);
	$("#legendaVincular").html("Vincular Bibliografia à disciplina: "+ codigo+" "+nome);
	$("#selecionarBibliografia").empty();
	$("#selecionarBasica").empty();
	$("#selecionarComplementar").empty();
	
	$.ajax({
		type: "get",
		url: "./ListarBibliografiaBasica",
		data: { id_d:id_d },
		success: function(data){ 
			$.each(data, function(key, val){
				$("#selecionarBasica").last().append("<option name=\"" + val.nome + "\" title=\"" + val.nome + "\" value=\"" + val.id_t + "\">" + val.nome + "</option>");
				basicas.push(val.nome);
			});
		}
		
	});
	$.ajax({
		type: "get",
		url: "./ListarBibliografiaComplementar",
		data: { id_d:id_d },
		success: function(data){ 
			$.each(data, function(key, val){
				$("#selecionarComplementar").last().append("<option name=\"" + val.nome + "\" title=\"" + val.nome + "\" value=\"" + val.id_t + "\">" + val.nome + "</option>");
				complementares.push(val.nome);
			});
		}
		
	});
	
	$.ajax({
		type: "get",
		url: "./ListarTitulosServlet",
		dataType: "json",
		success: function(result){
			$.each(result, function(key, val){
				if($.inArray(val.nome, basicas) == -1 && $.inArray(val.nome, complementares) == -1){
					$("#selecionarBibliografia").last().append("<option name=\"" + val.nome + "\" title=\"" + val.nome + "\" value=\"" + val.id_t + "\">" + val.nome + "</option>");
				}
			});
		}
	});	
	
	$("#janelaModalDisciplinaVincular").parent().css('position', 'Fixed').end().dialog( "open" );
	
	$("#basicaDel").click(function () {
	    var selectedItem = $("#selecionarBasica option:selected");
	    $("#selecionarBibliografia").append(selectedItem);
	});

	$("#basicaAdd").click(function () {
	    var selectedItem = $("#selecionarBibliografia option:selected");
	    $("#selecionarBasica").append(selectedItem);
	});

	$("#complementarDel").click(function () {
	    var selectedItem = $("#selecionarComplementar option:selected");
	    $("#selecionarBibliografia").append(selectedItem);
	});

	$("#complementarAdd").click(function () {
	    var selectedItem = $("#selecionarBibliografia option:selected");
	    $("#selecionarComplementar").append(selectedItem);
	});
	
}
