package hanibal.ibs.library;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import org.apache.log4j.Logger;

public class MysqlConnect {
	public static Connection con;
	public static ResultSet rs;
	public static Statement st;
	public static PreparedStatement psmt;
	public static CallableStatement csmt;
	static Logger log = Logger.getLogger(MysqlConnect.class);
	
	public MysqlConnect(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch (ClassNotFoundException e) {
			log.info("!!!!!!!-DB DRIVER LOADING FAIL-!!!!!!!");
		}
	}

	public static void dbConnect(String propsPath) throws IOException{
		String properties=propsPath;
		Properties props=new Properties();
		FileInputStream file=new FileInputStream(properties);
		props.load(new java.io.BufferedInputStream(file));
		log.info(props.getProperty("jdbc.url"));
		try {
			con = DriverManager.getConnection(props.getProperty("jdbc.url"),props.getProperty("jdbc.username"),props.getProperty("jdbc.password"));
			log.info("*****DB CONNECT SUCCESS*******");
		}catch(SQLException E){
			log.info("!!!!!!!-DB CONNECT FAIL-!!!!!!!");
		}
	}
	public static void dbClose(){
		try {
			if(rs != null) rs.close();
			if(st != null) st.close();
			if(psmt != null) psmt.close();
			if(csmt != null) csmt.close();
			if(con != null) con.close();
		}catch (SQLException e) {
			log.info("!!!!!!!-QUERY FAIL-!!!!!!!");
		}
	}
}

