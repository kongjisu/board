
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="notice_board.userDAO"%>
<%@page import="java.io.PrintWriter"%>
<jsp:useBean id="UserJava" class="notice_board.UserJava" scope="page" />
<jsp:setProperty name="UserJava" property="userID" />
<jsp:setProperty name="UserJava" property="userPassword" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>로그인</h1>
	<% 
	// 현재 세션상태 체크
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID =(String)session.getAttribute("userID");
		
		}
	if(userID != null)
	{
		 PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('이미 로그인 되어 있음')");
	        script.println("location.href = 'main.jsp'");
	        script.println("</script>");
	}
		
	userDAO dao = new userDAO();
	int result = dao.login(UserJava.getUserID(), UserJava.getUserPassword());
	
	if (result == 1){ //성공했을 시 
		session.setAttribute("userID",UserJava.getUserID()); 
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    }
    else if (result == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호가 틀립니다.')");
        script.println("history.back()");    // 이전 페이지로 사용자를 보냄
        script.println("</script>");
    }
    else if (result == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('존재하지 않는 아이디입니다.')");
        script.println("history.back()");    // 이전 페이지로 사용자를 보냄
        script.println("</script>");
    }
    else if (result == -2){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('DB 오류가 발생했습니다.')");
        script.println("history.back()");    // 이전 페이지로 사용자를 보냄
        script.println("</script>");
    }
	
%>

</body>
</html>
>
