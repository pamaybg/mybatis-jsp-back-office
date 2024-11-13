package com.icignal.loyalty.family.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.family.dto.request.LoyFamilyListReqDto;
import com.icignal.loyalty.family.dto.response.LoyFamilyListResDto;

/*
 * 1. 클래스명	: LoyFamilyMapper
 * 2. 파일명	: LoyFamilyMapper.java
 * 3. 패키지명	: com.icignal.loyalty.famaily.mapper
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 6. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *		패밀리 Mapper
 * </PRE>
 */ 
@Mapper
public interface LoyFamilyMapper {

	 /*
	  * 1. 메소드명: selectFamilyList
	  * 2. 클래스명: LoyFamilyMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyFamilyListResDto> selectFamilyList(LoyFamilyListReqDto reqDto);

	 /*
	  * 1. 메소드명: clearMaskListMbr
	  * 2. 클래스명: LoyFamilyMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 회원 마스킹해제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyFamilyListResDto clearMaskFamilyList(LoyFamilyListReqDto reqDto);

	 /*
	  * 1. 메소드명: updateApprProcess
	  * 2. 클래스명: LoyFamilyMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패일리 승인처리
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updateApprProcess(LoyFamilyListReqDto reqDto);
	
	 /*
	  * 1. 메소드명: updateCanlProcess
	  * 2. 클래스명: LoyFamilyMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 해지처리
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updateCanlProcess(LoyFamilyListReqDto reqDto);
	void updateMbrCanlProcess(LoyFamilyListReqDto reqDto);
	//이력남기기
	void insertFmlyMbrHist(LoyFamilyListReqDto reqDto);

	 /*
	  * 1. 메소드명: saveNewFmly
	  * 2. 클래스명: LoyFamilyMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 신규가입
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void saveNewFmly(LoyFamilyListReqDto reqDto);

	void addFmly(Map<String, Object> map);

	

}
