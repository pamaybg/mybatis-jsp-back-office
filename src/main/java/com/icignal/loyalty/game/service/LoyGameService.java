/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**
 * 1. FileName	: LoyGameService.java
 * 2. Package	: com.icignal.loyalty.game.service
 * 3. Comments	:	
 * 4. Author	: nh.lee
 * 5. DateTime	: 2020. 7. 15. 오전 10:10:46
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 15.	 | nh.lee			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.game.service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.game.dto.request.*;
import com.icignal.loyalty.game.dto.response.*;
import com.icignal.loyalty.game.mapper.LoyGameMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/*
 * 1. 클래스명	: LoyGameService
 * 2. 파일명	: LoyGameService.java
 * 3. 패키지명	: com.icignal.loyalty.game.service
 * 4. 작성자명	: nh.lee
 * 5. 작성일자	: 2020. 7. 15.
 */

/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyGameService {
	
	@Autowired
	private LoyGameMapper loyGameMapper;
	
	/*
	 * 1. 메소드명: getGameList
	 * 2. 클래스명: LoyGameService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 7. 15.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyGameResDto> getGameList(LoyGameReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyGameResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyGameMapper.selectGameList(reqDto), AnnotationType.CommCode);
	}

	/*
	 * 1. 메소드명: getGameDetail
	 * 2. 클래스명: LoyGameService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyGameResDto getGameDetail(LoyGameReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return loyGameMapper.selectGameDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: updateGame
	  * 2. 클래스명: LoyGameService
	  * 3. 작성자명: nhlee 
	  * 4. 작성일자: 2020. 5. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto updateGame(LoyGameReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
        loyGameMapper.updateGame(reqDto);

        rtnValue.setSuccess(true);
        return rtnValue;
	}

	/*
	 * 1. 메소드명: insertGame
	 * 2. 클래스명: LoyGameService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto insertGame(LoyGameReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

        reqDto.setRid(CommonUtil.newRid());

        StatusResDto rtnValue = new StatusResDto();
        loyGameMapper.insertGame(reqDto);

        rtnValue.setSuccess(true);
        return rtnValue;
	}

	/*
	 * 1. 메소드명: delGame
	 * 2. 클래스명: LoyGameService
	 * 3. 작성자명: nhlee 
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto delGame(LoyGameReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        
		StatusResDto rtnValue = new StatusResDto();
		loyGameMapper.updateGameDel(reqDto);
        rtnValue.setSuccess(true);

        return rtnValue;
	}

	/*
	 * 1. 메소드명: stopGame
	 * 2. 클래스명: LoyGameService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 중지
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto stopGame(LoyGameReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyGameMapper.updateGameStop(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getGameSubDetail
	 * 2. 클래스명: LoyGameService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyGameSubResDto getGameSubDetail(LoyGameSubReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return loyGameMapper.selectGameSubDetail(reqDto);
	}

	/*
	 * 1. 메소드명: updateGameSub
	 * 2. 클래스명: LoyGameService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 상세 정책 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto editGameSub(LoyGameSubReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyGameMapper.updateGameSub(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: removeGameSub
	 * 2. 클래스명: LoyGameService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 상세 정책 삭제(Null 처리)
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto removeGameSub(LoyGameSubReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyGameMapper.updateGameSubDel(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getGameRuleList
	 * 2. 클래스명: LoyGameRuleService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 7. 15.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyGameRuleResDto> getGameRuleList(LoyGameRuleReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyGameRuleResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyGameMapper.selectGameRuleList(reqDto), AnnotationType.CommCode);
	}

	/*
	 * 1. 메소드명: getGameRuleDetail
	 * 2. 클래스명: LoyGameRuleService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyGameRuleResDto getGameRuleDetail(LoyGameRuleReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return loyGameMapper.selectGameRuleDetail(reqDto);
	}

	/*
	 * 1. 메소드명: updateGameRule
	 * 2. 클래스명: LoyGameRuleService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto updateGameRule(LoyGameRuleReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyGameMapper.updateGameRule(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: insertGameRule
	 * 2. 클래스명: LoyGameRuleService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 등록
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto insertGameRule(LoyGameRuleReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setRid(CommonUtil.newRid());

		StatusResDto rtnValue = new StatusResDto();
		loyGameMapper.insertGameRule(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: delGameRule
	 * 2. 클래스명: LoyGameRuleService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto delGameRule(LoyGameRuleReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyGameMapper.updateGameRuleDel(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getGameJoinList
	 * 2. 클래스명: LoyGameService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 7. 15.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 하위 참여자 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyGameJoinResDto> getGameJoinList(LoyGameJoinReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyGameJoinResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyGameMapper.selectGameJoinList(reqDto), AnnotationType.CommCode);
	}

	/*
	 * 1. 메소드명: getGameTicketList
	 * 2. 클래스명: LoyGameService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 7. 15.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 하위 티켓 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyGameTicketResDto> getGameTicketList(LoyGameTicketReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyGameTicketResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyGameMapper.selectGameTicketList(reqDto), AnnotationType.CommCode);
	}

}
