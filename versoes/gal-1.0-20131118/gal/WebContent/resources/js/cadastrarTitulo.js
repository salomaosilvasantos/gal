var validar = true;
$(document).ready(function() {
	
	
	
	
//	$("#cadastrarTitulos").validate({
//		rules : {
//			isbn : {
//				required : true
//			},
//			nome : {
//				required : true,
//				minlength : 5
//			}
//		},
//
//		messages : {
//			isbn : {
//				required : "*Campo Obrigatório"
//			},
//
//			nome : {
//				required : "*Campo Obrigatório",
//				minlength : "*Nome deve ter no minimo 5 caracteres."
//			}
//		}
//	});
	
    var form = $("#cadastrarTitulos");
    form.submit(function (ev) {
    	if(validar){
    		ev.preventDefault();
        	
        	$.ajax({
                type: form.attr("method"),
                url: form.attr("action"),
                data: form.serialize(),
                success: function (data) {
                    alert(data);
                }
            });
    	}
    	

    });

});



function validarCadastroTitulo(form){
	
	if(form.isbn_titulo.value==""){
		validar = false;
		$("#msg_isbn").css("display", "inline");
		$("#msg_nome").css("display", "none");
		form.isbn_titulo.focus();
		return false;
	}
	
	
	
	
	if (form.nome_titulo.value=="") {
		validar = false;
		$("#msg_nome").css("display", "inline");
		$("#msg_isbn").css("display", "none");
		form.nome_titulo.focus();
		return false;
		}
	
	
	
}