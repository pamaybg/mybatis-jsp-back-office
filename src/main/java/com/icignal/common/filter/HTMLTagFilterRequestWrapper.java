/*
 * Copyright 2008-2009 MOPAS(MINISTRY OF SECURITY AND PUBLIC ADMINISTRATION).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.icignal.common.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class HTMLTagFilterRequestWrapper extends HttpServletRequestWrapper {

	public HTMLTagFilterRequestWrapper(HttpServletRequest request) {
		super(request);
	}
	
	@Override
	public String[] getParameterValues(String parameter) {       
		String[] values = super.getParameterValues(parameter);       
  
		if (values==null)  {                  
			return null;          
		}      
  
		int count = values.length;      
  
		String[] encodedValues = new String[count];      
  
		for (int i = 0; i < count; i++) {                
			encodedValues[i] = cleanXSS(values[i]);        
		}       
  
		return encodedValues;    
	}
	
	@Override 
	public String getParameter(String parameter) {           
		 String value = super.getParameter(parameter);           
		  
		 if (value == null) {                  
			 return null;                   
		 }           
		  
		 return cleanXSS(value);     
	}     
	
	@Override
	public String getHeader(String name) {         
		String value = super.getHeader(name);         
		  
		if (value == null){             
			return null;         
		}
		   
		return cleanXSS(value);     
	}     
	
	private String cleanXSS(String value) {    
		String inValue = value;
		//You'll need to remove the spaces from the html entities below         
		inValue = inValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");         
		inValue = inValue.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");         
		inValue = inValue.replaceAll("'", "&#39;");        
		inValue = inValue.replaceAll("eval\\((.*)\\)", "");         
		inValue = inValue.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");         
		  
		return inValue;     
	}
		 
	public static String decodeXSS(String value) {
		String inValue = value;
		inValue = inValue.replaceAll("&lt;", "<").replaceAll("&gt;", ">");         
		inValue = inValue.replaceAll("&#40;", "(").replaceAll("&#41;", ")");         
		inValue = inValue.replaceAll("&#39;", "'");        
		inValue = inValue.replaceAll("&quot;", "\"");  

		return inValue;     
	} 

}