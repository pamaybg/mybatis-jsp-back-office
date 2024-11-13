 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.mybastis.intercepter;

import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Signature;

import com.icignal.common.util.LogUtil;

/**
 * 1. FileName	: OracleParameterHandlerInterceptor.java
 * 2. Package	: com.icignal.core.mybastis.intercepter
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 28. 오후 2:08:22
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 28.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: OracleParameterInterceptor
 * 2. 파일명	: OracleParameterInterceptor.java
 * 3. 패키지명	: com.icignal.core.mybastis.intercepter
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 28.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

@Intercepts({@Signature(type = ParameterHandler.class, method = "getParameterObject" , args={})})
public class ParameterHandlerInterceptor implements Interceptor {

	/*
	 * 1. 메소드명: intercept
	 * 2. 클래스명: Interceptor
	 * 3. 작성자명: knlee
	 * 4. 작성일자: 2020. 2. 28.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * </PRE>
	 *   @param invocation
	 *   @return
	 *   @throws Throwable	
	 */
	
	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		LogUtil.info("ParameterHandlerGetParameterObjectInterceptor intercept method start.... ");
		ParameterHandler parameterHandler = (ParameterHandler) invocation.getTarget();
	    Object obj  =  parameterHandler.getParameterObject();
        LogUtil.info("obj: " + obj);
		
		
		return obj;
	}
	
	
	
	

}

