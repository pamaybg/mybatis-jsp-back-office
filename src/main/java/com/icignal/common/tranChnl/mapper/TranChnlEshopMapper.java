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

import com.icignal.common.tranChnl.dto.TranChnlPushDto;
import com.icignal.common.tranChnl.dto.request.TranChnlReqDto;
import com.icignal.common.tranChnl.model.TranChnlDto;
import com.icignal.core.annotation.handler.EshopMapper;
import com.icignal.core.annotation.handler.MartMapper;
import com.icignal.marketing.contents.dto.response.MktContentResDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@EshopMapper
public interface TranChnlEshopMapper {

	//Sms 발송
	int insertSendSms(TranChnlDto param);

	//Lms 발송
	int insertSendLms(TranChnlDto param);

	//Lms 결재 발송
	int insertApproSendLms(TranChnlDto param);

	//Mms 발송
	int insertSendMms(TranChnlDto param);

	//KakaoNoti 발송
	int insertSendKakaoNoti(MktContentResDto param);

	//KakaoFr 발송
	int insertSendKakaoFr(MktContentResDto param);

	//email 발송
	int insertSendEmail(TranChnlReqDto param);

}
