package Comment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet { //httpservlet �ޱ� 
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// post������� ������ �� 
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String writer =request.getParameter("writer");
		String contents =request.getParameter("comtents");
		//������ �Ķ���ͷ� �޾ƿ��� ����
		if(writer == null || writer.equals("") || contents == null || contents.equals(""));
	//������ ����� �ִ��� Ȯ���ϴ� �ڵ�
	request.getSession().setAttribute("messageType","���� �޽���");
	request.getSession().setAttribute("messageContent","��� ������ �Է��Ͻÿ�");
	response.sendRedirect("main1.jsp");
	return;
	}
}