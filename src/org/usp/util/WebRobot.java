package org.usp.util;

import java.io.*;
import java.text.DateFormat;
import java.util.Date;
import java.util.Vector;

import org.xml.sax.*;
import org.xml.sax.helpers.*;
import org.usp.futebol.*;

// TODO: Auto-generated Javadoc
/**
 * The Class WebRobot.
 */
public class WebRobot extends DefaultHandler {
	
	/** The title. */
	private String title;
	
	/** The link. */
	private String link;
	
	/** The description. */
	private String description;
	
	/** The data. */
	private StringBuffer data;
	
	/** The vet noticias. */
	Vector <News> vetNoticias;

    /**
     * Instantiates a new web robot.
     */
    public WebRobot() {
    	this.title = null;
    	this.description = null;
    	this.link = null;
	    this.data = new StringBuffer();
	    this.vetNoticias = new Vector<News>();
    }
    
    /**
     * Gets the news.
     * 
     * @return the news
     */
    public Vector<News> getNews() {
    	return vetNoticias;
    }
    
    /**
     * Read xml.
     * 
     * @param inStream the in stream
     */
    public void readXML(InputStream inStream) {
        try {
            System.setProperty("org.xml.sax.driver", "org.apache.crimson.parser.XMLReaderImpl");

            XMLReader reader = XMLReaderFactory.createXMLReader();
            reader.setContentHandler(this);
            reader.parse(new InputSource(new InputStreamReader(inStream)));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* (non-Javadoc)
     * @see org.xml.sax.helpers.DefaultHandler#startDocument()
     */
    public void startDocument() throws SAXException {
    }

    /* (non-Javadoc)
     * @see org.xml.sax.helpers.DefaultHandler#endDocument()
     */
    public void endDocument() throws SAXException {
    }

    /* (non-Javadoc)
     * @see org.xml.sax.helpers.DefaultHandler#characters(char[], int, int)
     */
    public void characters(char[] buffer, int start, int length) {
	    data.append(buffer, start, length);
    }
    
    /* (non-Javadoc)
     * @see org.xml.sax.helpers.DefaultHandler#startElement(java.lang.String, java.lang.String, java.lang.String, org.xml.sax.Attributes)
     */
    public void startElement (String namespaceURI, String localName, String qName, Attributes atts) throws SAXException {
		if (qName.equals("item")) {
			title = null;
			link = null;
			description = null;
		}
    }

    /* (non-Javadoc)
     * @see org.xml.sax.helpers.DefaultHandler#endElement(java.lang.String, java.lang.String, java.lang.String)
     */
    public void endElement(String namespaceURI, String localName, String qName) throws SAXException {

		if (qName.equals("title")) {
			title = data.toString();
			data.setLength(0);
		} 
		
		else if (qName.equals("link")) {
			link = data.toString();
			data.setLength(0);
		}
		
		else if (qName.equals("description")) {
			description = data.toString();
			data.setLength(0);
		}
		
		else if (qName.equals("item")) {
			try {
				News news = new News();
				Date now = new Date();
			    DateFormat df = DateFormat.getDateInstance();
			    String date = df.format(now);
			      
				news.setTitle(title);
				news.setBodyn(description);
				news.setDaten(date);
				news.setUrl(link);
				vetNoticias.addElement(news);
				
			} catch (Exception e) { 
				e.printStackTrace();
			}
			data.setLength(0);
		}
    }
}
