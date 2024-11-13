/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCustomerMapper.java
 * 2. Package	: com.icignal.loyalty.customer.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 24. 오후 6:54:56
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 24.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.customer.dto.request.LOYCustAddInfoReqDto;
import com.icignal.loyalty.customer.dto.request.LOYCustReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustAgreHistListReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustBnftReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustBranchReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustDetailMbrReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustMbrRelReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustNewReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustSettleReqDto;
import com.icignal.loyalty.customer.dto.response.LOYCustAddInfoResDto;
import com.icignal.loyalty.customer.dto.response.LOYCustResDto;
import com.icignal.loyalty.customer.dto.response.LOYMemberResDto;
import com.icignal.loyalty.customer.dto.response.LoyCafe24MbrDtlResDto;
import com.icignal.loyalty.customer.dto.response.LoyCafe24MbrResDto;
import com.icignal.loyalty.customer.dto.response.LoyCertCustResDto;
import com.icignal.loyalty.customer.dto.response.LoyCorpDetailResDto;
import com.icignal.loyalty.customer.dto.response.LoyCorporationCustResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustAgreHistListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustAgreListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustAlterHistResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustAppHistListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustBnftResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustBranchResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustChangeHistListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustDetailMbrListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustDetailNewResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustDetailResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustLoginInfoListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustLoginListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustMbrRelResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustNewResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustSettleResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustSvrHistListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustWebHistListResDto;
import com.icignal.loyalty.membership.dto.response.LoyMbrSegmentHistListResDto;

/*
 * 1. 클래스명	: LoyCustomerMapper
 * 2. 파일명	: LoyCustomerMapper.java
 * 3. 패키지명	: com.icignal.loyalty.customer.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 24.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyCustomerMapper {

	 /*
	  * 1. 메소드명: selectCustList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
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
	
	//List<LOYCustResDto> selectCustList(LOYCustReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCust
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
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
	
	LoyCustDetailResDto selectCust(LOYCustReqDto reqDto);

	 /*
	  * 1. 메소드명: updateCust
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
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
	
	void updateCust(LOYCustReqDto reqDto);

	 /*
	  * 1. 메소드명: insertCust
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 *///676
	
	void insertCust(LOYCustReqDto reqDto);

	 /*
	  * 1. 메소드명: duplCust
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
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
	
	Integer duplCust(LOYCustReqDto reqDto);

	 /*
	  * 1. 메소드명: updateCustDel
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
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
	
	void updateCustDel(LOYCustReqDto reqDto);

	 /*
	  * 1. 메소드명: clearMaskCust
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
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
	
	LOYCustResDto clearMaskCust(LOYCustReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustAddInfoList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
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
	
	List<LOYCustAddInfoResDto> selectCustAddInfoList(LOYCustReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMemberList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
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
	
	List<LOYMemberResDto> selectMemberList(LOYCustReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustAddInfo
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
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
	
	LOYCustAddInfoResDto selectCustAddInfo(LOYCustAddInfoReqDto reqDto);

	 /*
	  * 1. 메소드명: insertCustAddInfo
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
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
	
	void insertCustAddInfo(LOYCustAddInfoReqDto reqDto);

	 /*
	  * 1. 메소드명: updateCustAddInfo
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
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
	
	void updateCustAddInfo(LOYCustAddInfoReqDto reqDto);

	 /*
	  * 1. 메소드명: updateCustAddInfoDel
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
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
	
	void updateCustAddInfoDel(LOYCustAddInfoReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustListPage
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 23.
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
	
	List<LoyCustNewResDto> selectCustListPage(LoyCustNewReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustDetailNewPage
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 24.
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
	
	LoyCustDetailNewResDto selectCustDetailNewPage(LoyCustNewReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCorpCustListPage
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 27.
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
	
	List<LoyCorporationCustResDto> selectCorpCustListPage(LoyCustNewReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCorpCustDetailNewPage
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 27.
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
	
	LoyCorpDetailResDto selectCorpCustDetailNewPage(LoyCustNewReqDto reqDto);

	 /*
	  * 1. 메소드명: clearMaskCustList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 27.
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
	
	LoyCustNewResDto clearMaskCustList(LoyCustNewReqDto reqDto);

	 /*
	  * 1. 메소드명: clearMaskCorpCustList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 27.
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
	
	LoyCorporationCustResDto clearMaskCorpCustList(LoyCustNewReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCertList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 28.
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
	
	List<LoyCertCustResDto> selectCertList(LoyCustNewReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustLoginList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 28.
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
	
	List<LoyCustLoginListResDto> selectCustLoginList(LoyCustNewReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustRid
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 28.
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
	
	String selectCustRid(LoyCustNewReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustAgreList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 29.
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
	
	List<LoyCustAgreListResDto> selectCustAgreList(LoyCustNewReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustAgreHistList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
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
	 *   @return	
	 */
	
	List<LoyCustAgreHistListResDto> selectCustAgreHistList(LoyCustAgreHistListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustSvrHistList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 10.
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
	
	List<LoyCustSvrHistListResDto> selectCustSvrHistList(LoyCustNewReqDto reqDto);

	 /*
	  * 1. 메소드명: selectAlterSvrHistList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 11.
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
	
	List<LoyCustAlterHistResDto> selectAlterSvrHistList(LoyCustNewReqDto reqDto);

	 /*
	  * 1. 메소드명: selectAppSvrHistList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 11.
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
	
	List<LoyCustAppHistListResDto> selectAppSvrHistList(LoyCustNewReqDto reqDto);

	 /*
	  * 1. 메소드명: selectChangeHistList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 11.
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
	
	List<LoyCustChangeHistListResDto> selectChangeHistList(LoyCustNewReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustDetailMbrList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 상세 회원 리스트 탭
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyCustDetailMbrListResDto> selectCustDetailMbrList(LoyCustDetailMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustLoginInfo
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 13.
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
	
	List<LoyCustLoginInfoListResDto> selectCustLoginInfo(LoyCustDetailMbrReqDto reqDto);

	/*
	 * 1. 메소드명: selectCustMbrRelList
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 2.
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

	List<LoyCustMbrRelResDto> selectCustMbrRelList(LoyCustMbrRelReqDto reqDto);

	/*
	 * 1. 메소드명: selectCustBranchList
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 브랜치 리스트 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	List<LoyCustBranchResDto> selectCustBranchList(LoyCustBranchReqDto reqDto);

	/*
	 * 1. 메소드명: selectCustBranchDetail
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 브랜치 단건 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	LoyCustBranchResDto selectCustBranchDetail(LoyCustBranchReqDto reqDto);

	/*
	 * 1. 메소드명: updateCustBranch
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 브랜치 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateCustBranch(LoyCustBranchReqDto reqDto);

	/*
	 * 1. 메소드명: insertCustBranch
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 브랜치 입력
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void insertCustBranch(LoyCustBranchReqDto reqDto);

	/*
	 * 1. 메소드명: updateCustBranchDel
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 브랜치 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateCustBranchDel(LoyCustBranchReqDto reqDto);

	/*
	 * 1. 메소드명: selectCustSettleDetail
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 정산 단건 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	LoyCustSettleResDto selectCustSettleDetail(LoyCustSettleReqDto reqDto);

	/*
	 * 1. 메소드명: updateCustSettle
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 정산 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateCustSettle(LoyCustSettleReqDto reqDto);

	/*
	 * 1. 메소드명: insertCustSettle
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 정산 입력
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void insertCustSettle(LoyCustSettleReqDto reqDto);

	/*
	 * 1. 메소드명: updateCustSettleDel
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 정산 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateCustSettleDel(LoyCustSettleReqDto reqDto);


	/*
	 * 1. 메소드명: selectCustBnftList
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 혜택 리스트 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	List<LoyCustBnftResDto> selectCustBnftList(LoyCustBnftReqDto reqDto);

	/*
	 * 1. 메소드명: selectCustBnftDetail
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 혜택 단건 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	LoyCustBnftResDto selectCustBnftDetail(LoyCustBnftReqDto reqDto);

	/*
	 * 1. 메소드명: updateCustBnft
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 혜택 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateCustBnft(LoyCustBnftReqDto reqDto);

	/*
	 * 1. 메소드명: insertCustBnft
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 혜택 입력
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void insertCustBnft(LoyCustBnftReqDto reqDto);

	/*
	 * 1. 메소드명: updateCustBnftDel
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 혜택 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 */
	void updateCustBnftDel(LoyCustBnftReqDto reqDto);

	List<LoyMbrSegmentHistListResDto> selectCustSegmentRuleHist(LOYCustReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustWebHistList
	  * 2. 클래스명: LoyCustomerMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 상세 - 서비스 이용내역 - 웹이용내역 상세이력 리스트 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyCustWebHistListResDto> selectCustWebHistList(LoyCustNewReqDto reqDto);

	/*
	 * 1. 메소드명: getCafe24MemList
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 11. 20
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param 
	 * @return
	 */
	List<LoyCafe24MbrResDto> selectCafe24MemList(LoyCustNewReqDto reqDto);

	/*
	 * 1. 메소드명: selectCafe24MbrCamHist
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 11. 26
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 캠페인 이력 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param 
	 * @return
	 */
	List<LoyCafe24MbrResDto> selectCafe24MbrCamHist(LoyCustNewReqDto reqDto);
	
	/*
	 * 1. 메소드명: selectCafe24MemDetail
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 11. 26
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param 
	 * @return
	 */
	LoyCafe24MbrDtlResDto selectCafe24MemDetail(LoyCustNewReqDto reqDto);

	
	/*
	 * 1. 메소드명: clearMaskCf24MbrList
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 12. 09
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 마스킹해제
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param 
	 * @return
	 */
	LoyCafe24MbrResDto selectClearMaskCf24(LoyCustNewReqDto reqDto);

	
	/*
	 * 1. 메소드명: selectCafe24MemListExcel
	 * 2. 클래스명: LoyCustomerMapper
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 12. 10
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 마스킹해제
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param request
	 * @param response
	 * @param 
	 * @return
	 */
	List<LoyCafe24MbrDtlResDto> selectCafe24MemListExcel(LoyCustNewReqDto reqDto);
	 /*
	  * 1. 메소드명: selectMobileCustLoginInfo
	  * 2. 클래스명: LoyCustomerMapper
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
	
	List<LoyCustLoginInfoListResDto> selectMobileCustLoginInfo(LoyCustDetailMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: getMbrMobileLoginPopGrid
	  * 2. 클래스명: LoyCustomerMapper
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
	
	List<LoyCustLoginInfoListResDto> selectMbrMobileLoginPopGrid(LoyCustDetailMbrReqDto reqDto);

	List<LoyCustLoginInfoListResDto> updateLoginFailCnt(LoyCustDetailMbrReqDto reqDto);
}
