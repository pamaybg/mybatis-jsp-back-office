/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyGameMapper.java
 * 2. Package	: com.icignal.loyalty.game.mapper
 * 3. Comments	:	
 * 4. Author	: nh.lee
 * 5. DateTime	: 2020. 7. 14. 오전 10:11:05
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 14.	 | nh.lee			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.game.mapper;

import com.icignal.loyalty.game.dto.request.*;
import com.icignal.loyalty.game.dto.response.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/*
 * 1. 클래스명	: LoyGameMapper
 * 2. 파일명	: LoyGameMapper.java
 * 3. 패키지명	: com.icignal.loyalty.loyprogram.mapper
 * 4. 작성자명	: nhlee
 * 5. 작성일자	: 2020. 6. 08.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyGameMapper {

	 /*
	  * 1. 메소드명: selectGameList
	  * 2. 클래스명: LoyGameMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyGameResDto> selectGameList(LoyGameReqDto reqDto);
	
	 /*
	  * 1. 메소드명: selectGameDetail
	  * 2. 클래스명: LoyGameMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 단건 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyGameResDto selectGameDetail(LoyGameReqDto reqDto);

	 /*
	  * 1. 메소드명: updateGame
	  * 2. 클래스명: LoyGameMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updateGame(LoyGameReqDto reqDto);

	 /*
	  * 1. 메소드명: insertGame
	  * 2. 클래스명: LoyGameMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 입력
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void insertGame(LoyGameReqDto reqDto);

	 /*
	  * 1. 메소드명: updateGameDel
	  * 2. 클래스명: LoyGameMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updateGameDel(LoyGameReqDto reqDto);

	/*
	 * 1. 메소드명: updateGameStop
	 * 2. 클래스명: LoyGameMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 14.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 중지
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateGameStop(LoyGameReqDto reqDto);

	/*
	 * 1. 메소드명: selectGameSubDetail
	 * 2. 클래스명: LoyGameMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 14.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 상세 정책 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	LoyGameSubResDto selectGameSubDetail(LoyGameSubReqDto reqDto);

	/*
	 * 1. 메소드명: updateGameSub
	 * 2. 클래스명: LoyGameMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 14.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 상세 정책 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateGameSub(LoyGameSubReqDto reqDto);

	/*
	 * 1. 메소드명: updateGameSub
	 * 2. 클래스명: LoyGameMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 14.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 상세 정책 삭제(Null 처리)
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateGameSubDel(LoyGameSubReqDto reqDto);

	/*
	 * 1. 메소드명: selectGameRuleList
	 * 2. 클래스명: LoyGameMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 14.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 리스트 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	List<LoyGameRuleResDto> selectGameRuleList(LoyGameRuleReqDto reqDto);

	/*
	 * 1. 메소드명: selectGameRuleDetail
	 * 2. 클래스명: LoyGameMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 14.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 단건 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	LoyGameRuleResDto selectGameRuleDetail(LoyGameRuleReqDto reqDto);

	/*
	 * 1. 메소드명: updateGameRule
	 * 2. 클래스명: LoyGameMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 14.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateGameRule(LoyGameRuleReqDto reqDto);

	/*
	 * 1. 메소드명: insertGameRule
	 * 2. 클래스명: LoyGameMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 14.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 입력
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void insertGameRule(LoyGameRuleReqDto reqDto);

	/*
	 * 1. 메소드명: updateGameRuleDel
	 * 2. 클래스명: LoyGameMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 14.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임룰 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateGameRuleDel(LoyGameRuleReqDto reqDto);

	/*
	 * 1. 메소드명: selectGameTicketList
	 * 2. 클래스명: LoyGameMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 하위 티켓 리스트 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	List<LoyGameTicketResDto> selectGameTicketList(LoyGameTicketReqDto reqDto);

	/*
	 * 1. 메소드명: selectGameJoinList
	 * 2. 클래스명: LoyGameMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		게임 하위 참여자 리스트 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	List<LoyGameJoinResDto> selectGameJoinList(LoyGameJoinReqDto reqDto);

}
