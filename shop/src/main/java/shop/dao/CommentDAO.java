package shop.dao;

import  java.util.*;
import  java.sql.*;

public class CommentDAO {
	
	// 후기 작성 가능한지 확인 
	public static String reviewStateCk(String mail, int productNo) throws Exception{
		String stateCk = null;
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT orders_no ordersNo, state"
				+ " FROM orders"
				+ " WHERE mail = ?"
				+ " AND product_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, productNo);
		System.out.println("reviewStateCk commetDAO stmt: " + stmt);
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			if(rs.getString("state").equals("배송 완료")) {
				stateCk = "배송 완료";
			} else {
				stateCk = "구매 이력 없음";
			}
		}
		
		conn.close();
		return stateCk;
	}
	
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
			l.put("ordersNo", rs.getInt("orders_no"));
			l.put("createDate", rs.getString("create_date"));
			reviewWriteList.add(l);
		}
		
		conn.close();
		return reviewWriteList;
	}
	
	
	// 보여질 후기의 개수
	public static ArrayList<HashMap<String, Object>> selectCommentList(int productNo) 
			throws Exception{
		ArrayList<HashMap<String, Object>> commentList = new ArrayList<HashMap<String,Object>>();
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT *" 
				+ " FROM COMMENT c"
				+ " INNER JOIN orders o" 
				+ " ON c.orders_no = o.orders_no" 
				+ " WHERE o.product_no = ?" 
				+ " LIMIT 0, 5";
	
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);	
		
		System.out.println("CommentDAO.selectCommentList stmt: " + stmt);
		rs = stmt.executeQuery();

		while(rs.next()) {
			HashMap<String, Object> list = new HashMap<>();
			list.put("score", rs.getInt("c.score"));
			list.put("content", rs.getString("c.content"));
			list.put("orderCreateDate", rs.getString("o.create_date"));
			list.put("ordersNo", rs.getInt("o.orders_no"));
			list.put("commentCreateDate", rs.getString("c.create_date"));
			
			commentList.add(list);
		}
		
		conn.close();
		return commentList;
	}
		
	
	// 고객이 작성한 후기를 삭제하면 다시 state를 '배송 완료'로 변경 
	public static int deleteCommentState(int ordersNo) 
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
	public static int insertComment(int ordersNo, int score, String content) throws Exception{
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO comment(orders_no, score, content, create_date) VALUES (?, ?, ?, NOW())";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		stmt.setInt(2, score);
		stmt.setString(3, content);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
}
