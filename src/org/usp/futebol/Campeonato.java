package org.usp.futebol;

import java.sql.*;
import org.usp.database.*;

public class Campeonato {

	private int idCamp;
	private String nomeCamp;
	private String apelidoClube;
	private int anoCamp;
	private int divisaoCamp;
	private String abrangenciaCamp;
	private String cnpjClubeVence;
	private String nomeEqVence;
	private int pontosVitoria;
	private int pontosEmpate;
	
	public Campeonato() {
		this.idCamp = 0;
		this.nomeCamp = null;
		this.anoCamp = 0;
		this.divisaoCamp = 0;
		this.abrangenciaCamp = null;
		this.cnpjClubeVence = null;
		this.nomeEqVence = null;
		this.pontosVitoria = 0;
		this.pontosEmpate = 0;
	}

	public Campeonato(int idCamp) throws Exception {
		Database db = new Database();
		ResultSet rs = findByPrimaryKey(db, idCamp);

		if (rs.next()){
			this.idCamp = rs.getInt("idCamp");
			this.nomeCamp = rs.getString("nomeCamp");
			this.anoCamp = rs.getInt("anoCamp");
			this.divisaoCamp = rs.getInt("divisaoCamp");
			this.abrangenciaCamp = rs.getString("abrangenciaCamp");
			this.cnpjClubeVence = rs.getString("cnpjClubeVence");
			this.nomeEqVence = rs.getString("nomeCamp");
			this.pontosVitoria = rs.getInt("pontosVitoria");
			this.pontosEmpate = rs.getInt("pontosEmpate");
		}
		db.close();
	}

	public int getIdCamp() {
		return idCamp;
	}

	public String getNomeCamp() {
		return nomeCamp;
	}

	public int getAnoCamp() {
		return anoCamp;
	}

	public int getDivisaoCamp() {
		return divisaoCamp;
	}

	public String getAbrangenciaCamp() {
		return abrangenciaCamp;
	}

	public String getCnpjClubeVence() {
		return cnpjClubeVence;
	}

	public String getNomeEqVence() {
		return nomeEqVence;
	}

	public int getPontosVitoria() {
		return pontosVitoria;
	}

	public int getPontosEmpate() {
		return pontosEmpate;
	}

	public void setIdCamp(int idCamp) {
		this.idCamp = idCamp;
	}

	public void setNomeCamp(String nomeCamp) {
		this.nomeCamp = nomeCamp;
	}

	public void setAnoCamp(int anoCamp) {
		this.anoCamp = anoCamp;
	}

	public void setDivisaoCamp(int divisaoCamp) {
		this.divisaoCamp = divisaoCamp;
	}

	public void setAbrangenciaCamp(String abrangenciaCamp) {
		this.abrangenciaCamp = abrangenciaCamp;
	}

	public void setCnpjClubeVence(String cnpjClubeVence) {
		this.cnpjClubeVence = cnpjClubeVence;
	}

	public void setNomeEqVence(String nomeEqVence) {
		this.nomeEqVence = nomeEqVence;
	}

	public void setPontosVitoria(int pontosVitoria) {
		this.pontosVitoria = pontosVitoria;
	}

	public void setPontosEmpate(int pontosEmpate) {
		this.pontosEmpate = pontosEmpate;
	}

	public void insert() throws Exception { 
		Database db = new Database();
		db.beginTransaction();
		db.update("INSERT INTO Campeonato VALUES (idCampSeq.NEXTVAL, '"+this.nomeCamp+
				"', '"+this.anoCamp+"', '"+this.divisaoCamp+"', '"+this.abrangenciaCamp+
				"', '"+this.cnpjClubeVence+"', '"+this.nomeEqVence+"', '"+this.pontosVitoria+
				"', '"+this.pontosEmpate+"')");
		db.commitTransaction();
		db.close();
	}
	
	public static Campeonato nextClubes(ResultSet rs) throws Exception { 
        if (rs.next()) { 
            Campeonato camp = new Campeonato(); 
            camp.setApelidoClube(rs.getString("apelidoClube"));             
            return camp; 
        } 
        return null; 
    }
	
	public void remove() throws Exception { 
		Database db = new Database();
		db.update("DELETE FROM Campeonato WHERE idCamp = '"+this.idCamp+"'");
		db.commit();
		db.close();
	}
	
	public void update() throws Exception { 
		Database db = new Database();
		db.update("UPDATE Campeonato SET nomeCamp='"+this.nomeCamp+"', anoCamp='"+this.anoCamp+
					"', divisaoCamp='"+this.divisaoCamp+"', abrangenciaCamp='"+this.abrangenciaCamp+
					"' WHERE idCamp='"+this.idCamp+"'");
		db.commit();
		db.close();
	}

	public static ResultSet findAll(Database db) throws Exception { 
		return db.query("SELECT idCamp, nomeCamp, anoCamp, divisaoCamp," +
							"abrangenciaCamp, cnpjClubeVence, nomeEqVence, pontosVitoria, " +
							"pontosEmpate FROM Campeonato");
	}
	
	public static ResultSet findByPrimaryKey(Database db, int idCamp) throws Exception { 
		return db.query("SELECT idCamp, nomeCamp, anoCamp, divisaoCamp," +
		  					"abrangenciaCamp, cnpjClubeVence, nomeEqVence, pontosVitoria, " +
		  					"pontosEmpate FROM Campeonato "+
		  				"WHERE idCamp= '"+idCamp+"'");
	}

	public static ResultSet findByName(Database db, String name) throws Exception { 
		return db.query("SELECT idCamp, nomeCamp, anoCamp, divisaoCamp," +
		  					"abrangenciaCamp, cnpjClubeVence, nomeEqVence, pontosVitoria, " +
		  					"pontosEmpate FROM Campeonato "+
		  				"WHERE nomeCamp= '"+name+"'");
	}
	
	public static ResultSet findClubes(Database db, int idCamp) throws Exception {  
        return db.query("select cl.apelidoclube " +  
                        " from eqinscrevecamp ec join clube cl on ec.cnpjclube = cl.cnpjclube" + 
                        " where ec.idcamp = '"+idCamp+"'"); 
    }

	public static Campeonato next(ResultSet rs) throws Exception {
		if (rs.next()) {
			Campeonato camp = new Campeonato();
			camp.setIdCamp(rs.getInt("idCamp"));
			camp.setNomeCamp(rs.getString("nomeCamp"));
			camp.setAnoCamp(rs.getInt("anoCamp"));
			camp.setDivisaoCamp(rs.getInt("divisaoCamp"));
			camp.setAbrangenciaCamp(rs.getString("abrangenciaCamp"));
			camp.setCnpjClubeVence(rs.getString("cnpjClubeVence"));
			camp.setNomeEqVence(rs.getString("nomeEqVence"));
			camp.setPontosVitoria(rs.getInt("pontosVitoria"));
			camp.setPontosEmpate(rs.getInt("pontosEmpate"));
			return camp;
		}
		return null;
	}

	public String toString() {
		return "Campeonato [abrangenciaCamp=" + this.abrangenciaCamp + ", anoCamp="
				+ this.anoCamp + ", cnpjClubeVence=" + this.cnpjClubeVence
				+ ", divisaoCamp=" + this.divisaoCamp + ", idCamp=" + this.idCamp
				+ ", nomeCamp=" + this.nomeCamp + ", this.nomeEqVence=" + this.nomeEqVence
				+ ", pontosEmpate=" + this.pontosEmpate + ", pontosVitoria="
				+ this.pontosVitoria + "]";
	}

	public void setApelidoClube(String apelidoClube) {
		this.apelidoClube = apelidoClube;
	}

	public String getApelidoClube() {
		return apelidoClube;
	}
	
}
