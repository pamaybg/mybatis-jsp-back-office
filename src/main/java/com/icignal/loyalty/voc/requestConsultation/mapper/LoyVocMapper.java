/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyVocMapper.java
 * 2. Package	: com.icignal.loyalty.voc.requestConsultation.mapper
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 7. 오전 11:09:35
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 7.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.voc.requestConsultation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetActyHistoryListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetActyHistoryMsgReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetRecordFileListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetReplyHistoryListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetRgstCardListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetTransactionListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocModifyRequestConsultationReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocRequestConsultationListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocRequestConsultationReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocSetActyHistoryReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocSetRequestConsultationReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetActyHistoryListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetActyHistoryMsgResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetRecordFileListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetReplyHistoryListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetRgstCardListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetTransactionListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocRequestConsultationExcelListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocRequestConsultationListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocRequestConsultationResDto;

/*
 * 1. 클래스명	: LoyVocMapper
 * 2. 파일명	: LoyVocMapper.java
 * 3. 패키지명	: com.icignal.loyalty.voc.requestConsultation.mapper
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 7.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyVocMapper {

	 /*
	  * 1. 메소드명: selectRequestConsultationListCount
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	Integer selectRequestConsultationListCount(VocRequestConsultationListReqDto bccr);

	 /*
	  * 1. 메소드명: selectRequestConsultationList
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	List<VocRequestConsultationListResDto> selectRequestConsultationList(VocRequestConsultationListReqDto bccr);

	 /*
	  * 1. 메소드명: selectRequestConsultation
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	VocRequestConsultationResDto selectRequestConsultation(VocRequestConsultationReqDto bccr);

	 /*
	  * 1. 메소드명: selectRidMbrByRidCust
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	String selectRidMbrByRidCust(VocRequestConsultationReqDto bccr);

	 /*
	  * 1. 메소드명: selectActyHistoryListCount
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	Integer selectActyHistoryListCount(VocGetActyHistoryListReqDto bccr);

	 /*
	  * 1. 메소드명: selectActyHistoryList
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	List<VocGetActyHistoryListResDto> selectActyHistoryList(VocGetActyHistoryListReqDto bccr);

	 /*
	  * 1. 메소드명: selectTransactionListByRidMbr
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	List<VocGetTransactionListResDto> selectTransactionListByRidMbr(VocGetTransactionListReqDto bccr);

	 /*
	  * 1. 메소드명: insertActyHistory
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void insertActyHistory(VocSetActyHistoryReqDto bccr);

	 /*
	  * 1. 메소드명: updateRequestConsultationComplete
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void updateRequestConsultationComplete(VocModifyRequestConsultationReqDto bccr);

	 /*
	  * 1. 메소드명: updateRequestConsultationTransfer
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void updateRequestConsultationTransfer(VocModifyRequestConsultationReqDto bccr);

	 /*
	  * 1. 메소드명: updateRequestConsultation
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void updateRequestConsultation(VocModifyRequestConsultationReqDto bccr);

	 /*
	  * 1. 메소드명: insertRequestConsultation
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void insertRequestConsultation(VocSetRequestConsultationReqDto bccr);

	 /*
	  * 1. 메소드명: selectRecordFileListForCCA
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	VocGetRecordFileListResDto selectRecordFileListForCCA(VocGetRecordFileListReqDto bccr);

	 /*
	  * 1. 메소드명: updateActyHistory
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void updateActyHistory(VocSetActyHistoryReqDto bccr);

	 /*
	  * 1. 메소드명: selectRgstCardListByRidMbr
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	List<VocGetRgstCardListResDto> selectRgstCardListByRidMbr(VocGetRgstCardListReqDto bccr);

	 /*
	  * 1. 메소드명: selectActyHistoryMsg
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	VocGetActyHistoryMsgResDto selectActyHistoryMsg(VocGetActyHistoryMsgReqDto bccr);

	 /*
	  * 1. 메소드명: clearMaskDrop
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	VocRequestConsultationResDto clearMaskDrop(VocRequestConsultationReqDto bccr);

	 /*
	  * 1. 메소드명: selectConsultMaskList
	  * 2. 클래스명: LoyVocMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	List<VocRequestConsultationExcelListResDto> selectConsultMaskList(VocRequestConsultationListReqDto bccr);


	 /*
	  * 1. 메소드명: selectUpdateCrmUser
	  * 2. 클래스명: LoyVocMapper
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
	 *   @param bccr
	 *   @return	
	 */
	
	String selectUpdateCrmUser(VocModifyRequestConsultationReqDto bccr);

	 /*
	  * 1. 메소드명: selectCrmUser
	  * 2. 클래스명: LoyVocMapper
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
	 *   @param bccr
	 *   @return	
	 */
	
	String selectCrmUser(VocModifyRequestConsultationReqDto bccr);

	 /*
	  * 1. 메소드명: insertRequestConsultationCompleActyHist
	  * 2. 클래스명: LoyVocMapper
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
	 */
	
	void insertRequestConsultationActyHist(VocSetActyHistoryReqDto reqDto);

	 /*
	  * 1. 메소드명: insertRequestConsultationCompleActyHist
	  * 2. 클래스명: LoyVocMapper
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
	 */
	
	void insertRequestConsultationCompleActyHist(VocSetActyHistoryReqDto reqDto);

	 /*
	  * 1. 메소드명: insertRequestConsultationHist
	  * 2. 클래스명: LoyVocMapper
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
	 *   @param vocReqDto	
	 */
	
	void insertRequestConsultationHist(VocSetActyHistoryReqDto vocReqDto);

	 /*
	  * 1. 메소드명: selectRcpMethNm
	  * 2. 클래스명: LoyVocMapper
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
	 *   @param bccr
	 *   @return	
	 */
	
	String selectRcpMethNm(VocSetRequestConsultationReqDto bccr);

	List<VocGetReplyHistoryListResDto> selectReplyHistoryList(VocGetReplyHistoryListReqDto bccr);





}
