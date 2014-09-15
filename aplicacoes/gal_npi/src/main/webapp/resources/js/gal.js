$( document ).ready(function() {
	
	// Get items
	
	// Example 2.1: Get items
	
	
	
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
	
	$('#txtBusca').fastLiveFilter('#teste');
	
	function getItems(exampleNr) {
		var columns = [];
		$(exampleNr + ' ul.sortable-list').each(
				function() {
					if ($(this).attr('id') != 'teste') {
						columns.push($(this).sortable(
								'toArray').join(','));
					}
				});
		alert(columns);
		return columns;
	}
	
	$('#btn-get')
	.click(
			function() {
				var data = {
					basica : getItems('#example-2-1')[0],
					complementar : getItems('#example-2-1')[1],
					idDiciplina : $('#disciplinaId').val()
				};
				$
						.get(
								'/gal_npi/disciplina/vincular',
								data)
						.success(
								function(data) {
									alert('OK');
									window.location
											.replace('/gal_npi/disciplina/listar');
								});
				//alert(getItems('#example-2-1'));
			});
	
	
	
	
	$('#example-2-1 .sortable-list').sortable({
		connectWith : '#example-2-1 .sortable-list'
	});
	
	/*$("#example-2-1 input").keyup(function() {
		var index = $(this).parent().index();
		$('#example-2-1 .sortable-list').sortable({
			connectWith : '#example-2-1 .sortable-list'
		});
		$('#txtBusca').fastLiveFilter('#teste');
	});*/
	$("#example-2-1 input").focus(function() {
		
		$('#example-2-1 .sortable-list').sortable({
			connectWith : '#example-2-1 .sortable-list'
		});
		$('#txtBusca').fastLiveFilter('#teste');
	});
	
	

	
});
