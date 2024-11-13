/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: loggingMapper.java
 * 2. Package	: com.icignal.common.logging.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 20. 오후 2:40:14
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 20.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.common.tranChnl.mapper;

import com.icignal.common.tranChnl.model.TranChnlDto;
import com.icignal.core.annotation.handler.MartMapper;

import java.util.HashMap;
import java.util.List;

@MartMapper
public interface TranChnlMartMapper {

	//Sms 발송
	List<HashMap<Object, Object>> selectTest();


}
