package org.usp.futebol;

import java.sql.*;
import org.usp.database.*;
import org.usp.util.*;
import java.security.MessageDigest;

public class AdmUser {

	private String username;
	private String usermail; //PK
	private String userpass; //criptografado com MD5
	
	public AdmUser() { } //construtor vazio
	
	public AdmUser(String usermail, String userpass, String username) { //sobrecarga do construtor
		setName(username);
		setMail(usermail);
		setPass(userpass);
	}
	
	public void setName(String username) {
		this.username = username;
	}
	
	public void setMail(String usermail) {
		this.usermail = usermail;
	}
	
	public void setPass(String userpass) {
		this.userpass = userpass;
	}
	
	public String getName() {
		return this.username;
	}
	
	public String getMail() {
		return this.usermail;
	}
	
	public String getPass() {
		return this.userpass;
	}
	
	public void insert() throws Exception { 
		Database db = new Database();
		db.update("INSERT INTO admuser VALUES ('"+this.usermail+"', '"+this.userpass+"', '"+this.username+"');");
		db.close();
	}
	
	public void remove() throws Exception { 
		Database db = new Database();
		db.update("DELETE FROM admuser WHERE usermail = '"+this.usermail+"';");
		db.close();
	}
	
	public void update(Database db) throws Exception { 
		
		db.update("UPDATE admuser SET userpass='"+this.userpass+"', username='"+this.username+"' WHERE usermail='"+this.usermail+"'");
		
	}
	
	public static ResultSet findAll(Database db) throws Exception { 
		return db.query("SELECT usermail, userpass, username FROM admuser");
	}
	
	public static ResultSet findByPrimaryKey(Database db, String usermail) throws Exception { 
		return db.query("SELECT usermail, userpass, username FROM admuser WHERE usermail='"+usermail+"'");
	}
	
	public static AdmUser next(ResultSet rs) throws Exception {
		if (rs.next()) {
			AdmUser au = new AdmUser(rs.getString("usermail"), rs.getString("userpass"), rs.getString("username"));
			return au;
		}
		return null;
	}
	
	public static AdmUser login(Database db, String usermail, String userpass) throws LoginException,Exception {
		
		try {
			Interceptor.filterEmail(usermail);
		}
		catch (Exception e) {
			throw new LoginException(e.getMessage());
		}
		
		ResultSet rs = AdmUser.findByPrimaryKey(db, usermail);
		AdmUser au = AdmUser.next(rs);
		
		if (au != null) {
			if(au.getPass().equals(userpass)) {
				return au;
			}
			else {
				throw new LoginException("Senha incorreta!");
			}
		}
		throw new LoginException("Email inválido!");
	}
	
	
}
