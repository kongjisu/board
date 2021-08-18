package board_Data;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	
	private Connection conn; //db�� �����ϴ� ��ü
	private ResultSet rs; //db�����͸� ���� �� �ִ� ��ü
	
	
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
	
	public String getDate() //������ �ð��� �־�
	{
		String SQL ="SELECT NOW()"; //���� �ð��� ��Ÿ���� mysql
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
				
				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return ""; //db ����
}
	
	public int getNext()
	{
		String SQL = "SELECT bbsID FROM forum ORDER BY bbsID DESC"; //������������ ���� �������� ���� ���� �����´�.
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				
				return rs.getInt(1)+1;//�״��� �Խñ��� ��ȣ
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();	
			
		}
		return -1;//db����
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
        return -1; // �����ͺ��̽� ����
        
    }

	   public ArrayList<BbsJava> getList(int pageNumber)
	    {
	        String SQL = "SELECT * FROM forum WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10"; // ������������ ���� �������� ���� ���� �����´�
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
    return null; // �����ͺ��̽� ����
    
}
}