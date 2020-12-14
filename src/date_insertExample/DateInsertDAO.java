package date_insertExample;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DateInsertDAO {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	String id = "scott";
	String pw = "tiger";
	String url = "jdbc:oracle:thin:@localhost:1521:system";
	
	public void getCon() {
		try {
			//1.해당 db를 사용한다고 선언(클래스 등록 =오라클사용)
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//2.해당 db에접속
			con = DriverManager.getConnection(url, id, pw);
		}catch (Exception e) {
			
		}
	}
	
	public void insertDate(DateBean dbean) {
		getCon();
		try {
			String sql="INSERT INTO insertdate VALUES(SYSDATE,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dbean.getWhat());
			pstmt.setInt(2, dbean.getNum());
			pstmt.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public DateBean confirm(int num) {
		getCon();
		DateBean dbean = new DateBean();
		try {
		String sql = "SELECT * FROM insertdate WHERE num=?";
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			dbean.setSysdate(rs.getDate(1).toString());
			dbean.setWhat(rs.getString(2));
			dbean.setNum(rs.getInt(3));
		}
		con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dbean;
	}
}
