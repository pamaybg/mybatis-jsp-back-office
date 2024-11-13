/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyBlackTxnRuleMapper.java
 * 2. Package	: com.icignal.loyalty.blackTxnRule.mapper
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 4. 오후 4:49:58
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 4.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.blackTxnRule.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.blackTxnRule.dto.request.LoyBalckMbrDetailReqDto;
import com.icignal.loyalty.blackTxnRule.dto.request.LoyBalckTxnRuleDetailReqDto;
import com.icignal.loyalty.blackTxnRule.dto.request.LoyBalckTxnRuleListReqDto;
import com.icignal.loyalty.blackTxnRule.dto.request.LoyBlackRuleDetailReqDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBalckMbrDetailResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackMbrListResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackRuleDetailResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackRuleListResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackTxnRuleDetailResDto;
import com.icignal.loyalty.blackTxnRule.dto.response.LoyBlackTxnRuleListResDto;

/*
 * 1. 클래스명	: LoyBlackTxnRuleMapper
 * 2. 파일명	: LoyBlackTxnRuleMapper.java
 * 3. 패키지명	: com.icignal.loyalty.blackTxnRule.mapper
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyBlackTxnRuleMapper {

	 /*
	  * 1. 메소드명: selectBlackRuleList
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 4.
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
	
	List<LoyBlackTxnRuleListResDto> selectBlackRuleList(LoyBalckTxnRuleListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectBlackRuleDetail
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 4.
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
	
	LoyBlackTxnRuleDetailResDto selectBlackRuleMstDetail(LoyBalckTxnRuleListReqDto reqDto);

	 /*
	  * 1. 메소드명: insertBlackRuleDetail
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 4.
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
	
	void insertBlackRuleDetail(LoyBalckTxnRuleDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateBlackRuleDetail
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 4.
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
	
	void updateBlackRuleDetail(LoyBalckTxnRuleDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectBlackRuleListTab
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 5.
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
	
	List<LoyBlackRuleListResDto> selectBlackRuleListTab(LoyBalckTxnRuleDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteeBlackRule
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 5.
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
	
	void deleteBlackRule(LoyBalckTxnRuleDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteBlackMst
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 5.
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
	
	void deleteBlackMst(LoyBalckTxnRuleDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectBlackRuleDetail
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 5.
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
	
	LoyBlackRuleDetailResDto selectBlackRuleDetail(LoyBalckTxnRuleDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: insertBlackRule
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 5.
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
	
	void insertBlackRule(LoyBlackRuleDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateBlackRule
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 5.
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
	
	void updateBlackRule(LoyBlackRuleDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectBlackMbrListTab
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 5.
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
	
	List<LoyBlackMbrListResDto> selectBlackMbrListTab(LoyBalckTxnRuleDetailReqDto reqDto);


	 /*
	  * 1. 메소드명: selectBaseTypeNm
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	String selectBaseTypeNm(LoyBlackRuleDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: insertBlackMbr
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	void insertBlackMbr(LoyBalckMbrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrCnt
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	Integer selectMbrCnt(LoyBalckMbrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateBlackMbr
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	void updateBlackMbr(LoyBalckMbrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectBlackMbrDetail
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	LoyBalckMbrDetailResDto selectBlackMbrDetail(LoyBalckTxnRuleDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateStatCdConf
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	void updateStatCdConf(LoyBalckMbrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateStatCdCanl
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	void updateStatCdCanl(LoyBalckMbrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateStatCd
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	void updateStatCd(LoyBalckMbrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectClearMaskBlackMbr
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	LoyBlackMbrListResDto selectClearMaskBlackMbr(LoyBalckTxnRuleDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteBlackMbr
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	void deleteBlackMbr(LoyBalckTxnRuleDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectBasTypeCheck
	  * 2. 클래스명: LoyBlackTxnRuleMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 6.
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
	
	Integer selectBasTypeCheck(LoyBlackRuleDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectBaseDayNm
	  * 2. 클래스명: LoyBlackTxnRuleMapper
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
	
	String selectBaseDayNm(LoyBlackRuleDetailReqDto reqDto);

}
