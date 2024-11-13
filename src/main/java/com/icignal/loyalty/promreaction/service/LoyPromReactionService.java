/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPromReactionService.java
 * 2. Package	: com.icignal.loyalty.promreaction.service
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 15. 오전 10:04:01
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 15.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.promreaction.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.promreaction.dto.request.LoyPromReactionListReqDto;
import com.icignal.loyalty.promreaction.dto.response.LoyPromMbrCalcExcelListResDto;
import com.icignal.loyalty.promreaction.dto.response.LoyPromMbrCalcListResDto;
import com.icignal.loyalty.promreaction.dto.response.LoyPromReactionDetailResDto;
import com.icignal.loyalty.promreaction.dto.response.LoyPromReactionListResDto;
import com.icignal.loyalty.promreaction.mapper.LoyPromReactionMapper;

/*
 * 1. 클래스명	: LoyPromReactionService
 * 2. 파일명	: LoyPromReactionService.java
 * 3. 패키지명	: com.icignal.loyalty.promreaction.service
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyPromReactionService {

	@Autowired
	private LoyPromReactionMapper loyPromReactionMapper;
	 /*
	  * 1. 메소드명: getPromReactionList
	  * 2. 클래스명: LoyPromReactionService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyPromReactionListResDto> getPromReactionList(LoyPromReactionListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<LoyPromReactionListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyPromReactionMapper.selectPromReactionList(bccr),AnnotationType.CommCode
				);
	}
	 /*
	  * 1. 메소드명: getPromReactDetail
	  * 2. 클래스명: LoyPromReactionService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	public LoyPromReactionDetailResDto getPromReactDetail(LoyPromReactionListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return loyPromReactionMapper.selectPromReactDetail(bccr);
	}
	 /*
	  * 1. 메소드명: getProdItemList
	  * 2. 클래스명: LoyPromReactionService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyPromMbrCalcListResDto> getPromMbrCalcList(LoyPromReactionListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<LoyPromMbrCalcListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyPromReactionMapper.selectPromMbrCalcList(bccr),AnnotationType.ALL
				);
	}
	 /*
	  * 1. 메소드명: getPromMbrCalcExcelList
	  * 2. 클래스명: LoyPromReactionService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public GridPagingResDto<LoyPromMbrCalcExcelListResDto> getPromMbrCalcExcelList(LoyPromReactionListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<LoyPromMbrCalcExcelListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyPromReactionMapper.selectPromMbrCalcExcelList(bccr),AnnotationType.ALL
				);
	}

}
