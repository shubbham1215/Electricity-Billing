package com.jwt.Clientservlet;
 
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.jwt.Exceptions.DBExceptions;
import com.jwt.Services.Bill;
import com.jwt.Services.CustomerServices;
import com.jwt.Services.LatestBill;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ClientServlet implements Servlet 
{
	String customerid = "";
    ServletConfig config = null; 
    
    // init method 
    public void init(ServletConfig sc) 
    { 
        config = sc; 
        System.out.println("in init");
    } 
  
    // service method 
    public void service(ServletRequest req, ServletResponse resp) 
        throws ServletException, IOException 
    { 
    	
    	HttpServletRequest request = (HttpServletRequest) req; 
        HttpServletResponse response = (HttpServletResponse) resp;
        HttpSession session = request.getSession(false); 
        
        StringBuffer requestURL = request.getRequestURL();
        String completeURL = requestURL.toString();
        
        customerid = (String) session.getAttribute("id");
        
        String[] arrOfStr = completeURL.split("/", 0); 
        
        System.out.println("Customer Servlet");
        System.out.println("Passes: " + completeURL); 
        
    
        switch(arrOfStr[arrOfStr.length - 1])
        {
            case "complaint":
            {
            	String name = request.getParameter("first_name");
            	String last_name = request.getParameter("last_name");
            	String email = request.getParameter("email");
            	String mobile = request.getParameter("mobile");
            	String amount = request.getParameter("amount");
            	String billno = request.getParameter("billno");
            	String description = request.getParameter("description");
            	
          
            	if(name == "" || last_name == "" || email == "" || mobile == "" || amount == "" || description == "" || billno == "") {
            		session.setAttribute("message", "Complaint was not submitted due to incomplete fields, Please try again!");
                	response.sendRedirect(request.getContextPath() + "/customer");
            	}
            	else {
            		CustomerServices service = new CustomerServices(customerid);
            		try {
						service.CustomerComplaint(billno, description, amount);
						session.setAttribute("message", "Complaint for Bill No.: " + billno + " submitted successfully!");
	            		response.sendRedirect(request.getContextPath() + "/customer");
					} catch (Exception e) {
						session.setAttribute("message", "Complaint was not submitted! :" + e.toString());
	                	response.sendRedirect(request.getContextPath() + "/customer");	
					}
            		
            	}
                break;
            }
            
            case "payment":
            {
            	LatestBill latestbill = (LatestBill) session.getAttribute("latestbill");
            	
            	String billno = latestbill.getBillno();
                
                CustomerServices service = new CustomerServices(customerid);
                
                try {
					service.CustomerPayment(billno);
					session.setAttribute("message", "Bill No: " + billno + ". Paid Successfully!");
					
					List<Bill> bills = null;
            		LatestBill latest_bill = null;

            		try {
            			latest_bill = service.FinalBillData();
            			session.setAttribute("latestbill", latest_bill);
						bills = service.CustomerBillHistory();
						session.setAttribute("billshistory", bills);
					} 
            		catch (ClassNotFoundException | DBExceptions | SQLException e) {
						e.printStackTrace();
					}
					
                	response.sendRedirect(request.getContextPath() + "/customer");
					
				} catch (Exception e1) {
					session.setAttribute("message", "Payment Unsuccessful! :" + e1.toString());
                	response.sendRedirect(request.getContextPath() + "/customer");	
				}
                
                break;
            }
            
            case "exit":
            {
            	System.out.println("In exit");
            	session.invalidate();
            	response.sendRedirect(request.getContextPath());
                break;
            }
            
            default:
            {
            	if(session.getAttribute("billshistory") != null && session.getAttribute("dropdownbills") != null && session.getAttribute("latestbill") != null) {
            		RequestDispatcher rd = request.getRequestDispatcher("customerHome.jsp");
                	rd.forward(request, response);
            	}
            	else {
            		CustomerServices service = new CustomerServices(customerid);
            		List<Bill> bills = null;
            		List<String> drop_bills = null;
            		LatestBill latest_bill = null;

            		try {
            			latest_bill = service.FinalBillData();
            			System.out.println(latest_bill.getFinalAmount());
            			session.setAttribute("latestbill", latest_bill);
						bills = service.CustomerBillHistory();
						session.setAttribute("billshistory", bills);
						drop_bills = service.CustomerBillsforComplaint();
						session.setAttribute("dropdownbills", drop_bills);
	            		RequestDispatcher rd = request.getRequestDispatcher("customerHome.jsp");
	                	rd.forward(request, response);
					} catch (Exception e) {
						RequestDispatcher rd = request.getRequestDispatcher("customerHomedead.jsp");
	                	rd.forward(request, response);
					}
            	}

            }
               
        }
    } 
  
    // destroy method 
    public void destroy() 
    { 
        System.out.println("in destroy"); 
    } 
    
    public String getServletInfo() 
    { 
        return "Server"; 
    } 
    
    public ServletConfig getServletConfig() 
    { 
        return config; // getServletConfig 
    } 
}