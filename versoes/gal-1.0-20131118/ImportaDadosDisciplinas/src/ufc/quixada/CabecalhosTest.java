package ufc.quixada;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.junit.Test;


public class CabecalhosTest {
	
	final String pattern = "\\d+\\s*\\.\\s*[a-zA-Z].*";
	
	@Test
	public void padraoTituloSecao() {
		Pattern patt = Pattern.compile(pattern);
		Matcher m = patt.matcher("11 . blá");
		assertTrue(m.matches());
	}
	
	@Test
	public void evitarSomenteNumeros() {
		Pattern patt = Pattern.compile(pattern);
		Matcher m = patt.matcher("2007.1");
		assertFalse(m.matches());
	}

}
