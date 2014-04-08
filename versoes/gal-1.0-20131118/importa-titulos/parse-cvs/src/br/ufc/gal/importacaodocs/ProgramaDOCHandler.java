package br.ufc.gal.importacaodocs;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import ufc.quixada.Disciplina.Atributo;

public class ProgramaDOCHandler extends DefaultHandler {

	//private static final String SECAO_PROGRAMA_PATTERN_old = "\\d+\\s*\\..*";
	private static final String SECAO_PROGRAMA_PATTERN = "\\d+\\s*\\.\\s*[a-zA-Z].*";
	
	Document documento;
	Element raiz;
	Element secaoAtual;
	public enum Sinalizador {IGNORAR, PROXIMO, ATESECAO};
	Sinalizador sinalAtual = Sinalizador.IGNORAR;
	Atributo atributoSendoLido;
	Disciplina disc = new Disciplina();

	public ProgramaDOCHandler(){
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		try {
			//Abrindo a conexão com o documento.
			documento = dbf.newDocumentBuilder().newDocument();
			raiz = documento.createElement("root");
			documento.appendChild(raiz);
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} 
	}
	
	public void executar(String arquivo) {
		//Criando uma factory e o parser.
		SAXParserFactory spf = SAXParserFactory.newInstance();
		SAXParser parser; 
		try {
			parser = spf.newSAXParser();
			parser.parse(arquivo, this);			
		} catch (SAXException e) {
			System.out.println("SAX exception = [[" + e.getMessage() + "]]");
		} catch (IOException e) {
			System.out.println("I/O exception = [[" + e.getMessage() + "]]");
		} catch (ParserConfigurationException e) {
			System.out.println("ParserConfig exception = [[" + e.getMessage() + "]]");
		}
	}

	public void startDocument() throws SAXException {
	}

	public void endDocument() throws SAXException {
		if(secaoAtual != null){
			raiz.appendChild(secaoAtual);
		}
		echo(documento);
		//System.out.println("+++++++++++++++++++++++++++++++++++++++++++\n" + disc);
	}

	public void startElement(String uri, String localName,
			String qName, Attributes attributes) throws SAXException {		
	}

	public void endElement(String uri, String localName, String qName)
	throws SAXException {
	}

	public void characters(char ch[], int start, int length)
	throws SAXException {
		String texto = new String(ch, start, length);
		
		Pattern patt = Pattern.compile(SECAO_PROGRAMA_PATTERN);
		Matcher m = patt.matcher(texto);
		if(m.matches()){
			//System.out.println("SECAO" + texto);
			inicioSecao(texto);
		} else {
			incorporaSecao(texto);
		}
	}

	private void incorporaSecao(String texto) {
		if(secaoAtual != null){
			secaoAtual.appendChild(documento.createTextNode(texto));
		}
	}

	private void inicioSecao(String texto) {
		if(secaoAtual != null){
			raiz.appendChild(secaoAtual);
		}
		secaoAtual = documento.createElement("secao");
		secaoAtual.setAttribute("titulo", texto);
	}
	
	
	private void infoNo(Node n) {
		out(" nodeName=\"" + n.getNodeName() + "\"");
		String val = n.getNamespaceURI();
		if (val != null) {
			out(" uri=\"" + val + "\"");
		}

		val = n.getPrefix();

		if (val != null) {
			out(" pre=\"" + val + "\"");
		}

		val = n.getLocalName();
		if (val != null) {
			out(" local=\"" + val + "\"");
		}

		val = n.getNodeValue();
		if (val != null) {
			out(" nodeValue=");
			if (val.trim().equals("")) {
				// Whitespace
				out("[WS]");
			}
			else {
				out("\"" + n.getNodeValue() + "\"");
			}
		}
	}
	private void echo(Node n) {
	    
	    int type = n.getNodeType();

	    switch (type) {
	        case Node.ATTRIBUTE_NODE:
	            break;

	        case Node.ELEMENT_NODE:
	        	if(sinalAtual.equals(Sinalizador.ATESECAO)){
	        		sinalAtual = Sinalizador.IGNORAR;
	        	}
	        	NamedNodeMap atts = n.getAttributes();
	            for (int i = 0; i < atts.getLength(); i++) {
	                Node att = atts.item(i);
	                echo(att);
	            }
	            break;

	        case Node.TEXT_NODE:
	            out("TEXT = " + n.getNodeValue());
	            if(sinalAtual.equals(Sinalizador.IGNORAR)){
	            	verificaTextoDoNo(n.getNodeValue());
	            }
	            else
	            {
	            	disc.concatenar(atributoSendoLido, n.getNodeValue());
	            	if (sinalAtual.equals(Sinalizador.PROXIMO)) {
	            		sinalAtual = Sinalizador.IGNORAR;
	            	}
	            }
	            break;

	        default:
	            out("UNSUPPORTED NODE: " + type);
	            infoNo(n);
	            break;
	    }

	    for (Node child = n.getFirstChild(); child != null; child = child.getNextSibling()) {
	        echo(child);
	    }
	}
	private void verificaTextoDoNo(String nodeValue) {
		if(nodeValue.indexOf("4. Nome da Disciplina:") >= 0){
			sinalAtual = Sinalizador.PROXIMO;
			atributoSendoLido = Atributo.NOME;
			return;
		}
		if(nodeValue.indexOf("5. Código") >= 0){
			sinalAtual = Sinalizador.PROXIMO;
			atributoSendoLido = Atributo.CODIGO;
			return;
		}
		if(nodeValue.indexOf("Carga Horária Total") >= 0){
			sinalAtual = Sinalizador.PROXIMO;
			atributoSendoLido = Atributo.CARGA;
			return;
		}
		if(nodeValue.indexOf("11. Ementa") >= 0){
			sinalAtual = Sinalizador.ATESECAO;
			atributoSendoLido = Atributo.EMENTA;
			return;
		}
		if(nodeValue.indexOf("13. Bibliografia") >= 0){
			sinalAtual = Sinalizador.ATESECAO;
			atributoSendoLido = Atributo.BIBLIO;
			return;
		}
		
	}

	public void out(String s){ /*System.out.println(s);*/ };
	
}
