package br.ufc.npi.gal.web;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.ufc.npi.gal.model.Bibliografia;
import br.ufc.npi.gal.model.Disciplina;
import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.service.BibliografiaService;
import br.ufc.npi.gal.service.DisciplinaService;
import br.ufc.npi.gal.service.TituloService;

@Controller
@RequestMapping("/disciplina")
public class DisciplinaController {

	@Inject
	private DisciplinaService disciplinaService;
	private List<Titulo> listaIdTitulo;
	private List<Titulo> complementar;
	@Inject
	private TituloService tituloService;
	@Inject
	private BibliografiaService bibliografiaService;

	@RequestMapping(value = "/listar")
	public String listar(ModelMap modelMap) {
		modelMap.addAttribute("disciplinas",
				this.disciplinaService.find(Disciplina.class));
		return "disciplina/listar";
	}

	@RequestMapping(value = "/{id}/editar", method = RequestMethod.GET)
	public String editar(@PathVariable("id") Integer id, ModelMap modelMap) {

		Disciplina disciplina = this.disciplinaService.find(Disciplina.class,
				id);

		if (disciplina == null) {
			return "redirect:/disciplina/listar";

		}
		modelMap.addAttribute("disciplina", disciplina);
		return "disciplina/editar";
	}

	@RequestMapping(value = "/editar", method = RequestMethod.POST)
	public String atualizar(@Valid Disciplina disciplina, BindingResult result,
			RedirectAttributes redirectAttributes) {
		if (result.hasErrors()) {
			return "disciplina/editar";
		}

		if (disciplinaService.getOutraDisciplinaByCodigo(disciplina.getId(),
				disciplina.getCodigo()) != null) {
			result.rejectValue("codigo", "Repeat.disciplina.codigo",
					"Já existe uma disciplina com esse código");
			return "disciplina/editar";
		}
		if (disciplinaService.getOutraDisciplinaByNome(disciplina.getId(),
				disciplina.getNome().toUpperCase()) != null) {
			result.rejectValue("nome", "Repeat.disciplina.nome",
					"Já existe uma disciplina com esse nome");
			return "disciplina/editar";
		}

		disciplina.setNome(disciplina.getNome().toUpperCase());
		disciplinaService.update(disciplina);
		redirectAttributes.addFlashAttribute("info",
				"Disciplina atualizada com sucesso.");
		return "redirect:/disciplina/listar";

	}

	@RequestMapping(value = "/{id}/excluir", method = RequestMethod.GET)
	public String excluir(@PathVariable("id") Integer id,
			RedirectAttributes redirectAttributes) {
		Disciplina disciplina = disciplinaService.find(Disciplina.class, id);
		if (disciplina != null) {
			this.disciplinaService.delete(disciplina);
			redirectAttributes.addFlashAttribute("info",
					"Disciplina removida com sucesso.");
		}
		return "redirect:/disciplina/listar";
	}

	@RequestMapping(value = "/adicionar")
	public String adicionar(ModelMap modelMap) {
		modelMap.addAttribute("disciplina", new Disciplina());
		return "disciplina/adicionar";
	}

	@RequestMapping(value = "/adicionar", method = RequestMethod.POST)
	public String adicionar(@Valid Disciplina disciplina, BindingResult result,
			RedirectAttributes redirectAttributes) {

		if (result.hasErrors()) {
			return "disciplina/adicionar";
		}

		if (disciplinaService.getDisciplinaByCodigo(disciplina.getCodigo()) != null) {
			result.rejectValue("codigo", "Repeat.disciplina.codigo",
					"Já existe uma disciplina com esse código");
			return "disciplina/adicionar";
		}
		if (disciplinaService.getDisciplinaByNome(disciplina.getNome()
				.toUpperCase()) != null) {
			result.rejectValue("nome", "Repeat.disciplina.nome",
					"Já existe uma disciplina com esse nome");
			return "disciplina/adicionar";
		}

		disciplina.setNome(disciplina.getNome().toUpperCase());
		disciplinaService.save(disciplina);
		redirectAttributes.addFlashAttribute("info",
				"Disciplina adicionada com sucesso.");
		return "redirect:/disciplina/listar";
	}

	@RequestMapping(value = "/vincular_bibliografia")
	public String vincular_bibliografia(ModelMap modelMap) {
		modelMap.addAttribute("disciplina",
				this.disciplinaService.find(Disciplina.class));
		return "disciplina/vincular_bibliografia";
	}

	@RequestMapping(value = "/{id}/vincular", method = RequestMethod.GET)
	public String vincular(@PathVariable("id") Integer id, ModelMap modelMap) {

		Disciplina disciplina = this.disciplinaService.find(Disciplina.class,
				id);
		List<Titulo> titulos = this.tituloService.find(Titulo.class);
		if (disciplina == null) {
			return "redirect:/disciplina/listar";

		}
		List<Bibliografia> bibliografias = disciplina.getBibliografias();
		listaIdTitulo = new ArrayList<Titulo>();
		complementar = new ArrayList<Titulo>();
		for (Bibliografia b : bibliografias) {
			if (b.getTipoBibliografia().equals("Básica")) {
				listaIdTitulo.add(b.getTitulo());
				titulos.remove(b.getTitulo());
			} else if (b.getTipoBibliografia().equals("Complementar")) {
				complementar.add(b.getTitulo());
				titulos.remove(b.getTitulo());
			}
		}
		modelMap.addAttribute("titulo", titulos);
		modelMap.addAttribute("basica", listaIdTitulo);
		modelMap.addAttribute("complementar", complementar);
		modelMap.addAttribute("disciplina", disciplina);
		return "disciplina/vincular_bibliografia";
	}

	@RequestMapping(value = "/vincular", method = RequestMethod.POST)
	public String atualizarVincular(@RequestParam("endereco[]") String teste) {
		// @Valid Disciplina disciplina, List<String> retorno ,BindingResult
		// result, RedirectAttributes redirectAttributes
		// if (result.hasErrors()) {
		// return "disciplina/editar";
		// }

		System.out.println("Passou aki");
		System.out.println(teste);
		System.out.println("************************");

		// disciplinaService.update(disciplina);
		// redirectAttributes.addFlashAttribute("info",
		// "Disciplina atualizada com sucesso.");
		return "redirect:/disciplina/listar";

	}

	public List<Bibliografia> atualizaOuCriaBibligrafia (String[] listaIdTitulo, List<Bibliografia> bibliografiasAseremModificadas, Disciplina disciplina, String TipoBibliografia){
		int id_titulo;
		for (int i = 0; i < listaIdTitulo.length; i++) {
			id_titulo = Integer.parseInt(listaIdTitulo[i]);
			for (int j = 0; j < bibliografiasAseremModificadas.size(); j++) {
				if (bibliografiasAseremModificadas.get(j).getTitulo().getId() == id_titulo) {
					if (!bibliografiasAseremModificadas.get(j).getTipoBibliografia().equals(TipoBibliografia)) {
						bibliografiasAseremModificadas.get(j).setTipoBibliografia(TipoBibliografia);
						bibliografiaService.update(bibliografiasAseremModificadas.get(j));
						bibliografiasAseremModificadas.remove(bibliografiasAseremModificadas.get(j));
						listaIdTitulo[i]=null;
						j=bibliografiasAseremModificadas.size()+1;
						
					}else{
						bibliografiasAseremModificadas.remove(bibliografiasAseremModificadas.get(j));
						listaIdTitulo[i]=null;
					}
					
				} 
			}
			if (listaIdTitulo[i]!=null){
				Bibliografia biblio = new Bibliografia();
				biblio.setDisciplina(disciplina);
				biblio.setTitulo(tituloService.find(Titulo.class, id_titulo));
				biblio.setTipoBibliografia(TipoBibliografia);
				bibliografiaService.save(biblio);
			}
		}
		
		return bibliografiasAseremModificadas;
	}
	
	@RequestMapping(value = "/teste")
	public String teste(@RequestParam("endereco") String enderecos, @RequestParam("idDiciplina") Integer idDiciplina) {
		System.out.println(enderecos);
		String[] parts = enderecos.split("A");
		System.out.println(parts.length);
		String basicaArray = parts[0];
		String[] basica = basicaArray.split(",");
		String complementarArray = parts[1];
		String[] complementar = complementarArray.split(",");

		Disciplina disciplina = this.disciplinaService.find(Disciplina.class,idDiciplina);
		List<Bibliografia> bibliografiaLista = disciplina.getBibliografias();
		
		bibliografiaLista = atualizaOuCriaBibligrafia(basica, bibliografiaLista, disciplina, "Básica");
		bibliografiaLista = atualizaOuCriaBibligrafia(complementar, bibliografiaLista, disciplina, "Complementar");
		for (int i = 0; i < bibliografiaLista.size(); i++) {
			bibliografiaService.delete(bibliografiaLista.get(i));
		}

		return "redirect:/disciplina/listar";
	}

}