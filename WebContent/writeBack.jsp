<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="board_Data.BbsDAO"%>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="BbsJava" class="board_Data.BbsJava" scope="page" />
<jsp:setProperty name="BbsJava" property="bbsTitle" />
<jsp:setProperty name="BbsJava" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 웹사이트</title>
</head>
<body>
	<%
		String userID = null;
//로그인된사람은 회원가입페이지에 들어갈 수 없음
 		if(session.getAttribute("userID") != null)
        {
            userID = (String)session.getAttribute("userID");
        }
        if(userID == null)
        {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 하세요')");
            script.println("location.href = 'login1.jsp'");
            script.println("</script>");
        } else {
        	if(BbsJava.getBbsTitle() == null || BbsJava.getBbsContent() == null){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            BbsDAO bbsDAO = new BbsDAO();
            int result = bbsDAO.write(BbsJava.getBbsTitle(),  userID,  BbsJava.getBbsContent());
                if(result == -1){ // 글쓰기에 실패했을 경우
                    PrintWriter script = response.getWriter(); //하나의 스크립트 문장을 넣을 수 있도록.
                    script.println("<script>");
                    script.println("alert('글쓰기에 실패했습니다.')");
                    script.println("history.back()");
                    script.println("</script>");
                }
                else { // 글쓰기에 성공했을 경우
                
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("location.href= 'main1.jsp'");
                    script.println("</script>");
                    }
            }
        }
%>
</body>
</html>