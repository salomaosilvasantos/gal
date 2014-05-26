package com.companyname.springapp.web;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.companyname.springapp.service.ProductManager;

//anotación controlador
@Controller
public class InventoryController {

    protected final Log logger = LogFactory.getLog(getClass());

    //vou armazenar uma referência de ProductManager dentro do meu controlador para que ele possa passar as VIEWS informaçoes
    //sobre os produtos.
    @Autowired
    private ProductManager productManager;

    @RequestMapping(value="/hello.htm")
    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	String now = (new Date()).toString();
    	//msg console
        logger.info("Returning hello view with " + now);

        Map<String, Object> myModel = new HashMap<String, Object>();
        myModel.put("now", now);
        myModel.put("products", this.productManager.getProducts());
        //vou retornar um hashmap com quantos campos eu quiser.
        // view + chave + valor

        return new ModelAndView("hello", "model", myModel);
    }


    public void setProductManager(ProductManager productManager) {
        this.productManager = productManager;
    }
}