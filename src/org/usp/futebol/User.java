package org.usp.futebol;

import java.sql.*;
import org.usp.database.*;

/**
 * This is the class User (JavaBean)
 * @author TPW
 */
public class User {
	/**
	 * This is the email
	 */
	private String email;
	/**
	 * This is the password
	 */
	private String password;
	/**
	 * This is the name
	 */
	private String name;

	// Todas as noticias daquele usuario

	/**
	 * This is the constructor
	 */
	public User() {
		this.email = null;
		this.password = null;
		this.name = null;
	}

	public User(String email) throws Exception {
		Database db = new Database();
		ResultSet rs = findByPrimaryKey(db, email);
		/*
		User user = next(rs);
		this.email = user.getEmail();
		this.password = user.getPassword();
		this.name = user.getName();
		*/
		
		if (rs.next()) {
			this.email = rs.getString("email");
			this.password = rs.getString("password");
			this.name = rs.getString("name");
		}

		db.close();
	}

	public void setEmail (String value) { this.email = value; } 
	public void setPassword (String value){ this.password = value; } 
	public void setName (String value) { this.name = value; } 
	// public void setNews() {}

	public String getEmail() { return this.email; }
	public String getPassword() { return this.password; }
	public String getName() { return this.name; }
	public ResultSet getNews(Database db) throws Exception {
		return db.query("select id, title, body, date, expire,"+
			       	"url, email from NNews where email = '"+
				this.email+"'");
	}

	public void insert() throws Exception { 
		Database db = new Database();
		db.update("insert into NUser (email, password, name) values ('"+this.email+"', '"+this.password+"', '"+this.name+"')");
		db.close();
	}
	public void remove() throws Exception { 
		Database db = new Database();
		db.update("delete from NUser where email = '"+this.email+"'");
		db.close();
	}
	public void update() throws Exception { 
		Database db = new Database();
		db.update("update NUser "+
				"set password = '"+this.password+"', "+
				"name = '"+this.name+"' where "+
				"email = '"+this.email+"'");
		db.close();
	}

	public static ResultSet findAll(Database db) throws Exception { 
		return 
		  db.query("select email, password, name from NUser");
	}
	public static ResultSet findByPrimaryKey(Database db, 
			String email) throws Exception { 
		return 
		  db.query("select email, password, name from NUser "+
				  "where email = '"+email+"'");
	}
	public static ResultSet findByName(Database db,
			String name) throws Exception { 
		return 
		  db.query("select email, password, name from NUser "+
				  "where name like '%"+name+"%'");
	}

	public static User next(ResultSet rs) throws Exception {
		if (rs.next()) {
			User user = new User();
			user.setEmail(rs.getString("email"));
			user.setPassword(rs.getString("password"));
			user.setName(rs.getString("name"));
			return user;
		}
		return null;
	}

	public String toString() {
		return this.email+", "+
			this.password+", "+
			this.name;
	}

	/**
	 * Teste de unidade numero 01
	 */
	public static void unitTest01() throws Exception {
		User user = new User();
		user.setEmail("teste@teste.org");
		user.setPassword("senha");
		user.setName("Teste");
		user.insert();
	}

	public static void unitTest02() throws Exception {
		User user = new User("teste@teste.org");
		System.out.println(user.toString());
	}

	public static void unitTest03() throws Exception {
		User user = new User("teste@teste.org");
		user.setName("Novo Nome");
		user.setPassword("Nova Senha");
		user.update();
	}

	public static void unitTest04() throws Exception {
		User user = new User("teste@teste.org");
		user.remove();
	}

	/**
	 * Teste de unidade
	 */
	public static void main(String args[]) throws Exception {
		User.unitTest01();
		User.unitTest02();
		User.unitTest03();
		User.unitTest02();
		User.unitTest04();
	}
}
