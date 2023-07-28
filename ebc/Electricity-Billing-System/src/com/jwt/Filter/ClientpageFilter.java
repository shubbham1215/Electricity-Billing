package com.jwt.Filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.jwt.Exceptions.DBExceptions;
import com.jwt.Services.CustomerServices;
import com.mysql.cj.jdbc.exceptions.CommunicationsException;
      
public class ClientpageFilter implements Filter{  
	
    String customerid, usertype;
      
	public void init(FilterConfig arg0) throws ServletException {
		
	}  
          
    public void doFilter(ServletRequest req, ServletResponse resp,  
            FilterChain chain) throws IOException, ServletException {
    	
    	HttpServletRequest request = (HttpServletRequest) req; 
        HttpServletResponse response = (HttpServletResponse) resp; 
        HttpSession session = request.getSession(true); 
        
        System.out.println("Customer filter");
        
        try {
        	String type = (String) session.getAttribute("user_type"); 
        	
        	if(type.equals("admin")) {
        		session.invalidate();
        		session = request.getSession(true);
        	}
        }catch(Exception e) {
        	session = request.getSession(true);
        }
        
        Boolean status = (Boolean) session.getAttribute("customer_login_status");
        
        if(status != null && status == true) {
        	System.out.println("Customer Logged in");
        	chain.doFilter(request, response);
        }
        else {
	        usertype = "customer";
	        customerid = (String) request.getParameter("customerid"); 
	        
	        String message = null;
	        
	        try {
	        	CustomerServices service = new CustomerServices(customerid);
	        	service.CustomerAuthentication();
	        	session.setAttribute("customer_login_status", true);
	        	session.setAttribute("id", customerid);
	            session.setAttribute("user_type", usertype);
	        	chain.doFilter(req, resp);//sends request to next resource  
	        }
	        catch(CommunicationsException e){  
		        message = "Database could not be reached";
		        session.setAttribute("error_message", message);
		        session.setAttribute("user_type", usertype);
		        response.sendRedirect(request.getContextPath());  
	        }
	        catch(DBExceptions e){  
	        	session.setAttribute("error_message", e.toString());
	        	session.setAttribute("user_type", usertype);
		        response.sendRedirect(request.getContextPath());   
	        }
	        catch(Exception e){  
	        	message = "User could not be Authenticated! " + e;  
	        	session.setAttribute("error_message", message);
	        	session.setAttribute("user_type", usertype);
		        response.sendRedirect(request.getContextPath());   
	        } 
        }      
    }  
    
    public void destroy() {}
}  