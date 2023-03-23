package DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class DBCRUDTest {
	
	
	//필수객체 선언
	static Connection con = null;
	static PreparedStatement psmt = null;
	static ResultSet rs = null;
	static Scanner sc = new Scanner(System.in);
	
	//db필드
	static String uid;
	static String uname;
	static String email;
	static Date rdate;
	
	//드라이브 연결 메서드
	static void connectionDB() throws SQLException {
		
		//드라이브 로딩
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("드라이브 로딩");
			
		} catch(ClassNotFoundException e) {
			System.out.println("JDBC드라이버 로딩 오류");
			e.printStackTrace();
			return;
		}
		
		// DB연결
		try {
			//DB연결
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pnusw36", "root", "1234");
			System.out.println("DB연결완료");

		}catch (SQLException e) {
			System.out.println("DB 연결 오류");
			e.printStackTrace();
		}		
	}
	
	//데이터 입력 메서드
	static void insertDB() {
		
		try {
			System.out.println("데이터를 입력합니다.");
			System.out.println("입력 할 ID를 입력하세요 : ");
			uid = sc.next();
			
			String delId = "";
			String isID = "";
			
			psmt = con.prepareStatement("SELECT uid FROM deluser WHERE uid=?;");
			psmt.setString(1, uid);
			rs = psmt.executeQuery();
			if (rs.next()) 
				delId = rs.getString(1);
			
			psmt = con.prepareStatement("SELECT uid FROM user WHERE uid=?;");
			psmt.setString(1, uid);
			rs = psmt.executeQuery();
			if (rs.next()) 
				isID = rs.getString(1);
			
			if(delId.equals(uid) || isID.equals(uid)) {
				System.out.println("이미 존재하는 ID입니다. 다른 ID를 입력해 주세요.");
			}
			else {
				System.out.print("이름을 입력하세요 : ");
				uname = sc.next();
				System.out.print("이메일주소를 입력하세요 : ");
				email = sc.next();
				
				psmt = con.prepareCall("{CALL InsertUser(?, ?, ?)}");
				psmt.setString(1, uid);
				psmt.setString(2, uname);
				psmt.setString(3, email);
				psmt.executeUpdate();
			}

		} catch(SQLException e) {
			System.out.println("검색 및 입력 시 예외 발생");
			e.printStackTrace();
		}
		
	}
	
	//데이터 삭제 메서드
	static void deleteDB() {
		
		
		try {
			System.out.println("데이터를 삭제합니다.");
			System.out.println("삭제 할 ID를 입력하세요 : ");
			uid = sc.next();
			
			psmt = con.prepareCall("{CALL SearchUser(?)}");
			psmt.setString(1, uid);
			rs = psmt.executeQuery();
			
			if(rs.next()) {		
				psmt = con.prepareCall("{CALL DeleteUser(?)}");
				psmt.setString(1, uid);
				psmt.executeUpdate();
			}
			else {
				System.out.println("삭제할 ID가 존재하지 않습니다.");
			}

		} catch(SQLException e) {
			System.out.println("검색 및 삭제 시 예외 발생");
			e.printStackTrace();
		}
	}
	
	//데이터 검색 메서드
	static void searchDB() {
		
		try {
			System.out.println("데이터를 검색합니다.");
			System.out.println("검색 할 ID를 입력하세요 : ");
			uid = sc.next();
			
			psmt = con.prepareCall("{CALL SearchUser(?)}");
			psmt.setString(1, uid);
			rs = psmt.executeQuery();

			while(rs.next()) {
				System.out.println("uid    name    email    rdate");
				uid = rs.getString(1);
				uname = rs.getString(2);
				email = rs.getString(3);
				rdate = rs.getDate(4);
				System.out.printf("(%2s) %5s %s %s", uid, uname, email, rdate);
				System.out.println();
			}
		} catch(SQLException e) {
			System.out.println("검색 시 예외 발생");
			e.printStackTrace();
		}
		
		
	}
	
	//데이터 수정 메서드
	static void updateDB() throws SQLException {
		
		try {
			System.out.println("데이터를 수정합니다.");
			System.out.println("수정 할 ID를 입력하세요 : ");
			uid = sc.next();
			
			psmt = con.prepareCall("{CALL SearchUser(?)}");
			psmt.setString(1, uid);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				System.out.print("수정할 이메일주소를 입력하세요 : ");
				email = sc.next();
				
				psmt = con.prepareCall("{CALL UpdateUserEmail(?, ?)}");
				psmt.setString(1, uid);
				psmt.setString(2, email);
				psmt.executeUpdate();

			}
			else {
				System.out.println("수정할 ID가 존재하지 않습니다.");
			}

		} catch(SQLException e) {
			System.out.println("검색 시 예외 발생");
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) throws SQLException {
	
		//db연결
		System.out.println("DB를 연결합니다.");
		DBCRUDTest.connectionDB();
		
		//메뉴 입력
		int num;
		
		do {
			System.out.println("==== 메뉴 선택 ====");
			System.out.println("(0) Print (1)Insert  (2)Delete  (3)Search  (4)Update  (5)Quit");
			num = sc.nextInt();
			
			switch(num) {
			
			case 0: //전체 출력
				try {
					System.out.println("전체 자료 출력");
					psmt = con.prepareStatement("SELECT * FROM user;");
					rs = psmt.executeQuery();
					
					System.out.println("uid    name    email    rdate");
					while(rs.next()) {
						
						uid = rs.getString(1);
						uname = rs.getString(2);
						email = rs.getString(3);
						rdate = rs.getDate(4);
						System.out.printf("(%2s) %5s %s %s", uid, uname, email, rdate);
						System.out.println();
					}
					break;
					
				} catch(SQLException e) {
					System.out.println("데이터 조회 중 오류 발생");
					e.printStackTrace();
				}
				
			case 1: //입력
				DBCRUDTest.insertDB();
				break;
				
			case 2: //삭제
				DBCRUDTest.deleteDB();
				break;
				
			case 3: //검색
				DBCRUDTest.searchDB();
				break;
				
			case 4: //수정
				DBCRUDTest.updateDB();
				break;
				
			case 5:
				System.out.println("프로그램 종료");
				if(rs!=null) rs.close();
				if(psmt!=null) psmt.close();
				if(con!=null) con.close();
				break;
				
			}
		} while(num!=5);

	}
}
