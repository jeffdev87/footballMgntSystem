package org.usp.futebol;

import java.sql.ResultSet;

import org.usp.database.Database;

public class Equipe {
	private String cnpjClube;
	private String nomeClube;
	private String nomeEq;
	private int nroJogadoresEq;
	private int nroTitulosEq;
	
	public Equipe() {
		this.cnpjClube = null;
		this.nomeEq = null;
		this.nomeClube = null;
		this.nroJogadoresEq = 0;
		this.nroTitulosEq = 0;
	}
	
	public Equipe(String cnpjClube, String nomeEq) throws Exception {
		Database db = new Database();
		ResultSet rs = findByPrimaryKey(db, cnpjClube, nomeEq);

		if (rs.next()){
			System.out.println(cnpjClube +" "+ nomeEq);
			
			this.cnpjClube = cnpjClube;
			this.nomeEq = nomeEq;
		}
		db.close();
		System.out.println(this.toString());
	}
	
	public String getCnpjClube() {
		return cnpjClube;
	}
	
	public String getNomeEq() {
		return nomeEq;
	}
	
	public int getNroJogadoresEq() {
		return nroJogadoresEq;
	}
	
	public int getNroTitulosEq() {
		return nroTitulosEq;
	}
	
	public void setCnpjClube(String cnpjClube) {
		this.cnpjClube = cnpjClube;
	}
	
	public void setNomeEq(String nomeEq) {
		this.nomeEq = nomeEq;
	}
	
	public void setNroJogadoresEq(int nroJogadoresEq) {
		this.nroJogadoresEq = nroJogadoresEq;
	}
	
	public void setNroTitulosEq(int nroTitulosEq) {
		this.nroTitulosEq = nroTitulosEq;
	}
	
	public void insert() throws Exception { 
		Database db = new Database();
		db.update("INSERT INTO Equipe VALUES ("+this.cnpjClube+", '"+this.nomeEq+
					"', '"+this.nroJogadoresEq+"', '"+this.nroTitulosEq+"')");
		db.commit();
		db.close();
	}
	
	public void remove() throws Exception { 
		Database db = new Database();
		db.update("DELETE FROM Equipe WHERE cnpjClube="+this.cnpjClube+" AND nomeEq='"+this.nomeEq+"'");
		db.commit();
		db.close();
	}
	
	public void update() throws Exception { 
		Database db = new Database();
		System.out.println(this.toString());
		db.update("UPDATE Equipe SET cnpjClube="+this.cnpjClube+", nomeEq='"+this.nomeEq+"', nroJogadoresEq="+this.nroJogadoresEq+", nroTitulosEq="+this.nroTitulosEq+" WHERE cnpjClube="+this.cnpjClube+" AND nomeEq='"+this.nomeEq+"'");
		db.commit();
		db.close();
	}

	public static ResultSet findAll(Database db) throws Exception { 
		return db.query("SELECT cnpjClube, nomeEq, nroJogadoresEq, nroTitulosEq FROM Equipe");
	}
	
	public static ResultSet findTODO(Database db) throws Exception { 
		return db.query("SELECT e.cnpjClube, c.nomeClune,  e.nomeEq, e.nroJogadoresEq, e.nroTitulosEq FROM Equipe e JOIN Clube c ON c.cnpjClube = e.cnpjClube ");
	}
	
	public static ResultSet findByPrimaryKey(Database db, String cnpjClube, String nomeEq) throws Exception {
		return db.query("SELECT cnpjClube, nomeEq, nroJogadoresEq, nroTitulosEq FROM Equipe WHERE cnpjClube="+cnpjClube+" AND nomeEq='"+nomeEq+"'");
	}

	public static ResultSet findByClube(Database db, String cnpjClube) throws Exception { 
		return db.query("SELECT cnpjClube, nomeEq, nroJogadoresEq, nroTitulosEq FROM Equipe WHERE cnpjClube="+cnpjClube);
	}

	public static Equipe next(ResultSet rs) throws Exception {
		if (rs.next()) {
			Equipe eq = new Equipe();
			eq.setCnpjClube(rs.getString(1));
			eq.setNomeEq(rs.getString(2));
			eq.setNroJogadoresEq(rs.getInt(3));
			eq.setNroTitulosEq(4);
			return eq;
		}
		return null;
	}

	public static Equipe nextTODO(ResultSet rs) throws Exception {
		if (rs.next()) {
			Equipe eq = new Equipe();
			eq.setCnpjClube(rs.getString(1));
			eq.setNomeClube(rs.getString(2));
			eq.setNomeEq(rs.getString(3));
			eq.setNroJogadoresEq(rs.getInt(4));
			eq.setNroTitulosEq(5);
			return eq;
		}
		return null;
	}

	public String toString() {
		return "Equipe [cnpjClube=" + this.cnpjClube + ", nomeEq=" + this.nomeEq
				+ ", nroJogadoresEq=" + this.nroJogadoresEq + ", nroTitulosEq="
				+ this.nroTitulosEq + "]";
	}

	public void setNomeClube(String nomeClube) {
		this.nomeClube = nomeClube;
	}

	public String getNomeClube() {
		return nomeClube;
	}
	
}
