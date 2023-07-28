package com.jwt.Adminservlet;
 
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.jwt.Exceptions.DBExceptions;
import com.jwt.Services.AdminServices;
import com.jwt.Services.Bill;
import com.jwt.Services.Complaint;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.io.output.*;

import au.com.bytecode.opencsv.CSVReader;


@MultipartConfig(fileSizeThreshold = 128,
maxFileSize = 1024 * 1024 * 5, 
maxRequestSize = 1024 * 1024 * 5 * 5)
public class AdminServlet implements Servlet 
{
	String username = "", password = "";
    ServletConfig config = null; 
    
    // init method 
    public void init(ServletConfig sc) 
    { 
        config = sc; 
        System.out.println("in init"); 
    } 
    
	private String getFileName(Part part) {
	    for (String content : part.getHeader("content-disposition").split(";")) {
	        if (content.trim().startsWith("filename"))
	            return content.substring(content.indexOf("=") + 2, content.length() - 1);
	        }
	    
	    return "Default.csv";
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
        
        username = (String) session.getAttribute("id");
        password = (String) session.getAttribute("pass");
        
        String[] arrOfStr = completeURL.split("/", 0); 
        
        System.out.println("Admin Servlet");
        System.out.println("Passes: " + completeURL); 
        

    
        switch(arrOfStr[arrOfStr.length - 1])
        {

        
        case "monthlyreadings":
        {
        	String filepath = "";
        	String uploadPath = session.getServletContext().getRealPath("") + File.separator;
        	
        	File uploadDir = new File(uploadPath);
        	if (!uploadDir.exists()) uploadDir.mkdir();
        	
        	for (Part part : request.getParts()) {
        	    String fileName = "flat.csv";
        	    part.write(uploadPath + File.separator + fileName);
        	    filepath = uploadPath + fileName;
        	}
        	CSVReader reader = new CSVReader(new FileReader(filepath), ',');
        	
        	String[] nextRecord; 
        	  
        	AdminServices service = new AdminServices(username, password);
        	
        	int success = 0, fail = 0;
        	
        	String[] size = reader.readNext();
        	
        	if(size.length == 4){
	            while ((nextRecord = reader.readNext()) != null) { 
	                    try {
	                    	service.UpdateReadings(nextRecord[0], nextRecord[1], nextRecord[2], nextRecord[3]);
	                    	success++;
	                    }catch(Exception e) {
	                    	fail++;
	                    }
	            	}
	            session.setAttribute("message", "Readings added Successfully: " + success + ", Failed: " + fail);
	        	response.sendRedirect(request.getContextPath() + "/admin");	
        	}else {
        		session.setAttribute("message", "Invalid CSV: needs to have 4 columns (Consumer_id, Reading, Date, Peak_load)");
            	response.sendRedirect(request.getContextPath() + "/admin");	
        	}
            break;
        }
        
            case "newcustomer":
            {
            	String name = request.getParameter("name");
            	String address = request.getParameter("address");
            	String email = request.getParameter("email");
            	String mobile = request.getParameter("mobile");
            	String discomname = request.getParameter("discomname");

            	System.out.println(discomname);

            	String[] discomselection = null;
          
            	if(name == "" || email == "" || mobile == "" || address == "" || discomname == "") {
            		session.setAttribute("message", "Customer was not registered due to incomplete fields, Please try again!");
                	response.sendRedirect(request.getContextPath() + "/admin");
            	}
            	else {
            		AdminServices service = new AdminServices(username, password);
            		try {
            			
            			List<Object> dis_vals = (List<Object>) session.getAttribute("dis_vals");
						List<String> discoms = (List<String>) dis_vals.get(0);
						List<String> vals = (List<String>) dis_vals.get(1);
						
						for(int i = 0; i < vals.size(); i++) {
							if(discomname.equals(discoms.get(i))) {
								discomselection = (vals.get(i)).split(":", 0); 
								break;
							}
						}
            			
						service.RegisterCustomer(discomselection[0], discomselection[1], name, address, email, mobile);
						session.setAttribute("message", "Customer was registered Successfully!!");
	            		response.sendRedirect(request.getContextPath() + "/admin");
					} catch (Exception e) {
						session.setAttribute("message", "Customer was not registered due to internal error, Please try again!!");
	                	response.sendRedirect(request.getContextPath() + "/admin");	
					}
            		
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
            
            case "complaintaccept":
            {
                AdminServices service = new AdminServices(username, password);
                List<Complaint> complaints = null;
                
                System.out.println("Accept");
               
                try {
                    Complaint complain = (Complaint) session.getAttribute("complaintforapproval");
                    service.DeleteComplaint(complain.getCus_id(),(String) request.getParameter("cor_amt"),(String) session.getAttribute("complaintID"),"accept");
                    session.setAttribute("message", "Complaint: " + (String) session.getAttribute("complaintID") + " was resolved!!");
                    complaints = service.AdminComplaints();
					session.setAttribute("complaints", complaints);
                	response.sendRedirect(request.getContextPath() + "/admin");	
                } catch (Exception e) {
                	session.setAttribute("message", "Complaint: " + (String) session.getAttribute("complaintID") + " was not resolved!! Correction amount wasn't provided.");
                	response.sendRedirect(request.getContextPath() + "/admin");	
                }
               
                break;
            }
            
            case "complaintreject":
            {
                AdminServices service = new AdminServices(username, password);
                List<Complaint> complaints = null;
                
                System.out.println("Reject");
                
                try {
                    Complaint complain = (Complaint) session.getAttribute("complaintforapproval");
                    service.DeleteComplaint(complain.getCus_id(),(String) request.getParameter("cor_amt"),(String) session.getAttribute("complaintID"),"reject");
                    session.setAttribute("message", "Complaint: " + (String) session.getAttribute("complaintID") + " was resolved!!");
                    complaints = service.AdminComplaints();
					session.setAttribute("complaints", complaints);
                	response.sendRedirect(request.getContextPath() + "/admin");	
                } catch (Exception e) {
                	session.setAttribute("message", "Complaint: " + (String) session.getAttribute("complaintID") + " was not resolved!!");
                	response.sendRedirect(request.getContextPath() + "/admin");	
                }
               
                break;
            }
            
            default:
            {
            	if(completeURL.contains("complaint")) {
                	
                	String complaintid = arrOfStr[arrOfStr.length - 1];
                	List<Complaint> complaints = (List<Complaint>) session.getAttribute("complaints");
                	Complaint complaint = null;
                	
                	for(int i = 0; i < complaints.size(); i++) {
                		complaint = complaints.get(i);
                		if((complaint.getComplaint_id()).equals(complaintid)){
                			session.setAttribute("complaintforapproval", complaint);
                			RequestDispatcher rd = request.getRequestDispatcher("/complaintresolver");
                			rd.forward(request, response);
                		}
                	}
                }
            	else {
	            	if(session.getAttribute("complaints") != null && session.getAttribute("dis_vals") != null) {
	            		RequestDispatcher rd = request.getRequestDispatcher("adminHome.jsp");
	                	rd.forward(request, response);
	            	}
	            	else {
	            		AdminServices service = new AdminServices(username, password);
	            		List<Complaint> complaints = null;
	            		List<Object> dis_vals = null;
	
	            		try {
							complaints = service.AdminComplaints();
							session.setAttribute("complaints", complaints);
							dis_vals = service.getDISCOMnCats();
							session.setAttribute("dis_vals", dis_vals);
		            		RequestDispatcher rd = request.getRequestDispatcher("adminHome.jsp");
		                	rd.forward(request, response);
						} catch (Exception e) {
							e.printStackTrace();
						}
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
        return "AdminServer"; 
    } 
    
    public ServletConfig getServletConfig() 
    { 
        return config; // getServletConfig 
    } 
}