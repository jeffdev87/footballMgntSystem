package org.usp.futebol;

import java.sql.*;
import org.usp.database.*;

public class Partida {

	private int idCamp;
	private int nroPartida;	
	private String cnpjClubeMandante;
	private String apelidoClubeM;
	private String nomeEqMandante;
	private String cnpjClubeVisitante;
	private String apelidoClubeV;
	private String nomeEqVisitante;
	private Date dataHoraPartida;
	private Time horaPart;
	private double valorIngresso;
	private int nroTorcedores;
	private String nomeEst;
	
	public Partida() {
		this.idCamp = 0;
		this.nroPartida = 0;	
		this.cnpjClubeMandante = null;
		this.nomeEqMandante = null;
		this.cnpjClubeVisitante = null;
		this.nomeEqVisitante = null;
		this.dataHoraPartida = null;
		this.horaPart = null;
		this.valorIngresso = 0;
		this.nroTorcedores = 0;
		this.nomeEst = null;
	}

	public int getIdCamp() {
		return idCamp;
	}

	public void setIdCamp(int idCamp) {
		this.idCamp = idCamp;
	}

	public int getNroPartida() {
		return nroPartida;
	}

	public void setNroPartida(int nroPartida) {
		this.nroPartida = nroPartida;
	}

	public String getCnpjClubeMandante() {
		return cnpjClubeMandante;
	}

	public void setCnpjClubeMandante(String cnpjClubeMandante) {
		this.cnpjClubeMandante = cnpjClubeMandante;
	}

	public String getApelidoClubeM() {
		return apelidoClubeM;
	}

	public void setApelidoClubeM(String apelidoClubeM) {
		this.apelidoClubeM = apelidoClubeM;
	}

	public String getNomeEqMandante() {
		return nomeEqMandante;
	}

	public void setNomeEqMandante(String nomeEqMandante) {
		this.nomeEqMandante = nomeEqMandante;
	}

	public String getCnpjClubeVisitante() {
		return cnpjClubeVisitante;
	}

	public void setCnpjClubeVisitante(String cnpjClubeVisitante) {
		this.cnpjClubeVisitante = cnpjClubeVisitante;
	}

	public String getApelidoClubeV() {
		return apelidoClubeV;
	}

	public void setApelidoClubeV(String apelidoClubeV) {
		this.apelidoClubeV = apelidoClubeV;
	}

	public String getNomeEqVisitante() {
		return nomeEqVisitante;
	}

	public void setNomeEqVisitante(String nomeEqVisitante) {
		this.nomeEqVisitante = nomeEqVisitante;
	}

	public Date getDataHoraPartida() {
		return dataHoraPartida;
	}

	public void setDataHoraPartida(Date date) {
		this.dataHoraPartida = date;
	}

	public double getValorIngresso() {
		return valorIngresso;
	}

	public void setValorIngresso(double valorIngresso) {
		this.valorIngresso = valorIngresso;
	}

	public int getNroTorcedores() {
		return nroTorcedores;
	}

	public void setNroTorcedores(int nroTorcedores) {
		this.nroTorcedores = nroTorcedores;
	}

	public String getNomeEst() {
		return nomeEst;
	}

	public void setNomeEst(String nomeEst) {
		this.nomeEst = nomeEst;
	}

	public void setHoraPart(Time Time) {
		this.horaPart = Time;
	}

	public Time getHoraPart() {
		return horaPart;
	}

	public void insert() throws Exception { 
		Database db = new Database();
		db.update("INSERT INTO Partida VALUES ('"+this.idCamp+"', '"+this.nroPartida+
				"', '"+this.cnpjClubeMandante+"', '"+this.nomeEqMandante+"', '"+this.cnpjClubeVisitante+
				"', '"+this.nomeEqVisitante+"', '"+this.dataHoraPartida+"', '"+this.valorIngresso+"', '"+this.nroTorcedores+"', '"+this.nomeEst+"' )");
		db.close();
	}
	public void remove() throws Exception { 
		Database db = new Database();
		db.update("DELETE FROM partida WHERE idCamp = '"+this.idCamp+"' AND nroPartida = '"+this.nroPartida+"'");
		db.close();
	}
	public void update() throws Exception { 
		Database db = new Database();
		db.update("UPDATE partida "+
					"SET idCamp='"+this.idCamp+"', nroPartida='"+this.nroPartida+"', cnpjClubeMandante='"+this.cnpjClubeMandante+
					"', nomeEqMandante'"+this.nomeEqMandante+"', cnpjClubeVisitante='"+this.cnpjClubeVisitante+
					"', nomeEqVisitante='"+this.nomeEqVisitante+"', dataHoraPartida='"+this.dataHoraPartida+
					"', valorIngresso='"+this.valorIngresso+"', nroTorcedores='"+this.nroTorcedores+"', nomeEst='"+this.nomeEst+")");
		db.close();
	}

	public static ResultSet selectAll(Database db) throws Exception { 
		return db.query("SELECT idCamp, nroPartida, cnpjClubeMandante, nomeEqMandante, cnpjClubeVisitante, " + 
					    "nomeEqVisitante, dataHoraPartida, valorIngresso, nroTorcedores, nomeEst " + 
				        "FROM partida" );
	}
	
	public static ResultSet selectByPrimaryKey(Database db, int idCamp, int nroPart) throws Exception { 
		return db.query("SELECT idCamp, nroPartida, cnpjClubeMandante, nomeEqMandante, cnpjClubeVisitante, " + 
			    		"nomeEqVisitante, dataHoraPartida, valorIngresso, nroTorcedores, nomeEst " + 
        				"FROM partida " +
        				"WHERE idCamp = '"+idCamp+"' AND nroPartida = '"+nroPart+"");
	}
	
	public static ResultSet selectUltimaPartida(Database db, int idCamp) throws Exception { 
		return db.query("SELECT nroPartida, dataHoraPartida, apelidoClubeM, apelidoClubeV, nomeest " +
		                "FROM view_partidas WHERE idcamp = '"+idCamp+"' ORDER BY datahorapartida DESC");
	}

	public static ResultSet selectPartidasNaoRealizadas(Database db, int idCamp) throws Exception { 
		return db.query("SELECT nroPartida, dataHoraPartida, apelidoClubeM, apelidoClubeV, nomeest " +
				        "FROM view_partidas vp " +
				        "WHERE vp.idcamp = '"+idCamp+"' AND " +
				        "NOT EXISTS (SELECT * FROM res r WHERE vp.idcamp = r.idcamp AND vp.nropartida = r.nropartida )" +
				        "ORDER BY vp.nropartida");
	}
	
	public static Partida next(ResultSet rs) throws Exception {
		if (rs.next()) {
			Partida part = new Partida();
			part.setIdCamp(rs.getInt("idCamp"));
			part.setNroPartida(rs.getInt("nroPartida"));
			part.setCnpjClubeMandante(rs.getString("cnpjClubeMandante"));
			part.setNomeEqMandante(rs.getString("nomeEqMandante"));
			part.setCnpjClubeVisitante(rs.getString("cnpjClubeVisitante"));
			part.setNomeEqVisitante(rs.getString("nomeEqVisitante"));
			part.setDataHoraPartida(rs.getDate("dataHoraPartida"));
			part.setHoraPart(rs.getTime("dataHoraPartida"));
			part.setValorIngresso(rs.getDouble("valorIngresso"));
			part.setNroTorcedores(rs.getInt("nroTorcedores"));
			part.setNomeEst(rs.getString("nomeEst"));
			return part;
		}
		return null;
	}
	
	public static Partida nextPart(ResultSet rs) throws Exception {
		if (rs.next()) {
			Partida part = new Partida();
			part.setNroPartida(rs.getInt("nroPartida"));
			part.setDataHoraPartida(rs.getDate("dataHoraPartida"));
			part.setHoraPart(rs.getTime("dataHoraPartida"));
			part.setApelidoClubeM(rs.getString("apelidoClubeM"));
			part.setApelidoClubeV(rs.getString("apelidoClubeV"));
			part.setNomeEst(rs.getString("nomeEst"));
			return part;
		}
		return null;
	}
}
