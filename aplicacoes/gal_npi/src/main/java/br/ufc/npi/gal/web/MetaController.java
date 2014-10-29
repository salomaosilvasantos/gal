package br.ufc.npi.gal.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.ufc.npi.gal.model.Curso;
import br.ufc.npi.gal.model.DetalheMetaCalculada;
import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.service.CalculoMetaService;
import br.ufc.npi.gal.service.CursoService;
import br.ufc.npi.gal.service.ResultadoCalculo;
import br.ufc.npi.gal.service.TituloService;

import java.util.logging.Level;
import java.util.logging.Logger;

@Controller
@RequestMapping("meta")
public class MetaController {
	private final static Logger LOGGER = Logger.getLogger(MetaController.class.getName());
	
	@Inject
	private CalculoMetaService calculo;

	@Inject
	private TituloService tituloService;

	@Inject
	private CursoService cursoService;

	public MetaController() {
		super();

	}

	public File criaRelatorioMetaDetalhado() {
		CriaArquivoCsvETxt cria = new CriaArquivoCsvETxt();
		BufferedWriter str = cria.abreFile("metaDetalhada.csv");
		DecimalFormat df = new DecimalFormat("#,###.0");
		String linha = new String();
		linha = "Nome do Titulo; Isbn;Semestre;Curso;Disciplina;Tipo de Bibliografia;Meta";
		cria.escreveFile(str, linha);
		List<DetalheMetaCalculada> metacalculada;
		List<ResultadoCalculo> resultados = calculo.gerarCalculo();
		for (ResultadoCalculo element : resultados) {
			metacalculada = null;
			metacalculada = element.getMetaCalculada().getDetalheImpar();
			if (!metacalculada.isEmpty()) {
				for (DetalheMetaCalculada detalheMetaCalculada : metacalculada) {
					linha = "\"" + element.getTitulo().getNome() + "\";\""
							+ element.getTitulo().getIsbn() + "\";\"Meta Impar\";\""
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
							+ element.getTitulo().getIsbn() + "\";\"Meta Par\";\""
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

	@RequestMapping(value = "/downloadMetaDetalhada", method = RequestMethod.GET)
	public void downloadMetaDetalhada(ModelMap modelMap,
			HttpServletResponse response, HttpSession session) {
		String csvFileName = "metaDetalhada.csv";
		InputStream is = null;
		File file = criaRelatorioMetaDetalhado();
		try {

			is = new FileInputStream(file);
			response.setContentType("text/csv");
			String headerKey = "Content-Disposition";
			String headerValue = String.format("attachment; filename=\"%s\"",
					csvFileName);
			response.setHeader(headerKey, headerValue);
			IOUtils.copy(is, response.getOutputStream());
			response.flushBuffer();
		} catch (FileNotFoundException e1) {

			LOGGER.setLevel(Level.INFO);
			LOGGER.severe(e1.getMessage());
		} catch (IOException e) {

			LOGGER.setLevel(Level.INFO);
			LOGGER.severe(e.getMessage());
		} finally {
			try {
				is.close();
				file.delete();
			} catch (IOException e) {

				LOGGER.setLevel(Level.INFO);
				LOGGER.severe(e.getMessage());
			}
		}

	}

	@RequestMapping(value = "/listar", method = RequestMethod.GET)
	public String listar(ModelMap modelMap) {
		List<ResultadoCalculo> resultados = calculo.gerarCalculo();
		List<Curso> cursos = cursoService.find(Curso.class);
		modelMap.addAttribute("resultados", resultados);
		modelMap.addAttribute("cursos", cursos);
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

		for (ResultadoCalculo resultadoCalculo : resultados) {
			boolean flag = false;

			for (DetalheMetaCalculada detalhePar : resultadoCalculo
					.getMetaCalculada().getDetalhePar()) {

				if (detalhePar.getCurso().equals(curso.getNome())) {
					flag = true;
					break;

				}

			}
			for (DetalheMetaCalculada detalheImpar : resultadoCalculo
					.getMetaCalculada().getDetalheImpar()) {

				if (detalheImpar.getCurso().equals(curso.getNome())) {
					flag = true;
					break;

				}

			}
			if (flag) {

				resultadosCurso.add(new ResultadoCalculo(resultadoCalculo
						.getTitulo(), resultadoCalculo.getMetaCalculada()));
				flag = false;

			}
		}
		modelMap.addAttribute("idCurso", curso.getId());
		modelMap.addAttribute("cursos", cursos);
		modelMap.addAttribute("resultados", resultadosCurso);

		return "meta/listar";

	}

	@RequestMapping(value = "/{id}/detalhe", method = RequestMethod.GET)
	public String tituloByDetalhe(@PathVariable("id") Integer id,
			ModelMap modelMap, RedirectAttributes redirectAttributes) {
		Titulo titulo;
		List<ResultadoCalculo> resultados = calculo.gerarCalculo();
		for (ResultadoCalculo resultadoCalculo : resultados) {

			if (resultadoCalculo.getTitulo().getId().equals(id)) {
				if (resultadoCalculo.getMetaCalculada().getCalculo() > 0.1) {
					titulo = this.tituloService.find(Titulo.class, id);
					modelMap.addAttribute("titulo", titulo);
					modelMap.addAttribute("metaCalculada",
							resultadoCalculo.getMetaCalculada());

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

}
