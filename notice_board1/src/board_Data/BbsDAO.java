package board_Data;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	
	private Connection conn; //db에 접근하는 객체
	private ResultSet rs; //db데이터를 담을 수 있는 객체
	
	
	public BbsDAO() {
		try {
			
			String dbURL = "jdbc:mysql://localhost:3306/board?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
			String dbID = "root";
			String dbPassword ="oxiz9535!";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public String getDate() //현재의 시간을 넣어
	{
		String SQL ="SELECT NOW()"; //현재 시간을 나타내는 mysql
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
				
				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return ""; //db 오류
}
	
	public int getNext()
	{
		String SQL = "SELECT bbsID FROM forum ORDER BY bbsID DESC"; //내림차순으로 가장 마지막에 쓰인 것을 가져온다.
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				
				return rs.getInt(1)+1;//그다음 게시글의 번호
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();	
			
		}
		return -1;//db오류
		}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String sql =  "INSERT INTO forum (bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable) VALUES(?, ?, ?, ?, ?, ?)"; 
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, bbsTitle);
            pstmt.setString(3, userID);
            pstmt.setString(4, getDate());
            pstmt.setString(5, bbsContent);
            pstmt.setInt(6, 1);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
        
    }

	   public ArrayList<BbsJava> getList(int pageNumber)
	    {
	        String SQL = "SELECT * FROM forum WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10"; // 내림차순으로 가장 마지막에 쓰인 것을 가져온다
	        ArrayList<BbsJava> list = new ArrayList<BbsJava>();
	        try {
	            PreparedStatement pstmt = conn.prepareStatement(SQL);
	            pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
	            rs = pstmt.executeQuery();
	            while (rs.next()) {
	            	BbsJava bbs = new BbsJava();
	                bbs.setBbsID(rs.getInt(1));
	                bbs.setBbsTitle(rs.getString(2));
	                bbs.setUserID(rs.getString(3));
	                bbs.setBbsDate(rs.getString(4));
	                bbs.setBbsContent(rs.getString(5));
	                bbs.setBbsAvailable(rs.getInt(6));
	                list.add(bbs);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list; 
	    }
	   public boolean nextPage(int pageNumber) {
	        String SQL = "select * from forum where bbsID < ? and bbsAvailable = 1"; 
	        try {
	            PreparedStatement pstmt = conn.prepareStatement(SQL);
	            pstmt.setInt(1, getNext() - (pageNumber -1 ) * 10);
	            rs = pstmt.executeQuery();
	            if (rs.next())
	            {
	                return true;
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false; 
	    }
	
public BbsJava getBbs(int bbsID)
{
	String sql =  "SELECT * FROM forum WHERE bbsID = ?";

    try {
    	PreparedStatement pstmt = conn.prepareStatement(sql);
    	pstmt.setInt(1,bbsID);
    	rs = pstmt.executeQuery();
    	if(rs.next())
    	{
    		BbsJava bbs = new BbsJava();
    		 bbs.setBbsID(rs.getInt(1));
             bbs.setBbsTitle(rs.getString(2));
             bbs.setUserID(rs.getString(3));
             bbs.setBbsDate(rs.getString(4));
             bbs.setBbsContent(rs.getString(5));
             bbs.setBbsAvailable(rs.getInt(6));
             return bbs;
    	}
    
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null; // 데이터베이스 오류
    
}
}