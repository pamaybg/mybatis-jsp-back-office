 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.component;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 1. FileName	: BaseInterceptor.java
 * 2. Package	: com.icignal.core.component
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 24. 오후 1:18:09
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 24.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: BaseInterceptor
 * 2. 파일명	: BaseInterceptor.java
 * 3. 패키지명	: com.icignal.core.component
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 24.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class BaseInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		  //LogUtil.debug("BaseInterceptor class preHandle method start..");
	
		   String str = request.getRequestURI().toString();

		//   System.out.println("str::::::: " + str);
		   switch (str.indexOf(".mkt")) {
		      case -1 :
		         break;
		      default:
		         String[] arrUrl = str.split("\\.");
		         if ( arrUrl.length == 2 && arrUrl[arrUrl.length - 1].equals("mkt")) {
		            String url = arrUrl[0];
		            request.setAttribute("mktUri" , url);
		            RequestDispatcher dispatcher = request.getRequestDispatcher("/common/spaController");
		            dispatcher.forward(request,response);
		            return false;
		         }
		         break;
		   }
		   return true;
	}
	

}

