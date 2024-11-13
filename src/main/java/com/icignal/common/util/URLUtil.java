package com.icignal.common.util;




import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;



/**
 * URL 관련 Util
 * 
 * @author jskim
 *
 */
public class URLUtil {
	/**
	 * 짦게 변환되어 있는 URL을 원래의 URL로 재변환하여 반환
	 * 
	 * @param 	shortUrl	짧게 변환되어 있는 URL
	 * @return 	원래의 URL	
	 */
	 public static String getLongUrl(String shortUrl) {

			String result = shortUrl;
	        String header;
			try {
	            do {
	                URL url = new URL(result);
	                HttpURLConnection.setFollowRedirects(false);
	                URLConnection conn = url.openConnection();
	                header = conn.getHeaderField(null);
	                String location = conn.getHeaderField("location");
	                if (location != null) {
	                    result = location;
	                }
	            } while (header.contains("301"));
		            
			} catch (MalformedURLException e) {
				
				LogUtil.error(e);
			} catch (IOException e) {
				
				LogUtil.error(e);
			}
            
	        return result;
	    }

}
