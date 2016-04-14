/*
 * Projeto Futebol
 * 
 */
package org.usp.futebol;

import java.sql.*;
import org.usp.database.*;

// TODO: Auto-generated Javadoc
/**
 * The Class Classificacao.
 */
public class Classificacao {
	
	/** The id camp. */
	private int idCamp;
	
	/** The cnpj clube. */
	private String cnpjClube;
	
	/** The nome clube. */
	private String nomeClube;
	
	/** The nome eq. */
	private String nomeEq;	
	
	/** The pontos vitoria. */
	private int pontosVitoria;
	
	/** The pontos empate. */
	private int pontosEmpate;
	
	/** The pontos derrota. */
	private int pontosDerrota;
	
	/** The pontos ganhos. */
	private int pontosGanhos;
	
	/** The saldo gols. */
	private int saldoGols;
	
	/**
	 * Instantiates a new classificacao.
	 */
	public Classificacao() {
		this.idCamp = 0;
		this.cnpjClube = null;
		this.nomeClube = null;
		this.nomeEq = null;	
		this.pontosVitoria = 0;
		this.pontosEmpate = 0;
		this.pontosDerrota = 0;
		this.pontosGanhos = 0;
		this.saldoGols = 0;
	}
	
	/**
	 * Gets the id camp.
	 * 
	 * @return the id camp
	 */
	public int getIdCamp() {
		return idCamp;
	}

	/**
	 * Sets the id camp.
	 * 
	 * @param idCamp the new id camp
	 */
	public void setIdCamp(int idCamp) {
		this.idCamp = idCamp;
	}

	/**
	 * Gets the cnpj clube.
	 * 
	 * @return the cnpj clube
	 */
	public String getCnpjClube() {
		return cnpjClube;
	}
	
	/**
	 * Sets the cnpj clube.
	 * 
	 * @param cnpjClube the new cnpj clube
	 */
	public void setCnpjClube(String cnpjClube) {
		this.cnpjClube = cnpjClube;
	}

	/**
	 * Gets the nome clube.
	 * 
	 * @return the nome clube
	 */
	public String getNomeClube() {
		return nomeClube;
	}

	/**
	 * Sets the nome clube.
	 * 
	 * @param nomeClube the new nome clube
	 */
	public void setNomeClube(String nomeClube) {
		this.nomeClube = nomeClube;
	}
	
	/**
	 * Gets the nome eq.
	 * 
	 * @return the nome eq
	 */
	public String getNomeEq() {
		return nomeEq;
	}

	/**
	 * Sets the nome eq.
	 * 
	 * @param nomeEq the new nome eq
	 */
	public void setNomeEq(String nomeEq) {
		this.nomeEq = nomeEq;
	}

	/**
	 * Gets the pontos vitoria.
	 * 
	 * @return the pontos vitoria
	 */
	public int getPontosVitoria() {
		return pontosVitoria;
	}

	/**
	 * Sets the pontos vitoria.
	 * 
	 * @param pontosVitoria the new pontos vitoria
	 */
	public void setPontosVitoria(int pontosVitoria) {
		this.pontosVitoria = pontosVitoria;
	}

	/**
	 * Gets the pontos empate.
	 * 
	 * @return the pontos empate
	 */
	public int getPontosEmpate() {
		return pontosEmpate;
	}

	/**
	 * Sets the pontos empate.
	 * 
	 * @param pontosEmpate the new pontos empate
	 */
	public void setPontosEmpate(int pontosEmpate) {
		this.pontosEmpate = pontosEmpate;
	}

	/**
	 * Gets the pontos derrota.
	 * 
	 * @return the pontos derrota
	 */
	public int getPontosDerrota() {
		return pontosDerrota;
	}

	/**
	 * Sets the pontos derrota.
	 * 
	 * @param pontosDerrota the new pontos derrota
	 */
	public void setPontosDerrota(int pontosDerrota) {
		this.pontosDerrota = pontosDerrota;
	}

	/**
	 * Gets the pontos ganhos.
	 * 
	 * @return the pontos ganhos
	 */
	public int getPontosGanhos() {
		return pontosGanhos;
	}

	/**
	 * Sets the pontos ganhos.
	 * 
	 * @param pontosGanhos the new pontos ganhos
	 */
	public void setPontosGanhos(int pontosGanhos) {
		this.pontosGanhos = pontosGanhos;
	}

	/**
	 * Gets the saldo gols.
	 * 
	 * @return the saldo gols
	 */
	public int getSaldoGols() {
		return saldoGols;
	}

	/**
	 * Sets the saldo gols.
	 * 
	 * @param saldoGols the new saldo gols
	 */
	public void setSaldoGols(int saldoGols) {
		this.saldoGols = saldoGols;
	}

	/**
	 * Select all.
	 * 
	 * @param db the db
	 * 
	 * @return the result set
	 * 
	 * @throws Exception the exception
	 */
	public static ResultSet selectAll(Database db) throws Exception { 
		return 
		  db.query("SELECT idCamp, cnpjClube, nomeEq, pontosVitoria, pontosEmpate, pontosDerrota, pontosGanhos, saldoGols " + 
                   "FROM classificacao");
	}
	
	/**
	 * Select by primary key.
	 * 
	 * @param db the db
	 * @param idCamp the id camp
	 * @param cnpjClube the cnpj clube
	 * 
	 * @return the result set
	 * 
	 * @throws Exception the exception
	 */
	public static ResultSet selectByPrimaryKey(Database db, 
			int idCamp, int cnpjClube) throws Exception { 
		return 
		  db.query("SELECT idCamp, cnpjClube, nomeEq, pontosVitoria, pontosEmpate, pontosDerrota, pontosGanhos, saldoGols" +
		  		   " FROM classificacao" +
				   " WHERE idCamp = '" + idCamp + "'" + 
				   " AND cnpjClube = '" + cnpjClube + "'");
	}
	
	/**
	 * Select by id camp.
	 * 
	 * @param db the db
	 * @param idCamp the id camp
	 * 
	 * @return the result set
	 * 
	 * @throws Exception the exception
	 */
	public static ResultSet selectByIdCamp(Database db, 
			int idCamp) throws Exception { 
		return  
		  db.query("SELECT apelidoClube, nomeEq, pontosVitoria,"  +
				   " pontosEmpate, pontosDerrota, pontosGanhos, saldoGols" + 
				   " FROM view_classificacao" +
				   " WHERE idCamp = '" + idCamp + "'" + 
				   " ORDER BY (pontosGanhos) DESC");
	}
	
	/**
	 * Next class.
	 * 
	 * @param rs the rs
	 * 
	 * @return the classificacao
	 * 
	 * @throws Exception the exception
	 */
	public static Classificacao nextClass(ResultSet rs) throws Exception {
		if (rs.next()) {
			Classificacao classificacao = new Classificacao();
			classificacao.setNomeEq(rs.getString("nomeEq"));
			classificacao.setNomeClube(rs.getString("apelidoClube"));
			classificacao.setPontosVitoria(rs.getInt("pontosVitoria"));
			classificacao.setPontosEmpate(rs.getInt("pontosEmpate"));
			classificacao.setPontosDerrota(rs.getInt("pontosDerrota"));
			classificacao.setPontosGanhos(rs.getInt("pontosGanhos"));
			classificacao.setSaldoGols(rs.getInt("saldoGols"));
			return classificacao;
		}
		return null;
	}	
	
	/**
	 * Next.
	 * 
	 * @param rs the rs
	 * 
	 * @return the classificacao
	 * 
	 * @throws Exception the exception
	 */
	public static Classificacao next(ResultSet rs) throws Exception {
		if (rs.next()) {
			Classificacao classificacao = new Classificacao();
			classificacao.setIdCamp(rs.getInt("idCamp"));
			classificacao.setCnpjClube(rs.getString("cnpjClube"));
			classificacao.setNomeEq(rs.getString("nomeEq"));
			classificacao.setNomeClube(rs.getString("apelidoClube"));
			classificacao.setPontosVitoria(rs.getInt("pontosVitoria"));
			classificacao.setPontosEmpate(rs.getInt("pontosEmpate"));
			classificacao.setPontosDerrota(rs.getInt("pontosDerrota"));
			classificacao.setPontosGanhos(rs.getInt("pontosGanhos"));
			classificacao.setSaldoGols(rs.getInt("saldoGols"));
			return classificacao;
		}
		return null;
	}	

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return 
			this.idCamp + ", " +
			this.cnpjClube + ", " +
			this.nomeEq + ", " +	
			this.pontosVitoria + ", " +
			this.pontosEmpate + ", " +
			this.pontosDerrota + ", " +
			this.pontosGanhos;	
	}
}
