$( document ).ready(function() {
	
	$('table').dataTable(
		{
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
			}
		}
	);
	
	$('#confirm-delete').on('show.bs.modal', function(e) {
	    $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
	});
	
	$('div:has(span.error)').find('span.error').css('color', '#a94442');
	$('div:has(span.error)').find('span.error').parent().parent().addClass('has-error has-feedback');
	
});