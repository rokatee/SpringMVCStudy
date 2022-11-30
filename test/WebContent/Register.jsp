<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Register.jsp</title>

<!-- Custom fonts for this template -->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</head>
<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
       	<div>
			<c:import url="Sidebar.jsp"></c:import>
		</div>
        <!-- End of Sidebar -->
        
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
		
		<!-- Main Content -->
		<div id="content">
		
			<!-- Topbar -->
			<div>
				<c:import url="Topbar.jsp"></c:import>
			</div>
			<!-- End of Topbar -->
		
			<div class="container">
		        <div class="card o-hidden border-0 shadow-lg my-5">
		            <div class="card-body p-0">
		                <!-- Nested Row within Card Body -->
		                <div class="row">
		                    <div class="col-lg-5 d-none d-lg-block bg-register-image">
		                    	<img src="img/sist.png" style="width: 450px; margin:50px auto"/>
		                    </div>
		                    <div class="col-lg-7">
		                        <div class="p-5">
		                            <div class="text-center">
		                                <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
		                            </div>
		                            <form class="user">
		                                <div class="form-group row">
		                                    <div class="col-sm-6 mb-3 mb-sm-0">
		                                        <input type="text" class="form-control form-control-user" id="exampleFirstName" placeholder="First Name">
		                                    </div>
		                                    <div class="col-sm-6">
		                                        <input type="text" class="form-control form-control-user" id="exampleLastName" placeholder="Last Name">
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <input type="email" class="form-control form-control-user" id="exampleInputEmail" placeholder="Email Address">
		                                </div>
		                                <div class="form-group row">
		                                    <div class="col-sm-6 mb-3 mb-sm-0">
		                                        <input type="password" class="form-control form-control-user"
		                                            id="exampleInputPassword" placeholder="Password">
		                                    </div>
		                                    <div class="col-sm-6">
		                                        <input type="password" class="form-control form-control-user"
		                                            id="exampleRepeatPassword" placeholder="Repeat Password">
		                                    </div>
		                                </div>
		                                <a href="login.html" class="btn btn-primary btn-user btn-block">
		                                    Register Account
		                                </a>
		                                <hr>
		                                <a href="index.html" class="btn btn-google btn-user btn-block">
		                                    <i class="fab fa-google fa-fw"></i> 
		                                    Register with Google
		                                </a>
		                                <a href="index.html" class="btn btn-facebook btn-user btn-block">
		                                    <i class="fab fa-facebook-f fa-fw"></i> 
		                                    Register with Facebook
		                                </a>
		                            </form>
		                            <hr>
		                            <div class="text-center">
		                                <a class="small" href="forgot-password.html">Forgot Password?</a>
		                            </div>
		                            <div class="text-center">
		                                <a class="small" href="login.html">Already have an account? Login!</a>
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
		
        <!-- Footer -->
       	<div>
			<c:import url="Footer.jsp"></c:import>
		</div>
		
        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->
    
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</body>

</html>