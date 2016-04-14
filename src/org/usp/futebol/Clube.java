package org.usp.futebol;

import java.sql.*;

import org.usp.database.*;

public class Clube {
	
	private String cnpjClube;
	private String nomeClube;
	private	String apelidoClube;
	private	String logoClube;
	
	public Clube() {
		this.cnpjClube = null;
		this.nomeClube = null;
		this.apelidoClube = null;
		this.logoClube = null;
	}

	public Clube(String cnpjClube) throws Exception {
		Database db = new Database();
		ResultSet rs = findByPrimaryKey(db, cnpjClube);

		if (rs.next()){
			this.cnpjClube = rs.getString("cnpjClube");
			this.nomeClube = rs.getString("nomeClube");
			this.apelidoClube = rs.getString("apelido");
			this.logoClube = rs.getString("logoClube");
		}
		db.close();
	}
		
	public String getCnpjClube() {
		return cnpjClube;
	}

	public String getNomeClube() {
		return nomeClube;
	}

	public String getApelidoClube() {
		return apelidoClube;
	}

	public String getLogoClube() {
		return logoClube;
	}

	public void setCnpjClube(String cnpjClube) {
		this.cnpjClube = cnpjClube;
	}

	public void setNomeClube(String nomeClube) {
		this.nomeClube = nomeClube;
	}

	public void setApelidoClube(String apelidoClube) {
		this.apelidoClube = apelidoClube;
	}

	public void setLogoClube(String logoClube) {
		this.logoClube = logoClube;
	}

	public static ResultSet findAll(Database db) throws Exception { 
		return db.query("SELECT cnpjClube, nomeClube, apelidoClube, logoClube FROM Clube");
	}

	public static ResultSet findByPrimaryKey(Database db, String cnpjClube) throws Exception { 
		return db.query("SELECT cnpjClube, nomeClube, apelidoClube, logoClube FROM Clube "+
		  				"WHERE cnpjClube= '"+cnpjClube+"'");
	}

	public static Clube next(ResultSet rs) throws Exception {
		if (rs.next()) {
			Clube clube = new Clube();
			clube.setCnpjClube(rs.getString("cnpjClube"));
			clube.setNomeClube(rs.getString("nomeClube"));
			clube.setApelidoClube(rs.getString("apelidoClube"));
			clube.setLogoClube(rs.getString("logoClube"));
			return clube;
		}
		return null;
	}
	
	public void insert() throws Exception { 
		Database db = new Database();
		db.update("INSERT INTO Clube VALUES ("+this.cnpjClube+", '"+this.nomeClube+
				"', '"+this.apelidoClube+"', '"+this.logoClube+"')");
		db.commit();
		db.close();
	}

	public void remove() throws Exception { 
		Database db = new Database();
		db.update("DELETE FROM Clube WHERE cnpjClube = '"+this.cnpjClube+"'");
		db.commit();
		db.close();
	}
	
	public String toString() {
		return "Clube [apelidoClube=" + apelidoClube + ", cnpjClube="
				+ cnpjClube + ", logoClube=" + logoClube + ", nomeClube="
				+ nomeClube + "]";
	}
	
	
	
}
