 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.mybastis.intercepter;

import java.lang.reflect.Field;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.executor.resultset.ResultSetHandler;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Signature;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;

/*
 * 1. 클래스명	: ResultSetHandlerIntercepter
 * 2. 파일명	: ResultSetHandlerIntercepter.java
 * 3. 패키지명	: com.icignal.core.mybastis.intercepter
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 3. 5.
 */
/**
 * <PRE>
 * 1. 설명
 *  ResultSet 결과를 intercepter하는 클래스
 *  구현 로직 : List 객체가 아닌 단일객제의 경우 StatusResDto.success 값을 true로 설정함. 
 * </PRE>
 */ 
@Intercepts({@Signature(type = ResultSetHandler.class, method = "handleResultSets", args = {Statement.class})})
public class ResultSetHandlerInterceptor implements Interceptor { 

	/*
	 * 1. 메소드명: intercept
	 * 2. 클래스명: Interceptor
	 * 3. 작성자명: knlee
	 * 4. 작성일자: 2020. 2. 14.
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
		LogUtil.debug("ResultSetHandlerInterceptor intercept method start..");
        @SuppressWarnings("unchecked")
		List<Object> results = (ArrayList<Object>)invocation.proceed();
        if(results.size() == 1) {
        	 Object obj = results.get(0);
        	 
        	 if (obj != null) {
        		 Class<?> sc =	obj.getClass().getSuperclass();
        		 if(sc == StatusResDto.class) {
        			 Field field = sc.getDeclaredField("success");
        			 field.setAccessible(true);
        			 field.set(obj, true);
        		 }
        	 }
        }
        
        return results;
	}

}

