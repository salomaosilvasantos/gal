package br.ufc.npi.gal.repository.jpa;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Named;

import br.ufc.npi.gal.model.AcervoDocumento;
import br.ufc.npi.gal.model.Usuario;
import br.ufc.npi.gal.repository.AcervoDocumentoRepository;
import br.ufc.quixada.npi.enumeration.QueryType;
import br.ufc.quixada.npi.repository.jpa.JpaGenericRepositoryImpl;

@Named
public class AcervoDocumentoRepositoryImpl extends
		JpaGenericRepositoryImpl<AcervoDocumento> implements
		AcervoDocumentoRepository {

	@Override
	public List<AcervoDocumento> findDocumentosByUsuario(Usuario usuario) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", usuario.getId());
		List<AcervoDocumento> result = find(QueryType.JPQL,
				"from AcervoDocumento where id_usuario = :id", params);
		if (result != null && !result.isEmpty()) {
			return result;
		}
		return null;
	}

}
