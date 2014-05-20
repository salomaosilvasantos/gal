var prefix = '/gal3';

$( document ).ready(function() {
	
	$('.detalhes').click(function() {
		$.ajax({
	      type: "GET",
	      url: prefix  + "/titulo/detail/" + $(this).attr('id') + ".json",
	      contentType : 'application/json',
	      success :function(result) {
	       $('#nome').html(result.tit.nome);
	       $('#isbn').html(result.tit.isbn);
	       $('#tipo').html(result.tit.tipo);
	       $('#detalhes').modal({
	    	   backdrop: 'static'
	       });
	     },
	     error: function() {
	    	 $('.modal-body').html('<div class="alert alert-danger">Ocorreu um erro na busca do título.</div>');
	     }
	  });
	});
});