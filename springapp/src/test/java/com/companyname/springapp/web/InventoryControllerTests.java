package com.companyname.springapp.web;

import java.util.ArrayList;
import java.util.Map;

import static org.junit.Assert.*;

import org.junit.Test;
import org.springframework.web.servlet.ModelAndView;

import com.companyname.springapp.domain.Product;
import com.companyname.springapp.repository.InMemoryProductDao;
import com.companyname.springapp.repository.JPADisciplinaDao;
import com.companyname.springapp.repository.JPAProductDao;
import com.companyname.springapp.service.SimpleProductManager;


public class InventoryControllerTests {

	private JPADisciplinaDao curriculoDao;
	private  JPAProductDao productDao;
	
    @Test
    public void testHandleRequestView() throws Exception{		
        InventoryController controller = new InventoryController();

       // SimpleProductManager spm = new SimpleProductManager();
        SimpleProductManager spm = new SimpleProductManager(curriculoDao,productDao);
        spm.setProductDao(new InMemoryProductDao(new ArrayList<Product>()));
        controller.setProductManager(spm);
        //controller.setProductManager(new SimpleProductManager());
        ModelAndView modelAndView = controller.handleRequest(null, null);
      //verificando se ele me retorna a view home.jsp
        assertEquals("hello", modelAndView.getViewName());
        assertNotNull(modelAndView.getModel());
        Map<String, Object> modelMap = (Map) modelAndView.getModel().get("model");
        String nowValue = (String) modelMap.get("now");
        assertNotNull(nowValue);
    }
}