package com.jwt.dbtools;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

//import com.jwt.Exceptions.DBExceptions;

public class DBtools 
{
	public Connection DBConnect(String username, String password) 
			throws SQLException, ClassNotFoundException {
        
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			conn = DriverManager.getConnection("jdbc:mysql://localhost/ebilling", username, password);
			return conn;
		}         
		catch (Exception e) {
        	throw e;
        }
	}
	
	public Connection DBDelete(Connection connection, String query)
            throws Exception {
        Statement stmt = null;
        try {
            stmt = connection.createStatement();
            System.out.println("DELETE " + query);
            stmt.executeUpdate("DELETE " + query);
        } catch (Exception e1) {
            throw e1;
        }
        return connection;
    }
	
	public Connection DBInsert(Connection connection, String query) 
			throws Exception {
	    Statement stmt = null;
	    try {
			stmt = connection.createStatement();
			System.out.println("INSERT INTO " + query);
	        stmt.executeUpdate("INSERT INTO " + query);
		} catch (Exception e1) {
			throw e1;
		}
	    return connection;
	}
	
	public ResultSet DBSelect(Connection connection, String query) {
	    Statement stmt = null;
	    ResultSet rs = null;
	    
	    try {
	    	System.out.println("SELECT " + query);
			stmt = connection.createStatement();
			rs = stmt.executeQuery("SELECT " + query);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
	    return rs;
	}
	
	public Connection DBUpdate(Connection connection, String query) 
			throws Exception {
	    Statement stmt = null;
	    try {
	    	System.out.println("UPDATE " + query);
			stmt = connection.createStatement();
	        stmt.executeUpdate("UPDATE " + query);
		} catch (Exception e1) {
			throw e1;
		} 
	    return connection;
	}
	
	public void DBClose(Connection connection) {
    	try {
	         if(connection != null)
	        	 connection.close();
	      } 
    	catch(SQLException se){
	         se.printStackTrace();
	      }
	}
}
