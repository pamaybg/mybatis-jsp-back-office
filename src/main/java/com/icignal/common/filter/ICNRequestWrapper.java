package com.icignal.common.filter;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.ReadListener;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import com.icignal.common.util.ObjectUtil;
import com.nhncorp.lucy.security.xss.XssFilter;


/**
 * @name : infavor.util.IFVMRequestWrapper
 * @date : 2017. 6. 20.
 * @author : "dg.ryu"
 * @description : XSS 필터
 */
public final class ICNRequestWrapper extends HttpServletRequestWrapper {
	 
	private byte[] b;

	public ICNRequestWrapper(HttpServletRequest request) throws IOException {
		super(request);
		
 		String body = getBody(request);
 		
 		if (ObjectUtil.isNotEmpty(body)) {
 			XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml", true);
 			
 			String setBody = new String(filter.doFilter(body));
 			
 			b = setBody.getBytes("UTF-8");
 		}
	}

	public ServletInputStream getInputStream() throws IOException {
 		final ByteArrayInputStream bis = new ByteArrayInputStream(b);

 		return new ServletInputStreamImpl(bis);
 	}

 	class ServletInputStreamImpl extends ServletInputStream{
 		final InputStream is;

 		public ServletInputStreamImpl(InputStream bis){
 			is = bis;
 		}

 		public int read() throws IOException {
 			return is.read();
 		}

 		public int read(byte[] b) throws IOException {
 			return is.read(b);
 		}

		/*
		 * 1. 메소드명: isFinished
		 * 2. 클래스명: ServletInputStream
		 * 3. 작성자명: knlee
		 * 4. 작성일자: 2020. 2. 4.
		 */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * </PRE>
		 *   @return	
		 */
		
		@Override
		public boolean isFinished() {
			return false;
		}

		/*
		 * 1. 메소드명: isReady
		 * 2. 클래스명: ServletInputStream
		 * 3. 작성자명: knlee
		 * 4. 작성일자: 2020. 2. 4.
		 */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * </PRE>
		 *   @return	
		 */
		
		@Override
		public boolean isReady() {
			return false;
		}

		/*
		 * 1. 메소드명: setReadListener
		 * 2. 클래스명: ServletInputStream
		 * 3. 작성자명: knlee
		 * 4. 작성일자: 2020. 2. 4.
		 */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * </PRE>
		 *   @param listener	
		 */
		
		@Override
		public void setReadListener(ReadListener listener) {
		}
 	}

 	public static String getBody(HttpServletRequest request) throws IOException {
 	    StringBuilder stringBuilder = new StringBuilder();
 	    BufferedReader bufferedReader = null;
 	    InputStream inputStream = null;
 	    try {
 	         inputStream = request.getInputStream();
 	        
 	        if (inputStream != null) {
 	            bufferedReader = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));
 	            char[] charBuffer = new char[128];
 	           int bytesRead = -1;
	            while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
	                stringBuilder.append(charBuffer, 0, bytesRead);
	            }
 	        } else {
 	            stringBuilder.append("");
 	        }
 	    } catch (IOException ex) {
 	        throw ex;
 	    } finally {
 	        if (bufferedReader != null) {
 	                bufferedReader.close();
 	        }
 	       if (inputStream != null) {
 	    	  inputStream.close();
        }
 	    }

 	    return stringBuilder.toString();
 	}
}