package shop.dao;

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
	/*
	 * String sql = "DELETE" + " FROM comment" + " WHERE orders_no = ?";
	 */
	
	
	// addCommentAction.jsp
	// 후기 입력
	
	/*
	 * String sql = "INSERT INTO comment(score, content)" + " VALUES(?, ?)";
	 */
		
}
