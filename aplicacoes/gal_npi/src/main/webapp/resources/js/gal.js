$.fn.serializeObject = function()
{
   var o = {};
   var a = this.serializeArray();
   $.each(a, function() {
       if (o[this.name]) {
           if (!o[this.name].push) {
               o[this.name] = [o[this.name]];
           }
           o[this.name].push(this.value || '');
       } else {
           o[this.name] = this.value || '';
       }
   });
   return o;
};

$( document ).ready(function() {
	
	$.fn.dataTableExt.sErrMode = 'throw';
	$('table').dataTable(
		{
			"sPaginationType" : "full_numbers",
			"oLanguage" : {
				"sEmptyTable" : "Nenhum registro encontrado na tabela",
				"sInfo" : "Mostrar _START_ até _END_ do _TOTAL_ registros",
				"sInfoEmpty" : "Mostrar 0 até 0 de 0 Registros",
				"sInfoFiltered" : "(Filtrar de _MAX_ total registros)",
				"sInfoPostFix" : "",
				"sInfoThousands" : ".",
				"sLengthMenu" : "Mostrar _MENU_ registros por pagina",
				"sLoadingRecords" : "Carregando...",
				"sProcessing" : "Processando...",
				"sZeroRecords" : "Nenhum registro encontrado",
				"sSearch" : "Pesquisar",
				"oPaginate" : {
					"sNext" : "Proximo",
					"sPrevious" : "Anterior",
					"sFirst" : "Primeiro",
					"sLast" : "Ultimo"
				},
				"oAria" : {
					"sSortAscending" : ": Ordenar colunas de forma ascendente",
					"sSortDescending" : ": Ordenar colunas de forma descendente"
				}
			}
		}
	);
	
	/*$('#add-curso-button').click(function() {
	    var $form = $('#add-curso-form');
	    var data = JSON.stringify($form.serializeObject());
	    $.ajax({
	        url: $form.attr("action"),
	        data: data,
	        contentType : "application/json; charset=utf-8",
	        dataType : "json",
	        type: "POST",
	        success: function(data) {
	            alert(data);
	        },
	        error: function(data) {
	            alert('error: ' + data);
	        }
	    });
	});*/
	
});