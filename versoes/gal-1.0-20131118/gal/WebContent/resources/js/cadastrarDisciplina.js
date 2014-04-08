var validar = true;
$(document).ready(function() {
//	$("#cadastrarDisciplinas").validate({
//		rules : {
//			codigo : {
//				required : true
//			},
//			nome_disciplina : {
//				required : true,
//				minlength: 5
//			}
//		},
//
//		messages : {
//			codigo : {
//				required : "*Campo Obrigatório"
//			},
//
//			nome_disciplina : {
//				required : "*Campo Obrigatório",
//				minlength : "*Nome deve ter no minimo 5 caracteres.",
//			}
//		}
//	});
	
    var form = $("#cadastrarDisciplinas");
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



function validarCadastroDisciplina(form){
	var quantidade = parseInt(form.quantidade_aluno.value);
	
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
	
	 if (quantidade < 0 || !isNum(form.quantidade_aluno.value )){
		$("#msg_quantidade").css("display","inline");
		$("#msg_nome").css("display","none");
		$("#msg_codigo").css("display","none");
		form.quantidade_aluno.focus();
		validar = false;
		return false;
	}
	
}

