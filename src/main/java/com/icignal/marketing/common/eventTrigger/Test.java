package com.icignal.marketing.common.eventTrigger;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Vector;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

import com.icignal.common.util.LogUtil;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

import com.icignal.common.base.controller.BaseController;
import com.icignal.common.util.DateUtil;


/**
 * @name : MKTCommonController.java
 * @date : 2016. 06. 09.
 * @author : 류동균
 * @description : 공통
 */
public class Test extends BaseController {


	/**
	   * Calculates the similarity (a number within 0 and 1) between two strings.
	   */
	  public static double similarity(String s1, String s2) {
	    String longer = s1, shorter = s2;
	    if (s1.length() < s2.length()) { // longer should always have greater length
	      longer = s2; shorter = s1;
	    }
	    int longerLength = longer.length();
	    if (longerLength == 0) { return 1.0; /* both strings are zero length */ }
	    /* // If you have Apache Commons Text, you can use it to calculate the edit distance:
	    LevenshteinDistance levenshteinDistance = new LevenshteinDistance();
	    return (longerLength - levenshteinDistance.apply(longer, shorter)) / (double) longerLength; */
	    return ((longerLength - editDistance(longer, shorter)) / (double) longerLength) * 100;

	  }

	  // Example implementation of the Levenshtein Edit Distance
	  // See http://rosettacode.org/wiki/Levenshtein_distance#Java
	  public static int editDistance(String s1, String s2) {
	    s1 = s1.toLowerCase();
	    s2 = s2.toLowerCase();

	    int[] costs = new int[s2.length() + 1];
	    for (int i = 0; i <= s1.length(); i++) {
	      int lastValue = i;
	      for (int j = 0; j <= s2.length(); j++) {
	        if (i == 0)
	          costs[j] = j;
	        else {
	          if (j > 0) {
	            int newValue = costs[j - 1];
	            if (s1.charAt(i - 1) != s2.charAt(j - 1))
	              newValue = Math.min(Math.min(newValue, lastValue),
	                  costs[j]) + 1;
	            costs[j - 1] = lastValue;
	            lastValue = newValue;
	          }
	        }
	      }
	      if (i > 0)
	        costs[s2.length()] = lastValue;
	    }
	    return costs[s2.length()];
	  }

	  public static void printSimilarity(String s, String t) {
	    System.out.println(String.format(
	      "%.3f is the similarity between \"%s\" and \"%s\"", similarity(s, t), s, t));
	  }
	  
	  public static void main(String[] args) {

//	  		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
//		    Map<String, String> map = new HashMap<String, String>();
//		    map.put("ID", "A");
//		  map.put("VAL", "A1");
//		    list.add(map);
//
//		  map.put("ID", "B");
//		  map.put("VAL", "B1");
//		  list.add(map);
//
//		  map.put("ID", "C");
//		  map.put("VAL", "C1");
//		  list.add(map);
//
//
//
//		  Map<String, Map<String, String>> builderMap =  new HashMap<>();
//
//		  list.forEach(
//			 m -> builderMap.put(m.get("ID"), m)
//		  );
//
//
//		  System.out.println(builderMap.get("C").get("VAL"));

			/*
			 * BigDecimal bd = new BigDecimal("10.0001");
			 * 
			 * String val = bd.toString();
			 * 
			 * System.out.println(val); // prints 10.0001
			 * 
			 * 
			 * List<String> list = new ArrayList<String>();
			 * 
			 * 
			 * System.out.println(list.size()-1); // prints 10.0001
			 * 
			 * Object value = (String) "마일";
			 * 
			 * System.out.println(getValue(value));
			 * 
			 * 
			 * Map<String, Object> map = new HashMap<String, Object>();
			 * 
			 * int i = 1;
			 * 
			 * int j = 2;
			 * 
			 * 
			 * BigDecimal d1 = BigDecimal.valueOf(i); BigDecimal d2 = BigDecimal.valueOf(j);
			 * 
			 * System.out.println(d1); System.out.println(d2);
			 * 
			 * System.out.println(d1.add(d2));
			 */
//		  String str = "주방잡화,C,D";
//		  String[] array = str.split(",");
//		  		    
//		  //출력				
//		  for(int i=0;i<array.length;i++) {
//		  System.out.println(array[i]);
//		  }

			StandardPBEStringEncryptor encrypor = new StandardPBEStringEncryptor();
			encrypor.setPassword("9pwc3dke");
			
//			String encrypt1 = encrypor.encrypt("jdbc:log4jdbc:sqlserver://172.21.102.10:1433;DatabaseName=dkl");
//			System.out.println(encrypt1);
//			String decrypt1 = encrypor.decrypt("5yFsuHQRmQo8+gblujbQiSDc56pCOate");

  //driver-class-name:
  //data-source-class-Name: urgwfygeP1ayPEbbO2fXGqDJoS35o09kkkt00IxumrjhuJO9Z7AnXqNwiCHAkmQ3
  //jdbc-url: KM5+1KYkYkw/n9RKY0JGYYS5R5PGodw4xL0oo38jkfxk46gUekdJ0k7EuUWVcyjMLDfnKIrO/ShbS0DrjQo41A==
  //username: m8GbSoConiW+5BvTAzgu/MSr5TrBhco8
  //password: yWoXUATk10jv33avPtP58LQ9b2E9QDLL
//			System.out.println("driver-class-name : "+ encrypor.decrypt("KnNLh6woirWd/4b1In2HnStCM7Catbm14DCXiU/TundSjQsxnTW5yncx8vXhCHHi"));
//			System.out.println("data-source-class-Name : "+ encrypor.decrypt("KnNLh6woirWd/4b1In2HnStCM7Catbm14DCXiU/TundSjQsxnTW5yncx8vXhCHHi"));
//			System.out.println("jdbc-url : "+ encrypor.decrypt("KM5+1KYkYkw/n9RKY0JGYYS5R5PGodw4xL0oo38jkfxk46gUekdJ0k7EuUWVcyjMLDfnKIrO/ShbS0DrjQo41A=="));
//			System.out.println("username : "+ encrypor.decrypt("m8GbSoConiW+5BvTAzgu/MSr5TrBhco8"));
//			System.out.println("password : "+ encrypor.decrypt("yWoXUATk10jv33avPtP58LQ9b2E9QDLL"));

//		  System.out.println(encrypor.encrypt("jdbc:log4jdbc:oracle:thin:@174.200.100.69:1522:dsteshop"));
//		  System.out.println(encrypor.encrypt("IF_CRM"));
//		  System.out.println(encrypor.encrypt("dkifshop14~crmusr"));

//			String encrypt2 = encrypor.encrypt("dklmuser");
//			System.out.println(encrypt2);
//			String decrypt2 = encrypor.decrypt(encrypt2);
//			System.out.println(decrypt2);
//
//
//			String encrypt3 = encrypor.encrypt("P@ssw0rd1!");
//			System.out.println(encrypt3);
//			String decrypt3 = encrypor.decrypt(encrypt3);
//			System.out.println(decrypt3);

//          Session ses = null;
//          Channel ch = null;
//          ChannelSftp chSftp = null;
//
//          String user = encrypor.decrypt("3SJ/qzUNllo6SWYoRKfapw==");
//          String pass = encrypor.decrypt("lvlAs+OfvEDe+ge0xnvDZpF3UAHz+rCF");
//          String server = encrypor.decrypt("Y+BiFUUyD6gsf/Msxrp4J1M9QenOXKHw");
//          int port = 22;
//          String SFTPWORKINGDIR = "/app/web/image.descentekorea.co.kr/crm/UploadFile/content_images";
//
//          JSch jsch = new JSch();
//          try {
//              ses = jsch.getSession(user,  server, port);
//              ses.setPassword(pass);
//
//              Properties p = new Properties();
//
//              // 호스트 정보를 검사하지 않음
//              p.put("StrictHostKeyChecking", "no");
//              ses.setConfig(p);
//
//              ses.connect();
//
//              ch = ses.openChannel("sftp");
//
//              ch.connect();
//
//              chSftp = (ChannelSftp) ch;
//
//              chSftp.cd(SFTPWORKINGDIR);
//              Vector filelist = chSftp.ls(SFTPWORKINGDIR);
//              for(int i=0; i<filelist.size();i++){
//                  ChannelSftp.LsEntry entry = (ChannelSftp.LsEntry) filelist.get(i);
//
//                  if(entry.getFilename().indexOf(".png") > -1){
//                      System.out.println("https://images.descentekorea.co.kr/crm/UploadFile/content_images/"+entry.getFilename());
//                  }
//
//              }
//          } catch (Exception e){
//              if (chSftp != null)
//                  chSftp.quit();
//
//              if (ch != null)
//                  ch.disconnect();
//
//              if (ses != null)
//                  ses.disconnect();
//              LogUtil.info("initializeConnection : Fail");
//          } finally {
//          }
	  }
	  
		public static Object getValue(Object val) {
		    Object rtnValue;
		    
			ScriptEngineManager mgr = new ScriptEngineManager();
		    ScriptEngine engine = mgr.getEngineByName("JavaScript");
		    
		    try {
				rtnValue = engine.eval((String) val);
			} catch (ScriptException e) {
				rtnValue = val;
			}
		    
		    return rtnValue;
		}
	  
	  public void test2() {
		    printSimilarity("", "");
		    printSimilarity("1234567890", "1");
		    printSimilarity("1234567890", "123");
		    printSimilarity("1234567890", "1234567");
		    printSimilarity("1234567890", "1234567890");
		    printSimilarity("1234567890", "0987654321");
		    printSimilarity("47/2010", "472010");
		    printSimilarity("47/2010", "472011");
		    printSimilarity("47/2010", "AB.CDEF");
		    printSimilarity("47/2010", "4B.CDEFG");
		    printSimilarity("47/2010", "AB.CDEFG");
		    printSimilarity("The quick fox jumped", "The fox jumped");
		    printSimilarity("The quick fox jumped", "The fox");
		    printSimilarity("kitten", "sitting");
		    
		    
		    String sql = "select a, b, c from dual";
		    
		    System.out.println(sql.substring(0, sql.indexOf("from")));
		    
		    System.out.println(DateUtil.getToday("yyyyMMdd"));
		    System.out.println(DateUtil.getToday("hhmm")+"00");
		    
		    
		    Map<String, Object> resultMap = new HashMap<String, Object>();
		    
		    //check(resultMap);
		    
		    String date = "2020-06-16 09:39:10.0";
		    
		    System.out.println(date.length());
		    
		    System.out.println(date.substring(0, date.indexOf(".")));
		    
		    date = "('2020-06-16 09:39:10.0', '2020-06-16 09:39:10.0')";
		    
		    date = date.replace("(", "");
		    date = date.replace(")", "");
		    date = date.replace("'", "");
		    
		    String s[] = date.split(",");
		    
		    String r = "";
		    boolean f = false;
		    for (String conVal : s) {
		    	if (conVal.indexOf(".") > 0) {
					conVal = conVal.substring(0, conVal.indexOf("."));
				}
		    	
		    	if (f) {
		    		r += ",";
		    	}
		    	
		    	r += "TO_DATE('" + conVal + "', 'yyyy-mm-dd hh24:mi:ss')";
		    	
		    	f = true;
		    }
		    
		    r = "(" + r + ")";
		    
		    System.out.println(r);
	  }
	  
	  public static void check(Object obj) {
		    if (obj instanceof Map) {
		    	HashMap map = (HashMap) obj;
		    	
		    	if (map.isEmpty()) {
		    		System.out.println("xxx");
		    	}
		    }
	  }
    

}