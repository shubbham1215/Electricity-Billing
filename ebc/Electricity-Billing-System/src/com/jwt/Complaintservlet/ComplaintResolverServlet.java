package com.jwt.Complaintservlet;


import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



public class ComplaintResolverServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String username = "", password = "";
	ServletConfig config = null; 
	
	public void init(ServletConfig sc) 
    { 
        config = sc; 
        System.out.println("in init"); 
    }
	
	public void service(ServletRequest req, ServletResponse resp) 
	        throws ServletException, IOException 
	    { 
	    	
	    	HttpServletRequest request = (HttpServletRequest) req; 
	        HttpServletResponse response = (HttpServletResponse) resp;
	        HttpSession session = request.getSession(false); 
	        
	        StringBuffer requestURL = request.getRequestURL();
	        String completeURL = requestURL.toString();
	        
	        username = (String) session.getAttribute("id");
	        password = (String) session.getAttribute("pass");
	        
	        String[] arrOfStr = completeURL.split("/", 0); 
	        
	        System.out.println("Complaint Servlet");
	        System.out.println("Passes: " + completeURL); 
	        
	        RequestDispatcher rd = request.getRequestDispatcher("Complaint.jsp");
        	rd.forward(request, response);
	    }
	
	

    public void destroy() 
    { 
        System.out.println("in destroy"); 
    } 
    
    public String getServletInfo() 
    { 
        return "ComplaintServer"; 
    } 
    
    public ServletConfig getServletConfig() 
    { 
        return config; // getServletConfig 
    }

}
