/*
 * Projeto Futebol
 * 
 */
package org.usp.futebol;

// TODO: Auto-generated Javadoc
/**
 * The Class News.
 */
public class News {
	
	/** The title. */
	private String title;
	
	/** The body n. */
	private String bodyN;
	
	/** The date n. */
	private String dateN;
	
	/** The url. */
	private String url;

	/**
	 * Instantiates a new news.
	 */
	public News() {
		this.title = null;
		this.bodyN = null;
		this.dateN = null;
		this.url = null;
	}

	/**
	 * Sets the title.
	 * 
	 * @param title the new title
	 */
	public void setTitle(String title) { this.title = title; }
	
	/**
	 * Sets the bodyn.
	 * 
	 * @param bodyN the new bodyn
	 */
	public void setBodyn(String bodyN) { this.bodyN = bodyN; }
	
	/**
	 * Sets the daten.
	 * 
	 * @param dateN the new daten
	 */
	public void setDaten(String dateN) { this.dateN = dateN; }
	
	/**
	 * Sets the url.
	 * 
	 * @param url the new url
	 */
	public void setUrl(String url) { this.url = url; }
	
	/**
	 * Gets the title.
	 * 
	 * @return the title
	 */
	public String getTitle() { return this.title; }
	
	/**
	 * Gets the bodyn.
	 * 
	 * @return the bodyn
	 */
	public String getBodyn() { return this.bodyN; }
	
	/**
	 * Gets the daten.
	 * 
	 * @return the daten
	 */
	public String getDaten() { return this.dateN; }
	
	/**
	 * Gets the url.
	 * 
	 * @return the url
	 */
	public String getUrl() { return this.url; }

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return
			this.title+", "+
			this.bodyN+", "+
			this.dateN+", ";
	}
}
