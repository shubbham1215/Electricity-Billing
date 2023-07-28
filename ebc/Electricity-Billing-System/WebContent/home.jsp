<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="false" %>

<!DOCTYPE html>
<%
	HttpSession session = request.getSession(false);
	String message, usertype;
	
	try{
		message = (String) session.getAttribute("error_message");
		usertype = (String) session.getAttribute("user_type");
		session.setAttribute("error_message", null);
		out.println(session.getId());
	}catch(Exception e){
		message = null;
		usertype = null;
	}
%>

<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>Home | Goa Electricity</title>
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
	
</style>

</head>
<body>
<!-- partial:index.partial.html -->
<div class="navbar-fixed ">
    <nav>
      <div class="nav">
        
        <div class="row mb-0">
        	<div class="col s12 m8 offset-m2">
          	<h3><a href="index.html">Electricity Billing System</a></h3>
        	</div>  
      	</div>
      	
        <div class="row mb-0">
         <div class='col s12 m6 l5 offset-l2'>
       <ul class="tabs"></ul>
        
        </div>
       </div>
        
      </div>
    </nav>
  </div>
 
 <div class="limiter"> 
  <div class="limiter" style="width: 50%; float: left;">
		<div class="container-login100">
			<div class="wrap-login100 p-t-80 p-b-90">
				<form class="login100-form validate-form1 flex-sb flex-w" action="admin" id="adminform" method="post">
					<span class="login100-form-title p-t-80 p-b-51">
						Admin Login
					</span>
					 <% 
					    if (message == null || usertype == "customer") {
					    	 out.println("&nbsp;");
					      } else {
					         out.println(message);
					    } %>
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Username is required">
						<input class="input100" type="text" name="userName" placeholder="Username">
					</div>
					
					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Password is required">
						<input class="input100" type="password" name="password" placeholder="Password">
					</div>

					<div class="container-login100-form-btn m-t-17">
						<button class="login100-form-btn">
							Login
						</button>
					</div>

				</form>

			</div>
		</div>
	</div>
	
	<div class="limiter" style="width: 50%; float: right;">
		<div class="container-login100">
			<div class="wrap-login100 p-t-80 p-b-90">
				<form class="login100-form validate-form2 flex-sb flex-w" action="customer" id="customerform" method="post">
					<span class="login100-form-title p-t-80 p-b-51">
						Customer Login
					</span>
					<% 
					    if (message == null || usertype == "admin") {
					    	 out.println("&nbsp;");
					      } else {
					         out.println(message);
					    } %>
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Customer ID is required">
						<input class="input100" type="text" name="customerid" placeholder="Customer ID">
					</div>

					<div class="container-login100-form-btn m-t-17">
						<button class="login100-form-btn">
							Submit
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- partial -->
	<script src='./js/main.js'></script>
	<script src='./js/main2.js'></script>

</body>
</html>
