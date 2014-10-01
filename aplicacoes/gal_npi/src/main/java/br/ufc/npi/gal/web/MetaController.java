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

@Controller
@RequestMapping("meta")
public class MetaController {

	@Inject
	private CalculoMetaService calculo;

	@Inject
	private TituloService tituloService;

	@Inject
	private CursoService cursoService;

	private List<ResultadoCalculo> resultados;

	private List<ResultadoCalculo> resultadosCurso;

	private List<Curso> cursos;

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
		for (ResultadoCalculo element : resultados) {
			metacalculada = null;
			metacalculada = element.getMetaCalculada().getDetalheImpar();
			if (!metacalculada.isEmpty()) {
				linha = "\"" + element.getTitulo().getNome() + "\";\""
						+ element.getTitulo().getIsbn() + "\";Meta Impar";
				cria.escreveFile(str, linha);
				for (DetalheMetaCalculada detalheMetaCalculada : metacalculada) {
					linha = "\"\";\"\";\"\";\""
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
				linha = "\"" + element.getTitulo().getNome() + "\";\""
						+ element.getTitulo().getIsbn() + "\";Meta Par";

				cria.escreveFile(str, linha);

				for (DetalheMetaCalculada detalheMetaCalculada : metacalculada) {
					linha = "\"\";\"\";\"\";\""
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
			// creates mock data
			String headerKey = "Content-Disposition";
			String headerValue = String.format("attachment; filename=\"%s\"",
					csvFileName);
			response.setHeader(headerKey, headerValue);
			IOUtils.copy(is, response.getOutputStream());
			response.flushBuffer();
		} catch (FileNotFoundException e1) {

			e1.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		} finally {
			try {
				is.close();
				file.delete();
			} catch (IOException e) {

				e.printStackTrace();
			}
		}

	}

	@RequestMapping(value = "/{id}/listar", method = RequestMethod.GET)
	public String listarByCurso(@PathVariable("id") Integer id,
			ModelMap modelMap, RedirectAttributes redirectAttributes) {

		if (id == -1) {
			cursos = cursoService.find(Curso.class);

			if (resultados == null) {

				resultados = calculo.gerarCalculo();

			}
			modelMap.addAttribute("idCurso", id);
			modelMap.addAttribute("cursos", cursos);
			modelMap.addAttribute("resultados", resultados);

		} else {
			this.resultadosCurso = new ArrayList<ResultadoCalculo>();

			for (ResultadoCalculo resultadoCalculo : resultados) {
				boolean flag = false;

				for (DetalheMetaCalculada detalhePar : resultadoCalculo
						.getMetaCalculada().getDetalhePar()) {

					if (detalhePar.getCurso().equals(cursos.get(id).getNome())) {
						flag = true;
					}

				}
				for (DetalheMetaCalculada detalheImpar : resultadoCalculo
						.getMetaCalculada().getDetalheImpar()) {

					if (detalheImpar.getCurso()
							.equals(cursos.get(id).getNome())) {
						flag = true;

					}

				}
				if (flag == true) {

					resultadosCurso.add(new ResultadoCalculo(resultadoCalculo
							.getTitulo(), resultadoCalculo.getMetaCalculada()));
					flag = false;
				}
			}
			modelMap.addAttribute("idCurso", id);
			modelMap.addAttribute("cursos", cursos);
			modelMap.addAttribute("resultados", resultadosCurso);

		}

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
					modelMap.addAttribute("metaCalculada",
							resultadoCalculo.getMetaCalculada());

					return "meta/detalhe";
				}

			}

		}
		redirectAttributes.addFlashAttribute("info",
				"Esse titulo não possui meta.");
		return "redirect:/meta/-1/listar";

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
