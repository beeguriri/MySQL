package SQLConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConTest {
	
	public static void main(String[] args) throws SQLException {
		
		//1. 드라이브 로딩
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
		} catch(ClassNotFoundException e) {
			System.out.println("JDBC드라이버 로딩 오류");
			e.printStackTrace();
			return;
		}
		
		//2. 필수객체 선언
		Connection con = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		//3. DB연결 및 쿼리 실행
		try {
			//DB연결
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0220", "root", "1234");
			
			//쿼리준비
			psmt = con.prepareStatement("SELECT * FROM book");
			//psmt = con.prepareStatement("INSERT INTO book VALUES(12, '야구의 기술', '마당', 18000)");
			
			//쿼리실행(SELECT문)
			rs = psmt.executeQuery();
			
			//쿼리실행(INSERT, UPDATE, DELETE문)
			//psmt.executeUpdate();
			
			//쿼리출력
			while(rs.next()) {
				int bookid = rs.getInt(1);
				String bookname = rs.getString(2);
				String publisher = rs.getString(3);
				int price = rs.getInt(4);
				System.out.printf("(%2d) 도서명: %s, 출판사: %s, %,d원", bookid, bookname, publisher, price);
				System.out.println();
			}
			
		}catch (SQLException e) {
			System.out.println("DB 연결 오류");
			e.printStackTrace();
			
		}finally {
			
			//객체 닫기
			rs.close();
			psmt.close();
			con.close();
		}
	}
}
