package Comment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet { //httpservlet 받기 
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// post방식으로 보내는 것 
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String writer =request.getParameter("writer");
		String contents =request.getParameter("comtents");
		//변수를 파라미터로 받아오는 과정
		if(writer == null || writer.equals("") || contents == null || contents.equals(""));
	//변수가 비워져 있는지 확인하는 코드
	request.getSession().setAttribute("messageType","오류 메시지");
	request.getSession().setAttribute("messageContent","모든 내용을 입력하시오");
	response.sendRedirect("main1.jsp");
	return;
	}
}