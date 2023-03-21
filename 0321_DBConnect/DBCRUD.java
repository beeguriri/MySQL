package SQLConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class DBCRUD {
	
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
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0321", "root", "1234");
			
			
		}catch (SQLException e) {
			System.out.println("DB 연결 오류");
			e.printStackTrace();
			
		}
		Scanner sc = new Scanner(System.in);
        
		int num;
		
		do {
			System.out.println("==== 메뉴선택 ====");
	        System.out.println("(1)자료입력  (2)전체자료 출력  (3)ID로검색  (4)ID로 삭제  (5)ID로 이메일 갱신  (6)종료");
			num = sc.nextInt();
			int id, age;
			String name, mail; 
			
			switch(num) {
				case 1: //INSERT
					
					try {
					System.out.println("데이터를 입력합니다.");
					System.out.println("ID를 입력하세요 : ");
					id = sc.nextInt();	
					System.out.print("이름을 입력하세요 : ");
					name = sc.next();
					System.out.print("나이를 입력하세요 : ");
					age = sc.nextInt();
					System.out.print("이메일주소를 입력하세요 : ");
					mail = sc.next();
	
					psmt = con.prepareStatement("insert into user values(?, ?, ?, ?);");
					psmt.setInt(1, id);
					psmt.setString(2, name);
					psmt.setInt(3, age);
					psmt.setString(4, mail);
					psmt.executeUpdate();
						
					} catch(SQLException e) {
						
						System.out.println("ID가 중복됩니다. 다른 ID를 입력해주세요.");
						//e.printStackTrace();
					}
					
					break;
					
				case 2: 
					System.out.println("전체 자료 출력");
					psmt = con.prepareStatement("SELECT * FROM user;");
					rs = psmt.executeQuery();
					
					System.out.println(" ID    이름  나이    E-mail");
					while(rs.next()) {
						id = rs.getInt(1);
						name = rs.getString(2);
						age = rs.getInt(3);
						mail = rs.getString(4);
						System.out.printf("(%2d) %4s %3d %s",id, name, age, mail);
						System.out.println();
					}
					break;
		
				case 3:
					System.out.print("검색할 ID를 입력하세요 : ");
					id = sc.nextInt();
					
					psmt = con.prepareStatement("SELECT * FROM user WHERE id=?;");						
					psmt.setInt(1, id);
					rs = psmt.executeQuery();
					System.out.println(" ID    이름  나이    E-mail");

					while(rs.next()) {
						id = rs.getInt(1);
						name = rs.getString(2);
						age = rs.getInt(3);
						mail = rs.getString(4);
						System.out.printf("(%2d) %4s %3d %s",id, name, age, mail);
						System.out.println();
					}
					
					break;
					
				case 4:
					System.out.print("삭제할 ID를 입력하세요 : ");
					id = sc.nextInt();
					
					psmt = con.prepareStatement("DELETE FROM user WHERE id=?;");						
					psmt.setInt(1, id);
					psmt.executeUpdate();
					break;
					
				case 5:
					System.out.println("E-mail주소를 변경합니다.");
					System.out.print("ID를 입력하세요 : ");
					id = sc.nextInt();
					System.out.print("변경 할 E-mail주소를 입력하세요 : ");
					mail = sc.next(); 
						
					psmt = con.prepareStatement("UPDATE user SET mail=? WHERE id=?;");						
					psmt.setString(1, mail);
					psmt.setInt(2, id);
					psmt.executeUpdate();
					break;
					
				case 6: 
					System.out.println("프로그램을 종료합니다.");
					if(rs!=null) rs.close();
					if(psmt!=null) psmt.close();
					if(con!=null) con.close();
					break;
			}
		} while(num!=6);
	}
}
