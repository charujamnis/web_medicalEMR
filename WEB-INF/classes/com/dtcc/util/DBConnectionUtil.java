package com.dtcc.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectionUtil{

    private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost/medicalemr?useSSL=false";
    private static final String USER = "root";
    //static final String PASS = "Root2020";
    private static final String PASS = "LearnHiber12@!";
    private static Connection connection=null;

    public static Connection getConnection(){
        try {

        	if(connection !=null){return connection;}
        	else{
        		Class.forName(JDBC_DRIVER);
            	connection= DriverManager.getConnection(DB_URL,USER,PASS);
                //System.out.println("the connection "+connection);
        	}
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return connection;
    }
}