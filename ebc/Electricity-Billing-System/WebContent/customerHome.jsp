<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="com.jwt.Services.Bill"%>
<%@ page import="java.util.List"%>
<%@ page import="com.jwt.Services.LatestBill"%>
<%
	session = request.getSession(false);
	String message, usertype;
	
	try{
		message = (String) session.getAttribute("message");
		session.setAttribute("message", null);
		//out.println(session.getId());
	}catch(Exception e){
		message = null;
	}
%>

<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>Customer | Goa Electricity</title>

	<link rel="stylesheet" href="./css/main2.css">
	<link rel="stylesheet" href="./css/main.css">
	
	<style>
	.flex-sb {
	display: -webkit-box;
	display: -webkit-flex;
	display: -moz-box;
	display: -ms-flexbox;
	display: flex;
	justify-content: space-between;
}

	.flex-w {
	display: -webkit-box;
	display: -webkit-flex;
	display: -moz-box;
	display: -ms-flexbox;
	display: flex;
	-webkit-flex-wrap: wrap;
	-moz-flex-wrap: wrap;
	-ms-flex-wrap: wrap;
	-o-flex-wrap: wrap;
	flex-wrap: wrap;
}

	.m-l-16 {margin-left: 16px;}
	.m-r-16 {margin-right: 16px;}
	.m-b-16 {margin-bottom: 16px;}
	.m-t-17 {margin-top: 16px;}
	.p-b-51 {padding-bottom: 51px;}
	.p-t-60 {padding-top: 60px;}
	.p-t-50 {padding-top: 50px;}
	.p-t-80 {padding-top: 80px;}
	.p-b-90 {padding-bottom: 90px;}
	

		.invoice {
			background: #fff;
			padding: 20px
		}

		.invoice-company {
			font-size: 20px
		}

		.invoice-header {
			margin: 0 -20px;
			background: #f0f3f4;
			padding: 20px
		}

		.invoice-date,
		.invoice-from,
		.invoice-to {
			display: table-cell;
			width: 1%
		}

		.invoice-from,
		.invoice-to {
			padding-right: 20px
		}

		.invoice-date .date,
		.invoice-from strong,
		.invoice-to strong {
			font-size: 16px;
			font-weight: 600
		}

		.invoice-date {
			text-align: right;
			padding-left: 20px
		}

		.invoice-price {
			background: #f0f3f4;
			display: table;
			width: 100%
		}

		.invoice-price .invoice-price-left,
		.invoice-price .invoice-price-right {
			display: table-cell;
			padding: 20px;
			font-size: 20px;
			font-weight: 600;
			width: 75%;
			position: relative;
			vertical-align: middle
		}

		.invoice-price .invoice-price-left .sub-price {
			display: table-cell;
			vertical-align: middle;
			padding: 0 20px
		}

		.invoice-price small {
			font-size: 12px;
			font-weight: 400;
			display: block
		}

		.invoice-price .invoice-price-row {
			display: table;
			float: left
		}

		.invoice-price .invoice-price-right {
			width: 25%;
			background: #2d353c;
			color: #fff;
			font-size: 28px;
			text-align: right;
			vertical-align: bottom;
			font-weight: 300
		}

		.invoice-price .invoice-price-right small {
			display: block;
			opacity: .6;
			position: absolute;
			top: 10px;
			left: 10px;
			font-size: 12px
		}

		.invoice-footer {
			border-top: 1px solid #ddd;
			padding-top: 10px;
			font-size: 10px
		}

		.invoice-note {
			color: #999;
			margin-top: 80px;
			font-size: 85%
		}

		.invoice>div:not(.invoice-footer) {
			margin-bottom: 20px
		}


		}

	
</style>
	
</head>
<body>
<!-- partial:index.partial.html -->
<div class="navbar-fixed ">
    <nav>
      <div class="nav">
        
        <div class="row mb-0">
        <div class="col s12 m8 offset-m2">
          <h3><a >Electricity Billing System</a></h3>
        </div>  
      </div>
         <div class="row mb-0">
			<div class='col s12 m6 l5 offset-l2'>
            
		       <ul class="tabs">
		        <li class="tab col s1"><a href="#test1" class='active white-text'>Home</a></li>
		        <li class="tab col s1"><a href="#test2" class=" white-text" >View Bill History</a></li>
		        <li class="tab col s1"><a href="#test3" class='white-text'>Complaint Registration</a></li>
		      </ul>
	  
        </div>
       </div>
      </div>
    </nav>
  </div>


<div class="container pt-10">
  <div id="test1" class="col s12">
  <% 
    if (message == null) {
    	 out.println("&nbsp;");
      } else {
         out.println(message);
    } %>
	<h3 class='header'>Latest Bill:</h3>
		<div class="limiter">
			<div class="row card">
			
		<div class="invoice">
         <!-- begin invoice-company -->
         <div class="invoice-company text-inverse f-w-600">
            <h4>Goa Electricity Department</h4>
         </div>
		 <div class="limiter">
		 <span class="pull-right hidden-print" style="float: center;">
            <div class="btn m-b-10 p-l-5">
            <% LatestBill latestbill = (LatestBill) session.getAttribute("latestbill"); %>
            <i class="fa fa-circle-o t-plus-1 text-danger fa-fw fa-lg"></i> 
            <% out.println(latestbill.getStatus()); %>
            </div>
            <a href="javascript:;" onclick="window.print()" class="btn btn-sm btn-white m-b-10 p-l-5"><i class="fa fa-print t-plus-1 fa-fw fa-lg"></i> Print</a>
         </span>
		 </div>
         <!-- end invoice-company -->
         <!-- begin invoice-header -->
         <div class="invoice-header">
            <div class="invoice-from">
               <small>from</small>
               <address class="m-t-5 m-b-5">
                  <strong class="text-inverse">Goa Electricity Department.</strong><br>
                  Opposite Deltin Casino<br>
                  Panjim, 403001<br>
                  North-Goa<br>
                  Phone: 9876543210<br>
               </address>
            </div>
            
            
            
            
            <div class="invoice-to">
               <small>to</small>
               <address class="m-t-5 m-b-5">
               
               <%
		            
		            
		            out.println("<strong class=\"text-inverse\">" + latestbill.getCusName() + "</strong><br>");
		            out.println("CustomerID:" + latestbill.getCusId() + "<br>");
		            out.println("Address:" + latestbill.getCusAddress() + "<br>");
		            out.println("Phone:" + latestbill.getPhoneNumber() + "<br>");
		            
            
            	%>
                  
               </address>
            </div>
            <div class="invoice-date">
               <small>Electricity Bill period</small>
               <div class="date text-inverse m-t-5">
               <% 
               	out.println(latestbill.getFromDate() + " to " + latestbill.getToDate());
               %>
               </div>
               <div class="invoice-detail">
                  <div class="date text-inverse m-t-5">
                  <%
                  		out.println("Bill no : " + latestbill.getBillno() + "<br></div>");
                   
	                  	out.println("Meter No: " + latestbill.getMeterNumber() + "<br>");
                  		out.println("Tariff Category: " + latestbill.getCatgName() + "<br>");
                  		out.println(latestbill.getDisName() + "<br>");
                  %>
               </div>
            </div>
         </div>
         <!-- end invoice-header -->
         <!-- begin invoice-content -->
         <div class="invoice-content">
            <!-- begin table-responsive -->
            <div class="table-responsive">
               <table class="table table-invoice">
                  <thead>
                     <tr>
                        <th>CURRENT DEMAND CALCULATION DETAILS</th>
                        <th class="text-center" width="10%">QUANTITY</th>
                        <th class="text-center" width="10%">RATE</th>
                        <th class="text-right" width="20%">LINE TOTAL</th>
                     </tr>
                  </thead>
                  <tbody>
                     <tr>
                        <td>
                           <span class="text-inverse">Electricity Charges</span><br>
                           <small></small>
                        </td>
                        <td class="text-center"><% out.println(latestbill.getQuantity()); %></td>
                        <td class="text-center">variable</td>
                        <td class="text-right"><% out.println(latestbill.getElec_charge()); %></td>
                     </tr>
                     <tr>
                        <td>
                           <span class="text-inverse">Load Rate</span><br>
                           <small></small>
                        </td>
                        <td class="text-center">-</td>
                        <td class="text-center"><% out.println(latestbill.getSancRate()); %></td>
                        <td class="text-right"><% out.println(latestbill.getSancRate()); %></td>
                     </tr>
                     <tr>
                        <td>
                           <span class="text-inverse">FPPCA</span><br>
                           <small></small>
                        </td>
                        <td class="text-center">-</td>
                        <td class="text-center"><% out.println(latestbill.getFixedCharge()); %></td>
                        <td class="text-right"><% out.println(latestbill.getFixedCharge()); %></td>
                     </tr>
                     <tr>
                        <td>
                           <span class="text-inverse">Subsidy</span><br>
                           <small></small>
                        </td>
                        <td class="text-center">-</td>
                        <td class="text-center"><% out.println(latestbill.getSubsidy()); %></td>
                        <td class="text-right"><% out.println(latestbill.getSubsidy()); %></td>
                     </tr>
                  </tbody>
               </table>
            </div>
            <!-- end table-responsive -->
            <!-- begin invoice-price -->
            <div class="invoice-price">
               <div class="invoice-price-left">
                  <div class="invoice-price-row">
                     <div class="sub-price">
                        <small>SUBTOTAL</small>
                        <span class="text-inverse">
                        <% out.println(latestbill.getFinalAmount() - latestbill.getPayDue()); %>
                        </span>
                     </div>
                     <div class="sub-price">
                        <i class="fa fa-plus text-muted"></i>
                     </div>
                     <div class="sub-price">
                        <small>PAYMENT DUE</small>
                        <span class="text-inverse">
                        <% out.println(latestbill.getPayDue()); %>
                        </span>
                     </div>
                  </div>
               </div>
               <div class="invoice-price-right">
                  <small>TOTAL</small> <span class="f-w-600">
                  <% out.println(latestbill.getFinalAmount()); %>
                  </span>
               </div>
            </div>
            <!-- end invoice-price -->
         </div>
         <!-- end invoice-content -->
         <!-- begin invoice-note -->
         <div class="invoice-note">
            * Payment on a Click<br>
            * You can print this Bill till your next bill is issued<br>
            * If you have any questions concerning this Bill, feel free to raise a Complaint
         </div>
         <!-- end invoice-note -->
         <!-- begin invoice-footer -->
         <div class="invoice-footer">
            <p class="text-center m-b-5 f-w-600">
               Electricity Department, Government of Goa All rights reserved.
            </p>
            <p class="text-center">
               <span class="m-r-10"><i class="fa fa-fw fa-lg fa-globe"></i>www.goaelectricity.gov.in</span>
               <span class="m-r-10"><i class="fa fa-fw fa-lg fa-phone-volume"></i> T:0832-098-3748</span>
               <span class="m-r-10"><i class="fa fa-fw fa-lg fa-envelope"></i> goaelectricity@gmail.com</span>
            </p>
         </div>
         <!-- end invoice-footer -->
      </div>
	  
	<div class="container">
		<form action="customer/payment" id="paymentform" method="post">
			<div class="col s6">
			  <div class="container-login100-form-btn pt-1 pb-1">
			  
					<button class="login100-form-btn">
						Pay Now
					</button>
				
			  </div>
			 </div>
		</form>
			 
		<form action="customer/exit" id="exitform" method="post">
			<div class="col s6">
			  <div class="container-login100-form-btn pt-1 pb-1">
			  
					<button class="login100-form-btn">
						Exit
					</button>
					
			  </div>
			 </div>
		</form>
	</div>

    </div>
  </div>
 </div>

 
    <div id="test2" class="col s12">
      <h3 class='header'>Billing History:</h3>
		<div class="limiter">
		<div class="row card">
		<div class="container-table100">
			<div class="wrap-table100">
				<div class="table100 ver1 m-b-110">
					<div class="table100-head">
						<table>
							<thead>
								<tr class="row100 head">
									<th class="cell100 column4" style="text-align:center; width:14%">Bill No.</th>
									<th class="cell100 column4" style="text-align:center; width:14%">Customer ID</th>
									<th class="cell100 column4" style="text-align:center; width:14%">From Date</th>
									<th class="cell100 column4" style="text-align:center; width:14%">To Date</th>
									<th class="cell100 column4" style="text-align:center; width:14%">Amount</th>
									<th class="cell100 column4" style="text-align:center; width:14%">Status</th>
									<th class="cell100 column4" style="text-align:center; width:14%">Trans. ID</th>
									
								</tr>
							</thead>
							</table>
						</div>
						     <div class="table100-body js-pscroll">
								<table>
									<tbody>
										<% 
											List<Bill> bills = (List<Bill>) session.getAttribute("billshistory");
											Bill bill=null;
											for(int i=0; i<bills.size(); i++)
											{
												bill = bills.get(i);
												out.println("<tr class=\"row100 body\">");

												out.println("<td class=\"cell100 column4\"  style=\"text-align:center; width:14%\">" + bill.getBill_no() + "</td>");
												out.println("<td class=\"cell100 column4\"  style=\"text-align:center; width:14%\">" + bill.getCus_id() + "</td>");
												out.println("<td class=\"cell100 column4\"  style=\"text-align:center; width:14%\">" + bill.getFrom_date() + "</td>");
												out.println("<td class=\"cell100 column4\"  style=\"text-align:center; width:14%\">" + bill.getTo_date() + "</td>");
												out.println("<td class=\"cell100 column4\"  style=\"text-align:center; width:14%\">" + bill.getAmount() + "</td>");
												out.println("<td class=\"cell100 column4\"  style=\"text-align:center; width:14%\">" + bill.getStatus() + "</td>");
												out.println("<td class=\"cell100 column4\"  style=\"text-align:center; width:14%\">" + bill.getTrans_id() + "</td>");

												out.println("</tr>");
											}
											
										%>
									</tbody>
								</table>
							</div>
						
					</div>

				</div>
			</div>
		</div>
    </div>
	</div>    

	
 <div id="test3" class="col s12">
	<h3 class='header'>Complaint Form:</h3>
		<div class="limiter">
			<div class="row card">
				<form class="login100-form validate-form2 flex-sb flex-w" action="customer/complaint" id="complaintform" method="post">
					<div class="col s12">
						<div class="row pt-1 pl-1 pr-1">
							<div class="col s6">
								<div class="validate-input m-b-16" data-validate = "First Name is required">
									<input type="text" name="first_name" placeholder="First Name">
								</div>
							</div>
							<div class="col s6">
								<div class="validate-input m-b-16" data-validate = "Last Name is required">
									<input type="text" name="last_name" placeholder="Last Name">
								</div>
							</div>
						</div>
						
						<div class="row pt-1 pl-1 pr-1">
							<div class="col s6">
								<div class="validate-input m-b-16" data-validate = "E-mail is required">
									<input type="email" name="email" placeholder="E-mail">
								</div>
							</div>
							<div class="col s6">
								<div class="validate-input m-b-16" data-validate = "Mobile No. is required">
									<input type="tel" name="mobile" placeholder="Mobile #">
								</div>
							</div>
						</div>
						
						<div class="row pt-1 pl-1 pr-1">
							<div class="col s6">
								<div class="validate-input m-b-16" data-validate = "Amount is required">
									<input type="number" name="amount" placeholder="Amount overcharged">
								</div>
							</div>
						</div>
						
					<div class="row pt-1 pl-1 pr-1">
						<div class="col s6">
							<div class = "login100-form-btn validate-input m-b-10 col s4"  onclick="myFunction()">Bill Number
								<select name="billno" id="billno" class = "login100-form-btn dropdown-button dropdown-content col s4" data-activates="dropdown">
								<% 
									List<String> bill_dropdown = (List<String>) session.getAttribute("dropdownbills");
								try{
									out.println("<option value=\"" + bill_dropdown.get(0) + "\" selected>" + bill_dropdown.get(0) + "</option>");
									for(int i=1; i< bill_dropdown.size(); i++){
										out.println("<option value=\"" + bill_dropdown.get(i) + "\">" + bill_dropdown.get(i) + "</option>");
									}
								}catch(Exception e){
								}
									
								%>
								</select>
							</div>
						</div>
						
						<font style="opacity:0.6"><div class="col s6" id="BillNo"></div></font>
						

						<script>
							function myFunction() {
							  document.getElementById("BillNo").innerHTML = "Bill Number: " + document.getElementById("billno").value;
							}
						</script>
						</div>
						
						<div class="row pt-1 pl-1 pr-1">
							<div class="col s12">
								<div class="validate-input m-b-16" data-validate = "Description is required">
									<input type="text" name="description" placeholder="Description">
								</div>
							</div>
						</div>
						
						<div class="container">  
						  <div class="container-login100-form-btn pt-1 pb-1">
							<button class="login100-form-btn">
								Submit
							</button>
						  </div>
						</div>
					</div>
			</form> 
	  </div>
    </div>
  </div>
</div>
</div>


<!-- partial -->
  <script src='./js/main.js'></script>
<script src='./js/main2.js'></script>

</body>
</html>

