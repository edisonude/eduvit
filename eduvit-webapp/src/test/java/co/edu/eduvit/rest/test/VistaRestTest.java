package co.edu.eduvit.rest.test;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

public class VistaRestTest {
	public static int doDelete() {
		try {
			String urlConsume= "http://localhost:9080/eduvit/vista/add/hola/como";
			//urlConsume = urlConsume.replaceFirst("_", String.valueOf(latitude));
			//urlConsume = urlConsume.replaceFirst("_", String.valueOf(longitude));
			
			URL url = new URL(urlConsume);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			//connection.setRequestMethod("GET");
			connection.setRequestMethod("POST");
			return connection.getResponseCode();
		} catch (IOException e) {
		}
		return -1;
	}
	
	public static void main(String[] args) {
		System.out.println(doDelete());
	}
}
