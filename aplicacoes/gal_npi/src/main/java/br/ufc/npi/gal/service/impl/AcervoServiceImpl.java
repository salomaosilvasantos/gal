package br.ufc.npi.gal.service.impl;

import java.io.File;
import java.io.IOException;

import javax.inject.Named;

import org.springframework.web.multipart.MultipartFile;

import br.ufc.npi.gal.service.AcervoService;
@Named
public class AcervoServiceImpl implements AcervoService {

	@Override
	public boolean atulizarAcervo() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void analisarArquivo(MultipartFile multipartFile) {
		try {
			File arquivo = new File("");
			multipartFile.transferTo(arquivo);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//arquivo é o xls
	}

}
