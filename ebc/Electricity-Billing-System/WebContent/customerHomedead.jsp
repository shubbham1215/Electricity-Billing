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
		      </ul>
	  
        </div>
       </div>
      </div>
    </nav>
  </div>


<div class="container pt-10">
  <div id="test1" class="col s12">
  <% 
   out.println("Bills for newly registered customers will be generated after collection of readings. Please check again soon.");
	%>
	<h3 class='header'>No Bills could be found!</h3>
		<div class="limiter">
			<div class="row card">
			
		
	<div class="limiter"> 
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
 </div>

<!-- partial -->
  <script src='./js/main.js'></script>
<script src='./js/main2.js'></script>

</body>
</html>

