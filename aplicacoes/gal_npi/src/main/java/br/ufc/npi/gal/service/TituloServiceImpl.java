package br.ufc.npi.gal.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.repository.TituloRespository;

@Service
public class TituloServiceImpl implements TituloService {
	
	@Autowired
	private TituloRespository tituloRespository;

	public void adicionar(Titulo titulo) {
		tituloRespository.adicionarOuAtualizar(titulo);
	}

	public void atualizar(Titulo titulo) {
		tituloRespository.adicionarOuAtualizar(titulo);
	}

	public void excluir(Integer id) {
		Titulo titulo = tituloRespository.buscar(id);
		if (titulo != null) {
			tituloRespository.excluir(titulo);
		}
		
	}

	public List<Titulo> listar() {
		return tituloRespository.listar();
	}

	public Titulo findById(Integer id) {
		return tituloRespository.buscar(id);
	}

	public List<Titulo> findByIsbn(String isbn) {
		return tituloRespository.findByIsbn(isbn);
	}

	public List<Titulo> findByNome(String nome) {
		return tituloRespository.findByNome(nome);
	}

}
