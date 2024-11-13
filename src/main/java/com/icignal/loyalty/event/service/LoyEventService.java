/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: loyEventMapper.java
 * 2. Package	: com.icignal.loyalty.event.service
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 18. 오후 3:10:45
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 18.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.event.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.AddBatchService;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.event.dto.request.LOYProdRequestDTO;
import com.icignal.loyalty.event.dto.request.LoyAddPromReqDto;
import com.icignal.loyalty.event.dto.request.LoyAddTierReqDto;
import com.icignal.loyalty.event.dto.request.LoyApplctRdmReqDto;
import com.icignal.loyalty.event.dto.request.LoyEventPlanExcutionReqDto;
import com.icignal.loyalty.event.dto.request.LoyEventPreviewTokenReqDto;
import com.icignal.loyalty.event.dto.request.LoyEvtApplctReqDto;
import com.icignal.loyalty.event.dto.request.LoyLimitMbrReqDto;
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
import com.icignal.loyalty.event.mapper.LoyEventMapper;


/*
 * 1. 클래스명	: loyEventMapper
 * 2. 파일명	: loyEventMapper.java
 * 3. 패키지명	: com.icignal.loyalty.event.service
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 18.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyEventService {
	
	@Autowired
	private LoyEventMapper loyEventMapper;
	
	@Autowired
    private AddBatchService addBatchService;
	
	@Autowired
	private LoggingHelper loggingHelper;
	
	@Autowired
	private CommonService commonService;
	/**
	* @programId :
	* @name : getEventPlanExcutionList
	* @date : 2019. 6. 19.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public GridPagingResDto<LoyEventPlanExcutionResDto> getEventPlanExcutionList(LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyEventPlanExcutionResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyEventMapper.selectEventPlanExcutionList(reqDto),AnnotationType.ALL);
	}
	
	
	/**
	* @programId :
	* @name : getPromotionPopUpList
	* @date : 2019. 6. 19.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public GridPagingResDto<LoyEventPlanExcutionResDto> getPromotionPopUpList(LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyEventPlanExcutionResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyEventMapper.getPromotionPopUpList(reqDto),AnnotationType.ALL);
	}


	/**
	* @programId :
	* @name : saveEventPlane
	* @date : 2019. 6. 25.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto saveEventPlane(LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		if("SNS".equals(reqDto.getEventType())) {
			/*reqDto.setEventDate("");
			reqDto.setEventTime("");
			reqDto.setEventWiningDate("");
			reqDto.setEventPlace("");*/
			if(reqDto.getThumImg()!=null) {
				commonService.deleteUploadS3(reqDto.getThumImg().replace("https://dev-img.glolive.co.kr/",""));
				reqDto.setThumImg("");
			}
			if(reqDto.getDetailImg1()!=null) {
				commonService.deleteUploadS3(reqDto.getDetailImg1().replace("https://dev-img.glolive.co.kr/",""));
				reqDto.setDetailImg1("");
			}
			if(reqDto.getDetailImg2()!=null) {
				commonService.deleteUploadS3(reqDto.getDetailImg2().replace("https://dev-img.glolive.co.kr/",""));
				reqDto.setDetailImg2("");
			}
			if(reqDto.getDetailImg3()!=null) {
				commonService.deleteUploadS3(reqDto.getDetailImg3().replace("https://dev-img.glolive.co.kr/",""));
				reqDto.setDetailImg3("");
			}
			/*reqDto.setAddrRegYn("");
			reqDto.setOneMaxCnt("");
			reqDto.setDevRegYn("");
			reqDto.setTierLimitYn("");*/
		}/*else if("ONLINE".equals(reqDto.getEventType())) {
			reqDto.setDownURL("");
			reqDto.setDownFile("");
			reqDto.setDownFileNm("");
			reqDto.setAddrRegYn("");
			reqDto.setOneMaxCnt("");
			reqDto.setDevRegYn("");
			reqDto.setTierLimitYn("");
		}else if("OFFLINE".equals(reqDto.getEventType())) {
			reqDto.setDownURL("");
			reqDto.setDownFile("");
			reqDto.setDownFileNm("");
			reqDto.setAddrRegYn("");
			reqDto.setOneMaxCnt("");
			reqDto.setDevRegYn("");
			reqDto.setTierLimitYn("");
		}else if("ONAIR".equals(reqDto.getEventType())) {
			reqDto.setEventDate("");
			reqDto.setEventTime("");
			reqDto.setEventWiningDate("");
			reqDto.setEventPlace("");
			if(reqDto.getThumImg()!=null) {
				commonService.deleteUploadS3(reqDto.getThumImg().replace("https://dev-img.glolive.co.kr/",""));
				reqDto.setThumImg("");
			}
			if(reqDto.getDetailImg2()!=null) {
				commonService.deleteUploadS3(reqDto.getDetailImg2().replace("https://dev-img.glolive.co.kr/",""));
				reqDto.setDetailImg2("");
			}
			if(reqDto.getDetailImg3()!=null) {
				commonService.deleteUploadS3(reqDto.getDetailImg3().replace("https://dev-img.glolive.co.kr/",""));
				reqDto.setDetailImg3("");
			}
			reqDto.setAddrRegYn("");
			reqDto.setDevRegYn("");
			reqDto.setTierLimitYn("");
			reqDto.setOneMaxCnt("1");
			reqDto.setMaxVoteCnt("1");
		}
		
		if("file".equals(reqDto.getRadioCheck())) {
			reqDto.setDownURL("");
		}else if("url".equals(reqDto.getRadioCheck())) {
			reqDto.setDownFile("");
			reqDto.setDownFileNm("");
		}*/
		
		StatusResDto rtnValue = new StatusResDto();

		reqDto.setRid(CommonUtil.newRid());
		loyEventMapper.insertSaveEventPlane(reqDto);
		
		rtnValue.setSuccess(true);
        rtnValue.setMessage(reqDto.getRid());
        
        return rtnValue;
	}


	/**
	* @programId :
	* @name : eventPlanDetail
	* @date : 2019. 6. 25.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public LoyEventPlanExcutionDetailResDto eventPlanDetail(LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		LoyEventPlanExcutionDetailResDto res = loyEventMapper.selectEventPlanDetail(reqDto);
	    return new AnnotationHelper<LoyEventPlanExcutionDetailResDto>(AnnotationType.ALL, res).getItem();
	}


	public StatusResDto updateEventPlane(LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		StatusResDto rtnValue = new StatusResDto();
		
		/*if("SNS".equals(reqDto.getEventType())) {
			reqDto.setEventDate("");
			reqDto.setEventTime("");
			reqDto.setEventWiningDate("");
			reqDto.setEventPlace("");
			reqDto.setThumImg("");
			reqDto.setDetailImg1("");
			reqDto.setDetailImg2("");
			reqDto.setDetailImg3("");
			reqDto.setAddrRegYn("");
			reqDto.setOneMaxCnt("");
			reqDto.setDevRegYn("");
			reqDto.setTierLimitYn("");
		}else if("MONTHLY".equals(reqDto.getEventType())) {
			reqDto.setDownURL("");
			reqDto.setDownFile("");
			reqDto.setDownFileNm("");
			reqDto.setAddrRegYn("");
			reqDto.setOneMaxCnt("");
			reqDto.setDevRegYn("");
			reqDto.setTierLimitYn("");
		}else if("GIFT".equals(reqDto.getEventType())) {
			reqDto.setEventDate("");
			reqDto.setEventWiningDate("");
			reqDto.setEventPlace("");
			reqDto.setThumImg("");
			reqDto.setDetailImg1("");
			reqDto.setDetailImg2("");
			reqDto.setDetailImg3("");
			reqDto.setDownFile("");
			reqDto.setDownURL("");
			reqDto.setDownFileNm("");
			reqDto.setOneMaxCnt("");
			reqDto.setDevRegYn("");
			reqDto.setTierLimitYn("");
		}else if("ONAIR".equals(reqDto.getEventType())) {
			reqDto.setEventDate("");
			reqDto.setEventTime("");
			reqDto.setEventWiningDate("");
			reqDto.setEventPlace("");
			reqDto.setThumImg("");
			reqDto.setDetailImg2("");
			reqDto.setDetailImg3("");
			reqDto.setAddrRegYn("");
			reqDto.setDevRegYn("");
			reqDto.setTierLimitYn("");
		}else if("UGC".equals(reqDto.getEventType())) {
			reqDto.setEventDate("");
			reqDto.setEventTime("");
			reqDto.setEventWiningDate("");
			reqDto.setEventPlace("");
			reqDto.setThumImg("");
			reqDto.setMainImg("");
			reqDto.setDetailImg3("");
			reqDto.setAddrRegYn("");
			reqDto.setOneMaxCnt("1");
		}
		
		if("file".equals(reqDto.getRadioCheck())) {
			reqDto.setDownURL("");
		}else if("url".equals(reqDto.getRadioCheck())) {
			reqDto.setDownFile("");
		}*/
		loyEventMapper.updateEventPlane(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	/**
	* @programId :
	* @name : deleteEventPlan
	* @date : 2019. 6. 25.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto deleteEventPlan(LoyEventPlanExcutionReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		LoyEventPlanExcutionDetailResDto valid = new LoyEventPlanExcutionDetailResDto();
		valid = loyEventMapper.validEventPlan(param);
		
		//활성 or 종료일경우 삭제 불가.
		if("A".equals(valid.getEvtStatusCd()) || "E".equals(valid.getEvtStatusCd())) {
			rtnValue.setSuccess(false);
		}else {
			loyEventMapper.deleteEventPlan(param);
			loyEventMapper.deleteEvtApplct(param);
			loyEventMapper.deleteEvtProdEntry(param);
			loyEventMapper.deleteEvtWinner(param);
			loyEventMapper.deleteLimitMbr(param);
			loyEventMapper.deletePromotion(param);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}

	/**
	* @programId :
	* @name : updateStartEventPlan
	* @date : 2019. 6. 25.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto updateStartEventPlan(LoyEventPlanExcutionReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		loyEventMapper.updateStartEventPlan(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	* @programId :
	* @name : updateFinishEventPlan
	* @date : 2019. 6. 25.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto updateFinishEventPlan(LoyEventPlanExcutionReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
	    loyEventMapper.updateFinishEventPlan(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	* @programId :
	* @name : updateStopEventPlan
	* @date : 2019. 6. 25.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto updateStopEventPlan(LoyEventPlanExcutionReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		loyEventMapper.updateStopEventPlan(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	/**
	* @programId :
	* @name : getEventApplicantList
	* @date : 2019. 6. 26.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public GridPagingResDto<LoyEvtApplctResDto> getEventApplicantList(LoyEvtApplctReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		return new GridPagingResHelper<LoyEvtApplctResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyEventMapper.evtApplctList(param),AnnotationType.ALL);
	}

	/**
	* @programId :
	* @name : getProdEntryList
	* @date : 2019. 6. 26.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public GridPagingResDto<LoyEventProdEntryResDto> getProdEntryList(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyEventProdEntryResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyEventMapper.prodEntryList(reqDto),AnnotationType.ALL);
	}


	/**
	* @programId :
	* @name : insertTransferWinner
	* @date : 2019. 6. 26.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto insertTransferWinner(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		//reqDto.setRid(CommonUtil.newRid());
		loyEventMapper.insertTransferWinner(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : validWinnerTransfer
	* @date : 2019. 6. 26.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto validWinnerTransfer(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		Integer valid = (Integer) loyEventMapper.validWinnerTransfer(reqDto);
		if(valid > 0) {
			rtnValue.setSuccess(false);
		} else {
			rtnValue.setSuccess(true);
		}
		
		return rtnValue;
	}


	/**
	* @programId :
	* @name : cancleVote
	* @date : 2019. 6. 26.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public LoyEventPlanExcutionDetailResDto cancelVote(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyEventPlanExcutionDetailResDto rtnValue = new LoyEventPlanExcutionDetailResDto();
		loyEventMapper.cancelVote(reqDto);
		rtnValue.setRst(reqDto.getRst());
		rtnValue.setRstMsg(reqDto.getRstmsg());
		return rtnValue;
	}


	/**
	* @programId :
	* @name : insertEvtWinner
	* @date : 2019. 6. 26.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto insertEvtWinner(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		reqDto.setId(CommonUtil.newRid());
		loyEventMapper.insertEvtWinner(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	/**
	* @programId :
	* @name : deleteEventWinner
	* @date : 2019. 6. 26.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto deleteEventWinner(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(true);

		loyEventMapper.cancelWinner(reqDto);
		
		if ("F".equals(reqDto.getRst())) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage(reqDto.getRstmsg());
		}
		
		return rtnValue;
	}


	/**
	* @programId :
	* @name : eventWinnerReset
	* @date : 2019. 6. 26.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto eventWinnerReset(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyEventMapper.eventWinnerReset(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	* @programId :
	* @name : eventApplicantReset
	* @date : 2021. 03. 18.
	* @author : jb.kim
	* @table :
	* @return : 
	* @description : [이벤트 > 응모/참여형 > 참여자 탭] 참여자 목록 초기화
	*/
	public StatusResDto eventApplicantReset(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyEventMapper.eventApplicantReset(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	

	/**
	* @programId :
	* @name : benefitPayment
	* @date : 2019. 6. 26.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public LoyEventPlanExcutionDetailResDto benefitPayment(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyEventPlanExcutionDetailResDto rtnValue = new LoyEventPlanExcutionDetailResDto();
		loyEventMapper.benefitPayment(reqDto);
		rtnValue.setRst(reqDto.getRst());
		rtnValue.setRstMsg(reqDto.getRstmsg());
		return rtnValue;
		
	}


	/**
	* @programId :
	* @name : cancleBenefitPayment
	* @date : 2019. 6. 26.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public LoyEventPlanExcutionDetailResDto cancleBenefitPayment(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyEventPlanExcutionDetailResDto rtnValue = new LoyEventPlanExcutionDetailResDto();
		loyEventMapper.cancleBenefitPayment(reqDto);
		rtnValue.setRst(reqDto.getRst());
		rtnValue.setRstMsg(reqDto.getRstmsg());
		
		return rtnValue;
	}


	/**
	* @programId :
	* @name : insertEventWinnerList
	* @date : 2019. 6. 27.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto insertEventWinnerList(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		String dataKey = BeansUtil.getDbEncryptDataKey();
		rtnValue.setSuccess(false);
		StringBuffer sql = new StringBuffer()
				.append("MERGE INTO LOY.LOY_EVT_WINNER T1")
				.append(" USING DUAL")
				.append(" ON (")
				.append("  ( SELECT COUNT(*) AS aplctCnt")
				.append("    FROM (")
				.append("       SELECT *")
				.append("		FROM LOY.LOY_EVT_APPLCT lea")
				.append("		LEFT OUTER JOIN LOY.LOY_EVT_WINNER lew ON lea.RID = lew.RID_EVT_APPLCT AND lew.FLAG = 1")
				.append("		WHERE 1=1")
				.append("		AND lea.FLAG = 1")
				.append("		AND lea.MBR_NO = ?")
				.append("		AND lea.RID_EVT = ?")
				.append("		AND lew.RID IS NOT NULL")
				.append("	 )")
				.append("	) != 0")
				.append(" )")
				.append("WHEN NOT MATCHED THEN")
				.append("	INSERT (")
			    .append("       RID ")
			    .append("     , CREATE_BY")
			    .append("     , MODIFY_BY")
			    .append("     , CREATE_DATE")
			    .append("     , MODIFY_DATE")
			    .append("     , FLAG")
			    .append("     , RID_EVT")
			    .append("     , RID_MBR")
			    .append("     , MBR_NO")
			    .append("     , WIN_DT")
			    .append("     , RID_EVT_APPLCT")
			    .append("     ) values (")
			    .append("       ?")
			    .append("     , ?")
			    .append("     , ?")
			    .append("     , SYSDATE")
			    .append("     , SYSDATE")
			    .append("     , 1")
			    .append("     , ?")
			    .append("     , ?")
			    .append("     , ?")
			    .append("     , SYSDATE")
			    .append("     , (SELECT RID FROM LOY.LOY_EVT_APPLCT WHERE MBR_NO = ? AND RID_EVT = ? AND ROWNUM = 1 AND FLAG = 1)" )
			    .append("     )");
				
		List<Map<Integer,Object>> params = new ArrayList<Map<Integer,Object>>();
		
		for(LoyEvtApplctReqDto lear : reqDto.getArray()) {
			
			if( ObjectUtil.isNotEmpty(lear.getMbrNo())) {
				LoyEvtApplctResDto resDto = loyEventMapper.selectMbrNoDetail(lear);
				if( ObjectUtil.isNotEmpty(resDto)) {
					reqDto.setMbrNo(resDto.getMbrNo());
					reqDto.setRidMbr((resDto.getRidMbr()));
				} else continue;
			} else if( ObjectUtil.isNotEmpty(lear.getHhp()) &&  ObjectUtil.isNotEmpty(lear.getCustNm())) {
				lear.setHhp(StringUtil.convertNull(lear.getHhp(), "").replaceAll("-", "").trim());
				lear.setHhp(SecurityUtil.encodeDbAES256(dataKey,lear.getHhp()));
				lear.setCustNm(SecurityUtil.encodeDbAES256(dataKey,lear.getCustNm()));
				LoyEvtApplctResDto resDto = loyEventMapper.selectMbrDetail(lear);
				if( ObjectUtil.isNotEmpty(resDto)) {
					reqDto.setMbrNo(resDto.getMbrNo());
					reqDto.setRidMbr((resDto.getRidMbr()));
				} else continue;
			}
			
			
			String rid = UUID.randomUUID().toString().replace("-", "");
			reqDto.setRid(rid);
			
			/*if("Y".equals(lear.getBnfYn())) {
				lear.setBnfYn("W");
			} else if("N".equals(lear.getBnfYn())){
				lear.setBnfYn("C");
			}*/
			
			//if(ObjectUtil.isNotEmpty(lear.getBnfYn())) {}
			//신규
			
			int idx = 1;
			Map<Integer,Object> param = new HashMap<Integer,Object>();
			
			/*// UPDATE부분
			param.put(idx++, reqDto.getEventRid());			// RID_EVT 값
			param.put(idx++, reqDto.getMbrNo());			// MBR_NO 값
			param.put(idx++, reqDto.getModifyBy());			// MODIFY_BY값
			param.put(idx++, reqDto.getEventRid()); // RID_EVT 값
			param.put(idx++, reqDto.getMbrNo()); // MBR_NO 값*/
			
			// INSERT부분	 		
			param.put(idx++, reqDto.getMbrNo());
			param.put(idx++, reqDto.getEventRid());
			param.put(idx++, reqDto.getRid());
			param.put(idx++, reqDto.getCreateBy());
			param.put(idx++, reqDto.getModifyBy());
			param.put(idx++, reqDto.getEventRid());
			param.put(idx++, reqDto.getRidMbr());
			param.put(idx++, reqDto.getMbrNo());
			param.put(idx++, reqDto.getMbrNo());
			param.put(idx++, reqDto.getEventRid());
			
			params.add(param);
		}
		
		addBatchService.addBatch(sql.toString(), params);
		reqDto.setpType("ALL");
		
		//프로시저 호출
		//benefitPayment(reqDto);
		
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : insertEventApplicantList
	* @date : 2021. 03. 17.
	* @author : jb.kim
	* @table :
	* @return : 
	* @description : [이벤트 > 응모/참여형 > 참여자 탭] 참여자 '엑셀업로드'
	*/
	public StatusResDto insertEventApplicantList(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		String dataKey = BeansUtil.getDbEncryptDataKey();

		rtnValue.setSuccess(false);
		
		StringBuffer sql = new StringBuffer()
				.append("MERGE INTO LOY.LOY_EVT_APPLCT T1")
				.append(" USING DUAL")
				.append(" ON (")
				/*.append("  ( SELECT COUNT(*) AS aplctCnt")
				.append("    FROM (")
				.append("       SELECT *")
				.append("		FROM LOY.LOY_EVT_APPLCT lea")
				.append("		WHERE 1=1")
				.append("		AND lea.FLAG = 1")
				.append("		AND lea.MBR_NO = ?")
				.append("		AND lea.RID_EVT = ?")
				.append("	 )")
				.append("	) != 0")*/
				.append(" 1 != 1")
				.append(" )")
				.append("WHEN NOT MATCHED THEN")
				.append("	INSERT (")
			    .append("       RID ")
			    .append("     , CREATE_BY")
			    .append("     , MODIFY_BY")
			    .append("     , CREATE_DATE")
			    .append("     , MODIFY_DATE")
			    .append("     , FLAG")
			    .append("     , RID_EVT")
			    .append("     , RID_MBR")
			    .append("     , MBR_NO")
			    .append("     , APPLCT_DT")
			    .append("     ) values (")
			    .append("       ?")
			    .append("     , ?")
			    .append("     , ?")
			    .append("     , SYSDATE")
			    .append("     , SYSDATE")
			    .append("     , 1")
			    .append("     , ?")
			    .append("     , ?")
			    .append("     , ?")
			    .append("     , SYSDATE")
			    .append("     )");
				
		List<Map<Integer,Object>> params = new ArrayList<Map<Integer,Object>>();
		
		for(LoyEvtApplctReqDto lear : reqDto.getArray()) {
			if( ObjectUtil.isNotEmpty(lear.getMbrNo())) {
				LoyEvtApplctResDto resDto = loyEventMapper.selectMbrNoDetail(lear);
				if( ObjectUtil.isNotEmpty(resDto)) {
					reqDto.setMbrNo(resDto.getMbrNo());
					reqDto.setRidMbr((resDto.getRidMbr()));
				} else continue;
			} else if( ObjectUtil.isNotEmpty(lear.getHhp()) &&  ObjectUtil.isNotEmpty(lear.getCustNm())) {
				lear.setHhp(StringUtil.convertNull(lear.getHhp(), "").replaceAll("-", "").trim());
				lear.setHhp(SecurityUtil.encodeDbAES256(dataKey,lear.getHhp()));
				lear.setCustNm(SecurityUtil.encodeDbAES256(dataKey,lear.getCustNm()));
				LoyEvtApplctResDto resDto = loyEventMapper.selectMbrDetail(lear);
				if( ObjectUtil.isNotEmpty(resDto)) {
					reqDto.setMbrNo(resDto.getMbrNo());
					reqDto.setRidMbr((resDto.getRidMbr()));
				} else continue;
			}
			
			String rid = UUID.randomUUID().toString().replace("-", "");
			reqDto.setRid(rid);
			
			int idx = 1;
			Map<Integer,Object> param = new HashMap<Integer,Object>();
			
			/*param.put(idx++, reqDto.getMbrNo());
			param.put(idx++, reqDto.getEventRid());*/
			param.put(idx++, reqDto.getRid());
			param.put(idx++, reqDto.getCreateBy());
			param.put(idx++, reqDto.getModifyBy());
			param.put(idx++, reqDto.getEventRid());
			param.put(idx++, reqDto.getRidMbr());
			param.put(idx++, reqDto.getMbrNo());
			
			params.add(param);
		}
				
		// [이벤트>응모/참여형>참여자 탭] 엑셀 업로드 유형 판별 
		if(reqDto.getExcelUploadType().equals("T1")) { // T1: 참여자 전체 삭제 후 업로드
			loyEventMapper.eventApplicantReset(reqDto);
		}
		
		addBatchService.addBatch(sql.toString(), params);
		reqDto.setpType("ALL");
		
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	
	/**
	* @programId :
	* @name : getSelectProdEntryList
	* @date : 2019. 6. 27.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public GridPagingResDto<LoyProdEntryResDto> getSelectProdEntryList(LoyProdEntryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyProdEntryResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyEventMapper.selectProdEntryList(reqDto),AnnotationType.PersonalData);
	}


	/**
	* @programId :
	* @name : updateSendSuccess
	* @date : 2019. 6. 27.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto updateSendSuccess(LoyProdEntryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyEventMapper.updateSendSuccess(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : updateSendCancel
	* @date : 2019. 6. 27.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description : 발송취소
	*/
	public StatusResDto updateSendCancel(LoyProdEntryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyEventMapper.updateSendCancel(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	/**
	* @programId :
	* @name : insertEventProdEntryList
	* @date : 2019. 6. 27.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto insertEventProdEntryList(LoyProdEntryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		int overlapCnt = 0;
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE loy.LOY_EVT_PROD_ENTRY" + 
				"   SET SEND_YN     = 'Y'		" + 
				"     , SEND_DT     = SYSDATE	" + 
				"     , MODIFY_BY   = ?			" + 
				"     , MODIFY_DATE = SYSDATE	" + 
				" WHERE FLAG    = 1 	 		" + 
				"   AND rid_mbr  = (select rid from loy.loy_mbr where mbr_no = ?) " + 
				"   AND SEND_YN = 'N'			");
		
		List<Map<Integer,Object>> params = new ArrayList<Map<Integer,Object>>();
		
		for(LoyProdEntryReqDto lear : reqDto.getArray()) {
			reqDto.setMbrNo(lear.getMbrNo());
			//중복회원
			overlapCnt = (int) loyEventMapper.selectOverLapProdEntry(reqDto);

			if(0 == overlapCnt) {
				int idx = 1;
				Map<Integer,Object> param = new HashMap<Integer,Object>();
				//회원정보
				param.put(idx++, reqDto.getModifyBy());
				param.put(idx++, reqDto.getMbrNo());
				params.add(param);
			}
		}
		
		addBatchService.addBatch(sql.toString(), params);
		return rtnValue;
	}

	/**
	* @programId :
	* @name : evtAppliClearMask
	* @date : 2019. 7. 11.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public LoyEvtApplctResDto evtAppliClearMask(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto,"LOY_EVT_APPLCT");
		LoyEvtApplctResDto res = loyEventMapper.evtAppliClearMask(reqDto);
	    return new AnnotationHelper<LoyEvtApplctResDto>(AnnotationType.PersonalData, res).getItem();
	}


	/**
	* @programId :
	* @name : getWinnerExcelDownList
	* @date : 2019. 7. 11.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public GridPagingResDto<LoyEventProdEnrtyExcelResDto> getWinnerExcelDownList(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyEventProdEnrtyExcelResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyEventMapper.getWinnerExcelDownList(reqDto),AnnotationType.CommCode);
	}


	/**
	* @programId :
	* @name : evtWinnerClearMask
	* @date : 2019. 7. 11.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public LoyEvtWinnerResDto evtWinnerClearMask(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "LOY_EVT_WINNER");  //이력 저장
		LoyEvtWinnerResDto res = loyEventMapper.evtWinnerClearMask(reqDto);
	    return new AnnotationHelper<LoyEvtWinnerResDto>(AnnotationType.ALL, res).getItem();
	}


	/**
	* @programId :
	* @name : evtProdEntryClearMask
	* @date : 2019. 7. 11.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public LoyProdEntryResDto evtProdEntryClearMask(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "LOY_EVT_PROD_ENTRY");  //이력 저장
		LoyProdEntryResDto res = loyEventMapper.evtProdEntryClearMask(reqDto);
	    return new AnnotationHelper<LoyProdEntryResDto>(AnnotationType.PersonalData, res).getItem();
	}
	
	/**
	* @programId :
	* @name : getEventApplicantListExcelDown
	* @date : 2019. 7. 11.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public GridPagingResDto<LoyEvtApplctExcelResDto> getEvtApplicantDown(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyEvtApplctExcelResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyEventMapper.getEvtApplicantDown(reqDto),AnnotationType.CommCode);
	}
	
	/**
	* @programId :
	* @name : addEventPreviewToken
	* @date : 2019. 7. 17.
	* @author : dg.ryu
	* @table :
	* @return : 
	* @description : 이벤트 미리보기 토큰 등록
	*/
	public StatusResDto addEventPreviewToken(LoyEventPreviewTokenReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		StatusResDto rtnValue = new StatusResDto();
		reqDto.setRid(CommonUtil.newRid());		//RID
		loyEventMapper.insertEvtPreviewToken(reqDto);
		rtnValue.setSuccess(true);
        rtnValue.setMessage(reqDto.getRid());
        
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : getEvtPreviewToken
	* @date : 2019. 7. 17.
	* @author : dg.ryu
	* @table :
	* @return : 
	* @description : 이벤트 미리보기 토큰 조회
	*/
	public LoyEventPreviewTokenResDto getEventPreviewToken(LoyEventPreviewTokenReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		LoyEventPreviewTokenResDto rtnValue = new LoyEventPreviewTokenResDto();
		
		//기존 토큰 삭제
		loyEventMapper.deleteEvtPreviewToken(reqDto);
		
		//토큰 생성
		//유효시간 기본 30분
		reqDto.setValidTime(30);
		reqDto.setToken(CommonUtil.newRid());
		StatusResDto res = addEventPreviewToken(reqDto);
		
		reqDto.setRid(res.getMessage());
		
		//토큰 조회
		rtnValue = loyEventMapper.selectEvtPreviewToken(reqDto);
	     
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : removeEventPreviewToken
	* @date : 2019. 7. 17.
	* @author : dg.ryu
	* @table :
	* @return : 
	* @description : 이벤트 미리보기 토큰 삭제
	*/
	public StatusResDto removeEventPreviewToken(LoyEventPreviewTokenReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		StatusResDto rtnValue = new StatusResDto();
		loyEventMapper.deleteEvtPreviewToken(reqDto);
		rtnValue.setSuccess(true);
        
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : setEventWinCmplt
	* @date : 2019. 7. 26.
	* @author : dg.ryu
	* @table :
	* @return : 
	* @description : 이벤트 당첨 완료
	*/
	public StatusResDto setEventWinCmplt(LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		StatusResDto rtnValue = new StatusResDto();
		loyEventMapper.updateEventWinCmplt(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : getEventWinCompleteYn
	* @date : 2021. 03. 18.
	* @author : jb.kim
	* @table :
	* @return : 
	* @description : 해당 이벤트의 '당첨완료'여부를 체크
	*/
	public LoyEvtApplctResDto getEventWinCompleteYn(LoyEvtApplctReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		return loyEventMapper.selectEventWinCompleteYn(param);
	}
	
	/**
	* @programId :
	* @name : getProdEntryExcelDownList
	* @date : 2019. 7. 29.
	* @author : dg.ryu
	* @table :
	* @return : 
	* @description : 신청자 엑셀 다운로드 목록 조회
	*/
	public GridPagingResDto<LoyProdEntryResDto> getProdEntryExcelDownList(LoyProdEntryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyProdEntryResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyEventMapper.getProdEntryExcelDownList(reqDto),AnnotationType.PersonalData);
	}

    /**
    * @programId :
    * @name : getMbrStoreList
    * @date : 2019. 9. 10.
    * @author : 2sh.kim
    * @table :
    * @return : 
    * @description : 스토어 거래이력 조회
    */
    public GridPagingResDto<LoyStoreListResDto> getMbrStoreList(LoyStoreListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        return new GridPagingResHelper<LoyStoreListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyEventMapper.selectMbrStoreList(reqDto),AnnotationType.PersonalData);
    }


    /**
    * @programId :
    * @name : clearMaskingStore
    * @date : 2019. 9. 10.
    * @author : 2sh.kim
    * @table :
    * @return : 
    * @description :스토어 거래이력 마스킹 해제
    */
    public LoyStoreListResDto clearMaskingStore(LoyStoreListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        loggingHelper.insertCustReleaLog(reqDto, "loy_mbr_Store"); // 이력 저장
        LoyStoreListResDto res = loyEventMapper.clearMaskingStore(reqDto);
	    return new AnnotationHelper<LoyStoreListResDto>(AnnotationType.PersonalData, res).getItem();
    }


    /**
    * @programId :
    * @name : getMbrStoreListExport
    * @date : 2019. 9. 10.
    * @author : 2sh.kim
    * @table :
    * @return : 
    * @description :스토어 거래이력 엑셀 다운로드
    *//*
    public GridPagingResDto<> getMbrStoreListExport(LOYStoreListRequestDTO reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        return loyEventMapper.getMbrStoreListExport(reqDto);
    }*/

	/**
	* @programId :
	* @name : getAttdanceList
	* @date : 2019. 9. 3.
	* @author : jh.seo
	* @table :
	* @return : 
	* @description : 출석이벤트 이력 조회
	*//*
	@Override
	public GridPagingResDto<> getAttendanceList(LOYAttendanceRequestDTO reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		
		return loyEventMapper.getAttendanceList(reqDTO);
	}*/
	
	/**
	* @programId :
	* @name : clearMaskAttendance
	* @date : 2019. 9. 4.
	* @author : jh.seo
	* @table :
	* @return : 
	* @description : 출석이벤트 이력 마스킹 해제
	*//*
	@Override
	public LOYAttendanceResponseDTO clearMaskAttendance(LOYAttendanceRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setRid(reqDto.getPstMbrRid());
		iLOYCustService.insertCustReleaLog(reqDto,"LOY_MBR"); //이력 저장
		
		return loyEventMapper.clearMaskAttendance(reqDto);
	}*/

	/**
	* @programId :
	* @name : clearMaskAttendance
	* @date : 2019. 9. 4.
	* @author : jh.seo
	* @table :
	* @return : 
	* @description : 출석이벤트 엑셀 다운로드
	*//*
	@Override
	public GridPagingResDto<> excelDownAttendanceList(LOYAttendanceRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		iLOYCustService.insertCustReleaLog(reqDto, "loy_mbr");
		
		return loyEventMapper.excelDownAttendanceList(reqDto);
	}*/
	
	/*@Override
	public LOYEventPreviewTokenResponseDTO getEventStorePreviewToken(LOYEventPreviewTokenRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		LOYEventPreviewTokenResponseDTO rtnValue = new LOYEventPreviewTokenResponseDTO();
		
		//기존 토큰 삭제
		loyEventMapper.removeEventPreviewToken(reqDto);
		
		//토큰 생성
		//유효시간 기본 30분
		reqDto.setValidTime(30);
		reqDto.setToken(imktBase.getRowID());
		StatusResDto res = addEventPreviewToken(reqDto);
		
		reqDto.setRid(res.getMessage());
		
		//토큰 조회
		rtnValue = loyEventMapper.getEventStorePreviewToken(reqDto);
	     
		return rtnValue;
	}*/


	/**
	* @programId :
	* @name : getStoreListRdmPoint
	* @date : 2019. 10. 23.
	* @author : jh.seo
	* @table :
	* @return : LOYStoreListResponseDTO
	* @description : SHOP 총 사용 포인트
	*//*
	@Override
	public LOYStoreListResponseDTO getStoreListRdmPoint(LOYStoreListRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyEventMapper.getStoreListRdmPoint(reqDto);
	}*/


	/**
	* @programId :
	* @name : getStoreListAcrlPoint
	* @date : 2019. 10. 23.
	* @author : jh.seo
	* @table :
	* @return : LOYStoreListResponseDTO
	* @description : SHOP 총 적립 포인트
	*//*
	@Override
	public LOYStoreListResponseDTO getStoreListAcrlPoint(LOYStoreListRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyEventMapper.getStoreListAcrlPoint(reqDto);
	}*/


	/**
	* @programId :
	* @name : getAddPromList
	* @date : 2019. 10. 22.
	* @author : 2sh.kim
	* @table :
	* @return : 
	* @description : 추가혜택 조회
	*/
	public GridPagingResDto<LoyAddPromResDto> getAddPromList(LoyAddPromReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		 return new GridPagingResHelper<LoyAddPromResDto>().newGridPagingResDto(
					reqDto.init(CommonUtil.getInstance().getDBType()),
					loyEventMapper.SelectAddPromList(reqDto),AnnotationType.ALL);
	}


	/**
	* @programId :
	* @name : addPromSave
	* @date : 2019. 10. 22.
	* @author : 2sh.kim
	* @table :
	* @return : 
	* @description : 추가혜택 등록
	*/
	public StatusResDto addPromSave(LoyAddPromReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
	    param.setRid(CommonUtil.newRid());
		loyEventMapper.insertAddPromSave(param);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}


	/**
	* @programId :
	* @name : deleteProm
	* @date : 2019. 10. 22.
	* @author : 2sh.kim
	* @table :
	* @return : 
	* @description : 추가혜택 삭제
	*/
	public StatusResDto deleteProm(LoyAddPromReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		loyEventMapper.deleteProm(param);

		rtnValue.setSuccess(true);
		
		return rtnValue;
	}


	/**
	* @programId :
	* @name : InsertLimitMbr
	* @date : 2019. 10. 22.
	* @author : 2sh.kim
	* @table :
	* @return : 
	* @description : 부정회원 등록
	*/
	public StatusResDto InsertLimitMbr(LoyLimitMbrReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		param.setRid(CommonUtil.newRid());
		loyEventMapper.InsertLimitMbr(param);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}


	/**
	* @programId :
	* @name : validLimitMbr
	* @date : 2019. 10. 22.
	* @author : 2sh.kim
	* @table :
	* @return : 
	* @description : 부정회원 중복체크
	*/
	public StatusResDto validLimitMbr(LoyLimitMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		StatusResDto rtnValue = new StatusResDto();
		
		Integer valid =  (Integer) loyEventMapper.validLimitMbr(reqDto);
		
		if (valid > 0) {
			rtnValue.setSuccess(false);
		}else {
			rtnValue.setSuccess(true);
		}
		
		return rtnValue;
	}


	/**
	* @programId :
	* @name : getLimitMbrList
	* @date : 2019. 10. 22.
	* @author : 2sh.kim
	* @table :
	* @return :  부정회원 조회
	* @description :
	*/
	public GridPagingResDto<LoyLimitMbrResDto> getLimitMbrList(LoyLimitMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyLimitMbrResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyEventMapper.SelectLimitMbrList(reqDto),AnnotationType.PersonalData);
	}
	
	/*@Override
	public LOYEventPreviewTokenResponseDTO getPointMallPreviewToken(LOYEventPreviewTokenRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		LOYEventPreviewTokenResponseDTO rtnValue = new LOYEventPreviewTokenResponseDTO();
		
		//기존 토큰 삭제
		loyEventMapper.removeEventPreviewToken(reqDto);
		
		//토큰 생성
		//유효시간 기본 30분
		reqDto.setValidTime(30);
		reqDto.setToken(imktBase.getRowID());
		StatusResDto res = addEventPreviewToken(reqDto);
		
		reqDto.setRid(res.getMessage());
		
		//토큰 조회
		rtnValue = loyEventMapper.getPointMallPreviewToken(reqDto);
	    
	
		return rtnValue;
	}*/


	/**
	* @programId :
	* @name : LimitMbrClearMask
	* @date : 2019. 10. 23.
	* @author : 2sh.kim
	* @table :
	* @return : 
	* @description : 부정등록회원 마스킹해제
	*/
	public LoyLimitMbrResDto LimitMbrClearMask(LoyLimitMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto,"LOY_EVT_LIMIT_MBR"); // 이력 저장
		LoyLimitMbrResDto res = loyEventMapper.LimitMbrClearMask(reqDto);
	    return new AnnotationHelper<LoyLimitMbrResDto>(AnnotationType.PersonalData, res).getItem();
	}


	/**s
	* @programId :
	* @name : terminationCancel
	* @date : 2019. 10. 23.
	* @author : 2sh.kim
	* @table :
	* @return : 
	* @description : 부정등록회원 해지
	*/
	public StatusResDto terminationCancel(LoyLimitMbrReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		
		loyEventMapper.CancelLimitMbr(param);

		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : getReservPreviewToken
	* @date : 2019. 10. 23.
	* @author : jh.seo
	* @table :
	* @return : LOYEventPreviewTokenResponseDTO
	* @description : 예약서비스 미리보기 토큰 조회
	*//*
	@Override
	public LOYEventPreviewTokenResponseDTO getReservPreviewToken(LOYEventPreviewTokenRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		LOYEventPreviewTokenResponseDTO rtnValue = new LOYEventPreviewTokenResponseDTO();
		
		//기존 토큰 삭제
		loyEventMapper.removeEventPreviewToken(reqDto);
		
		//토큰 생성
		//유효시간 기본 30분
		reqDto.setValidTime(30);
		reqDto.setToken(imktBase.getRowID());
		StatusResDto res = addEventPreviewToken(reqDto);
		
		reqDto.setRid(res.getMessage());
		
		//토큰 조회
		rtnValue = loyEventMapper.getReservPreviewToken(reqDto);
	     
		return rtnValue;
	}*/


	/**
	* @programId :
	* @name : getWinningCond
	* @date : 2019. 10. 29.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public LoyEventWinningCondResDto getWinningCond(LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyEventWinningCondResDto res = loyEventMapper.selectWinningCond(reqDto);
	    return new AnnotationHelper<LoyEventWinningCondResDto>(AnnotationType.ALL, res).getItem();
	}
	
	/**
	* @programId :
	* @name : updateEventEmg
	* @date : 2019. 10. 31.
	* @author : 2sh.kim
	* @table :
	* @return : 
	* @description : 이미지 삭제 업데이트
	*/
	public StatusResDto updateEventEmg(LoyEventPlanExcutionReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();

		if("thumImage".equals(reqDto.getFileNm())) {
			reqDto.setFileNm("THUMBNAIL_IMG");
		}else if("mainImage".equals(reqDto.getFileNm())) {
			reqDto.setFileNm("MAIN_IMG");
		}else if("detailImageOne".equals(reqDto.getFileNm())) {
			reqDto.setFileNm("DETAIL_IMG1");
		}else if("detailImageTwo".equals(reqDto.getFileNm())) {
			reqDto.setFileNm("DETAIL_IMG2");
		}else if("detailImageThree".equals(reqDto.getFileNm())) {
			reqDto.setFileNm("DETAIL_IMG3");
		}
		
		loyEventMapper.updateEventEmg(reqDto);
		rtnValue.setSuccess(true);
        rtnValue.setMessage(reqDto.getRid());
        return rtnValue;
	}
	
	/**
	* @programId :
	* @name : getAttendAcrlPoint
	* @date : 2019. 10. 29.
	* @author : jh.seo
	* @table :
	* @return : LOYAttendanceResponseDTO
	* @description : 출석이벤트 총적립 및 적립별 총액 조회
	*//*
	@Override
	public LOYAttendanceResponseDTO getAttendAcrlPoint(LOYAttendanceRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyEventMapper.getAttendAcrlPoint(reqDto);
	}*/

	/**
	* @programId :
	* @name : getUGCList
	* @date : 2019. 11. 05.
	* @author : yj.choi
	* @table :
	* @return : GridPagingResDto<>
	* @description : UGCList조회
	*/
	public GridPagingResDto<LoyUGCListResDto> getUGCList(LoyUGCListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyUGCListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyEventMapper.getUGCList(reqDto),AnnotationType.PersonalData);
	}

	/**
	* @programId :
	* @name : getUGCAch
	* @date : 2019. 11. 06.
	* @author : yj.choi
	* @table :
	* @return : getUGCAchResponseDTO
	* @description :  UGC 총 달성인원, 달성횟수 조회
	*/
	public LoyUGCAchResDto getUGCAch(LoyUGCAchReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyUGCAchResDto res = loyEventMapper.getUGCAch(reqDto);
	    return new AnnotationHelper<LoyUGCAchResDto>(AnnotationType.ALL, res).getItem();
	}

	/**
	* @programId :
	* @name : LimitMbrClearMask
	* @date : 2019. 11. 06.
	* @author : yj.choi
	* @table :
	* @return : 
	* @description : ugc 이력 마스킹해제
	*/
	public LoyUGCListResDto UGCMbrClearMasking(LoyUGCListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto,"LOY_MBR"); // 이력 저장
		LoyUGCListResDto res = loyEventMapper.ugcMbrclearMasking(reqDto);
	    return new AnnotationHelper<LoyUGCListResDto>(AnnotationType.PersonalData, res).getItem();
	}

	/**
	* @programId :
	* @name : ugcListExport
	* @date : 2019. 11. 06.
	* @author : yj.choi
	* @table :
	* @return : 
	* @description : 
	*/
	public GridPagingResDto<LoyUGCListResDto> ugcListExport(LoyUGCListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "LOY_MBR");
		return new GridPagingResHelper<LoyUGCListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyEventMapper.ugcListExport(reqDto),AnnotationType.ALL);
	}


	/**
	* @programId :
	* @name : validLimitProm
	* @date : 2019. 11. 15.
	* @author : 2sh.kim
	* @table :
	* @return : 
	* @description : 추가혜택 중복체크
	*/
	public StatusResDto validLimitProm(LoyAddPromReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		
		Integer valid =  (Integer) loyEventMapper.validLimitProm(reqDto);
		
		if (valid > 0) {
			rtnValue.setSuccess(false);
		}else {
			rtnValue.setSuccess(true);
		}
		
		return rtnValue;
		
	}


	/**
	* @programId :
	* @name : selectAddProm
	* @date : 2019. 11. 15.
	* @author : 2sh.kim
	* @table :
	* @return : 
	* @description : 추가혜택 조회
	*/
	public LoyAddPromResDto selectAddProm(String reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyAddPromResDto res = loyEventMapper.selectAddProm(reqDto);
	    return new AnnotationHelper<LoyAddPromResDto>(AnnotationType.ALL, res).getItem();
	}


	/**
	* @programId :
	* @name : updatePromSave
	* @date : 2019. 11. 15.
	* @author : 2sh.kim
	* @table :
	* @return : 
	* @description : 추가혜택 수정
	*/
	public StatusResDto updatePromSave(LoyAddPromReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyEventMapper.updatePromSave(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : getAttendAcrlJoin
	* @date : 2019. 11. 15.
	* @author : jh.seo
	* @table :
	* @return : LOYAttendanceResponseDTO
	* @description : 출석이벤트 참여횟수 및 참여인원, 비율 조회
	*//*
	@Override
	public LOYAttendanceResponseDTO getAttendAcrlJoin(LOYAttendanceRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyEventMapper.getAttendAcrlJoin(reqDto);
	}*/

	/**
	* @programId :
	* @name : getAttendAgeGroupCnt
	* @date : 2019. 11. 22.
	* @author : jh.seo
	* @table :
	* @return : LOYAttendanceResponseDTO
	* @description : 출석이벤트 연령별 인원 조회
	*//*
	@Override
	public LOYAttendanceResponseDTO getAttendAgeGroupCnt(LOYAttendanceRequestDTO reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyEventMapper.getAttendAgeGroupCnt(reqDto);
	}*/


	/**
	* @programId :
	* @name : getAddPromCondVal
	* @date : 2019. 11. 29.
	* @author : 2sh.kim
	* @table :
	* @return : 
	* @description : 추가혜택 조건값 조회
	*/
	public LoyAddPromResDto getAddPromCondVal(LoyAddPromReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyAddPromResDto res = loyEventMapper.selectAddPromCondVal(reqDto);
	    return new AnnotationHelper<LoyAddPromResDto>(AnnotationType.ALL, res).getItem();
	}
	
	/**
	* @name : getApplicantCnt
	* @date : 2019. 11. 28.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public LoyApplctRdmResDto getApplicantCnt(LoyApplctRdmReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyApplctRdmResDto res = loyEventMapper.selectApplicantCnt(reqDto);
	    return new AnnotationHelper<LoyApplctRdmResDto>(AnnotationType.ALL, res).getItem();
	}


	/**
	* @programId :
	* @name : getRdmWinner
	* @date : 2019. 11. 28.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto getRdmWinner(LoyApplctRdmReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyEventMapper.getRdmWinner(param);
		String rst = param.getRST();
		
		if("S".equals(rst)) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage(param.getRST_MSG());
		}else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage(param.getRST_MSG());
		}
		
		return rtnValue;
	}


	/**
	* @programId :
	* @name : validCheckWinnerTrans
	* @date : 2019. 12. 2.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto validCheckWinnerTrans(LoyApplctRdmReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		Integer valid = (Integer) loyEventMapper.validCheckWinnerTrans(param);
		if(valid > 0) {
			rtnValue.setSuccess(true);
		}else {
			rtnValue.setSuccess(false);
		}
		
		return rtnValue;
	}

	/**
	* @programId :
	* @name : InsertMbrMsg
	* @date : 2019. 12. 11.
	* @author : jh.seo
	* @table :
	* @return : StatusResDto
	* @description : 부정회원 등록 및 취소, 이벤트 당첨완료 프로시저 호출
	*/
	public StatusResDto InsertMbrMsg(LoyLimitMbrReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		/*LoyLimitMbrResDto resDto;*/
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		/*if(param.getType().equals("BLACK_MEM") && ObjectUtil.isEmpty(param.getCrudType())) {
			resDto = loyEventMapper.getInsertLimitMbr(param);
			param.setRid(resDto.getRid());
		}*/
		loyEventMapper.InsertLimitMbr(param);
		rtnValue.setSuccess(true);
		//String rst = param.getRST();
		
		/*if("S".equals(rst)) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage(param.getRST_MSG());
		}else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage(param.getRST_MSG());
		}*/
		
		return rtnValue;
		
	}


	 /*
	  * 1. 메소드명: getTierLimitList
	  * 2. 클래스명: LoyEventService
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
	
	public GridPagingResDto<LoyTierLimitListResDto> getTierLimitList(LoyUGCListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyTierLimitListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyEventMapper.selectTierLimitList(reqDto),AnnotationType.Nothing);
	}


	 /*
	  * 1. 메소드명: insertEvtApplict
	  * 2. 클래스명: LoyEventService
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
	 *   @return	
	 */
	
	public StatusResDto insertEvtApplict(LoyEvtApplctReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		reqDto.setId(CommonUtil.newRid());
		loyEventMapper.insertEvtApplict(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: saveTierLimit
	  * 2. 클래스명: LoyEventService
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
	 *   @param param
	 *   @return	
	 */
	
	public StatusResDto saveTierLimit(LoyAddTierReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		reqDto.setRid(CommonUtil.newRid());
		loyEventMapper.insertTierLimit(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	public StatusResDto insertProdList(LOYProdRequestDTO raDto) {
		StatusResDto rtnValue = new StatusResDto(); // '상태응답객체 StatusResDto'
		rtnValue.setSuccess(false);
		List<LOYProdRequestDTO> array = raDto.getArray(); // 파라미터 raDto안에서 내용들이 담겨있는 array객체를 가져온다
		
		StringBuffer truncateSql = new StringBuffer();// 스트링버퍼 생성
		StringBuffer insertSql = new StringBuffer();// 스트링버퍼 생성
				
		// DELETE sql문
		//truncateSql.append("TRUNCATE TABLE COM.B_CODE");
				
		// INSERT sql문
		insertSql.append("INSERT INTO LOY.LOY_PROD")
		.append("(")
		.append("  RID")
		.append(", PROD_ID")
		.append(", PROD_NM")
		.append(", PROD_AMT")
		.append(", DESC1")
		.append(", CPN_AVL_YN")
		.append(", CREATE_BY")
		.append(", MODIFY_BY")
		.append(") VALUES (") 
		.append("  ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(")");
		
		
		// insert 작업 전 기존데이터 delete를 위한 deleteBeforeInsert() 를 호출
		//addBatchService.truncateBeforeInsert(truncateSql.toString());
	
		int cntUpload = array.size(); // 배열에 반복돌려야 할 횟수 카운트 cntUpload
		int uploadcnt = 0; // 업로드건에 대한 카운트
		List<Map<Integer,Object>> params = new ArrayList<Map<Integer,Object>>(); // 가변배열 params 객체

		// insert sql을 위한 처리(데이터 매핑 및 초기화)
		for(LOYProdRequestDTO arr : array) {
				int idx = 1;	
				Integer cnt = loyEventMapper.dupCheckProd(arr);
				if(cnt<=0) {
					Map<Integer,Object> param = new HashMap<Integer,Object>();
								
					param.put(idx++, StringUtil.convertNull(CommonUtil.newRid()));
					param.put(idx++, StringUtil.convertNull(arr.getProdId(),""));
					param.put(idx++, StringUtil.convertNull(arr.getProdNm(),""));
					param.put(idx++, StringUtil.convertNull(arr.getSalePrice(),""));
					param.put(idx++, StringUtil.convertNull(arr.getDesc(),""));
					param.put(idx++, StringUtil.convertNull(arr.getCpnAvlYn(),""));
					param.put(idx++, StringUtil.convertNull(raDto.getCreateBy(),""));
					param.put(idx++, StringUtil.convertNull(raDto.getModifyBy(),""));
					params.add(param);
					uploadcnt++;
				}
			}

		int duplCnt = cntUpload - uploadcnt;
		
		addBatchService.addBatch(insertSql.toString(), params);
		
		rtnValue.setSuccess(true);
		rtnValue.setMessage("총 : "+cntUpload+"건, 정상입력 : "+uploadcnt+", 중복제외 : "+duplCnt+"건");

		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : isThereWinnerInApplicant
	* @date : 2021. 03. 19.
	* @author : jb.kim
	* @table :
	* @return : 
	* @description : 해당 이벤트의 참여자들 중, 당첨자가 현재 있는지 체크 
	*/
	public List<LoyEvtApplctResDto> isThereWinnerInApplicant(LoyEvtApplctReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		return loyEventMapper.isThereWinnerInApplicant(param);
	}

}
