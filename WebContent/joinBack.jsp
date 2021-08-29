<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="notice_board.userDAO"%>
<%@page import="java.io.PrintWriter"%>
<jsp:useBean id="UserJava" class="notice_board.UserJava" scope="page" />
<jsp:setProperty name="UserJava" property="userID" />
<jsp:setProperty name="UserJava" property="userPassword" />
<jsp:setProperty name="UserJava" property="userName" />
<jsp:setProperty name="UserJava" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<h1>회원가입</h1>
	<%
//세션부여 
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID =(String)session.getAttribute("userID");
	
		}
		if(userID != null)
		{
	 		PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('이미 로그인되어 있음')");
        	script.println("location.href = 'main1.jsp'");
        	script.println("</script>");
		}
		
	if(UserJava.getUserID() == null || UserJava.getUserPassword() == null || UserJava.getUserName() == null|| UserJava. getUserEmail() ==  null){
		
		PrintWriter script= response.getWriter();
		   script.println("<script>");
           script.println("alert('입력이 안된 사항이 있습니다.')");
           script.println("history.back()");
           script.println("</script>");
   } else {
       userDAO userDAO = new userDAO();
       int result = userDAO.join(UserJava);
           if(result == -1){
               PrintWriter script = response.getWriter(); //하나의 스크립트 문장을 넣을 수 있도록.
               script.println("<script>");
               script.println("alert('이미 존재하는 아이디 입니다..')");
               script.println("history.back()");
               script.println("</script>");
           }
           else{
        	session.setAttribute("userID",UserJava.getUserID());  
        	PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href ='logout.jsp'");
            script.println("</script>");
            }
           }
	





%>

</body>
</html>