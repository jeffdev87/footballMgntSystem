package org.usp.database;

import java.sql.*;
import org.usp.config.*;

public class Database implements DBConfig {
	private Connection conn;

	public Database() throws Exception {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, 
				username, password);
		conn.setAutoCommit(true);
	}

	public int update(String cmd) throws Exception {
		Statement stmt = conn.createStatement();
		int ret = stmt.executeUpdate(cmd);
		stmt.close();
		return ret;
	}
	
    public void commit() throws Exception {
        conn.commit();
    }

	public ResultSet query(String sql) throws Exception {
		Statement stmt = conn.createStatement();
		return stmt.executeQuery(sql);
	}

	public void close() throws Exception {
		conn.close();
	}

	public void beginTransaction() throws Exception {
		conn.setAutoCommit(false);
	}

	public void commitTransaction() throws Exception {
		conn.commit();
		conn.setAutoCommit(true);
	}

	public void rollbackTransaction() throws Exception {
		conn.rollback();
		conn.setAutoCommit(true);
	}
	
	public CallableStatement prepareCall(String call) throws Exception {
		return conn.prepareCall(call);
	}
	
	public Connection getConnection() {
		return conn;
	}
}
