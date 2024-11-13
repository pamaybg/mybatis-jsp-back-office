/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBlackMbrService.java
 * 2. Package	: com.icignal.loyalty.blackMbr.service
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 10. 오후 3:38:57
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 10.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackMbr.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.blackMbr.dto.request.LoyBlackMbrDetailReqDto;
import com.icignal.loyalty.blackMbr.dto.request.LoyBlackMbrListReqDto;
import com.icignal.loyalty.blackMbr.dto.response.LoyBlackMbrDetailResDto;
import com.icignal.loyalty.blackMbr.dto.response.LoyBlackMbrListResDto;
import com.icignal.loyalty.blackMbr.mapper.LoyBlackMbrMapper;

/*
 * 1. 클래스명	: LoyBlackMbrService
 * 2. 파일명	: LoyBlackMbrService.java
 * 3. 패키지명	: com.icignal.loyalty.blackMbr.service
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyBlackMbrService {
	
	@Autowired
	private LoyBlackMbrMapper loyBlackMbrMapper;
	 /*
	  * 1. 메소드명: getBlackMbrDetail
	  * 2. 클래스명: LoyBlackMbrService
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 10.
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
	
	public GridPagingResDto<LoyBlackMbrListResDto> getBlackMbrList(LoyBlackMbrListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

	    return new GridPagingResHelper<LoyBlackMbrListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyBlackMbrMapper.selectBlackMbrList(reqDto),AnnotationType.ALL);
	}
	 /*
	  * 1. 메소드명: getBlackMbrDetail
	  * 2. 클래스명: LoyBlackMbrService
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 11.
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
	
	public LoyBlackMbrDetailResDto getBlackMbrDetail(LoyBlackMbrListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyBlackMbrDetailResDto resDto = loyBlackMbrMapper.selectBlackMbrDetail(reqDto);
		return new AnnotationHelper<LoyBlackMbrDetailResDto>(AnnotationType.PersonalData, resDto).getItem();
	}
	 /*
	  * 1. 메소드명: saveBlackMbrDetail
	  * 2. 클래스명: LoyBlackMbrService
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 11.
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
	
	public StatusResDto saveBlackMbrDetail(LoyBlackMbrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		
		reqDto.setRid(CommonUtil.newRid());
		loyBlackMbrMapper.insertBlackMbrDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
		
	}

	 /*
	  * 1. 메소드명: modifyBlackMbrDetail
	  * 2. 클래스명: LoyBlackMbrService
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 11.
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
	
	public StatusResDto modifyBlackMbrDetail(LoyBlackMbrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyBlackMbrMapper.updateBlackMbrDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	 /*
	  * 1. 메소드명: clearMaskBlackMbr
	  * 2. 클래스명: LoyBlackMbrService
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 11.
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
	
	public LoyBlackMbrListResDto clearMaskBlackMbr(LoyBlackMbrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyBlackMbrListResDto resDto = loyBlackMbrMapper.selectClearMaskBlackMbr(reqDto);
		return new AnnotationHelper<LoyBlackMbrListResDto>(AnnotationType.PersonalData, resDto).getItem();
	}
	 /*
	  * 1. 메소드명: removeBlackListMbr
	  * 2. 클래스명: LoyBlackMbrService
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 11.
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
	
	public StatusResDto removeBlackListMbr(LoyBlackMbrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyBlackMbrMapper.deleteBlackListMbr(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

}
