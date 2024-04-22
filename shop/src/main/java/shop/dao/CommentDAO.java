package shop.dao;

import  java.util.*;
import  java.sql.*;

public class CommentDAO {
	
	// 후기 입력이 가능한 사람 조회
	/*
	 * String sql = "SELECT *" + " FROM orders" + " WHERE mail = ?" +
	 * " AND state = '배송 완료'";
	 */
	
	
	// 후기 수정 불가 -> 삭제 후 생성
	/*
	 * String sql = "SELECT o.product_no, c.score, c.content" + " FROM COMMENT c" +
	 * " INNER JOIN orders o" + " ON c.orders_no = o.orders_no" +
	 * " WHERE o.product_no = ?" + " LIMIT 0, 5";
	 */
	
	
	
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
