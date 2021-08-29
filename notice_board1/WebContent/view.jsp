
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="board_Data.BbsDAO"%>
<%@page import="board_Data.BbsJava"%>
<%@page import="java.io.PrintWriter"%>


<!DOCTYPE html>

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
	<section class="signup-section" id="signup">
		<div class="container px-4 px-lg-5">
			<div class="row gx-4 gx-lg-5">
				<div class="col-md-10 col-lg-8 mx-auto text-center">
					<i class="far fa-paper-plane fa-2x mb-2 text-white"></i>

					<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		 int bbsID = 0;
		    if (request.getParameter("bbsID") != null)
		    {
		        bbsID = Integer.parseInt(request.getParameter("bbsID"));
		    }
		    if (bbsID == 0)
		    {
		        PrintWriter script = response.getWriter();
		        script.println("<script>");
		        script.println("alert('유효하지 않은 글입니다')");
		        script.println("location.href = 'main.jsp'");
		        script.println("</script>");
		    }
		  BbsJava bbs = new BbsDAO().getBbs(bbsID);
	%>
					<!-- Email address input-->

					<div class="container">
						<div class="row">
							<table class="table table-striped"
								style="text-align: center; border: 1px solid #dddddd">
								<thead>
									<tr>
										<th colspan="3"
											style="background-color: #eeeeee; text-align: center;">게시판
											글 보기</th>

									</tr>
								</thead>
								<tbody>
									<tr>
										<td style="width: 20%;">글 제목</td>
										<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
									</tr>
									<tr>
										<td>작성자</td>
										<td colspan="2"><%= bbs.getUserID().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
									</tr>
									<tr>
										<td>작성일자</td>
										<td colspan="2"><%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11, 13) + "시" 
                                + bbs.getBbsDate().substring(14,16) + "분"  %></td>
									</tr>
									<tr>
										<td>내용</td>
										<td colspan="2" style="min-height: 200px; text-align: left;">
											<!-- 특수문자를 제대로 출력하기위해 & 악성스크립트를 방지하기위해 --> <%= bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
									</tr>
								</tbody>
							</table>
							<a href="main.jsp" class="btn btn-primary">목록</a>
							<%
                if(userID != null && userID.equals(bbs.getUserID()))
                {
            %>
							<a href="update.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">수정</a>
							<a href="deleteAction.jsp?bbsID=<%=bbsID %>"
								class="btn btn-primary">삭제</a>

							<%     
                }
            %>

							<div class="container">
								<form id="commentForm" name="commentForm" method="post"></form>
								; <br>
								<br>
								<div>
									<div>
										<span><strong>Comments</strong></span><span id="cCnt"></sqan>
									</div>
									<table class="table">
										<tr>
											<td><textarea style="width: 1100px" rows="3" cols="30"
													id="comment" name="comment" placeholder="댓글을 입력하세요"></textarea>
												<br>
												<div>
													<a href='#' onClick="fn_comment('${result.code}')"
														class="btn pull-right btn-success">등록</a>
												</div></td>
										</tr>

									</table>
								</div>

								<input type="hidden" id="b_code" name="b_code"
									value="${result.code }" />
								</form>
							</div>

							<div class="container">
								<form id="commentListForm" name="commentListForm" method="post">
									<div id="commentList"></div>
								</form>
							</div>




							<!-- Submit success message-->
							<!---->
							<!-- This is what your users will see when the form-->
							<!-- has successfully submitted-->

							<!-- Submit error message-->
							<!---->
							<!-- This is what your users will see when there is-->




							<!-- Footer-->

							<script
								src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
							<!-- Core theme JS-->
							<script src="js/scripts.js"></script>
							<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
							<!-- * *                               SB Forms JS                               * *-->
							<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
							<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
							<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>
