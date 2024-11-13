/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyProgramMapper.java
 * 2. Package	: com.icignal.loyalty.loyprogram.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 26. 오전 10:11:05
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 26.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.loyprogram.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

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
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.request.SystemCommCodeExGridReqDto;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.commcode.dto.response.SystemCommCodeExGridResDto;

/*
 * 1. 클래스명	: LoyProgramMapper
 * 2. 파일명	: LoyProgramMapper.java
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
public interface LoyProgramMapper {

	 /*
	  * 1. 메소드명: selectPgmList
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyPgmResDto> selectPgmList(LoyPgmReqDto reqDto);

	 /*
	  * 1. 메소드명: selectPgm
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 단건 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyPgmResDto selectPgm(LoyPgmReqDto reqDto);

	 /*
	  * 1. 메소드명: updatePgm
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updatePgm(LoyPgmReqDto reqDto);

	 /*
	  * 1. 메소드명: insertPgm
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 26.
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
	void insertPgm(LoyPgmReqDto reqDto);

	 /*
	  * 1. 메소드명: updatePgmDel
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updatePgmDel(LoyPgmReqDto reqDto);

	 /*
	  * 1. 메소드명: selectPgmJoinPlcyList
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 가입정책 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyPgmJoinPlcyResDto> selectPgmJoinPlcyList(LoyPgmJoinPlcyReqDto reqDto);
	
	 /*
	  * 1. 메소드명: selectPgmJoinPlcy
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 가입정책 단건 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyPgmJoinPlcyResDto selectPgmJoinPlcy(LoyPgmJoinPlcyReqDto reqDto);

	 /*
	  * 1. 메소드명: insertPgmJoinPlcy
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 가입정책 입력
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	void insertPgmJoinPlcy(LoyPgmJoinPlcyReqDto reqDto);

	 /*
	  * 1. 메소드명: updatePgmJoinPlcy
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 가입정책 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	void updatePgmJoinPlcy(LoyPgmJoinPlcyReqDto reqDto);
	
	 /*
	  * 1. 메소드명: updatePgmJoinPlcyDel
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 포인트 정책 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	void updatePgmJoinPlcyDel(LoyPgmJoinPlcyReqDto reqDto);
	
	 /*
	  * 1. 메소드명: selectPgmPntPlcy
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 포인트 정책 단건 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyPgmPntPlcyResDto selectPgmPntPlcy(LoyPgmPntPlcyReqDto reqDto);
	
	 /*
	  * 1. 메소드명: insertPgmPntPlcy
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 포인트 정책 입력
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	void insertPgmPntPlcy(LoyPgmPntPlcyReqDto reqDto);

	 /*
	  * 1. 메소드명: updatePgmPntPlcy
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 포인트 정책 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	void updatePgmPntPlcy(LoyPgmPntPlcyReqDto reqDto);
	
	 /*
	  * 1. 메소드명: updatePgmPntPlcyDel
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 포인트 정책 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	void updatePgmPntPlcyDel(LoyPgmPntPlcyReqDto reqDto);
	
	 /*
	  * 1. 메소드명: selectPgmFmlyPlcy
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 패밀리 정책 입력
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyPgmFmlyPlcyResDto selectPgmFmlyPlcy(LoyPgmFmlyPlcyReqDto reqDto);
	 
	 /*
	  * 1. 메소드명: insertPgmFmlyPlcy
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 패밀리 정책 입력
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	void insertPgmFmlyPlcy(LoyPgmFmlyPlcyReqDto reqDto);

	 /*
	  * 1. 메소드명: updatePgmFmlyPlcy
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 패밀리 정책 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	void updatePgmFmlyPlcy(LoyPgmFmlyPlcyReqDto reqDto);
	
	 /*
	  * 1. 메소드명: updatePgmFmlyPlcyDel
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 패밀리 정책 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	void updatePgmFmlyPlcyDel(LoyPgmFmlyPlcyReqDto reqDto);
	
	 /*
	  * 1. 메소드명: selectPgmMgtPlcyList
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 운영 정첵 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyPgmMgtPlcyResDto> selectPgmMgtPlcyList(LoyPgmMgtPlcyReqDto reqDto);
	
	 /*
	  * 1. 메소드명: selectPgmMgtPlcy
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 운영 정첵 단건 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyPgmMgtPlcyResDto selectPgmMgtPlcy(LoyPgmMgtPlcyReqDto reqDto);

	 /*
	  * 1. 메소드명: insertPgmMgtPlcy
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 운영 정첵 입력
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	void insertPgmMgtPlcy(LoyPgmMgtPlcyReqDto reqDto);

	 /*
	  * 1. 메소드명: updatePgmMgtPlcy
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 운영 정첵 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	void updatePgmMgtPlcy(LoyPgmMgtPlcyReqDto reqDto);

	 /*
	  * 1. 메소드명: updatePgmMgtPlcyDel
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 운영 정첵 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	void updatePgmMgtPlcyDel(LoyPgmMgtPlcyReqDto reqDto);
	
	 /*
	  * 1. 메소드명: selectPgmClubPlcyList
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 채널 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyClubListResDto> selectPgmClubPlcyList(LoyClubListReqDto reqDto);
	
	 /*
	  * 1. 메소드명: selectPgmChnlList
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 채널 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyChnlResDto> selectPgmChnlList(LoyChnlReqDto reqDto);
	
	 /*
	  * 1. 메소드명: selectBLPlcyList
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 하위 이상 거래 정책 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyPgmBLPlcyResDto> selectBLPlcyList(LoyPgmBLPlcyReqDto reqDto);

	 /*
	  * 1. 메소드명: selectPgmHistList
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee 
	  * 4. 작성일자: 2020. 6. 08.
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
	List<LoyPgmHistResDto> selectPgmHistList(LoyPgmHistReqDto reqDto);
	
	 /*
	  * 1. 메소드명: insertPgmHist
	  * 2. 클래스명: LoyProgramMapper
	  * 3. 작성자명: nh.lee
	  * 4. 작성일자: 2020. 6. 08.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param phr	
	 */
	void insertPgmHist(LoyPgmHistReqDto phr);


	 /*
	  * 1. 메소드명: selectCustItemConfList
	  * 2. 클래스명: LoyProgramMapper
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
	List<LoyCustItemConfListResDto> selectCustItemConfList(LoyCustItemConfReqDto reqDto);


	 /*
	  * 1. 메소드명: selectCustItemConfDetail
	  * 2. 클래스명: LoyProgramMapper
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
	LoyCustItemConfResDto selectCustItemConfDetail(LoyCustItemConfReqDto reqDto);


	 /*
	  * 1. 메소드명: insertCustItemConfDetail
	  * 2. 클래스명: LoyProgramMapper
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
	 */
	void insertCustItemConfDetail(LoyCustItemConfReqDto reqDto);


	 /*
	  * 1. 메소드명: updateCustItemConfDetail
	  * 2. 클래스명: LoyProgramMapper
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
	 */
	void updateCustItemConfDetail(LoyCustItemConfReqDto reqDto);


	 /*
	  * 1. 메소드명: deleteCustItemConfDetail
	  * 2. 클래스명: LoyProgramMapper
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
	 */
	void deleteCustItemConfDetail(LoyCustItemConfReqDto reqDto);


	 /*
	  * 1. 메소드명: selectItemCodeList
	  * 2. 클래스명: LoyProgramMapper
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
	List<MKTCommonCodeResponseDTO> selectItemCodeList(MKTCommonCodeRequestDTO reqDto);


	Integer checkLoyPgmCnt(LoyPgmReqDto slr);

	 /*
	  * 1. 메소드명: selectGroupCodeListPop
	  * 2. 클래스명: LoyProgramMapper
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
	List<SystemCommCodeExGridResDto> selectGroupCodeListPop(SystemCommCodeExGridReqDto reqDto);

	Integer checkCustItemVal(LoyCustItemConfReqDto reqDto);
	
}
