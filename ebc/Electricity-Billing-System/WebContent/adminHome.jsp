<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="com.jwt.Services.Complaint"%>
<%@ page import="java.util.List"%>  
<%@ page import="java.util.ArrayList"%> 
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
  <title>Administrator | Goa Electricity</title>
  
	<link rel="stylesheet" href="./css/main2.css">
	<link rel="stylesheet" href="./css/main.css">
	    <style type="text/css">


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
		
		.center {
		  margin: auto;
		  width: 50%;
		  padding: 10px;
		}

		}
    </style>
	<script type="text/javascript">
		function Upload() {
			var fileUpload = document.getElementById("csvUpload");
			var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
			if (regex.test(fileUpload.value.toLowerCase())) {
				if (typeof (FileReader) != "undefined") {
					var reader = new FileReader();
					reader.onload = function (e) {
						var table = document.createElement("table");
						var rows = e.target.result.split("\n");
						
						var row = table.insertRow(-1);
							var cells = rows[0].split(",");
							for (var j = 0; j < cells.length; j++) {
								var cell = row.insertCell(-1);
								cell.innerHTML = '<h5>' + cells[j] + '</h5>';
							}
						
						for (var i = 1; i < rows.length; i++) {
							var row = table.insertRow(-1);
							var cells = rows[i].split(",");
							for (var j = 0; j < cells.length; j++) {
								var cell = row.insertCell(-1);
								cell.innerHTML = cells[j];
							}
						}
						var dvCSV = document.getElementById("dvCSV");
						dvCSV.innerHTML = "";
						dvCSV.appendChild(table);
					}
					reader.readAsText(fileUpload.files[0]);
				} else {
					alert("This browser does not support HTML5.");
				}
			} else {
				alert("Please upload a valid CSV file.");
			}
			myFunction();
		}
	</script>
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
				<li class="tab col s1"><a href="#test1" class='active white-text'>Upload</a></li>
				<li class="tab col s1"><a href="#test2" class='white-text'>Complaints</a></li>
				<li class="tab col s1"><a href="#test3" class='white-text'>New Customer</a></li>
				<li class="tab col s1"><a href="#test4" class='white-text'>New DISCOM</a></li>
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
	<h3 class='header'>UPLOAD READING:</h3>
		<div class="limiter">
			<div class="row card">
					<div class="container-table100">
						<form class="login100-form validate-form2 flex-sb flex-w" enctype="multipart/form-data" action="admin/monthlyreadings" id="readingsform" method="post">
				
				<div class="col s4">
				  <label class ="login100-form-btn" for="csvUpload">Browse</label>
				  <input type="file" name="csvUpload" id="csvUpload" style="opacity:0 "/>
				</div>
				
			
				<div class="col s4">
					<label class ="login100-form-btn" for="upload">Upload</label>
					<input type="button" id="upload" style="opacity:0" onclick="Upload()" />
				</div>
				
				<div class="col s4">
					<button class="login100-form-btn">
								Submit
					</button>
				</div>
				
			</form>
				
				<div id="csvName"></div>
				
				<div id="dvCSV"></div>
				
				<script>
					function myFunction() {
						var filename = document.getElementById("csvUpload").value;
						var list = filename.split("\\");
						filename = list[list.length -1];
						  document.getElementById("csvName").innerHTML = "CSV: " + filename;
					}
				</script>
				
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
									<th class="cell100 column4" style="text-align:center; width:14%">Complaint ID</th>
									<th class="cell100 column4" style="text-align:center; width:14%">Customer ID</th>
									<th class="cell100 column4" style="text-align:center; width:14%">Bill No.</th>
									<th class="cell100 column4" style="text-align:center; width:14%">Description</th>
									<th class="cell100 column4" style="text-align:center; width:14%">Amount</th>
									
								</tr>
							</thead>
							</table>
						</div>
						     <div class="table100-body js-pscroll">
								<table>
									<tbody>
										<% 
											List<Complaint> complaints = (List<Complaint>) session.getAttribute("complaints");
											Complaint complaint=null;
											for(int i=0; i<complaints.size(); i++)
											{
												complaint = complaints.get(i);
												out.println("<tr class=\"row100 body\">");

												out.println("<td class=\"cell100 column4\"  style=\"text-align:center; width:14%\"><form action=\"admin/complaint/"+ complaint.getComplaint_id() +
														"\" id=\"complaintform\" method=\"post\"><button class=\"login100-form-btn\">" + complaint.getComplaint_id() + 
														"</form></button></td>");
												out.println("<td class=\"cell100 column4\"  style=\"text-align:center; width:14%\">" + complaint.getCus_id() + "</td>");
												out.println("<td class=\"cell100 column4\"  style=\"text-align:center; width:14%\">" + complaint.getBill_no() + "</td>");
												out.println("<td class=\"cell100 column4\"  style=\"text-align:center; width:14%\">" + complaint.getDescription() + "</td>");
												out.println("<td class=\"cell100 column4\"  style=\"text-align:center; width:14%\">" + complaint.getAmount() + "</td>");

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
	<h3 class='header'>New Customer Registration:</h3>
	  
		<div class="limiter">
			<div class="row card">
				<form class="login100-form validate-form2 flex-sb flex-w" action="admin/newcustomer" id="newcustomer" method="post">
					<div class="col s12">
						<div class="row pt-1 pl-1 pr-1">
							<div class="col s6">
								<div class="validate-input m-b-16" data-validate = "Name is required">
									<input type="text" name="name" placeholder="Name">
								</div>
							</div>
							<div class="col s6">
								<div class="validate-input m-b-16" data-validate = "Address is required">
									<input type="text" name="address" placeholder="Address">
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
							<div class = "login100-form-btn validate-input m-b-10 col s4"  onclick="discomdrop()">DISCOM & Category
								<select name = "discomname" id="discomname" class = "login100-form-btn dropdown-button dropdown-content col s4" data-activates="dropdown">
									<% 
										List<Object> dis_vals = (List<Object>) session.getAttribute("dis_vals");
										List<String> discoms = (List<String>) dis_vals.get(0);
										
										try{
											out.println("<option value=\"" + discoms.get(0) + "\" selected>" + discoms.get(0) + "</option>");
											for(int i = 1; i< discoms.size(); i++){
												out.println("<option value=\"" + discoms.get(i) + "\">" + discoms.get(i) + "</option>");
											}
										}catch(Exception e){
										}
										
									%>
								</select>
							</div>
						</div>

						<font style="opacity:0.6"><div class="col s6" id="discom"></div></font>
						
						
						<script>
							function discomdrop() {
							  	document.getElementById("discom").innerHTML = "DISCOM: " + document.getElementById("discomname").value;
							  	
							}
						</script>
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
  
  <div id="test4" class="col s12">
	<h3 class='header'>New DISCOM Registration:</h3>
	  
		<div class="limiter">
			<div class="row card">
				<form class="login100-form validate-form2 flex-sb flex-w" action="admin/newdiscom" id="newdiscom" method="post">
					<div class="col s12">
						<div class="row pt-1 pl-1 pr-1">
							<div class="col s6">
								<div class="validate-input m-b-16" data-validate = "DISCOM Name is required">
									<input type="text" name="discom_name" placeholder="Discom Name">
								</div>
							</div>
							<div class="col s6">
								<div class="validate-input m-b-16" data-validate = "Address is required">
									<input type="text" name="address" placeholder="Address">
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
						
						<div class="col s4">
							<div class = "login100-form-btn validate-input m-b-10 col s4">DISCOM Name
								<select name = "discomname" class = "login100-form-btn dropdown-button dropdown-content col s2" data-activates="dropdown">
									<option value="D1" selected>D1</option>
									<option value="D2">D2</option>
									<option value="D3">D3</option>
									<option value="D4">D4</option>
								</select>
							</div>
						</div>
						
						<div class="col s4">
							<div class = "login100-form-btn validate-input m-b-10 col s4">Category
								<select name = "category" class = "login100-form-btn dropdown-button dropdown-content col s2" data-activates="dropdown">
									<option value="C1" selected>C1</option>
									<option value="C2">C2</option>
									<option value="C3">C3</option>
									<option value="C4">C4</option>
								</select>
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

<div class="container-table100">
	<div class="col s6 center">
		<form action="admin/exit" id="exitform" method="post">
			
			  <div class="container-login100-form-btn pt-1 pb-1">
			  
					<button class="login100-form-btn">
						Exit
					</button>
					
			  </div>
			 
		</form>
	</div>
</div>
      


<!-- partial -->
  <script src='./js/main.js'></script>
<script src='./js/main2.js'></script>

</body>
</html>