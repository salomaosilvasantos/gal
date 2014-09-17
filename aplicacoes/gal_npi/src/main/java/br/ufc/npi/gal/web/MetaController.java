package br.ufc.npi.gal.web;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.service.CalculoMetaService;
import br.ufc.npi.gal.service.ResultadoCalculo;
import br.ufc.npi.gal.service.TituloService;

@Controller
@RequestMapping("meta")
public class MetaController {

	@Inject
	private CalculoMetaService calculo;

	@Inject
	private TituloService tituloService;

	private List<ResultadoCalculo> resultados;

	@RequestMapping(value = "/listar", method = RequestMethod.GET)
	public String listar(ModelMap modelMap) {
		resultados = calculo.gerarCalculo();
		modelMap.addAttribute("resultados", resultados);
		return "meta/listar";
	}

	@RequestMapping(value = "/{id}/detalhe", method = RequestMethod.GET)
	public String tituloByDetalhe(@PathVariable("id") Integer id,
			ModelMap modelMap, RedirectAttributes redirectAttributes) {
		Titulo titulo; 
		for (ResultadoCalculo resultadoCalculo : resultados) {

			if (resultadoCalculo.getTitulo().getId().equals(id)) {
				if (resultadoCalculo.getMetaCalculada().getCalculo() > 0.1) {
					titulo = this.tituloService.find(Titulo.class, id);
					modelMap.addAttribute("titulo", titulo);
					modelMap.addAttribute("metaCalculada", resultadoCalculo.getMetaCalculada());

					return "meta/detalhe";
				}

			}

		}
		redirectAttributes.addFlashAttribute("info",
				"Esse titulo não possui meta.");
		return "redirect:/meta/listar";

	}

	public CalculoMetaService getCalculo() {
		return calculo;
	}

	public void setCalculo(CalculoMetaService calculo) {
		this.calculo = calculo;
	}

	public List<ResultadoCalculo> getResultados() {
		return resultados;
	}

	public void setResultados(List<ResultadoCalculo> resultados) {
		this.resultados = resultados;
	}

}
