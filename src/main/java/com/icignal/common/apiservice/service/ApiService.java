/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: ApiService.java
 * 2. Package	: com.icignal.common.apiservice.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 2. 오전 9:46:12
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 2.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.common.apiservice.service;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;

import javax.net.ssl.HttpsURLConnection;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.config.RequestConfig.Builder;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.common.util.LogUtil;



/*
 * 1. 클래스명	: ApiService
 * 2. 파일명	: ApiService.java
 * 3. 패키지명	: com.icignal.common.apiservice.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 2.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class ApiService {
	
	 /*
	  * 1. 메소드명: executeHttpRequest
	  * 2. 클래스명: ApiService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param url
	 *   @param entity
	 *   @return
	 *   @throws ClientProtocolException
	 *   @throws IOException
	 *   @throws ParseException	
	 */
	public HashMap<String, Object> executeHttpRequest(String url, HashMap<String,Object> entity) throws ClientProtocolException, IOException, ParseException {
		//String jsonStr = "";
		//String responseBody = "";
		String jsonData = "";
		StringBuffer responseString  = new StringBuffer();


		jsonData = new ObjectMapper().writeValueAsString(entity);
		if(!url.substring(0, 5).equals("https")) {
		
			

	        CloseableHttpClient httpclient = HttpClients.createDefault();
	        Builder builder = RequestConfig.custom();
	        builder.setConnectTimeout(40000);
	        builder.setSocketTimeout(40000);

	        RequestConfig config = builder.build();
	        try {
	            HttpPost httpPost = new HttpPost(url);
	            StringEntity jsonParam = null;

	            jsonParam = new StringEntity(jsonData , "UTF-8");
	            jsonParam.setContentType("application/json;");
	            jsonParam.setContentEncoding("UTF-8");
	            httpPost.setEntity(jsonParam);
	            httpPost.setConfig(config);
	            HttpResponse response = null;
	            response = httpclient.execute(httpPost);

	         
	            if (response.getEntity() != null) {
					BufferedReader reader = new BufferedReader(	new InputStreamReader(response.getEntity().getContent(), "UTF-8"));
					
					String readLine = null;
					while ((readLine = reader.readLine()) != null) {
						responseString.append(readLine);
					}
					reader.close();
	            }

	        } finally {
	            httpclient.close();
	            
	        }


		}else{


	     
	        	trustAllHttpsCertificates();
	        	HttpsURLConnection.setDefaultHostnameVerifier(new SSLHostnameVerifier());
	        	URL url1 = new URL(url);
	        	HttpsURLConnection conn = (HttpsURLConnection) url1.openConnection();
	        	conn.setDoInput(true);
	        	conn.setDoOutput(true);
	        	conn.setUseCaches(false);
	        	conn.setRequestMethod("POST");
	        	conn.setRequestProperty("Content-Type", "application/json");
	        	DataOutputStream out = new DataOutputStream(conn.getOutputStream());
	        	out.writeChars(jsonData);
	        	out.flush();
	        	out.close();

	        	BufferedReader reader = new BufferedReader(new InputStreamReader(
	        	conn.getInputStream()));

	        	

	        	int read = 0;

	        	char[] cbuff = new char[1024];
	        	while ((read = reader.read(cbuff)) > 0)
	        		responseString.append(cbuff, 0, read);

	        	reader.close();
	        	out.close();
	      //  	System.out.println("DATA : " + responseString.toString());
        	



		}

	        HashMap<String, Object> rtnVal = new ObjectMapper().readValue(responseString.toString() , HashMap.class) ;
			return rtnVal;
	}
	
	 /*
	  * 1. 메소드명: trustAllHttpsCertificates
	  * 2. 클래스명: ApiService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @throws Exception	
	 */
	private void trustAllHttpsCertificates() {
		try {
		javax.net.ssl.TrustManager[] trustAllCerts = new javax.net.ssl.TrustManager[1];
		trustAllCerts[0] = new SSLTrustManager();
		javax.net.ssl.SSLContext sc = javax.net.ssl.SSLContext.getInstance("SSL");
		sc.init(null, trustAllCerts, null);
		javax.net.ssl.HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
		} catch(KeyManagementException e) {
			LogUtil.error(e);
		} catch(NoSuchAlgorithmException e) {
			LogUtil.error(e);
		}

	}


}
