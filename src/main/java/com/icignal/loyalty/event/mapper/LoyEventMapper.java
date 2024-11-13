/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyEventMapper.java
 * 2. Package	: com.icignal.loyalty.event.mapper
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 22. 오전 9:23:23
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 22.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.event.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.event.dto.request.LOYProdRequestDTO;
import com.icignal.loyalty.event.dto.request.LoyAddPromReqDto;
import com.icignal.loyalty.event.dto.request.LoyAddTierReqDto;
import com.icignal.loyalty.event.dto.request.LoyApplctRdmReqDto;
import com.icignal.loyalty.event.dto.request.LoyEventPlanExcutionReqDto;
import com.icignal.loyalty.event.dto.request.LoyEventPreviewTokenReqDto;
import com.icignal.loyalty.event.dto.request.LoyEvtApplctReqDto;
import com.icignal.loyalty.event.dto.request.LoyLimitMbrReqDto;
import com.icignal.loyalty.event.dto.request.LoyMbrMsgReqDto;
import com.icignal.loyalty.event.dto.request.LoyProdEntryReqDto;
import com.icignal.loyalty.event.dto.request.LoyStoreListReqDto;
import com.icignal.loyalty.event.dto.request.LoyUGCAchReqDto;
import com.icignal.loyalty.event.dto.request.LoyUGCListReqDto;
import com.icignal.loyalty.event.dto.response.LoyAddPromResDto;
import com.icignal.loyalty.event.dto.response.LoyApplctRdmResDto;
import com.icignal.loyalty.event.dto.response.LoyEventPlanExcutionDetailResDto;
import com.icignal.loyalty.event.dto.response.LoyEventPlanExcutionResDto;
import com.icignal.loyalty.event.dto.response.LoyEventPreviewTokenResDto;
import com.icignal.loyalty.event.dto.response.LoyEventProdEnrtyExcelResDto;
import com.icignal.loyalty.event.dto.response.LoyEventProdEntryResDto;
import com.icignal.loyalty.event.dto.response.LoyEventWinningCondResDto;
import com.icignal.loyalty.event.dto.response.LoyEvtApplctExcelResDto;
import com.icignal.loyalty.event.dto.response.LoyEvtApplctResDto;
import com.icignal.loyalty.event.dto.response.LoyEvtWinnerResDto;
import com.icignal.loyalty.event.dto.response.LoyLimitMbrResDto;
import com.icignal.loyalty.event.dto.response.LoyProdEntryResDto;
import com.icignal.loyalty.event.dto.response.LoyStoreListResDto;
import com.icignal.loyalty.event.dto.response.LoyTierLimitListResDto;
import com.icignal.loyalty.event.dto.response.LoyUGCAchResDto;
import com.icignal.loyalty.event.dto.response.LoyUGCListResDto;

/*
 * 1. 클래스명	: LoyEventMapper
 * 2. 파일명	: LoyEventMapper.java
 * 3. 패키지명	: com.icignal.loyalty.event.mapper
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyEventMapper {

	 /*
	  * 1. 메소드명: cancelWinner
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void cancelWinner(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: eventWinnerReset
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void eventWinnerReset(LoyEvtApplctReqDto reqDto);
	
	 /*
	  * 1. 메소드명: eventApplicantReset
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: jb.kim 
	  * 4. 작성일자: 2021. 03. 18.
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
	
	void eventApplicantReset(LoyEvtApplctReqDto reqDto);
	
	 /*
	  * 1. 메소드명: benefitPayment
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: [이벤트 > 응모/참여형 > 참여자 탭] 참여자 목록 초기화
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	
	void benefitPayment(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: cancleBenefitPayment
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void cancleBenefitPayment(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: selectProdEntryList
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	List<LoyProdEntryResDto> selectProdEntryList(LoyProdEntryReqDto reqDto);

	 /*
	  * 1. 메소드명: updateSendSuccess
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void updateSendSuccess(LoyProdEntryReqDto reqDto);

	 /*
	  * 1. 메소드명: updateSendCancel
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void updateSendCancel(LoyProdEntryReqDto reqDto);

	 /*
	  * 1. 메소드명: selectOverLapProdEntry
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	int selectOverLapProdEntry(LoyProdEntryReqDto reqDto);

	 /*
	  * 1. 메소드명: evtAppliClearMask
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	LoyEvtApplctResDto evtAppliClearMask(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: getWinnerExcelDownList
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	List<LoyEventProdEnrtyExcelResDto> getWinnerExcelDownList(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: evtWinnerClearMask
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	LoyEvtWinnerResDto evtWinnerClearMask(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: evtProdEntryClearMask
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	LoyProdEntryResDto evtProdEntryClearMask(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: getEvtApplicantDown
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	List<LoyEvtApplctExcelResDto> getEvtApplicantDown(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: insertEvtPreviewToken
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void insertEvtPreviewToken(LoyEventPreviewTokenReqDto reqDto);

	 /*
	  * 1. 메소드명: selectEvtPreviewToken
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	LoyEventPreviewTokenResDto selectEvtPreviewToken(LoyEventPreviewTokenReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteEvtPreviewToken
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void deleteEvtPreviewToken(LoyEventPreviewTokenReqDto reqDto);

	 /*
	  * 1. 메소드명: updateEventWinCmplt
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void updateEventWinCmplt(LoyEventPlanExcutionReqDto reqDto);

	 /*
	  * 1. 메소드명: getProdEntryExcelDownList
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	List<LoyProdEntryResDto> getProdEntryExcelDownList(LoyProdEntryReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrStoreList
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	List<LoyStoreListResDto> selectMbrStoreList(LoyStoreListReqDto reqDto);

	 /*
	  * 1. 메소드명: clearMaskingStore
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	LoyStoreListResDto clearMaskingStore(LoyStoreListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectEventPlanExcutionList
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	List<LoyEventPlanExcutionResDto> selectEventPlanExcutionList(LoyEventPlanExcutionReqDto reqDto);

	 /*
	  * 1. 메소드명: getPromotionPopUpList
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	List<LoyEventPlanExcutionResDto> getPromotionPopUpList(LoyEventPlanExcutionReqDto reqDto);

	 /*
	  * 1. 메소드명: insertSaveEventPlane
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void insertSaveEventPlane(LoyEventPlanExcutionReqDto reqDto);


	 /*
	  * 1. 메소드명: updateEventPlane
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void updateEventPlane(LoyEventPlanExcutionReqDto reqDto);

	 /*
	  * 1. 메소드명: validEventPlan
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	LoyEventPlanExcutionDetailResDto validEventPlan(LoyEventPlanExcutionReqDto param);

	 /*
	  * 1. 메소드명: deleteEventPlan
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void deleteEventPlan(LoyEventPlanExcutionReqDto param);

	 /*
	  * 1. 메소드명: deleteEvtApplct
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void deleteEvtApplct(LoyEventPlanExcutionReqDto param);

	 /*
	  * 1. 메소드명: deleteEvtProdEntry
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void deleteEvtProdEntry(LoyEventPlanExcutionReqDto param);

	 /*
	  * 1. 메소드명: deleteEvtWinner
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void deleteEvtWinner(LoyEventPlanExcutionReqDto param);

	 /*
	  * 1. 메소드명: deleteLimitMbr
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void deleteLimitMbr(LoyEventPlanExcutionReqDto param);

	 /*
	  * 1. 메소드명: deletePromotion
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void deletePromotion(LoyEventPlanExcutionReqDto param);

	 /*
	  * 1. 메소드명: updateStartEventPlan
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void updateStartEventPlan(LoyEventPlanExcutionReqDto param);

	 /*
	  * 1. 메소드명: updateFinishEventPlan
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void updateFinishEventPlan(LoyEventPlanExcutionReqDto param);

	 /*
	  * 1. 메소드명: updateStopEventPlan
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void updateStopEventPlan(LoyEventPlanExcutionReqDto param);

	 /*
	  * 1. 메소드명: evtApplctList
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	List<LoyEvtApplctResDto> evtApplctList(LoyEvtApplctReqDto param);
	
	
	 /*
	  * 1. 메소드명: prodEntryList
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	

	/*
	  * 1. 메소드명: selectEventWinCompleteYn
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: jb.kim 
	  * 4. 작성일자: 2021. 03. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 : 해당 이벤트의 '당첨완료'여부를 체크 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyEvtApplctResDto selectEventWinCompleteYn(LoyEvtApplctReqDto reqDto);
	
	
	List<LoyEventProdEntryResDto> prodEntryList(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: insertTransferWinner
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void insertTransferWinner(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: validWinnerTransfer
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	Integer validWinnerTransfer(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: cancelVote
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void cancelVote(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: insertEvtWinner
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void insertEvtWinner(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: SelectAddPromList
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	List<LoyAddPromResDto> SelectAddPromList(LoyAddPromReqDto reqDto);

	 /*
	  * 1. 메소드명: insertAddPromSave
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void insertAddPromSave(LoyAddPromReqDto param);

	 /*
	  * 1. 메소드명: deleteProm
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void deleteProm(LoyAddPromReqDto param);

	 /*
	  * 1. 메소드명: InsertLimitMbr
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void InsertLimitMbr(LoyLimitMbrReqDto param);

	 /*
	  * 1. 메소드명: validLimitMbr
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	Integer validLimitMbr(LoyLimitMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: SelectLimitMbrList
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	List<LoyLimitMbrResDto> SelectLimitMbrList(LoyLimitMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: LimitMbrClearMask
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	LoyLimitMbrResDto LimitMbrClearMask(LoyLimitMbrReqDto reqDto);

	 /*
	  * 1. 메소드명: CancelLimitMbr
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void CancelLimitMbr(LoyLimitMbrReqDto param);

	 /*
	  * 1. 메소드명: selectWinningCond
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	LoyEventWinningCondResDto selectWinningCond(LoyEventPlanExcutionReqDto reqDto);

	 /*
	  * 1. 메소드명: updateEventEmg
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void updateEventEmg(LoyEventPlanExcutionReqDto reqDto);

	 /*
	  * 1. 메소드명: getUGCList
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	List<LoyUGCListResDto> getUGCList(LoyUGCListReqDto reqDto);

	 /*
	  * 1. 메소드명: getUGCAch
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	LoyUGCAchResDto getUGCAch(LoyUGCAchReqDto reqDto);

	 /*
	  * 1. 메소드명: ugcMbrclearMasking
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	LoyUGCListResDto ugcMbrclearMasking(LoyUGCListReqDto reqDto);

	 /*
	  * 1. 메소드명: ugcListExport
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	List<LoyUGCListResDto> ugcListExport(LoyUGCListReqDto reqDto);

	 /*
	  * 1. 메소드명: validLimitProm
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	Integer validLimitProm(LoyAddPromReqDto reqDto);

	 /*
	  * 1. 메소드명: selectAddProm
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	LoyAddPromResDto selectAddProm(String reqDto);

	 /*
	  * 1. 메소드명: updatePromSave
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	void updatePromSave(LoyAddPromReqDto reqDto);

	 /*
	  * 1. 메소드명: selectAddPromCondVal
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	LoyAddPromResDto selectAddPromCondVal(LoyAddPromReqDto reqDto);

	 /*
	  * 1. 메소드명: selectApplicantCnt
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	LoyApplctRdmResDto selectApplicantCnt(LoyApplctRdmReqDto reqDto);

	 /*
	  * 1. 메소드명: getRdmWinner
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void getRdmWinner(LoyApplctRdmReqDto param);

	 /*
	  * 1. 메소드명: validCheckWinnerTrans
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	Integer validCheckWinnerTrans(LoyApplctRdmReqDto param);

	 /*
	  * 1. 메소드명: getInsertLimitMbr
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	LoyLimitMbrResDto getInsertLimitMbr(LoyMbrMsgReqDto param);

	 /*
	  * 1. 메소드명: InsertMbrMsg
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void InsertMbrMsg(LoyMbrMsgReqDto param);

	 /*
	  * 1. 메소드명: selectEventPlanDetail
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 22.
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
	
	LoyEventPlanExcutionDetailResDto selectEventPlanDetail(LoyEventPlanExcutionReqDto reqDto);

	 /*
	  * 1. 메소드명: selectTierLimitList
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 27.
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
	
	List<LoyTierLimitListResDto> selectTierLimitList(LoyUGCListReqDto reqDto);

	 /*
	  * 1. 메소드명: InsertLimitMbr
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 10. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void InsertLimitMbr(LoyMbrMsgReqDto param);

	 /*
	  * 1. 메소드명: insertEvtApplict
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 10. 5.
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
	
	void insertEvtApplict(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: insertTierLimit
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 10. 7.
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
	
	void insertTierLimit(LoyAddTierReqDto reqDto);

	Integer dupCheckProd(LOYProdRequestDTO reqDto);

	
	/*
	  * 1. 메소드명: isThereWinnerInApplicant
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: jb.kim 
	  * 4. 작성일자: 2021. 03. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 : 해당 이벤트의 참여자들 중, 당첨자가 현재 있는지 체크 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyEvtApplctResDto> isThereWinnerInApplicant(LoyEvtApplctReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrDetail
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param lear
	 *   @return	
	 */
	
	LoyEvtApplctResDto selectMbrDetail(LoyEvtApplctReqDto lear);

	 /*
	  * 1. 메소드명: selectMbrNoDetail
	  * 2. 클래스명: LoyEventMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param lear
	 *   @return	
	 */
	
	LoyEvtApplctResDto selectMbrNoDetail(LoyEvtApplctReqDto lear);
	




}
