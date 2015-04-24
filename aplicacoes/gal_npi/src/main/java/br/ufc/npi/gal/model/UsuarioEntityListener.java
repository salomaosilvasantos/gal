package br.ufc.npi.gal.model;

import javax.persistence.PostLoad;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import br.ufc.quixada.npi.ldap.model.Usuario;
import br.ufc.quixada.npi.ldap.service.UsuarioService;

public class UsuarioEntityListener {
	
	@PostLoad
	public void loadUsuario(br.ufc.npi.gal.model.Usuario user) {
		@SuppressWarnings("resource")
		BeanFactory context = new ClassPathXmlApplicationContext("applicationContext.xml");
		UsuarioService usuarioService = (UsuarioService) context.getBean(UsuarioService.class);
		Usuario usuario = usuarioService.getByCpf(user.getCpf());
		
		user.setEmail(usuario.getEmail());
		user.setNome(usuario.getNome());
		user.setSiape(usuario.getSiape());
	}

}
