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
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TranChnlMapper {

	List<TranChnlPushDto> selectLoyCustAppTokenList(String mbrNo);

	/**
	 * 맴버십 + 마케팅 푸시용 공통 시퀀스
	 *
	 * @author gylee
	 * @since 2021. 05. 12.
	 */
	String selectComPushSeq();

	//외부테이블의 외부사이트 발송 정보(Braze Send) 조회
	TranChnlPushDto selectExternalWebService();

	//Braze 특정 캠페인 정보 조회
	TranChnlPushDto selectBrazeCam(String apiKey);

}
