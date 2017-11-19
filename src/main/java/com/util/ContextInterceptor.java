package com.util;

import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.mvc.WebContentInterceptor;

public class ContextInterceptor extends WebContentInterceptor{

		
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws ServletException{
		try{
			RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
			Map<String, Object> map =(Map<String, Object>)requestAttributes.getAttribute("loginInfo", RequestAttributes.SCOPE_SESSION);
			
			String reqUrl = request.getRequestURL().toString();
			
			System.out.println("reqUrl -=================== " +reqUrl + " // X-Requested-With====== " +request.getHeader("X-Requested-With"));
			
			if(reqUrl.indexOf("/com/login/") > 0 || reqUrl.indexOf("/resources/") > 0){
				return true;
			}
			if(map != null){
				System.out.println(" not nullnullnullnullnullnullnullnullnullnullnullnullnullnullnull");
				 //modelAndView.setViewName("/login/login.jsp");
				 //
				//response.sendRedirect("/com/loginPage");
				//return false;
				
				return true;
			}
		}catch(Exception e){
			System.out.println("eeeeeeeeeeeeee == " +e.toString());
		}

		System.out.println("nullnullnullnullnullnullnullnullnullnullnullnullnullnullnull");
		ModelAndView modelAndView = new ModelAndView("/login/login");
		
		System.out.println("modelAndView == " +modelAndView.toString());
		
		// /com/loginPage
		//modelAndView.setViewName("/login/login.jsp");
		/*if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            modelAndView.setViewName("/common/login/LoginAjax.jsp");
        } else {
            modelAndView.setViewName("/common/login/Login.jsp");
        }*/

        throw new ModelAndViewDefiningException(modelAndView);
			
		
		
		//System.out.println("returnreturnreturnreturnreturnreturn == ");
		//return true;
    }
	
	//System.out.println("ddddddddddddddd");
	/*if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
        modelAndView.setViewName("/common/login/LoginAjax.jsp");
    } else {
        modelAndView.setViewName("/common/login/Login.jsp");
    }*/
}
