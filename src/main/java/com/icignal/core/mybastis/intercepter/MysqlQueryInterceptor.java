/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: MysqlRowBoundsInterceptor.java
 * 2. Package	: com.icignal.core.common.mybastis.intercepter
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 9. 오후 3:40:36
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 9.		 | knlee			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.core.mybastis.intercepter;


import java.sql.Connection;

import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.DefaultReflectorFactory;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.ReflectorFactory;
import org.apache.ibatis.reflection.factory.DefaultObjectFactory;
import org.apache.ibatis.reflection.factory.ObjectFactory;
import org.apache.ibatis.reflection.wrapper.DefaultObjectWrapperFactory;
import org.apache.ibatis.reflection.wrapper.ObjectWrapperFactory;
import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
/*
 * 1. 클래스명	: MysqlRowBoundsInterceptor
 * 2. 파일명	: MysqlRowBoundsInterceptor.java
 * 3. 패키지명	: com.icignal.core.common.mybastis.intercepter
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Intercepts({@Signature(type = StatementHandler.class, method = "prepare", args = {Connection.class, Integer.class})})
public class MysqlQueryInterceptor implements Interceptor {
	
	private final Logger log = LoggerFactory.getLogger(this.getClass().getName());	

	private static final ObjectFactory DEFAULT_OBJECT_FACTORY = new DefaultObjectFactory();
	private static final ObjectWrapperFactory DEFAULT_OBJECT_WRAPPER_FACTORY = new DefaultObjectWrapperFactory();
	private static final ReflectorFactory DEFAULT_REFLECTOR_FACTORY = new DefaultReflectorFactory();

	public Object intercept(Invocation invocation) throws Throwable {
		StatementHandler statementHandler = (StatementHandler) invocation.getTarget();
		MetaObject metaStatementHandler = MetaObject.forObject(statementHandler, DEFAULT_OBJECT_FACTORY, DEFAULT_OBJECT_WRAPPER_FACTORY, DEFAULT_REFLECTOR_FACTORY);
		String originalSql = (String) metaStatementHandler.getValue("delegate.boundSql.sql");
		RowBounds rb = (RowBounds) metaStatementHandler.getValue("delegate.rowBounds");

		log.debug("originalSql = {}", originalSql);
		log.debug("RowBounds = {}", rb);

		if (rb == null || rb == RowBounds.DEFAULT) {
			// RowBounds가 없으면 그냥 실행
			return invocation.proceed();
		}

		// RowBounds가 있다!
		// 원래 쿼리에 limit 문을 붙여준다.
		StringBuffer sb = new StringBuffer();
		sb.append(originalSql)
		  .append(" limit ")
		  .append(rb.getOffset())
		  .append(", ")
		  .append(rb.getLimit());

		log.debug("sql = {}", sb.toString());

		// RowBounds 정보 제거
		metaStatementHandler.setValue("delegate.rowBounds.offset", RowBounds.NO_ROW_OFFSET);
		metaStatementHandler.setValue("delegate.rowBounds.limit", RowBounds.NO_ROW_LIMIT);
		// 변경된 쿼리로 바꿔치기
		metaStatementHandler.setValue("delegate.boundSql.sql", sb.toString());

		return invocation.proceed();
	}

	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	public Logger getLog() {
		return log;
	}

	

}
