package br.ufc.npi.gal.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.ufc.npi.gal.model.Curso;
import br.ufc.npi.gal.model.DetalheMetaCalculada;
import br.ufc.npi.gal.model.Meta;
import br.ufc.npi.gal.model.MetaForm;
import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.service.CalculoMetaService;
import br.ufc.npi.gal.service.CursoService;
import br.ufc.npi.gal.service.MetaCalculada;
import br.ufc.npi.gal.service.MetaService;
import br.ufc.npi.gal.service.ResultadoCalculo;
import br.ufc.npi.gal.service.TituloService;

@Controller
@RequestMapping("meta")
public class MetaController {

	@Inject
	private CalculoMetaService calculo;

	@Inject
	private TituloService tituloService;

	@Inject
	private CursoService cursoService;

	
	@Inject
	private MetaService metaService;

	@RequestMapping(value = "/listar", method = RequestMethod.GET)
	public String listar(ModelMap modelMap) {

		modelMap.addAttribute("resultados", calculo.gerarCalculo());
		modelMap.addAttribute("cursos", cursoService.find(Curso.class));
		modelMap.addAttribute("idCurso", -1);

		return "meta/listar";
	}

	@RequestMapping(value = "/{id}/listar", method = RequestMethod.GET)
	public String listarByCurso(@PathVariable("id") Integer id,
			ModelMap modelMap, RedirectAttributes redirectAttributes) {

		List<Curso> cursos = cursoService.find(Curso.class);
		List<ResultadoCalculo> resultados = calculo.gerarCalculo();
		Curso curso = cursoService.find(Curso.class, id);

		List<ResultadoCalculo> resultadosCurso = new ArrayList<ResultadoCalculo>();
		List<MetaCalculada> metasCalculadas;

		for (ResultadoCalculo resultadoCalculo : resultados) {
			metasCalculadas = new ArrayList<MetaCalculada>();

			for (MetaCalculada metaCalculada : resultadoCalculo
					.getMetasCalculadas()) {
				boolean flag = false;
				for (DetalheMetaCalculada detalhePar : metaCalculada
						.getDetalhePar()) {

					if (detalhePar.getCurso().equals(curso.getNome())) {
						flag = true;
						break;

					}

				}
				for (DetalheMetaCalculada detalheImpar : metaCalculada
						.getDetalheImpar()) {

					if (detalheImpar.getCurso().equals(curso.getNome())) {
						flag = true;
						break;

					}

				}
				if (flag) {
					metasCalculadas.add(metaCalculada);

					flag = false;

				}
			}
			if (!metasCalculadas.isEmpty()) {
				resultadosCurso.add(new ResultadoCalculo(resultadoCalculo
						.getTitulo(), metasCalculadas));
			}

		}

		modelMap.addAttribute("idCurso", curso.getId());
		modelMap.addAttribute("cursos", cursos);
		modelMap.addAttribute("resultados", resultadosCurso);

		return "meta/listar";

	}

	@RequestMapping(value = "/{id}/detalhe/{meta}", method = RequestMethod.GET)
	public String tituloByDetalhe(@PathVariable("id") Integer id,
			@PathVariable("meta") String meta, ModelMap modelMap,
			RedirectAttributes redirectAttributes) {

		List<ResultadoCalculo> resultados = calculo.gerarCalculo();
		for (ResultadoCalculo resultadoCalculo : resultados) {

			if (resultadoCalculo.getTitulo().getId().equals(id)) {

				for (MetaCalculada metaCalculada : resultadoCalculo
						.getMetasCalculadas()) {

					if (metaCalculada.getNome().trim().equals(meta)
							&& metaCalculada.getCalculo() > 0.1) {

						modelMap.addAttribute("titulo",
								this.tituloService.find(Titulo.class, id));
						modelMap.addAttribute("metaCalculada", metaCalculada);

						return "meta/detalhe";

					}

				}

			}

		}
		redirectAttributes.addFlashAttribute("info",
				"Esse titulo não possui meta.");

		return "redirect:/meta/listar";

	}

	@RequestMapping(value = "/configurar")
	public String configurar(ModelMap modelMap) {

		modelMap.addAttribute("metas", metaService.getMeta());
		return "meta/configurar";
	}

	@RequestMapping(value = "/configurar", method = RequestMethod.POST)
	public String configurar(@Valid MetaForm metaForm, BindingResult result,
			ModelMap modelMap, RedirectAttributes redirectAttributes) {

		if (result.hasErrors()) {
			return "meta/configurar";
		}
		for (Meta meta : metaForm.getMetas()) {
			try {
				metaService.update(meta);
			} catch (Exception e) {
				modelMap.addAttribute("metas", metaForm.getMetas());
				redirectAttributes
						.addFlashAttribute("error",
								"Já existe uma meta com esse nome. Meta não configurada.");
				return "redirect:/meta/configurar";

			}

		}
		redirectAttributes.addFlashAttribute("info",
				"Meta configurada com sucesso.");
		return "redirect:/meta/listar";
	}

	@RequestMapping(value = "/downloadMetaDetalhada")
	public String downloadMetaDetalhada(ModelMap modelMap) {

		modelMap.addAttribute("metas", metaService.getMeta());
		return "meta/downloadMetaDetalhada";
	}

	@RequestMapping(value = "/downloadMetaDetalhada/{meta}", method = RequestMethod.GET)
	public String downloadMetaDetalhada(ModelMap modelMap,
			RedirectAttributes redirectAttribute, HttpServletResponse response, @PathVariable("meta") String meta) {
		String csvFileName = "metaDetalhada_" + meta + ".csv";
		InputStream is = null;
		File file = null;
		try {
			file = criaRelatorioMetaDetalhado(meta);

			is = new FileInputStream(file);
			response.setContentType("text/csv");
			String headerKey = "Content-Disposition";
			String headerValue = String.format("attachment; filename=\"%s\"",
					csvFileName);
			response.setHeader(headerKey, headerValue);
			
			OutputStream out = response.getOutputStream();
			IOUtils.copy(is, out);
			out.flush();

			out.close();
			is.close();
			file.delete();
		} catch (Exception e) {

			redirectAttribute.addFlashAttribute("error", "Problemas ao realizar download. Erro: "+ e.getMessage());
			modelMap.addAttribute("metas", metaService.getMeta());
			return "redirect:/meta/downloadMetaDetalhada";
		}
		
		return null;

	}

	public File criaRelatorioMetaDetalhado(String meta) throws IOException {
	
		CriaArquivoCsvETxt cria = new CriaArquivoCsvETxt();
		BufferedWriter str = cria.abreFile("metaDetalhada_" + meta + ".csv");
		DecimalFormat df = new DecimalFormat("#,###.0");
		String linha = "Nome do Titulo; Isbn;Semestre;Curso;Disciplina;Tipo de Bibliografia;"+ meta;
		cria.escreveFile(str, linha);
		List<DetalheMetaCalculada> metacalculada;
		List<ResultadoCalculo> resultados = downloadMetaDetalhadaByMeta(meta);
		for (ResultadoCalculo element : resultados) {
			metacalculada = null;
			metacalculada = element.getMetaCalculada().getDetalheImpar();
			if (!metacalculada.isEmpty()) {
				for (DetalheMetaCalculada detalheMetaCalculada : metacalculada) {
					linha = "\"" + element.getTitulo().getNome() + "\";\""
							+ element.getTitulo().getIsbn()
							+ "\";\"Meta Impar\";\""
							+ detalheMetaCalculada.getCurso() + "\";\""
							+ detalheMetaCalculada.getDisciplina() + "\";\""
							+ detalheMetaCalculada.getTipoBibliografia()
							+ "\";\""
							+ df.format(detalheMetaCalculada.getCalculo())
							+ "\"";
					cria.escreveFile(str, linha);
				}
			}

			metacalculada = null;
			metacalculada = element.getMetaCalculada().getDetalhePar();
			if (!metacalculada.isEmpty()) {
				for (DetalheMetaCalculada detalheMetaCalculada : metacalculada) {
					linha = "\"" + element.getTitulo().getNome() + "\";\""
							+ element.getTitulo().getIsbn()
							+ "\";\"Meta Par\";\""
							+ detalheMetaCalculada.getCurso() + "\";\""
							+ detalheMetaCalculada.getDisciplina() + "\";\""
							+ detalheMetaCalculada.getTipoBibliografia()
							+ "\";\""
							+ df.format(detalheMetaCalculada.getCalculo())
							+ "\"";

					cria.escreveFile(str, linha);
				}
			}

		}
		cria.fechaFile(str);
		return cria.getFile();
	}

	public List<ResultadoCalculo> downloadMetaDetalhadaByMeta(String nomeMeta) {
		List<ResultadoCalculo> resultados = new ArrayList<ResultadoCalculo>();

		for (ResultadoCalculo resultadoCalculo : calculo.gerarCalculo()) {

			for (MetaCalculada metaCalculada : resultadoCalculo
					.getMetasCalculadas()) {
				if (metaCalculada.getNome().trim().equals(nomeMeta)) {

					resultados.add(new ResultadoCalculo(resultadoCalculo
							.getTitulo(), metaCalculada));
					break;
				}

			}
		}
		return resultados;

	}

	public CalculoMetaService getCalculo() {
		return calculo;
	}

	public void setCalculo(CalculoMetaService calculo) {
		this.calculo = calculo;
	}

}
