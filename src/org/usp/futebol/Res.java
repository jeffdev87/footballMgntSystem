/*
 * Projeto Futebol
 * 
 */
package org.usp.futebol;

import java.sql.*;

import org.usp.database.*;

// TODO: Auto-generated Javadoc
/**
 * The Class Res.
 */
public class Res {
	
	/** The id camp. */
	private int idCamp;
	
	/** The nro partida. */
	private int nroPartida;
	
	/** The cnpj clube mandante. */
	private String cnpjClubeMandante;
	
	/** The apelido clube mandante. */
	private String apelidoClubeMandante;
	
	/** The nome eq mandante. */
	private String nomeEqMandante;	
	
	/** The cnpj clube visitante. */
	private String cnpjClubeVisitante;
	
	/** The apelido clube visitante. */
	private String apelidoClubeVisitante;
	
	/** The nome eq visitante. */
	private String nomeEqVisitante;
	
	/** The data hora partida. */
	private String dataHoraPartida;
	
	/** The hora part. */
	private Time horaPart;
	
	/** The nome est. */
	private String nomeEst;
	
	/** The gols mandante. */
	private int golsMandante;
	
	/** The gols visitante. */
	private int golsVisitante;
	
	/** The time vencedor. */
	private String timeVencedor;
	
	/** The time perdedor. */
	private String timePerdedor;
	
	/**
	 * Instantiates a new res.
	 */
	public Res() {
		this.idCamp = 0;
		this.nroPartida = 0;
		this.cnpjClubeMandante = null;
		this.apelidoClubeMandante = null;
		this.nomeEqMandante = null;	
		this.cnpjClubeVisitante = null;
		this.apelidoClubeVisitante = null;
		this.nomeEqVisitante = null;
		this.dataHoraPartida = null;
		this.horaPart = null;
		this.nomeEst = null;
		this.golsMandante = 0;
		this.golsVisitante = 0;
		this.timeVencedor = null;
		this.timePerdedor = null;
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
	 * Gets the nro partida.
	 * 
	 * @return the nro partida
	 */
	public int getNroPartida() {
		return nroPartida;
	}

	/**
	 * Sets the nro partida.
	 * 
	 * @param nroPartida the new nro partida
	 */
	public void setNroPartida(int nroPartida) {
		this.nroPartida = nroPartida;
	}

	/**
	 * Gets the cnpj clube mandante.
	 * 
	 * @return the cnpj clube mandante
	 */
	public String getCnpjClubeMandante() {
		return cnpjClubeMandante;
	}

	/**
	 * Sets the cnpj clube mandante.
	 * 
	 * @param cnpjClubeMandante the new cnpj clube mandante
	 */
	public void setCnpjClubeMandante(String cnpjClubeMandante) {
		this.cnpjClubeMandante = cnpjClubeMandante;
	}

	/**
	 * Gets the apelido clube mandante.
	 * 
	 * @return the apelido clube mandante
	 */
	public String getApelidoClubeMandante() {
		return apelidoClubeMandante;
	}

	/**
	 * Sets the apelido clube mandante.
	 * 
	 * @param nomeClubeMandante the new apelido clube mandante
	 */
	public void setApelidoClubeMandante(String nomeClubeMandante) {
		this.apelidoClubeMandante = nomeClubeMandante;
	}

	/**
	 * Gets the nome eq mandante.
	 * 
	 * @return the nome eq mandante
	 */
	public String getNomeEqMandante() {
		return nomeEqMandante;
	}

	/**
	 * Sets the nome eq mandante.
	 * 
	 * @param nomeEqMandante the new nome eq mandante
	 */
	public void setNomeEqMandante(String nomeEqMandante) {
		this.nomeEqMandante = nomeEqMandante;
	}

	/**
	 * Gets the cnpj clube visitante.
	 * 
	 * @return the cnpj clube visitante
	 */
	public String getCnpjClubeVisitante() {
		return cnpjClubeVisitante;
	}

	/**
	 * Sets the cnpj clube visitante.
	 * 
	 * @param cnpjClubeVisitante the new cnpj clube visitante
	 */
	public void setCnpjClubeVisitante(String cnpjClubeVisitante) {
		this.cnpjClubeVisitante = cnpjClubeVisitante;
	}
	
	/**
	 * Gets the apelido clube visitante.
	 * 
	 * @return the apelido clube visitante
	 */
	public String getApelidoClubeVisitante() {
		return apelidoClubeVisitante;
	}

	/**
	 * Sets the apelido clube visitante.
	 * 
	 * @param nomeClubeVisitante the new apelido clube visitante
	 */
	public void setApelidoClubeVisitante(String nomeClubeVisitante) {
		this.apelidoClubeVisitante = nomeClubeVisitante;
	}

	/**
	 * Gets the nome eq visitante.
	 * 
	 * @return the nome eq visitante
	 */
	public String getNomeEqVisitante() {
		return nomeEqVisitante;
	}

	/**
	 * Sets the nome eq visitante.
	 * 
	 * @param nomeEqVisitante the new nome eq visitante
	 */
	public void setNomeEqVisitante(String nomeEqVisitante) {
		this.nomeEqVisitante = nomeEqVisitante;
	}

	/**
	 * Gets the data hora partida.
	 * 
	 * @return the data hora partida
	 */
	public String getDataHoraPartida() {
		return dataHoraPartida;
	}

	/**
	 * Sets the data hora partida.
	 * 
	 * @param horaPartida the new data hora partida
	 */
	public void setDataHoraPartida(String horaPartida) {
		this.dataHoraPartida = horaPartida;
	}

	/**
	 * Gets the nome est.
	 * 
	 * @return the nome est
	 */
	public String getNomeEst() {
		return nomeEst;
	}

	/**
	 * Sets the nome est.
	 * 
	 * @param nomeEst the new nome est
	 */
	public void setNomeEst(String nomeEst) {
		this.nomeEst = nomeEst;
	}

	/**
	 * Gets the gols mandante.
	 * 
	 * @return the gols mandante
	 */
	public int getGolsMandante() {
		return golsMandante;
	}

	/**
	 * Sets the gols mandante.
	 * 
	 * @param golsMandante the new gols mandante
	 */
	public void setGolsMandante(int golsMandante) {
		this.golsMandante = golsMandante;
	}

	/**
	 * Gets the gols visitante.
	 * 
	 * @return the gols visitante
	 */
	public int getGolsVisitante() {
		return golsVisitante;
	}

	/**
	 * Sets the gols visitante.
	 * 
	 * @param golsVisitante the new gols visitante
	 */
	public void setGolsVisitante(int golsVisitante) {
		this.golsVisitante = golsVisitante;
	}

	/**
	 * Gets the time vencedor.
	 * 
	 * @return the time vencedor
	 */
	public String getTimeVencedor() {
		return timeVencedor;
	}

	/**
	 * Sets the time vencedor.
	 * 
	 * @param timeVencedor the new time vencedor
	 */
	public void setTimeVencedor(String timeVencedor) {
		this.timeVencedor = timeVencedor;
	}

	/**
	 * Gets the time perdedor.
	 * 
	 * @return the time perdedor
	 */
	public String getTimePerdedor() {
		return timePerdedor;
	}

	/**
	 * Sets the time perdedor.
	 * 
	 * @param timePerdedor the new time perdedor
	 */
	public void setTimePerdedor(String timePerdedor) {
		this.timePerdedor = timePerdedor;
	}

	/**
	 * Sets the hora part.
	 * 
	 * @param horaPart the new hora part
	 */
	public void setHoraPart(Time horaPart) {
		this.horaPart = horaPart;
	}

	/**
	 * Gets the hora part.
	 * 
	 * @return the hora part
	 */
	public Time getHoraPart() {
		return horaPart;
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
		  db.query("SELECT * FROM res");
	}
	
	/**
	 * Select by primary key.
	 * 
	 * @param db the db
	 * @param idCamp the id camp
	 * @param nroPartida the nro partida
	 * 
	 * @return the result set
	 * 
	 * @throws Exception the exception
	 */
	public static ResultSet selectByPrimaryKey(Database db, 
			int idCamp, int nroPartida) throws Exception { 
		return 
		  db.query("SELECT *" +
		  		   " FROM res" +
				   " WHERE idCamp = '" + idCamp + "'" + 
				   " AND nroPartida = '" + nroPartida + "'");
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
		  db.query("SELECT res.nropartida, res.datahorapartida, cl1.apelidoclube AS apelidoClubeMandante, cl2.apelidoclube AS apelidoClubeVisitante, res.golsmandante, res.golsvisitante, res.nomeest " +
				   "FROM res, clube cl1, clube cl2 " +
				   "WHERE res.cnpjclubemandante = cl1.cnpjclube AND " + 
				   "res.cnpjclubevisitante = cl2.cnpjclube AND " +
				   "res.idcamp = '" + idCamp + "' " +
				   "ORDER BY res.nropartida");
	}
	
	/**
	 * Next res.
	 * 
	 * @param rs the rs
	 * 
	 * @return the res
	 * 
	 * @throws Exception the exception
	 */
	public static Res nextRes(ResultSet rs) throws Exception {
		if (rs.next()) {
			Res res = new Res();
			res.setNroPartida(rs.getInt("nroPartida"));
			res.setApelidoClubeMandante(rs.getString("apelidoClubeMandante"));
			res.setApelidoClubeVisitante(rs.getString("apelidoClubeVisitante"));
			res.setDataHoraPartida(rs.getString("dataHoraPartida"));
			res.setHoraPart(rs.getTime("dataHoraPartida"));
			res.setNomeEst(rs.getString("nomeEst"));
			res.setGolsMandante(rs.getInt("golsMandante"));
			res.setGolsVisitante(rs.getInt("golsVisitante"));
			return res;
		}
		return null;
	}
	
	/**
	 * Next.
	 * 
	 * @param rs the rs
	 * 
	 * @return the res
	 * 
	 * @throws Exception the exception
	 */
	public static Res next(ResultSet rs) throws Exception {
		if (rs.next()) {
			Res res = new Res();
			res.setIdCamp(rs.getInt("idCamp"));
			res.setNroPartida(rs.getInt("nroPartida"));
			res.setCnpjClubeMandante(rs.getString("cnpjClubeMandante"));
			res.setApelidoClubeMandante(rs.getString("apelidoClubeMandante"));
			res.setNomeEqMandante(rs.getString("nomeEqMandante"));	
			res.setCnpjClubeVisitante(rs.getString("cnpjClubeVisitante"));
			res.setApelidoClubeVisitante(rs.getString("apelidoClubeVisitante"));
			res.setNomeEqVisitante(rs.getString("nomeEqVisitante"));
			res.setDataHoraPartida(rs.getString("dataHoraPartida"));
			res.setHoraPart(rs.getTime("dataHoraPartida"));
			res.setNomeEst(rs.getString("nomeEst"));
			res.setGolsMandante(rs.getInt("golsMandante"));
			res.setGolsVisitante(rs.getInt("golsVisitante"));
			res.setTimeVencedor(rs.getString("timeVencedor"));
			res.setTimePerdedor(rs.getString("timePerdedor"));
			return res;
		}
		return null;
	}	
}
