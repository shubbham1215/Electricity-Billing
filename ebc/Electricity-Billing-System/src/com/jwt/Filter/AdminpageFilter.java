package com.jwt.Filter;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.jwt.Exceptions.DBExceptions;
import com.jwt.Services.AdminServices;
import com.mysql.cj.jdbc.exceptions.CommunicationsException;
      
public class AdminpageFilter implements Filter{  
	
	String username, password, usertype;
      
	public void init(FilterConfig arg0) throws ServletException {
	}  

	public void doFilter(ServletRequest req, ServletResponse resp, 
			FilterChain chain) throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) req; 
        HttpServletResponse response = (HttpServletResponse) resp;
        HttpSession session = request.getSession(true);
        
        System.out.println("Admin filter");
        
        try {
        	String type = (String) session.getAttribute("user_type"); 
        	
        	if(type.equals("customer")) {
        		session.invalidate();
        		session = request.getSession(true);
        	}
        }catch(Exception e) {
        }
        
        Boolean status = (Boolean) session.getAttribute("admin_login_status");
        
        if(status != null && status == true) {
        	System.out.println("Admin Logged in");
        	chain.doFilter(request, response);
        }
        else {
        	usertype = "admin";
        	username = request.getParameter("userName"); 
        	password = request.getParameter("password");
        
        	String message = null;    
        
	        try {
	        	AdminServices service = new AdminServices(username, password);
	            service.AdminAuthentication();
	            session.setAttribute("admin_login_status", true);
	            session.setAttribute("id", username);
	            session.setAttribute("pass", password);
	            session.setAttribute("user_type", usertype);
	        	chain.doFilter(request, response); //sends request to next resource  
	        }
	        catch(CommunicationsException e){  
		        message = "Database could not be reached";
		        session.setAttribute("error_message", message);
		        session.setAttribute("user_type", usertype);
		        response.sendRedirect(request.getContextPath()); 
	        }
	        catch(SQLException e){  
	        	message = "Username/ Password Incorrect!";  
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
	        	message = "User could not be Authenticated!" + e;  
	        	session.setAttribute("error_message", message);
		        session.setAttribute("user_type", usertype);
		        response.sendRedirect(request.getContextPath());   
	        } 
        }       
    }  
	
    public void destroy() {}
}  