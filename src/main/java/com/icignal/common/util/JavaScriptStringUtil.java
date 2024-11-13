/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: JavaScriptStringUtil.java
 * 2. Package	: com.icignal.common.util
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 4. 14. 오후 5:25:34
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 4. 14.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.common.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

/*
 * 1. 클래스명	: JavaScriptStringUtil
 * 2. 파일명	: JavaScriptStringUtil.java
 * 3. 패키지명	: com.icignal.common.util
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 4. 14.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class JavaScriptStringUtil {
	
	//뿌려줄 메세지를 화면단에 alert창으로 띄워주기 위한 코드
		public static void setPrintWriter(HttpServletResponse response) throws IOException {
			String alertMsg = "해당 프로그램 접근권한이 없습니다.";
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter printwriter;
			printwriter = response.getWriter();
			printwriter.print("<script>alert('"+ alertMsg +"'); history.go(-1);</script>");
			printwriter.flush();
			printwriter.close();
		}
		
		//뿌려줄 메세지를 화면단에 alert창으로 띄워주기 위한 코드
			public static void setRPrintPopupWriter(HttpServletResponse response) throws IOException {
				String alertMsg = "해당 팝업 접근권한이 없습니다.";
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter printwriter;
				printwriter = response.getWriter();
				printwriter.print("<script>alert('"+ alertMsg +"');</script>");
				//printwriter.print("<script>$.fn.ifvmPopupClose();</script>");
//				printwriter.print("<script>window[currentPopupId]._destroy();</script>");
//				printwriter.print("<script>window.location.reload();</script>");
				printwriter.flush();
				printwriter.close();
			}
			
			//뿌려줄 메세지를 화면단에 alert창으로 띄워주기 위한 코드
		public static void setPrintIncludeWriter(HttpServletResponse response) throws IOException {
			String alertMsg = "해당 탭 접근권한이 없습니다.";
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter printwriter;
			printwriter = response.getWriter();
			printwriter.print("<script>alert('"+ alertMsg +"');</script>");
			printwriter.flush();
			printwriter.close();
		}
		
		public static void homeUrl(HttpServletResponse response,String alertMsg) throws IOException {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter printwriter;
			printwriter = response.getWriter();
			printwriter.print("<script>alert('"+ alertMsg +"');</script>");
			printwriter.print("<script>location.href='/marketing/campaignhome/campaignHome'</script>");
			printwriter.flush();
			printwriter.close();
		}
		
		public static void homeLocation(HttpServletResponse response) throws IOException {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter printwriter;
			printwriter = response.getWriter();
			printwriter.print("<script>location.href='/marketing/campaignhome/campaignHome'</script>");
			printwriter.flush();
			printwriter.close();
		}
		
		public static void homeFirstUrl(HttpServletResponse response,String url) throws IOException {
			String alertMsg = "인증 성공하였습니다.";
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter printwriter;
			printwriter = response.getWriter();
			//printwriter.print("<script>top.window.open('about:blank','_self').close();</script>");
			printwriter.print("<script>alert('"+ alertMsg +"');</script>");
			//printwriter.print("<script>location.href='"+url+"'</script>");
			printwriter.flush();
			printwriter.close();
		}

		 /*
		  * 1. 메소드명: homeFaileUrl
		  * 2. 클래스명: CommonUtil
		  * 3. 작성자명: jh.seo 
		  * 4. 작성일자: 2020. 4. 9.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param response	
		 * @throws IOException 
		 */
		
		public static void homeFaileUrl(HttpServletResponse response) throws IOException {
			String alertMsg = "인증키등록이 실패하였습니다.";
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter printwriter;
			printwriter = response.getWriter();
			printwriter.print("<script>alert('"+ alertMsg +"');</script>");
			printwriter.print("<script>location.href='/marketing/campaignhome/campaignHome'</script>");
			//printwriter.print("<script>window[currentPopupId]._destroy();</script>");
			printwriter.flush();
			printwriter.close();
			
		}
		
		public static void homeFailLogin(HttpServletResponse response,String alertMsg) throws IOException {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter printwriter;
			printwriter = response.getWriter();
			printwriter.print("<script>alert('"+ alertMsg +"');</script>");
			printwriter.print("<script>location.href='/login'</script>");
			//printwriter.print("<script>window[currentPopupId]._destroy();</script>");
			printwriter.flush();
			printwriter.close();
			
		}
}
