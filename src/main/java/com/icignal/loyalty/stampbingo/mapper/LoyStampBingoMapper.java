/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyProgramMapper.java
 * 2. Package	: com.icignal.loyalty.stampbingo.mapper
 * 3. Comments	:	
 * 4. Author	: nh.lee
 * 5. DateTime	: 2020. 6. 23. 오전 10:11:05
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 23.	 | nh.lee			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.stampbingo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

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

/*
 * 1. 클래스명	: LoyStampBingoMapper
 * 2. 파일명	: LoyStampBingoMapper.java
 * 3. 패키지명	: com.icignal.loyalty.stampbingo.mapper
 * 4. 작성자명	: nhlee
 * 5. 작성일자	: 2020. 6. 23.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyStampBingoMapper {

	/*
	 * 1. 메소드명: selectStampBingoList
	 * 2. 클래스명: LoyStampBingoMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyStampBingoResDto> selectStampBingoList(LoyStampBingoReqDto reqDto);
	
	/*
	 * 1. 메소드명: selectStampBingoDetail
	 * 2. 클래스명: LoyStampBingoMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단건 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyStampBingoResDto selectStampBingoDetail(LoyStampBingoReqDto reqDto);

	/*
	 * 1. 메소드명: updateStampBingo
	 * 2. 클래스명: LoyStampBingoMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updateStampBingo(LoyStampBingoReqDto reqDto);

	/*
	 * 1. 메소드명: insertStampBingo
	 * 2. 클래스명: LoyStampBingoMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 입력
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void insertStampBingo(LoyStampBingoReqDto reqDto);


	/*
	 * 1. 메소드명: updateStampBingoDel
	 * 2. 클래스명: LoyStampBingoMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateStampBingoDel(LoyStampBingoReqDto reqDto);

	/*
	 * 1. 메소드명: updateStampBingoStop
	 * 2. 클래스명: LoyStampBingoMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 중지
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateStampBingoStop(LoyStampBingoReqDto reqDto);

	/*
	 * 1. 메소드명: selectStampBingoStepList
	 * 2. 클래스명: LoyStampBingoStepMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 리스트 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	List<LoyStampBingoStepResDto> selectStampBingoStepList(LoyStampBingoStepReqDto reqDto);

	/*
	 * 1. 메소드명: selectStampBingoStepDetail
	 * 2. 클래스명: LoyStampBingoStepMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 단건 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	LoyStampBingoStepResDto selectStampBingoStepDetail(LoyStampBingoStepReqDto reqDto);

	/*
	 * 1. 메소드명: updateStampBingoStep
	 * 2. 클래스명: LoyStampBingoStepMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateStampBingoStep(LoyStampBingoStepReqDto reqDto);

	/*
	 * 1. 메소드명: insertStampBingoStep
	 * 2. 클래스명: LoyStampBingoStepMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 입력
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void insertStampBingoStep(LoyStampBingoStepReqDto reqDto);

	/*
	 * 1. 메소드명: updateStampBingoStepDel
	 * 2. 클래스명: LoyStampBingoStepMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 단계 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateStampBingoStepDel(LoyStampBingoStepReqDto reqDto);

	/*
	 * 1. 메소드명: selectStampBingoMbrList
	 * 2. 클래스명: LoyStampBingoMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 하위 참여자 리스트 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	List<LoyStampBingoMbrResDto> selectStampBingoMbrList(LoyStampBingoMbrReqDto reqDto);

	/*
	 * 1. 메소드명: selectStampBingoMbrHistList
	 * 2. 클래스명: LoyStampBingoMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 하위 참여자 참여이력 리스트 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	List<LoyStampBingoMbrHistResDto> selectStampBingoMbrHistList(LoyStampBingoMbrHistReqDto reqDto);


	/*
	 * 1. 메소드명: selectStampBingoChnlList
	 * 2. 클래스명: LoyStampBingoMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 하위 행사점 리스트 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	List<LoyChnlResDto> selectStampBingoChnlList(LoyStampBingoChnlReqDto reqDto);

	/*
	 * 1. 메소드명: insertStampBingoChnl
	 * 2. 클래스명: LoyStampBingoStepMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 행사점 입력
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void insertStampBingoChnl(LoyStampBingoChnlReqDto reqDto);


	/*
	 * 1. 메소드명: updateStampBingoChnlDel
	 * 2. 클래스명: LoyStampBingoStepMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 행사점 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateStampBingoChnlDel(LoyStampBingoChnlReqDto reqDto);

	/*
	 * 1. 메소드명: selectStampBingoMbrList
	 * 2. 클래스명: LoyStampBingoMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 하위 행사점 참여이력 리스트 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	List<LoyStampBingoMbrResDto> selectStampBingoChnlHistList(LoyStampBingoChnlReqDto reqDto);


	/*
	 * 1. 메소드명: selectStampBingoBenfList
	 * 2. 클래스명: LoyStampBingoBenfMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 리스트 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	List<LoyStampBingoBenfResDto> selectStampBingoBenfList(LoyStampBingoBenfReqDto reqDto);

	/*
	 * 1. 메소드명: selectStampBingoBenfDetail
	 * 2. 클래스명: LoyStampBingoBenfMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 단건 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	LoyStampBingoBenfResDto selectStampBingoBenfDetail(LoyStampBingoBenfReqDto reqDto);

	/*
	 * 1. 메소드명: updateStampBingoBenf
	 * 2. 클래스명: LoyStampBingoBenfMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateStampBingoBenf(LoyStampBingoBenfReqDto reqDto);

	/*
	 * 1. 메소드명: insertStampBingoBenf
	 * 2. 클래스명: LoyStampBingoBenfMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 입력
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void insertStampBingoBenf(LoyStampBingoBenfReqDto reqDto);

	/*
	 * 1. 메소드명: updateStampBingoBenfDel
	 * 2. 클래스명: LoyStampBingoBenfMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		스탬프/빙고 달성 혜택 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateStampBingoBenfDel(LoyStampBingoBenfReqDto reqDto);

	 /*
	  * 1. 메소드명: selectStampListPop
	  * 2. 클래스명: LoyStampBingoMapper
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
	 *   @param reqDto
	 *   @return	
	 */
	
	List<LoyStampBingoResDto> selectStampListPop(LoyStampBingoReqDto reqDto);
}
