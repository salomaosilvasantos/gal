
	function verifyDelete(code) {
		
		var value = confirm("Deletar definitivamente a disciplina " +code +" ?");
		
		if(value == true){
			return true;
			
		}else if(value == false){
			return false;
		}
		

	}
