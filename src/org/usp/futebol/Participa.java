package org.usp.futebol;

import java.sql.*;

import org.usp.database.*;

public class Participa {

	private String cpfJogador;
	private String apelidoMembro;
	private String cnpjClube;
	private String apelidoClube;
	private String nomeEq;
	private Date dataInicJog;
	private int idCamp;
	private int nroPartida;
	private int nroFaltas;
	private int nroCamisa;
	private String posicao;
	private int golsPro;
	private int somaGols;
	private int golsContra;
	private int cartaoAmarelo;
	private int cartaoVermelho;
	
	public Participa() {
		this.cpfJogador = null;
		this.apelidoMembro = null;
		this.cnpjClube = null;
		this.apelidoClube = null;
		this.nomeEq = null;
		this.dataInicJog = null;
		this.idCamp = 0;
		this.nroPartida = 0;
		this.nroFaltas = 0;
		this.nroCamisa = 0;
		this.posicao = null;
		this.golsPro = 0;
		this.somaGols = 0;
		this.golsContra = 0;
		this.cartaoAmarelo = 0;
		this.cartaoVermelho = 0;
	}

	public String getCpfJogador() {
		return cpfJogador;
	}

	public void setCpfJogador(String cpfJogador) {
		this.cpfJogador = cpfJogador;
	}

	public String getCnpjClube() {
		return cnpjClube;
	}

	public void setCnpjClube(String cnpjClube) {
		this.cnpjClube = cnpjClube;
	}

	public String getNomeEq() {
		return nomeEq;
	}

	public void setNomeEq(String nomeEq) {
		this.nomeEq = nomeEq;
	}

	public Date getDataInicJog() {
		return dataInicJog;
	}

	public void setDataInicJog(Date dataInicJog) {
		this.dataInicJog = dataInicJog;
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

	public int getNroFaltas() {
		return nroFaltas;
	}

	public void setNroFaltas(int nroFaltas) {
		this.nroFaltas = nroFaltas;
	}

	public int getNroCamisa() {
		return nroCamisa;
	}

	public void setNroCamisa(int nroCamisa) {
		this.nroCamisa = nroCamisa;
	}

	public String getPosicao() {
		return posicao;
	}

	public void setPosicao(String posicao) {
		this.posicao = posicao;
	}

	public int getGolsPro() {
		return golsPro;
	}

	public void setGolsPro(int golsPro) {
		this.golsPro = golsPro;
	}

	public int getGolsContra() {
		return golsContra;
	}

	public void setGolsContra(int golsContra) {
		this.golsContra = golsContra;
	}

	public int getCartaoAmarelo() {
		return cartaoAmarelo;
	}

	public void setCartaoAmarelo(int cartaoAmarelo) {
		this.cartaoAmarelo = cartaoAmarelo;
	}

	public int getCartaoVermelho() {
		return cartaoVermelho;
	}

	public void setCartaoVermelho(int cartaoVermelho) {
		this.cartaoVermelho = cartaoVermelho;
	}

	public String getApelidoClube() {
		return apelidoClube;
	}

	public void setApelidoClube(String apelidoClube) {
		this.apelidoClube = apelidoClube;
	}

	public String getApelidoMembro() {
		return apelidoMembro;
	}

	public void setApelidoMembro(String apelidoMembro) {
		this.apelidoMembro = apelidoMembro;
	}

	public int getSomaGols() {
		return somaGols;
	}

	public void setSomaGols(int somaGols) {
		this.somaGols = somaGols;
	}

	public void insert() throws Exception { 
		Database db = new Database();
		db.update("INSERT INTO Participa VALUES ('"+this.cpfJogador+"', '"+this.cnpjClube+
				"', '"+this.nomeEq+"', '"+this.dataInicJog+"', '"+this.idCamp+
				"', '"+this.nroPartida+"', '"+this.nroFaltas+"', '"+this.nroCamisa+"', '"+this.posicao+"', '"+this.golsPro+"' , '"+this.golsContra+"', '"+this.cartaoAmarelo+"', '"+this.cartaoVermelho+"')");
		db.close();
	}
	public void remove() throws Exception { 
		Database db = new Database();
		db.update("DELETE FROM participa WHERE cpfJogador = '"+this.cpfJogador+"' AND cnpjClube = '"+this.cnpjClube+"' AND nomeEq = '"+this.nomeEq+"' AND" +
				  " dataInicJog = '"+this.dataInicJog+"' AND idCamp = '"+this.idCamp+"' AND nroPartida = '"+this.nroPartida+"'");
		db.close();
	}
	public void update() throws Exception { 
		Database db = new Database();
		db.update("UPDATE participa SET " +
				      "cpfJogador = '"+this.cpfJogador+"', cnpjClube = '"+this.cnpjClube+"', nomeEq = '"+this.nomeEq+"', " +
				      "dataInicJog = '"+this.dataInicJog+"', idCamp = '"+this.idCamp+"', nroPartida = '"+this.nroPartida+"', " + 
				      "nroFaltas = '"+this.nroFaltas+"', nroCamisa = '"+this.nroCamisa+"', posicao = '"+this.posicao+"', golsPro = '"+this.golsPro+"', golsContra = '"+this.golsContra+"', cartaoAmarelo = '"+this.cartaoAmarelo+"', cartaoVermelho = '"+this.cartaoVermelho+"'");
		db.close();
	}


	public static ResultSet selectArtilheirosCamp(Database db, int idCamp) throws Exception { 
		return db.query("SELECT vg.apelidomembro, vg.somagols, vg.apelidoclube " + 
        				"FROM view_golsjogcamp vg " +
        				"WHERE vg.idcamp = '"+idCamp+"' and (vg.idcamp, vg.apelidoclube, vg.somaGols) in ( " +
      				    "SELECT  v.idcamp, v.apelidoclube, max(v.somagols) as maxg " +
        				"FROM view_golsJogCamp v " +
        				"group by (v.idcamp, v.apelidoclube)) " +
        				"order by vg.idcamp, vg.apelidoclube, vg.apelidomembro, vg.somagols");
	}
	
	public static ResultSet selectArtilheirosCampTime(Database db, int idCamp, String apelidoClube) throws Exception { 
		return db.query("SELECT vg.apelidomembro, vg.somagols, vg.apelidoclube " + 
        				"FROM view_golsjogcamp vg " +
        				"WHERE vg.idcamp = '"+idCamp+"' and vg.apelidoClube = '"+apelidoClube+"' and (vg.idcamp, vg.apelidoclube, vg.somaGols) in ( " +
      				    "SELECT  v.idcamp, v.apelidoclube, max(v.somagols) as maxg " +
        				"FROM view_golsJogCamp v " +
        				"group by (v.idcamp, v.apelidoclube)) " +
        				"order by vg.idcamp, vg.apelidoclube, vg.apelidomembro, vg.somagols");
	}
	
	public static Participa next(ResultSet rs) throws Exception {
		if (rs.next()) {
			Participa part = new Participa();
			part.setCpfJogador(rs.getString("cpfJogador"));
			part.setCnpjClube(rs.getString("cnpjClube"));
			part.setNomeEq(rs.getString("nomeEq"));
			part.setDataInicJog(rs.getDate("dataInicJog"));
			part.setIdCamp(rs.getInt("idCamp"));
			part.setNroPartida(rs.getInt("nroPartida"));
			part.setNroFaltas(rs.getInt("nroFaltas"));
			part.setNroCamisa(rs.getInt("nroCamisa"));
			part.setPosicao(rs.getString("posicao"));
			part.setGolsPro(rs.getInt("golsPro"));
			part.setGolsContra(rs.getInt("golsContra"));
			part.setCartaoAmarelo(rs.getInt("cartaoAmarelo"));
			part.setCartaoVermelho(rs.getInt("cartaoVermelho"));
			return part;
		}
		return null;
	}
	
	public static Participa nextPart(ResultSet rs) throws Exception {
		if (rs.next()) {
			Participa part = new Participa();
			part.setApelidoMembro(rs.getString("apelidoMembro"));
			part.setSomaGols(rs.getInt("somaGols"));
			part.setApelidoClube(rs.getString("apelidoClube"));
			return part;
		}
		return null;
	}
}
