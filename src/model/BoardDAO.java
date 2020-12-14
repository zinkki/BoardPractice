package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public void getCon() {
		try {
			Context initctx = new InitialContext();
			Context envctx = (Context)initctx.lookup("java:comp/env");
			DataSource ds = (DataSource)envctx.lookup("jdbc/pool");
			con = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insertBoard(BoardBean bean) {
		
		getCon();
		
		int ref = 0;
		int re_step = 1;
		int re_level = 1;
		
		try {
		//가장 큰 ref값을 일겅오는 쿼리를 준비
			String refsql = "SELECT MAX(ref) FROM board";
			
			pstmt = con.prepareStatement(refsql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) { //결과값이 있다면!
				ref = rs.getInt(1)+1;
			} 
			//실제로 게시글 전체값을 테이블에 저장
			String sql = "INSERT INTO board VALUES(board_seq.NEXTVAL,?,?,?,?,SYSDATE,?,?,?,0,?)";
			pstmt = con.prepareStatement(sql);
			//?에 값을 맵핑해주기
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.setString(8, bean.getContent());
			
			pstmt.executeUpdate();
			
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//모든 게시글을 리턴받아주는 소스 >> 10개씩 받아올거임 boardList.jsp의 int startRow, endRow
	public Vector<BoardBean> getAllBoard(int start, int end) {
		
		//리턴할 객체 선언
		Vector<BoardBean> v = new Vector<>();
		
		getCon();
		
		try {
			//쿼리준비...ㅅㅂㅈㄴ어려움...
			String sql = "SELECT * FROM (SELECT A.*, Rownum Rnum FROM (SELECT * FROM board ORDER BY ref DESC , re_step ASC)A) WHERE Rnum >= ? AND Rnum <= ? ";
			
			//쿼리 실행객체 선언
			pstmt = con.prepareStatement(sql);
			//쿼리실행후 결과 저장
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			//데이터 개수가 몇개인지 모르기때문에 반복문을 이용하여 데이터추출
			while(rs.next()) {
				//데이터를 패키징(가방= BoardBean클래스를이용)해줌
				BoardBean bean = new BoardBean();
				bean.setBoard_num(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
				
				//패키징된 데이터를 벡터에 저장
				v.add(bean);
			}
			//자원반납
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return v;
	} 
	
	//BoardInfo의 하나의 게시글을 리턴해주는 메소드를 만들자
	public BoardBean getOneBoard(int board_num) {
		//리턴타입 선언
		BoardBean bean = new BoardBean();
		getCon();
		try {
			//조회수 증가 쿼리 <매우매우중요>
			String readsql = "UPDATE board SET readcount = readcount+1 WHERE board_num=?";
			pstmt = con.prepareStatement(readsql);
			pstmt.setInt(1, board_num);
			pstmt.executeUpdate();
			
			//쿼리준비
			String sql = "SELECT * FROM board WHERE board_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setBoard_num(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}

	//답변글이 저장되는 메소드만들기 ㅋ
		public void reWriteBoard(BoardBean bean){
			//부모글 그룹(r e f)과 글레벨(re_level),글스텝(re_step)읽어오기
			int ref = bean.getRef();
			int re_step = bean.getRe_step();
			int re_level = bean.getRe_level();
			
			getCon();
			
			try {//핵심코드!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				//부모글보다 큰 re_level의 값을 전부 1씩 증가시켜줘야됔!!!
				String levelsql = "UPDATE board SET re_level=re_level+1 WHERE ref=? AND re_level > ?";
				//쿼리실행
				pstmt = con.prepareStatement(levelsql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_level);
				
				pstmt.executeUpdate();
				//답변글 데이터를 저장
				String sql = "INSERT INTO board VALUES(board_seq.NEXTVAL,?,?,?,?,SYSDATE,?,?,?,0,?)";
				pstmt  = con.prepareStatement(sql);
				
				pstmt.setString(1, bean.getWriter());
				pstmt.setString(2, bean.getEmail());
				pstmt.setString(3, bean.getSubject());
				pstmt.setString(4, bean.getPassword());
				pstmt.setInt(5, ref);       //부모의 ref값을 넣어줍니다.
				pstmt.setInt(6, re_step+1); //답글이기에 부모글 re_step에 1을 더해줘야합니당. 
				pstmt.setInt(7, re_level+1); 
				pstmt.setString(8, bean.getContent());
				
				pstmt.executeUpdate();
				
				con.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	//boardUpdate용 , boardDelete용 하나의 게시글을 리턴(boardInfo에서 하나의 게시글리턴하는거에서 ㅈㄴ복붙해옴ㅋ
		public BoardBean getOneUpdateBoard(int board_num) {
			//리턴타입 선언
			BoardBean bean = new BoardBean();
			getCon();
			try {
				//쿼리준비
				String sql = "SELECT * FROM board WHERE board_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, board_num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					bean.setBoard_num(rs.getInt(1));
					bean.setWriter(rs.getString(2));
					bean.setEmail(rs.getString(3));
					bean.setSubject(rs.getString(4));
					bean.setPassword(rs.getString(5));
					bean.setReg_date(rs.getDate(6).toString());
					bean.setRef(rs.getInt(7));
					bean.setRe_step(rs.getInt(8));
					bean.setRe_level(rs.getInt(9));
					bean.setReadcount(rs.getInt(10));
					bean.setContent(rs.getString(11));
				}
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return bean;
		}
		
		//update와 delete시에 필요한 패스워드값을 리턴해주는 메소드
		public String getPass(int board_num) {
			//리턴할 변수 객체선언
			String pass="";  //초기값
			getCon();
			
			try {
				String sql = "SELECT password FROM board WHERE board_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, board_num);
				rs = pstmt.executeQuery();
				//패스워드값을 저장!
				if(rs.next()) { //데이터가 있다면!
					pass= rs.getString(1); //password값을 저장해라!
				}
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return pass;
		}
		
		//하나의 게시글을 수정하는 메소드
		public void updateBoard(BoardBean bean) {
			
			getCon();
			
			try {
				String sql = "UPDATE board SET subject=? , content=? WHERE board_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getSubject());
				pstmt.setString(2, bean.getContent());
				pstmt.setInt(3, bean.getBoard_num());
				pstmt.executeUpdate();
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//하나의 게시글 삭제하는 메소드!
		public void deleteBoard(int board_num) {
			
			getCon();
			
			try {
				String sql = "DELETE FROM board WHERE board_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, board_num);
				pstmt.executeUpdate();
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//전체 게시글의 갯수를 리턴하는 메소드
		public int getAllCount() {
			
			getCon();
			//게시글 전체수를 저장하는 변수
			int count = 0;
			try {
				String sql = "SELECT count(*) FROM board";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1); //전체 게시글 수
				}
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return count;
		}
		
}




