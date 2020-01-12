package cn.offcn.exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

public class OAHandlerException implements HandlerExceptionResolver{

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {

		    ex.printStackTrace();
		    
		    String message=null;
		    
		    if(ex instanceof OAException) {
		    	message=ex.getMessage();
		    }else {
		    	message="未知错误";
		    }
		    
		    //request.setAttribute("message", message);
		    ModelAndView mv=new ModelAndView();
		    mv.addObject("message", message);
		    mv.setViewName("forward:/error.jsp");
		
		return mv;
	}

}
