package com.jwt.Filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MainFilter implements Filter {
	
	String usertype;

	public void destroy() {
	}

	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest request = (HttpServletRequest) req; 
        HttpServletResponse response = (HttpServletResponse) resp; 
//        HttpSession session = request.getSession(false);
        
        StringBuffer requestURL = request.getRequestURL();
        String completeURL = requestURL.toString();
        
        char[] c = completeURL.toCharArray();
        
        if(completeURL.contains("fonts") || completeURL.contains("css") || completeURL.contains("js") ||
        		completeURL.contains("admin") || completeURL.contains("customer") ||
        		completeURL.contains("home.jsp") || c[c.length - 1] == '/') {
        	//System.out.println("Passes: " + completeURL); 
        	chain.doFilter(request, response);
        	 
        }
       	
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
