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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.ufc.npi.gal.model.Bibliografia;
import br.ufc.npi.gal.model.Disciplina;
import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.service.BibliografiaService;
import br.ufc.npi.gal.service.DisciplinaService;
import br.ufc.npi.gal.service.TituloService;
import br.ufc.npi.gal.service.impl.TituloServiceImpl;

@Controller
@RequestMapping("/disciplina")
public class DisciplinaController {

	@Inject
	private DisciplinaService disciplinaService;
	private List<Titulo> basica;
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
		basica = new ArrayList<Titulo>();
		complementar = new ArrayList<Titulo>();
		for (Bibliografia b : bibliografias) {
			if (b.getTipoBibliografia().equals("Básica")) {
				basica.add(b.getTitulo());
			} else if (b.getTipoBibliografia().equals("Complementar")) {
				complementar.add(b.getTitulo());
			}
		}
		modelMap.addAttribute("titulo", titulos);
		modelMap.addAttribute("basica", basica);
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

	@RequestMapping(value = "/teste")
	@ResponseBody
	public String teste(@RequestParam("endereco") String enderecos) {
		System.out.println(enderecos);
		String[] parts = enderecos.split("A");
		System.out.println(parts.length);
		String disciplinaId = parts[0];
		String basicaArray = parts[1];
		String[] basica = basicaArray.split(",");
		String complementarArray = parts[2];
		String[] complementar = complementarArray.split(",");

		Disciplina disciplina = this.disciplinaService.find(Disciplina.class,
				Integer.parseInt(disciplinaId));
		List<Bibliografia> bibliografiaLista = disciplina.getBibliografias();
		int id_titulo = Integer.parseInt(disciplinaId);
		for (int i = 0; i < basica.length; i++) {
			
			for (int j = 0; j < bibliografiaLista.size(); j++) {
				if (bibliografiaLista.get(j).getId_titulo() == id_titulo) {
					if (!bibliografiaLista.get(j).getTipoBibliografia()
							.equals("Básica")) {
						bibliografiaLista.get(j).setTipoBibliografia("Básica");
						bibliografiaService.update(bibliografiaLista.get(j));
					}
				} else {
					Bibliografia biblio = new Bibliografia();
					biblio.setId_disciplina(disciplina.getId());
					biblio.setId_titulo(id_titulo);
					biblio.setTipoBibliografia("Básica");
					bibliografiaService.save(biblio);
					
				}
			}

		}
		for (int i = 0; i < complementar.length; i++) {
			for (int j = 0; j < bibliografiaLista.size(); j++) {
				if (bibliografiaLista.get(j).getId_titulo() == id_titulo) {
					if (!bibliografiaLista.get(j).getTipoBibliografia()
							.equals("Complementar")) {
						bibliografiaLista.get(j).setTipoBibliografia("Complementar");
						bibliografiaService.update(bibliografiaLista.get(j));
					}
				} else {
					Bibliografia biblio = new Bibliografia();
					biblio.setId_disciplina(disciplina.getId());
					biblio.setId_titulo(id_titulo);
					biblio.setTipoBibliografia("Complementar");
					bibliografiaService.save(biblio);
					
				}
			}
		}

//		disciplina.setBibliografias(bibliografiaLista);
//		disciplinaService.update(disciplina);
		// bibliografiaService.update(bibliografiaLista);

		return "redirect:/disciplina/listar";
	}

}
