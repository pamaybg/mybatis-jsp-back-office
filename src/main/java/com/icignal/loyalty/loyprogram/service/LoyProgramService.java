/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyProgramService.java
 * 2. Package	: com.icignal.loyalty.loyprogram.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 26. 오전 10:10:46
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 26.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.loyprogram.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.channel.dto.request.LoyChnlReqDto;
import com.icignal.loyalty.channel.dto.response.LoyChnlResDto;
import com.icignal.loyalty.club.dto.request.LoyClubListReqDto;
import com.icignal.loyalty.club.dto.response.LoyClubListResDto;
import com.icignal.loyalty.loyprogram.dto.request.LoyCustItemConfReqDto;
import com.icignal.loyalty.loyprogram.dto.request.LoyPgmBLPlcyReqDto;
import com.icignal.loyalty.loyprogram.dto.request.LoyPgmFmlyPlcyReqDto;
import com.icignal.loyalty.loyprogram.dto.request.LoyPgmHistReqDto;
import com.icignal.loyalty.loyprogram.dto.request.LoyPgmJoinPlcyReqDto;
import com.icignal.loyalty.loyprogram.dto.request.LoyPgmMgtPlcyReqDto;
import com.icignal.loyalty.loyprogram.dto.request.LoyPgmPntPlcyReqDto;
import com.icignal.loyalty.loyprogram.dto.request.LoyPgmReqDto;
import com.icignal.loyalty.loyprogram.dto.response.LoyCustItemConfListResDto;
import com.icignal.loyalty.loyprogram.dto.response.LoyCustItemConfResDto;
import com.icignal.loyalty.loyprogram.dto.response.LoyPgmBLPlcyResDto;
import com.icignal.loyalty.loyprogram.dto.response.LoyPgmFmlyPlcyResDto;
import com.icignal.loyalty.loyprogram.dto.response.LoyPgmHistResDto;
import com.icignal.loyalty.loyprogram.dto.response.LoyPgmJoinPlcyResDto;
import com.icignal.loyalty.loyprogram.dto.response.LoyPgmMgtPlcyResDto;
import com.icignal.loyalty.loyprogram.dto.response.LoyPgmPntPlcyResDto;
import com.icignal.loyalty.loyprogram.dto.response.LoyPgmResDto;
import com.icignal.loyalty.loyprogram.mapper.LoyProgramMapper;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.request.SystemCommCodeExGridReqDto;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.commcode.dto.response.SystemCommCodeExGridResDto;

/*
 * 1. 클래스명	: LoyProgramService
 * 2. 파일명	: LoyProgramService.java
 * 3. 패키지명	: com.icignal.loyalty.loyprogram.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyProgramService {
	
	@Autowired
	LoyProgramMapper loyProgramMapper;
	
	/*
	 * 1. 메소드명: getPgmList
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyPgmResDto> getPgmList(LoyPgmReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyPgmResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyProgramMapper.selectPgmList(reqDto), AnnotationType.CommCode);
	}
	
	/*
	 * 1. 메소드명: getPgmDetail
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyPgmResDto getPgmDetail(LoyPgmReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return loyProgramMapper.selectPgm(reqDto);
	}

	 /*
	  * 1. 메소드명: updatePgm
	  * 2. 클래스명: LoyProgramService
	  * 3. 작성자명: nhlee 
	  * 4. 작성일자: 2020. 5. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto updatePgm(LoyPgmReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		        
        loyProgramMapper.updatePgm(reqDto);

        rtnValue.setSuccess(true);
        return rtnValue;
	}

	/*
	 * 1. 메소드명: insertPgm
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto insertPgm(LoyPgmReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

        reqDto.setRid(CommonUtil.newRid());
		
        StatusResDto rtnValue = new StatusResDto();
        loyProgramMapper.insertPgm(reqDto);

        rtnValue.setSuccess(true);
        return rtnValue;
	}

	/*
	 * 1. 메소드명: delPgm
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto delPgm(LoyPgmReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        
		StatusResDto rtnValue = new StatusResDto();
		
		loyProgramMapper.updatePgmDel(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}

	/*
	 * 1. 메소드명: getPgmJoinPlcyList
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 가입 정책 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyPgmJoinPlcyResDto> getPgmJoinPlcyList(LoyPgmJoinPlcyReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		GridPagingResDto<LoyPgmJoinPlcyResDto> rtnObj = new GridPagingResHelper<LoyPgmJoinPlcyResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyProgramMapper.selectPgmJoinPlcyList(reqDto), AnnotationType.CommCode);

		return rtnObj;
	}

	/*
	 * 1. 메소드명: getPgmJoinPlcyDetail
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 가입 정책 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyPgmJoinPlcyResDto getPgmJoinPlcyDetail(LoyPgmJoinPlcyReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return loyProgramMapper.selectPgmJoinPlcy(reqDto);
	}

	/*
	 * 1. 메소드명: addPgmJoinPlcy
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 가입 정책 추가
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto addPgmJoinPlcy(LoyPgmJoinPlcyReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        reqDto.setRid(CommonUtil.newRid());
		
        StatusResDto rtnValue = new StatusResDto();

        loyProgramMapper.insertPgmJoinPlcy(reqDto);

        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	/*
	 * 1. 메소드명: editPgmJoinPlcy
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 가입 정책 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto editPgmJoinPlcy(LoyPgmJoinPlcyReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();

        loyProgramMapper.updatePgmJoinPlcy(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}

	/*
	 * 1. 메소드명: removePgmJoinPlcy
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 가입 정책 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removePgmJoinPlcy(LoyPgmJoinPlcyReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();
		
        loyProgramMapper.updatePgmJoinPlcyDel(reqDto);
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	/*
	 * 1. 메소드명: getPgmPntPlcyDetail
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 포인트 정책 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyPgmPntPlcyResDto getPgmPntPlcyDetail(LoyPgmPntPlcyReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return loyProgramMapper.selectPgmPntPlcy(reqDto);
	}
	
	/*
	 * 1. 메소드명: addPgmPntPlcy
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 포인트 정책 입력
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto addPgmPntPlcy(LoyPgmPntPlcyReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        reqDto.setRid(CommonUtil.newRid());
		
        StatusResDto rtnValue = new StatusResDto();
        loyProgramMapper.insertPgmPntPlcy(reqDto);

        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	/*
	 * 1. 메소드명: editPgmPntPlcy
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 포인트 정책 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto editPgmPntPlcy(LoyPgmPntPlcyReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();

        loyProgramMapper.updatePgmPntPlcy(reqDto);
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	/*
	 * 1. 메소드명: removePgmPntPlcy
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 포인트 정책 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removePgmPntPlcy(LoyPgmPntPlcyReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();
		
        loyProgramMapper.updatePgmPntPlcyDel(reqDto);
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	/*
	 * 1. 메소드명: getPgmFmlyPlcyDetail
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 패밀리 정첵 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyPgmFmlyPlcyResDto getPgmFmlyPlcyDetail(LoyPgmFmlyPlcyReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return loyProgramMapper.selectPgmFmlyPlcy(reqDto);
	}
	
	/*
	 * 1. 메소드명: addPgmFmlyPlcy
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 패밀리 정첵 추가
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto addPgmFmlyPlcy(LoyPgmFmlyPlcyReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        reqDto.setRid(CommonUtil.newRid());
		
        StatusResDto rtnValue = new StatusResDto();
        loyProgramMapper.insertPgmFmlyPlcy(reqDto);

        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	/*
	 * 1. 메소드명: editPgmFmlyPlcy
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 패밀리 정첵 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto editPgmFmlyPlcy(LoyPgmFmlyPlcyReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();

        loyProgramMapper.updatePgmFmlyPlcy(reqDto);
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	/*
	 * 1. 메소드명: removePgmFmlyPlcy
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 패밀리 정첵 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removePgmFmlyPlcy(LoyPgmFmlyPlcyReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();
		
        loyProgramMapper.updatePgmFmlyPlcyDel(reqDto);
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	/*
	 * 1. 메소드명: getPgmMgtPlcyList
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 운영 정첵 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyPgmMgtPlcyResDto> getPgmMgtPlcyList(LoyPgmMgtPlcyReqDto reqDto) {
	    LogUtil.param(this.getClass(), reqDto);

	    GridPagingResDto<LoyPgmMgtPlcyResDto> rtnObj = new GridPagingResHelper<LoyPgmMgtPlcyResDto>().newGridPagingResDto(
	             reqDto.init(CommonUtil.getInstance().getDBType()),
	             loyProgramMapper.selectPgmMgtPlcyList(reqDto), AnnotationType.CommCode);

	    return rtnObj;
	}

	/*
	 * 1. 메소드명: getPgmMgtPlcyDetail
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 운영 정첵 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyPgmMgtPlcyResDto getPgmMgtPlcyDetail(LoyPgmMgtPlcyReqDto reqDto) {

		LogUtil.param(this.getClass(), reqDto);

	    return loyProgramMapper.selectPgmMgtPlcy(reqDto);
	}

	/*
	 * 1. 메소드명: addPgmMgtPlcy
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 운영 정첵 추가
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto addPgmMgtPlcy(LoyPgmMgtPlcyReqDto reqDto) {

	    LogUtil.param(this.getClass(), reqDto);

	    reqDto.setRid(CommonUtil.newRid());
	    
	    StatusResDto rtnValue = new StatusResDto();
	    loyProgramMapper.insertPgmMgtPlcy(reqDto);

	    rtnValue.setSuccess(true);
	    return rtnValue;
	}

	/*
	 * 1. 메소드명: editPgmMgtPlcy
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 운영 정첵 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto editPgmMgtPlcy(LoyPgmMgtPlcyReqDto reqDto) {

	    LogUtil.param(this.getClass(), reqDto);

	    StatusResDto rtnValue = new StatusResDto();

	    loyProgramMapper.updatePgmMgtPlcy(reqDto);
	    rtnValue.setSuccess(true);
	    return rtnValue;
	}

	/*
	 * 1. 메소드명: removePgmMgtPlcy
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 운영 정책 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removePgmMgtPlcy(LoyPgmMgtPlcyReqDto reqDto) {

		LogUtil.param(this.getClass(), reqDto);

	    StatusResDto rtnValue = new StatusResDto();
	    
	    loyProgramMapper.updatePgmMgtPlcyDel(reqDto);
	    rtnValue.setSuccess(true);
	    return rtnValue;
	}
	
	/*
	 * 1. 메소드명: getPgmClubPlcyList
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 클럽 정책 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyClubListResDto> getPgmClubPlcyList(LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

	    GridPagingResDto<LoyClubListResDto> rtnObj = new GridPagingResHelper<LoyClubListResDto>().newGridPagingResDto(
	             reqDto.init(CommonUtil.getInstance().getDBType()),
	             loyProgramMapper.selectPgmClubPlcyList(reqDto), AnnotationType.CommCode);

	    return rtnObj;
	}
	
	/*
	 * 1. 메소드명: getPgmChnlList
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 채널 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyChnlResDto> getPgmChnlList(LoyChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

	    GridPagingResDto<LoyChnlResDto> rtnObj = new GridPagingResHelper<LoyChnlResDto>().newGridPagingResDto(
	             reqDto.init(CommonUtil.getInstance().getDBType()),
	             loyProgramMapper.selectPgmChnlList(reqDto), AnnotationType.CommCode);

	    return rtnObj;
	}
	
	/*
	 * 1. 메소드명: getPgmBLPlcyList
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 이상거래 정책 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyPgmBLPlcyResDto> getPgmBLPlcyList(LoyPgmBLPlcyReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

	    GridPagingResDto<LoyPgmBLPlcyResDto> rtnObj = new GridPagingResHelper<LoyPgmBLPlcyResDto>().newGridPagingResDto(
	             reqDto.init(CommonUtil.getInstance().getDBType()),
	             loyProgramMapper.selectBLPlcyList(reqDto), AnnotationType.CommCode);

	    return rtnObj;
	}
	
	/*
	 * 1. 메소드명: getPgmHistList
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 변경 이력 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyPgmHistResDto> getPgmHistList(LoyPgmHistReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
	    GridPagingResDto<LoyPgmHistResDto> rtnObj = new GridPagingResHelper<LoyPgmHistResDto>().newGridPagingResDto(
	             reqDto.init(CommonUtil.getInstance().getDBType()),
	             loyProgramMapper.selectPgmHistList(reqDto), AnnotationType.CommCode);

	    return rtnObj;
	}

	/*
	 * 1. 메소드명: insertPgmHist
	 * 2. 클래스명: LoyProgramService
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 9.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로열티 프로그램과 그 하위 엔티티 히스토리 추가
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto addPgmHist(List<LoyPgmHistReqDto> reqDto, LoginResDto loginInfo) {

	    LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();

        for (LoyPgmHistReqDto change : reqDto) {
        	
        	change.setRid(CommonUtil.newRid());
        	change.setCreateBy(loginInfo.getId());
			change.setModifyBy(loginInfo.getId());

            loyProgramMapper.insertPgmHist(change);
        }

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getCustItemConfList
	  * 2. 클래스명: LoyProgramService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객정보 수집 항목 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyCustItemConfListResDto> getCustItemConfList(LoyCustItemConfReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyCustItemConfListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyProgramMapper.selectCustItemConfList(reqDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getCustItemConfDetail
	  * 2. 클래스명: LoyProgramService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객정보 수집 항목 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyCustItemConfResDto getCustItemConfDetail(LoyCustItemConfReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyProgramMapper.selectCustItemConfDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: saveCustItemConfDetail
	  * 2. 클래스명: LoyProgramService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객정보 수집 항목 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto saveCustItemConfDetail(LoyCustItemConfReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		reqDto.setRid(CommonUtil.newRid());
		int count = loyProgramMapper.checkCustItemVal(reqDto);
		if(count > 0) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("이미 추가된 항목입니다.");
		}else {
			loyProgramMapper.insertCustItemConfDetail(reqDto);
			rtnValue.setSuccess(true);
		}
		
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyCustItemConfDetail
	  * 2. 클래스명: LoyProgramService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객정보 수집 항목 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto modifyCustItemConfDetail(LoyCustItemConfReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		int count = loyProgramMapper.checkCustItemVal(reqDto);
		if(count > 0) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("이미 추가된 항목입니다.");
		}else {
			loyProgramMapper.updateCustItemConfDetail(reqDto);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeCustItemConf
	  * 2. 클래스명: LoyProgramService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객정보 수집 항목 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removeCustItemConf(LoyCustItemConfReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyProgramMapper.deleteCustItemConfDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getItemCodeList
	  * 2. 클래스명: LoyProgramService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		항목 필드 리스트 (공통코드)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<MKTCommonCodeResponseDTO> getItemCodeList(MKTCommonCodeRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<MKTCommonCodeResponseDTO>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyProgramMapper.selectItemCodeList(reqDto));
	}

	public int checkLoyPgmCnt(LoyPgmReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		return loyProgramMapper.checkLoyPgmCnt(slr);
	}

	 /*
	  * 1. 메소드명: getGroupCodeListPop
	  * 2. 클래스명: LoyProgramService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로열티 프로그램 상세 - 고객수집정보 상세 팝업 - 그룹코드 리스트 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<SystemCommCodeExGridResDto> getGroupCodeListPop(SystemCommCodeExGridReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<SystemCommCodeExGridResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyProgramMapper.selectGroupCodeListPop(reqDto), AnnotationType.CommCode);
	}
	
}
