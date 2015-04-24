package br.ufc.npi.gal.service;

import br.ufc.npi.gal.model.Usuario;
import br.ufc.quixada.npi.service.GenericService;

public interface UsuarioGalService extends GenericService<Usuario>{

	Usuario getByCpf(String cpf);

}
