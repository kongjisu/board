package notice_board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class userDAO {
		
			Connection conn;
			PreparedStatement pstmt;
		    ResultSet rs;
			
		public userDAO() {
			
			try {
				
				String dbURL = "jdbc:mysql://localhost:3306/board?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
				String dbID = "root";
				String dbPassword ="oxiz9535!";
				Class.forName("com.mysql.cj.jdbc.Driver"); //드라아버 인스턴스 생성
				conn = DriverManager.getConnection(dbURL,dbID,dbPassword); 
				
			}
			catch (Exception e) {
				e.printStackTrace();
				//예외처리
			}
		}
		
	public int login(String userID, String userPassword) {
		String sql = "SELECT userPassword FROM userinfo WHERE userID = ? "; //ID가 있으면 Password가 맞틑지 확인해봐라 
		try
		{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword))
					return 1;
				else
						return 0;
				
			}
			
			return -1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;
	
	}


	public int join(UserJava notice_board) {
		String sql ="INSERT INTO userinfo VALUES(?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, notice_board.getUserID());
			pstmt.setString(2, notice_board.getUserPassword());
			pstmt.setString(3, notice_board.getUserName());
			pstmt.setString(4, notice_board.getUserEmail());
		return pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;
		}
		
		
	}


