 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.mybastis.intercepter;

import java.sql.Statement;

import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Signature;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;

/**
 * 1. FileName	: StatementHandlerUpdateInterceptor.java
 * 2. Package	: com.icignal.core.mybastis.intercepter
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 3. 6. 오전 11:07:48
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 3. 6.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: StatementHandlerUpdateInterceptor
 * 2. 파일명	: StatementHandlerUpdateInterceptor.java
 * 3. 패키지명	: com.icignal.core.mybastis.intercepter
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 3. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Intercepts({@Signature(type = StatementHandler.class, method = "update", args = {Statement .class})})
public class StatementHandlerUpdateInterceptor  implements Interceptor {

	/*
	 * 1. 메소드명: intercept
	 * 2. 클래스명: Interceptor
	 * 3. 작성자명: knlee
	 * 4. 작성일자: 2020. 3. 6.
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
		LogUtil.info("StatementHandlerUpdateInterceptor intercept method start..");
		Object obj = invocation.proceed();
		
		LogUtil.info("obj::: " + obj);
		
		if(obj.getClass() == StatusResDto.class) {
			LogUtil.info("!!!!!!!!!!!!!!!!!!AAAA");
			
		}
		
		
		if(obj.getClass() == Integer.class ) {
			LogUtil.info("AAAAAAAAAA!!!!");
			Integer result = (Integer)obj;
			LogUtil.info("result: " + result);
			StatusResDto status = new StatusResDto();
			if(result == 1 ) status.setSuccess(true);
			return status;
			
		}
		
		
		return obj;
		
	}
	
	

}

