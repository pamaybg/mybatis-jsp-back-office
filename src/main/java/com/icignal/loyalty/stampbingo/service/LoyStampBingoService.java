/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyStampBingoService.java
 * 2. Package	: com.icignal.loyalty.stampbingo.service
 * 3. Comments	:	
 * 4. Author	: nh.lee
 * 5. DateTime	: 2020. 6. 23. 오전 10:10:46
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 23.	 | nh.lee			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.stampbingo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.channel.dto.response.LoyChnlResDto;
import com.icignal.loyalty.stampbingo.dto.request.LoyStampBingoBenfReqDto;
import com.icignal.loyalty.stampbingo.dto.request.LoyStampBingoChnlReqDto;
import com.icignal.loyalty.stampbingo.dto.request.LoyStampBingoMbrHistReqDto;
import com.icignal.loyalty.stampbingo.dto.request.LoyStampBingoMbrReqDto;
import com.icignal.loyalty.stampbingo.dto.request.LoyStampBingoReqDto;
import com.icignal.loyalty.stampbingo.dto.request.LoyStampBingoStepReqDto;
import com.icignal.loyalty.stampbingo.dto.response.LoyStampBingoBenfResDto;
import com.icignal.loyalty.stampbingo.dto.response.LoyStampBingoMbrHistResDto;
import com.icignal.loyalty.stampbingo.dto.response.LoyStampBingoMbrResDto;
import com.icignal.loyalty.stampbingo.dto.response.LoyStampBingoResDto;
import com.icignal.loyalty.stampbingo.dto.response.LoyStampBingoStepResDto;
import com.icignal.loyalty.stampbingo.mapper.LoyStampBingoMapper;

/*
 * 1. 클래스명	: LoyStampBingoService
 * 2. 파일명	: LoyStampBingoService.java
 * 3. 패키지명	: com.icignal.loyalty.stampbingo.service
 * 4. 작성자명	: nh.lee
 * 5. 작성일자	: 2020. 6. 23.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyStampBingoService {
	
	@Autowired
	LoyStampBingoMapper loyStampBingoMapper;
	
	/*
	 * 1. 메소드명: getStampBingoList
	 * 2. 클래스명: LoyStampBingoService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyStampBingoResDto> getStampBingoList(LoyStampBingoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyStampBingoResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyStampBingoMapper.selectStampBingoList(reqDto), AnnotationType.CommCode);
	}

	/*
	 * 1. 메소드명: getStampBingoDetail
	 * 2. 클래스명: LoyStampBingoService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyStampBingoResDto getStampBingoDetail(LoyStampBingoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return loyStampBingoMapper.selectStampBingoDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: updateStampBingo
	  * 2. 클래스명: LoyStampBingoService
	  * 3. 작성자명: nhlee 
	  * 4. 작성일자: 2020. 5. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto updateStampBingo(LoyStampBingoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
        loyStampBingoMapper.updateStampBingo(reqDto);

        rtnValue.setSuccess(true);
        return rtnValue;
	}

	/*
	 * 1. 메소드명: insertStampBingo
	 * 2. 클래스명: LoyStampBingoService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto insertStampBingo(LoyStampBingoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

        reqDto.setRid(CommonUtil.newRid());

        // 스탬프인지 빙고인지에 따라 프로시져이름 설정
        String numberGetterName = "S".equals(reqDto.getPromTypeCd()) ? "LOY.FN_GET_STAMP_NO" : "LOY.FN_GET_BINGO_NO";
        reqDto.setStbgNo(numberGetterName);
		
        StatusResDto rtnValue = new StatusResDto();
        loyStampBingoMapper.insertStampBingo(reqDto);

        rtnValue.setSuccess(true);
        return rtnValue;
	}

	/*
	 * 1. 메소드명: delStampBingo
	 * 2. 클래스명: LoyStampBingoService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto delStampBingo(LoyStampBingoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        
		StatusResDto rtnValue = new StatusResDto();
		loyStampBingoMapper.updateStampBingoDel(reqDto);
        rtnValue.setSuccess(true);

        return rtnValue;
	}

	/*
	 * 1. 메소드명: stopStampBingo
	 * 2. 클래스명: LoyStampBingoService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 중지
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto stopStampBingo(LoyStampBingoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyStampBingoMapper.updateStampBingoStop(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getStampBingoStepList
	 * 2. 클래스명: LoyStampBingoStepService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyStampBingoStepResDto> getStampBingoStepList(LoyStampBingoStepReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyStampBingoStepResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyStampBingoMapper.selectStampBingoStepList(reqDto), AnnotationType.CommCode);
	}

	/*
	 * 1. 메소드명: getStampBingoStepDetail
	 * 2. 클래스명: LoyStampBingoStepService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyStampBingoStepResDto getStampBingoStepDetail(LoyStampBingoStepReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return loyStampBingoMapper.selectStampBingoStepDetail(reqDto);
	}

	/*
	 * 1. 메소드명: updateStampBingoStep
	 * 2. 클래스명: LoyStampBingoStepService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto updateStampBingoStep(LoyStampBingoStepReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyStampBingoMapper.updateStampBingoStep(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: insertStampBingoStep
	 * 2. 클래스명: LoyStampBingoStepService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 등록
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto insertStampBingoStep(LoyStampBingoStepReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setRid(CommonUtil.newRid());

		StatusResDto rtnValue = new StatusResDto();
		loyStampBingoMapper.insertStampBingoStep(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: delStampBingoStep
	 * 2. 클래스명: LoyStampBingoStepService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto delStampBingoStep(LoyStampBingoStepReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyStampBingoMapper.updateStampBingoStepDel(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getStampBingoMbrList
	 * 2. 클래스명: LoyStampBingoService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 하위 참여자 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyStampBingoMbrResDto> getStampBingoMbrList(LoyStampBingoMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyStampBingoMbrResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyStampBingoMapper.selectStampBingoMbrList(reqDto), AnnotationType.PersonalData);
	}

	/*
	 * 1. 메소드명: getStampBingoMbrHistList
	 * 2. 클래스명: LoyStampBingoService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 하위 참여자 참여이력 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyStampBingoMbrHistResDto> getStampBingoMbrHistList(LoyStampBingoMbrHistReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyStampBingoMbrHistResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyStampBingoMapper.selectStampBingoMbrHistList(reqDto));
	}

	/*
	 * 1. 메소드명: getStampBingoChnlList
	 * 2. 클래스명: LoyStampBingoService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 하위 행사점 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyChnlResDto> getStampBingoChnlList(LoyStampBingoChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyChnlResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyStampBingoMapper.selectStampBingoChnlList(reqDto));
	}

	/*
	 * 1. 메소드명: addtampBingoChnl
	 * 2. 클래스명: LoyStampBingoStepService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 등록
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto addStampBingoChnl(LoyStampBingoChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setRid(CommonUtil.newRid());

		StatusResDto rtnValue = new StatusResDto();
		loyStampBingoMapper.insertStampBingoChnl(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: removeStampBingoStep
	 * 2. 클래스명: LoyStampBingoStepService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto removeStampBingoChnl(LoyStampBingoChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyStampBingoMapper.updateStampBingoChnlDel(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getStampBingoChnlHistList
	 * 2. 클래스명: LoyStampBingoService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 하위 행사점 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyStampBingoMbrResDto> getStampBingoChnlHistList(LoyStampBingoChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyStampBingoMbrResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyStampBingoMapper.selectStampBingoChnlHistList(reqDto));
	}

	/*
	 * 1. 메소드명: getStampBingoBenfList
	 * 2. 클래스명: LoyStampBingoBenfService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyStampBingoBenfResDto> getStampBingoBenfList(LoyStampBingoBenfReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyStampBingoBenfResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyStampBingoMapper.selectStampBingoBenfList(reqDto), AnnotationType.CommCode);
	}

	/*
	 * 1. 메소드명: getStampBingoBenfDetail
	 * 2. 클래스명: LoyStampBingoBenfService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyStampBingoBenfResDto getStampBingoBenfDetail(LoyStampBingoBenfReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return loyStampBingoMapper.selectStampBingoBenfDetail(reqDto);
	}

	/*
	 * 1. 메소드명: updateStampBingoBenf
	 * 2. 클래스명: LoyStampBingoBenfService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto updateStampBingoBenf(LoyStampBingoBenfReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyStampBingoMapper.updateStampBingoBenf(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: insertStampBingoBenf
	 * 2. 클래스명: LoyStampBingoBenfService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 등록
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto insertStampBingoBenf(LoyStampBingoBenfReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setRid(CommonUtil.newRid());

		StatusResDto rtnValue = new StatusResDto();
		loyStampBingoMapper.insertStampBingoBenf(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: delStampBingoBenf
	 * 2. 클래스명: LoyStampBingoBenfService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto delStampBingoBenf(LoyStampBingoBenfReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyStampBingoMapper.updateStampBingoBenfDel(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getStampListPop
	  * 2. 클래스명: LoyStampBingoService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyStampBingoResDto> getStampListPop(LoyStampBingoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyStampBingoResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyStampBingoMapper.selectStampListPop(reqDto), AnnotationType.CommCode);
	}
}
