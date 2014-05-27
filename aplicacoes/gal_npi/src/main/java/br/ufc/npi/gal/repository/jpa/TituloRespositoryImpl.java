package br.ufc.npi.gal.repository.jpa;

import java.util.List;

import org.springframework.stereotype.Repository;

import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.repository.TituloRespository;

@Repository
public class TituloRespositoryImpl extends GenericRepositoryImpl<Titulo> implements TituloRespository {

	public TituloRespositoryImpl() {
		super();
		this.persistentClass = Titulo.class;
	}
	
	@SuppressWarnings("unchecked")
	public List<Titulo> listar() {
		return em.createQuery("select t from Titulo t").getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Titulo> findByIsbn(String isbn) {
		return em.createQuery("select t from Titulo t where isbn = :isbn").setParameter("isbn", isbn).getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Titulo> findByNome(String nome) {
		return em.createQuery("select t from Titulo t where nome = :nome").setParameter("nome", nome).getResultList();
	}

}
