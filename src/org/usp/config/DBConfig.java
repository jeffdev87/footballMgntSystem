package org.usp.config;

public interface DBConfig {
	public String driver = "org.postgresql.Driver";
	public String url = "jdbc:postgresql://localhost:5432/futebol";
	public String username = System.getenv("DATABASE_USERNAME");
	public String password = System.getenv("DATABASE_PASSWD");
}
