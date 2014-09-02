function verificarDeletarDisciplina(code) {

	var value = confirm("Deletar definitivamente a disciplina " + code + " ?");

	if (value == true) {
		return true;

	} else if (value == false) {
		return false;
	}

}

function verificarDeletarCurso(name) {

	var value = confirm("Deletar definitivamente o curso " + name + " ?");

	if (value == true) {
		return true;

	} else if (value == false) {
		return false;
	}

}

function verificarDeletarTitulo(name) {

	var value = confirm("Deletar definitivamente o título " + name + " ?");

	if (value == true) {
		return true;

	} else if (value == false) {
		return false;
	}

}

function validarNomeDisciplina(nome, x) {

	x.style.color = "white";
	var regex = /^[a-zA-Z\sà-ùÀ-Ù]{6,100}$/;

	if (regex.test(nome)) {

		if (nome.match(/^[ \t]+$/)) {

			x.style.borderWidth = "2px";
			x.style.backgroundColor = "red";
			console.log("Apenas caracteres vazios");
		} else {
			x.style.backgroundColor = "blue";
			// regexp responsável por retirar espaços em branco no inicio e fim
			// de uma string
			str = nome.replace(/^\s+|\s+$/g, "");
			console.log("valor do nome: " + str);
			console.log("String aprovada !");
		}
	} else {

		x.style.borderWidth = "2px";
		x.style.backgroundColor = "red";
		console
				.log("O nome não pode conter caracteres especiais e deve estar entre 6 e 100 caracteres");

	}
}

function validarCodigoDisciplina(codigo, elemento) {

	elemento.style.color = "white";
	var letters = /^[a-zA-Z0-9]{6,12}$/;
	if(codigo.match(letters))
	{
		elemento.style.backgroundColor = "blue";
		// regexp responsável por retirar espaços em branco no inicio e fim de
		// uma string
		str = nome.replace(/^\s+|\s+$/g, "");
		console.log("valor do nome: " + str);
		console.log("String aprovada !");
	}
	else
	{
		elemento.style.borderWidth = "2px";
		elemento.style.backgroundColor = "red";
		console.log("O código não pode conter caracteres especiais e deve estar entre 6 e 12 caracteres");
	}
}
