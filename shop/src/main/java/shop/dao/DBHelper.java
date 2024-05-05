package shop.dao;

import java.io.*;
import java.sql.*;
import java.util.*;

public class DBHelper {
	public static Connection getConnection()
			throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		Connection conn = null;
		
		FileReader fr = new FileReader("C:\\dev\\goodee\\auth\\mariadb.properties"); 

		Properties prop = new Properties();
		 
		// 로컬 PC의 Properties 파일 읽어 오기
		  
		prop.load(fr);
		 
		String id = prop.getProperty("id"); 
		String pw = prop.getProperty("pw");
		 
		 
		System.out.println("id: " + id); 
		System.out.println("pw: " + pw);
		

		
		conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", id, pw);
		
		
		return conn;
	}
	// getConnection() 디버깅
	public static void main(String[] args)
			throws Exception {
		Connection conn = new DBHelper().getConnection();
		System.out.println("conn: " + conn);
	}
	
}