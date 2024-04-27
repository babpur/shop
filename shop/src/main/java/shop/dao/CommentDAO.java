package shop.dao;

import  java.util.*;
import  java.sql.*;

public class CommentDAO {
	
	// 후기 입력이 가능한 사람 조회
	public static ArrayList<HashMap<String, Object>> reviewWriteList(String mail, int productNo)
			throws Exception{
		ArrayList<HashMap<String, Object>> reviewWriteList = new ArrayList<>();
		
		System.out.println("reviewWriteList commetDAO: " + mail );
		System.out.println("reviewWriteList commetDAO" + productNo);
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
	
		String sql = "SELECT *" + " FROM orders" + " WHERE mail = ?"
				+ " AND state = '배송 완료'";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, productNo);
		System.out.println("reviewWriteList commetDAO" + stmt);
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> l = new HashMap<>();
			l.put("ordersNo", rs.getInt("ordersNo"));
			l.put("createDate", rs.getString("createDate"));
			reviewWriteList.add(l);
		}
		
		conn.close();
		return reviewWriteList;
	}
	
	// 보여질 후기의 개수
	/*
	 * String sql = "SELECT o.product_no, c.score, c.content" + " FROM COMMENT c" +
	 * " INNER JOIN orders o" + " ON c.orders_no = o.orders_no" +
	 * " WHERE o.product_no = ?" + " LIMIT 0, 5";
	 */
	
	// 본인이 작성한 본인 후기 삭제하기 delete
	public static int deleteMyReview(int ordersNo, String mail) 
			throws Exception{
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		
		String sql = "DELETE c"
				+ " FROM comment c"
				+ " INNER JOIN orders o"
				+ " ON c.orders_no = ?"
				+ " WHERE o.mail = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		stmt.setString(2, mail);
		System.out.println( "deleteMyReview commetDAO" + stmt);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	// 고객이 작성한 후기를 삭제하면 다시 state를 '배송 완료'로 변경 
	public static int deleteMyReviewState(int ordersNo) 
			throws Exception{
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		String sql = "UPDATE orders SET state = '배송 완료' WHERE orders_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	
	// deleteCommentAction.jsp
	public static int deleteComment(int ordersNo)
		throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "DELETE" + " FROM comment" + " WHERE orders_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	// addCommentAction.jsp
	// 후기 입력
	public static int insertComment(int score, String content)
		throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO comment(score, content)" + " VALUES(?, ?)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, score);
		stmt.setString(2, content);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
		
}
