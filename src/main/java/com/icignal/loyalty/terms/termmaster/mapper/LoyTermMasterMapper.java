/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTermMasterMapper.java
 * 2. Package	: com.icignal.loyalty.terms.termmaster.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 27. 오후 2:35:05
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 27.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.terms.termmaster.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.terms.termmaster.dto.request.LoyTermsDetailListReqDto;
import com.icignal.loyalty.terms.termmaster.dto.request.LoyTermsListReqDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsDetailListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsLoyPgmListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsRcvChnlListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsValidChekResDto;

/*
 * 1. 클래스명	: LoyTermMasterMapper
 * 2. 파일명	: LoyTermMasterMapper.java
 * 3. 패키지명	: com.icignal.loyalty.terms.termmaster.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyTermMasterMapper {

	 /*
	  * 1. 메소드명: selectTermsList
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	List<LoyTermsListResDto> selectTermsList(LoyTermsListReqDto reqDto);
	
	 /*
	  * 1. 메소드명: selectTermsDetail
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 상세 정보
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyTermsDetailListResDto selectTermsDetail(LoyTermsListReqDto reqDto);

	 /*
	  * 1. 메소드명: insertTermsList
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 상세 신규 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	
	void insertTermsList(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: updateTermsList
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관관리 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	
	void updateTermsList(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: getTermsVerList
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관버전 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyTermsListResDto> selectTermsVerList(LoyTermsListReqDto reqDto);

	 /*
	  * 1. 메소드명: getTermsRcvChnl
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		수신채널 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyTermsRcvChnlListResDto> selectTermsRcvChnl(LoyTermsListReqDto reqDto);

	 /*
	  * 1. 메소드명: insertTermsVersion
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관버전 신규 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void insertTermsVersion(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteTermsVersion
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 버전 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void deleteTermsVersion(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectTermsVerDetail
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 버전 상세 팝업 불러오기(rid)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyTermsDetailListResDto selectTermsVerDetail(LoyTermsListReqDto reqDto);

	 /*
	  * 1. 메소드명: modifyTermsVersion
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 버전 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void modifyTermsVersion(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteTermsList
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 삭제 - LOY_TERMS_M, LOY_TERMS_VER, LOY_TEMRS_RCV_CHNL (FLAG = 0 필요시 주석 풀면 됩니다.)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void deleteTermsList(LoyTermsListReqDto reqDto);
//	void deleteTermsVerList(LoyTermsListReqDto reqDto);
//	void deleteTermsRcvList(LoyTermsListReqDto reqDto);
//	void deleteLoyPgmList(LoyTermsListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectTermsContent
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		버전에 따른 약관 내용 보여주기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyTermsDetailListResDto selectTermsContent(LoyTermsListReqDto reqDto);

	 /*
	  * 1. 메소드명: validChekVer
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 버전 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	Integer validChekVer(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: insertRcvChnl
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 수신채널 신규
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void insertTermsRcvChnl(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: updateRcvChnl
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 수신채널 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updateTermsRcvChnl(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectTermsLoyPgmList
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 로열티 프로그램 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyTermsLoyPgmListResDto> selectTermsLoyPgmList(LoyTermsListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectRcvChnlDetail
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 수신 채널 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyTermsDetailListResDto selectRcvChnlDetail(LoyTermsListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectLoyPgmTList
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 로열티 프로그램 리스트 팝업 (TABLE - LOY.LOY_PGM)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyTermsLoyPgmListResDto> selectLoyPgmTList(LoyTermsListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectLoyPgmDetail
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 로열티 프로그램 상세 팝업 데이터 불러오기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyTermsLoyPgmListResDto selectLoyPgmDetail(LoyTermsListReqDto reqDto);

	 /*
	  * 1. 메소드명: insertTermsLoyPgm
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void insertTermsLoyPgm(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: updateTermsLoyPgm
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updateTermsLoyPgm(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectTermsInfoDetail
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 약관 내용 보기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyTermsDetailListResDto selectTermsInfoDetail(LoyTermsListReqDto reqDto);

	 /*
	  * 1. 메소드명: validCheckTermsTypeSub
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		동일 약관 있는지 check 하기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	Integer validCheckTermsTypeSub(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: validLoyaltyPgm
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 상세에서  사용여부 == 'Y' 인상태로 저장할때 로열티 프로그램 등록 확인(무조건 1개 이상 프로그램이 등록 되있어야한다)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyTermsValidChekResDto validLoyaltyPgm(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: vaildCheckRcvChnl
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		수신채널 중복 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	Integer vaildCheckRcvChnl(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: checkTermInfoCnt
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관상세 내용 validCheck
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	Integer checkTermInfoCnt(LoyTermsListReqDto reqDto);

	 /*
	  * 1. 메소드명: validLoyaltyPgmCnt
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 상세 저장시 로열티 프로그램이 Y인것이 등록했는지 여부cnt
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	Integer validLoyaltyPgmCnt(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: validTermsStatCheck
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 상태 (W : 작성중, A : 활성, S : 중지)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyTermsValidChekResDto validTermsStatCheck(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: validTermLoyPgmCnt
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로열티 프로그램 중복체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	Integer validTermLoyPgmCnt(LoyTermsDetailListReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteTermsLoyPgm
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 버전 로열티 프로그램 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void deleteTermsLoyPgm(LoyTermsListReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteTermsRcvChn
	  * 2. 클래스명: LoyTermMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		수신채널 항목 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void deleteTermsRcvChn(LoyTermsListReqDto reqDto);

	List<LoyTermsDetailListReqDto> selectInsertPgmList(LoyTermsDetailListReqDto reqDto);

	void insertNewTermsLoyPgm(LoyTermsDetailListReqDto reqPgm);

	List<LoyTermsListResDto> selectTermsGrp(LoyTermsListReqDto reqDto);

	void insertTermsGrp(LoyTermsListReqDto reqDto);

	List<LoyTermsListResDto> selectTermsGrpTermsPop(LoyTermsListReqDto reqDto);

	LoyTermsListResDto selectAlreadyTermsGrp(LoyTermsListReqDto reqDto);
	
	void updateTermsGrp(LoyTermsListReqDto reqDto);

	void deleteTermsGrp(LoyTermsListReqDto reqDto);
	
	List<LoyTermsListResDto> selectTermsGrpTermsList(LoyTermsListReqDto reqDto);
	
	void insertTermsGrpTerms(LoyTermsListReqDto reqDto);
	
	LoyTermsListResDto selectAlreadyTermsListGrp(LoyTermsListReqDto reqDto);

	LoyTermsListResDto selectAlreadyTermsListGrpTermsName(LoyTermsListReqDto reqDto);
	
	LoyTermsListResDto selectAlreadyTermsGrpTerms(LoyTermsListReqDto reqDto);

	void updateTermsListGrp(LoyTermsListReqDto reqDto);

	void deleteGrpTerms(LoyTermsListReqDto reqDto);

	LoyTermsDetailListResDto selectTermsSeqNoChk(LoyTermsDetailListReqDto reqDto);

	LoyTermsDetailListResDto selectNowSeqNo(LoyTermsDetailListReqDto reqDto);

}
