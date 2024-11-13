 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.component;

import java.util.concurrent.Executor;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.AsyncConfigurerSupport;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import com.icignal.common.util.BeansUtil;

/**
 * 1. FileName	: AsyncConfig.java
 * 2. Package	: com.icignal.core.component
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 20. 오후 4:17:07
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 20.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: AsyncConfig
 * 2. 파일명	: AsyncConfig.java
 * 3. 패키지명	: com.icignal.core.component
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *  비동기 처리 Bean
 * </PRE>
 */

@Configuration
@EnableAsync
public class AsyncConfig extends AsyncConfigurerSupport {

	@Override
	public Executor getAsyncExecutor() {
		ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
		executor.setCorePoolSize(BeansUtil.getApplicationProperty("icignal.async.thread-pool.init", Integer.class , 1));
		executor.setMaxPoolSize(BeansUtil.getApplicationProperty("icignal.async.thread-pool.max", Integer.class , 10));
		executor.setQueueCapacity(BeansUtil.getApplicationProperty("icignal.async.thread-pool.queue", Integer.class , 10));
		executor.setThreadNamePrefix("icignal-async-");
		executor.initialize();
		return executor;
	}
	

	
	
}






