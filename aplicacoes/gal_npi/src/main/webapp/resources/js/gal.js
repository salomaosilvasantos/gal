$( document ).ready(function() {

	$('.data').datepicker({
		language: 'pt-BR',
		autoclose: true,
		format: "dd/mm/yyyy",
	});

	$('#disciplinaTable').dataTable({
		iDisplayLength: 25,
		sPaginationType : "full_numbers",
		oLanguage : {
			"sEmptyTable" : "Nenhum registro encontrado",
			"sInfo" : "Mostrando _START_ até _END_ de _TOTAL_ registros",
			"sInfoEmpty" : "Mostrar 0 até 0 de 0 Registros",
			"sInfoFiltered" : "(Filtrar de _MAX_ total registros)",
			"sInfoPostFix" : "",
			"sInfoThousands" : ".",
			"sLengthMenu" : "Mostrar _MENU_ registros por página",
			"sLoadingRecords" : "Carregando...",
			"sProcessing" : "Processando...",
			"sZeroRecords" : "Nenhum registro encontrado",
			"sSearch" : "Pesquisar: ",
			"oPaginate" : {
				"sNext" : "PróximoPróximoPróximoPróximo",
				"sPrevious" : "Anterior",
				"sFirst" : "Primeiro",
				"sLast" : "Último"
			},
			"oAria" : {
				"sSortAscending" : ": Ordenar colunas de forma ascendente",
				"sSortDescending" : ": Ordenar colunas de forma descendente"
			}
		},
		"aoColumnDefs": [ { "bSortable": false, "aTargets": [ 2,3,4 ] }],
		"bDestroy": true
	});
	
	$('#tituloTable').dataTable({
		iDisplayLength: 25,
		sPaginationType : "full_numbers",
		oLanguage : {
			"sEmptyTable" : "Nenhum registro encontrado",
			"sInfo" : "Mostrando _START_ até _END_ de _TOTAL_ registros",
			"sInfoEmpty" : "Mostrar 0 até 0 de 0 Registros",
			"sInfoFiltered" : "(Filtrar de _MAX_ total registros)",
			"sInfoPostFix" : "",
			"sInfoThousands" : ".",
			"sLengthMenu" : "Mostrar _MENU_ registros por página",
			"sLoadingRecords" : "Carregando...",
			"sProcessing" : "Processando...",
			"sZeroRecords" : "Nenhum registro encontrado",
			"sSearch" : "Pesquisar: ",
			"oPaginate" : {
				"sNext" : "PróximoPróximoPróximoPróximo",
				"sPrevious" : "Anterior",
				"sFirst" : "Primeiro",
				"sLast" : "Último"
			},
			"oAria" : {
				"sSortAscending" : ": Ordenar colunas de forma ascendente",
				"sSortDescending" : ": Ordenar colunas de forma descendente"
			}
		},
		"aoColumnDefs": [ { "bSortable": false, "aTargets": [ 3,4,5 ] }],
		"bDestroy": true
	})
	
	$('#resultadoTable').dataTable({
		iDisplayLength: 25,
		sPaginationType : "full_numbers",
		oLanguage : {
			"sEmptyTable" : "Nenhum registro encontrado",
			"sInfo" : "Mostrando _START_ até _END_ de _TOTAL_ registros",
			"sInfoEmpty" : "Mostrar 0 até 0 de 0 Registros",
			"sInfoFiltered" : "(Filtrar de _MAX_ total registros)",
			"sInfoPostFix" : "",
			"sInfoThousands" : ".",
			"sLengthMenu" : "Mostrar _MENU_ registros por página",
			"sLoadingRecords" : "Carregando...",
			"sProcessing" : "Processando...",
			"sZeroRecords" : "Nenhum registro encontrado",
			"sSearch" : "Pesquisar: ",
			"oPaginate" : {
				"sNext" : "PróximoPróximoPróximoPróximo",
				"sPrevious" : "Anterior",
				"sFirst" : "Primeiro",
				"sLast" : "Último"
			},
			"oAria" : {
				"sSortAscending" : ": Ordenar colunas de forma ascendente",
				"sSortDescending" : ": Ordenar colunas de forma descendente"
			}
		},
		"aoColumnDefs": [ { "bSortable": false, "aTargets": [ 4,7,10 ] }],
		"bDestroy": true
	})

	$('#resultadoParTable').dataTable( {
		iDisplayLength: 25,
		sPaginationType : "full_numbers",
		oLanguage : {
			"sEmptyTable" : "Nenhum registro encontrado",
			"sInfo" : "Mostrando _START_ até _END_ de _TOTAL_ registros",
			"sInfoEmpty" : "Mostrar 0 até 0 de 0 Registros",
			"sInfoFiltered" : "(Filtrar de _MAX_ total registros)",
			"sInfoPostFix" : "",
			"sInfoThousands" : ".",
			"sLengthMenu" : "Mostrar _MENU_ registros por página",
			"sLoadingRecords" : "Carregando...",
			"sProcessing" : "Processando...",
			"sZeroRecords" : "Nenhum registro encontrado",
			"sSearch" : "Pesquisar: ",
			"oPaginate" : {
				"sNext" : "Próximo",
				"sPrevious" : "Anterior",
				"sFirst" : "Primeiro",
				"sLast" : "Último"
			},
			"oAria" : {
				"sSortAscending" : ": Ordenar colunas de forma ascendente",
				"sSortDescending" : ": Ordenar colunas de forma descendente"
			}
		},
        "paging":   false,
        "ordering": false,
        "info":     false,
		"bDestroy": true
    } );
	
	$('#confirm-delete').on('show.bs.modal', function(e) {
	    $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
	});
	
	$('div:has(span.error)').find('span.error').css('color', '#a94442');
	$('div:has(span.error)').find('span.error').parent().parent().addClass('has-error has-feedback');
	
	$('#txtBusca').fastLiveFilter("#acervo");
	
	function getItems(exampleNr) {
		var columns = [];
		$(exampleNr + ' ul.sortable-list').each(
				function() {
					if ($(this).attr('id') != 'acervo') {
						columns.push($(this).sortable(
								'toArray').join(','));
					}
				});
		return columns;
	}
	
	$('#btn-get').click(function() {
		var data = {
			basica : getItems('#drag-and-drop')[0],
			complementar : getItems('#drag-and-drop')[1],
			idDiciplina : $('#disciplinaId').val()
		};
		$.get('/gal_npi/disciplina/vincular', data).success(function(data) {
			alert('OK');
			window.location.replace('/gal_npi/disciplina/listar');
		});
	});

	$('#drag-and-drop .sortable-list').sortable({
		connectWith : '#drag-and-drop .sortable-list'
	});

	$("select#seleciona").change(function() { 
		var option = $("#seleciona").val();
		var url = location.pathname; // pega endereço que esta no
		// navegador
		url = url.split("/"); // quebra o endeço de acordo com a / (barra)
		if(option==-1){
			newUrl = "/"+url[1]+"/meta/listar";
		}else{
			newUrl = "/"+url[1]+"/meta/"+(option)+"/listar";
		}
		
		$(location).attr("href", newUrl);
	});
	

	$("#seleciona").val($("#idCurso").val());

	
	$(document).on("click", ".open-AddBookDialog", function() {
		var id = $(this).data('id');
		$(".modal-body #id").val(id);
	});

	$("#selectDisciplina").select2();

});

function goBack() {
	window.history.back()
}

function mascara(o,f){
    v_obj=o
    v_fun=f
    setTimeout("execmascara()",1)
}
	
function execmascara(){
    v_obj.value=v_fun(v_obj.value)
}

function soNumeros(v){
    return v.replace(/\D/g,"")
}
