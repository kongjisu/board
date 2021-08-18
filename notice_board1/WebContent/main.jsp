
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="board_Data.BbsDAO"%>
<%@page import="board_Data.BbsJava"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html lang="en">
<head>


<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Grayscale - Start Bootstrap Theme</title>
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Varela+Round"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
</head>
<body id="page-top">



	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top"
		id="mainNav">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="main1.jsp">Start</a>
		</div>

	</nav>
</head>

<body>



	<!-- Signup-->
	<section class="signup-section" id="signup">
		<div class="container px-4 px-lg-5">
			<div class="row gx-4 gx-lg-5">
				<div class="col-md-10 col-lg-8 mx-auto text-center">
					<i class="far fa-paper-plane fa-2x mb-2 text-white"></i>
					<h1 class="text-white mb-5">게시판</h1>
					<!-- * * * * * * * * * * * * * * *-->
					<!-- * * SB Forms Contact Form * *-->
					<!-- * * * * * * * * * * * * * * *-->
					<!-- This form is pre-integrated with SB Forms.-->
					<!-- To make this form functional, sign up at-->
					<!-- https://startbootstrap.com/solution/contact-forms-->
					<!-- to get an API token!-->
					<%
    String userID = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
    if (session.getAttribute("userID") != null)
    {
        userID = (String)session.getAttribute("userID");
    }
    int pageNumber = 1; // 기본페이지 기본적으로 페이지 1부터 시작하므로
    if (request.getParameter("pageNumber") != null)
    {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    }
%>

					<div class="container">
						<div class="row">
							<table class="table table-striped"
								style="text-align: center; border: 1px solid #dddddd">
								<thead>
									<tr>
										<th style="background-color: #eeeeee; text-align: center;">번호</th>
										<th style="background-color: #eeeeee; text-align: center;">제목</th>
										<th style="background-color: #eeeeee; text-align: center;">작성자</th>
										<th style="background-color: #eeeeee; text-align: center;">작성일</th>
									</tr>
								</thead>
								<tbody>
									<%
                    BbsDAO bbsDAO = new BbsDAO();
                	ArrayList<BbsJava> list = bbsDAO.getList(pageNumber);
               		for(int i = 0; i < list.size(); i++)
                    {
                %>

									<tr>
										<td><%=list.get(i).getBbsID() %></td>
										<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle() %></a></td>
										<td><%=list.get(i).getUserID() %></td>
										<td><%=list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11, 13) + "시" 
                        + list.get(i).getBbsDate().substring(14,16) + "분" %></td>
									</tr>
									<%
                    }
                %>
								</tbody>
							</table>
							<%
                if(pageNumber != 1) {
            %>
							<a href="main.jsp?pageNumber=<%=pageNumber - 1 %>"
								class="btn btn-success btn-arrow-left">이전</a>
							<%
                } if(bbsDAO.nextPage(pageNumber + 1)) {
            %>
							<a href="main.jsp?pageNumber=<%=pageNumber + 1 %>"
								class="btn btn-success btn-arrow-left">다음</a>

							<%
                }
            %>
							<!-- Email address input-->
							<div class="container">
								<div class="row">
									<table class="table table-striped"
										style="text-align: center; border: 1px solid #dddddd">
										<thead>
									</table>
									<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
								</div>
							</div>
							<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
							<script src="js/bootstrap.js"></script>
</body>
</html>



<!-- Submit error message-->
<!---->
<!-- This is what your users will see when there is-->
<!-- an error submitting the form-->


<!-- Footer-->

</body>
</html>
