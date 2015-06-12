package br.ufc.npi.gal.service;

import java.io.IOException;
import java.util.Collection;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import br.ufc.npi.gal.model.Usuario;
import br.ufc.quixada.npi.ldap.model.Constants;
import br.ufc.quixada.npi.ldap.service.UsuarioService;

public class SimpleUrlAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
	
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	
	@Inject
	private UsuarioService usuarioService;
	
	@Inject
	private UsuarioServiceGal usuarioServiceGal;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		boolean usuarioValido = false;
        for (GrantedAuthority grantedAuthority : authorities) {
        	usuarioValido = true;
            if (grantedAuthority.getAuthority().equals("ROLE_" + Constants.AFFILIATION_BIBLIOTECARIO) || grantedAuthority.getAuthority().equals("ROLE_" + Constants.AFFILIATION_COORDENADOR_CURSO)) {
            	usuarioValido = true;
                break;
            }
        }
        if(!usuarioValido) {
        	redirectStrategy.sendRedirect(request, response, "/loginfailed");
        }
        
        RegistraUsuario(getUsuarioLogado(request.getSession()));
               
        redirectStrategy.sendRedirect(request, response, "/inicio");
	}
	
	private void RegistraUsuario(Usuario usuarioLogado) {
		Usuario user = usuarioServiceGal.getUsuarioByLogin(usuarioLogado.getCpf());
		if(user==null) {
			usuarioServiceGal.save(usuarioLogado);
		}
	}

	private Usuario getUsuarioLogado(HttpSession session) {
		if (session.getAttribute("usuario") == null) {
			br.ufc.quixada.npi.ldap.model.Usuario user = usuarioService.getByCpf(SecurityContextHolder.getContext().getAuthentication().getName().toString());

			Usuario usuario = new Usuario();
			usuario.setCpf(user.getCpf());
			usuario.setEmail(user.getEmail());
			usuario.setNome(user.getNome());
			usuario.setSiape(user.getSiape());

			session.setAttribute("usuario", usuario);
		}
		return (Usuario) session.getAttribute("usuario");
	}
	

}
