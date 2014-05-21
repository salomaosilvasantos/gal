package br.ufc.npi.gal.service;

import java.util.List;

import br.ufc.npi.gal.model.Titulo;

public interface TituloService {
	
	public void adicionar(Titulo titulo);
	
	public void atualizar(Titulo titulo);
	
	public void excluir(Integer id);
	
    public List<Titulo> listar();    
    
    public Titulo findById(Integer id);
    
    public List<Titulo> findByIsbn(String isbn);
    
    public List<Titulo> findByNome(String nome);

}
