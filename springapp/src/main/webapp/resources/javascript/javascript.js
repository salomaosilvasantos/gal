$(document).ready(function() {

	/*
	$(".buttonUpdate").click(function editarDados(){
		
		//pegando o ID do botao que foi clicado
		var idBotao = $(this).attr("id");
		
		// pegando o conteudo dentro do elemento th de acordo com o respectivo id
		var conteudoNome = $(".colsLeft[id='" +idBotao +"']").text();
		
		var conteudoCodigo = $(".colsRight[id='" +idBotao +"']").text();
		
		$(".rows[id=" +idBotao +"]").html("");
		$(".rows[id=" +idBotao +"]").html("<th class = 'colsRight' id = '" +idBotao+ "' colspan='3'>" +
				"<form id ='editDisciplina' action = '' method='post'>" +
				"<input id='id' name='id' type='text' value='"+idBotao+"'/>" +
				"<input type= 'text' class = 'inputTextCodigo' id='code' name = 'code' value = '"+conteudoCodigo+"'/>" +
				"<input type= 'text' class = 'inputTextNome' id='nome' name ='nome' value = '"+conteudoNome+"'/>"+
				//"<a class = 'enviarDados' href ='springapp/" +idBotao +"/editDisciplina.htm'>click</a>" +
				//"<a class = 'buttonTable' href ='/" +idBotao +"/deleteDisciplina.htm'></a>" +
				"<input class = 'enviarDados' id = '" +idBotao+ "' value = 'submit' type = 'button'></input></form></th>");
		
		});

	*/
	$(".enviarDados").click(function enviarDadosAjax(){
		
		var idBotao = $(this).attr("id");
		alert(idBotao);
		alert("asdsa");
		/*
		if (window.XMLHttpRequest)
		{// code for IE7+, Firefox, Chrome, Opera, Safari
	       
		try{
				xmlhttp=new XMLHttpRequest();
		}catch (e){
	                xmlhttp = false;
	            }
		}else{	// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}

		xmlhttp.onreadystatechange = recuperarDadosForm;
		xmlhttp.open("POST","springapp/" +idBotao +"/editDisciplina.htm",true);
		xmlhttp.send(null);  
		*/
	});
	

	function recuperarDadosForm(){
		
		
		
	};
	
	
	
});
