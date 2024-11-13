/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCardMasterService.java
 * 2. Package	: com.icignal.loyalty.membershipcard.cardmaster.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 25. 오전 11:37:07
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 25.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membershipcard.cardmaster.service;

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
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.logging.mapper.LoggingMapper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.loyalty.membershipcard.cardmaster.dto.request.LoyCardBinReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.request.LoyCardNoPoolReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.request.LoyCardTypeReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.request.LoyIssuedCardReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyCardBinResDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyCardNoPoolResDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyCardTypeResDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.response.LoyIssuedCardResDto;
import com.icignal.loyalty.membershipcard.cardmaster.mapper.LoyCardMasterMapper;

/*
 * 1. 클래스명	: LoyCardMasterService
 * 2. 파일명	: LoyCardMasterService.java
 * 3. 패키지명	: com.icignal.loyalty.membershipcard.cardmaster.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 25.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyCardMasterService {
	
	@Autowired
	LoyCardMasterMapper loyCardMasterMapper;
	
	@Autowired
	LoggingHelper loggingHelper;
	
	@Autowired
	LoggingMapper loggingMapper;
	
    @Autowired
    private AddBatchService addBatchService;

	public GridPagingResDto<LoyCardTypeResDto> getCardTypeList(LoyCardTypeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyCardTypeResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyCardMasterMapper.selectCardTypeList(reqDto), AnnotationHelper.AnnotationType.CommCode);
	}


	public LoyCardTypeResDto getCardTypeDetail(LoyCardTypeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyCardMasterMapper.selectCardTypeDtl(reqDto);
	}

	public StatusResDto editCardType(LoyCardTypeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
    	rtnValue.setSuccess(false);
		
    	if(loyCardMasterMapper.updateCardTypeDtl(reqDto) > 0){
    		rtnValue.setSuccess(true);
    	}
    	return rtnValue;
	}

	public StatusResDto setCardType(LoyCardTypeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
    	rtnValue.setSuccess(false);
    	String rid = CommonUtil.newRid();
    	reqDto.setRid(rid);

    	if(loyCardMasterMapper.insertCardTypeDtl(reqDto) > 0){
    		rtnValue.setSuccess(true);
    		rtnValue.setMessage(rid);
    	}
    	return rtnValue;
	}

	public GridPagingResDto<LoyIssuedCardResDto> getIssuedCardList(LoyIssuedCardReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyIssuedCardResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyCardMasterMapper.selectIssuedCardList(reqDto),  AnnotationHelper.AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: getCardBinList
	  * 2. 클래스명: LoyCardMasterService
	  * 3. 작성자명: dg.ryu 
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
	 */
	public GridPagingResDto<LoyCardBinResDto> getCardBinList(LoyCardBinReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyCardBinResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyCardMasterMapper.selectCardBinList(reqDto));
	}

	public LoyCardBinResDto getCardBinDetail(LoyCardBinReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyCardMasterMapper.selectCardBinDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: saveCardBin
	  * 2. 클래스명: LoyCardMasterService
	  * 3. 작성자명: dg.ryu 
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
	 */
	public StatusResDto saveCardBin(LoyCardBinReqDto reqDto) {
	   	LogUtil.param(this.getClass(), reqDto);
	   	StatusResDto rtnValue = new StatusResDto();
	   	
	   	if (ObjectUtil.isNotEmpty(reqDto.getRid())) {
	   		loyCardMasterMapper.updateCardBin(reqDto);
	   	} else {
	   		reqDto.setRid(CommonUtil.newRid());
	   		loyCardMasterMapper.insertCardBin(reqDto);
	   	}
	   	
	   	rtnValue.setSuccess(true);
	   	return rtnValue;
   }
	
	 /*
	  * 1. 메소드명: removeCardBin
	  * 2. 클래스명: LoyCardMasterService
	  * 3. 작성자명: dg.ryu 
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
	 */
	public StatusResDto removeCardBin(LoyCardBinReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	StatusResDto rtnValue = new StatusResDto();

    	loyCardMasterMapper.deleteCardBin(reqDto);
    	
   		rtnValue.setSuccess(true);
    	return rtnValue;
    }
	
	 /*
	  * 1. 메소드명: getCardNoPoolList
	  * 2. 클래스명: LoyCardMasterService
	  * 3. 작성자명: dg.ryu 
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
	 */
	public GridPagingResDto<LoyCardNoPoolResDto> getCardNoPoolList(LoyCardNoPoolReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyCardNoPoolResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyCardMasterMapper.selectCardNoPoolList(reqDto),  AnnotationHelper.AnnotationType.CommCode);
	}

	/*
	 * 1. 메소드명: getCardNoPoolListForExcelExport
	 * 2. 클래스명: LoyCardMasterService
	 * 3. 작성자명: nh.lee
	 * 4. 작성일자: 2020. 7. 17.
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
	public GridPagingResDto<LoyCardNoPoolResDto> getCardNoPoolListForExcelExport(LoyCardNoPoolReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyCardNoPoolResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyCardMasterMapper.selectCardNoPoolListForExcelExport(reqDto),  AnnotationHelper.AnnotationType.CommCode);
	}

	public StatusResDto genCardNo(LoyCardNoPoolReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	StatusResDto rtnValue = new StatusResDto();

    	Map map = new HashMap<String, String>();

		map.put("p_commit_yn", "Y");
    	map.put("p_bin", reqDto.getBin());
		map.put("p_typ", "B");
    	map.put("p_cnt", reqDto.getCnt());
		map.put("p_card_kind", reqDto.getRidCardKind());
		map.put("p_title", reqDto.getTitle());
		map.put("p_create_by", reqDto.getCreateBy());
		map.put("p_rst", "");
		map.put("p_rst_msg", "");

		loyCardMasterMapper.callGenCardNoBulk(map);

		if (map.get("p_rst").equals("S")) {
			rtnValue.setSuccess(true);
		} else {
			rtnValue.setSuccess(false);
		}

    	return rtnValue;
    }

	public StatusResDto uploadCardNo(LoyCardNoPoolReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        
        if (ObjectUtil.isNotEmpty(reqDto.getPoolList())) {
	        // 타겟그룹 아이템 등록
	        StringBuffer sql = new StringBuffer();
	        sql.append(" insert into loy.loy_card_no_pool_temp")
	        .append(" (")
	        .append(" rid, ")
	        .append(" create_by, ")
	        .append(" modify_by, ")
	        .append(" rid_card_kind, ")
	    	.append(" card_no, ")
			.append(" title, ")
			.append(" reg_dt, ")
			.append(" stat_cd, ")
			.append(" rid_tr ")
	    	.append(" ) values ( ")
	    	.append(" com.getNewID('') ")
	    	.append(" , ? ")
	    	.append(" , ? ")
	    	.append(" , ? ")
			.append(" , ? ")
	    	.append(" , ? ")
	    	.append(" , TO_DATE(?, 'YYYY-MM-DD') ")
			.append(" , ? ")
			.append(" , ? ")
	    	.append(" ) ");
	    	
	    	List<Map<Integer, Object>> params = new ArrayList<Map<Integer, Object>>();
	    	String ridTr = UUID.randomUUID().toString().replace("-","");
	    	
	    	int itemSeq = 1;
	        for (Map<String, String> item : reqDto.getPoolList()) {
		    	int sIdx = 1;
				Map<Integer, Object> param = new HashMap<Integer, Object>();
				param.put(sIdx++, reqDto.getCreateBy());
				param.put(sIdx++, reqDto.getModifyBy());
				param.put(sIdx++, reqDto.getRidCardKind());
				param.put(sIdx++, item.get("CARD_NO"));
				param.put(sIdx++, item.get("TITLE"));
				param.put(sIdx++, item.get("REG_DT"));
				param.put(sIdx++, item.get("STAT_CD"));
				param.put(sIdx++, ridTr);
				
				params.add(param);
	        }
	        
	        addBatchService.addBatch(sql.toString(), params);
	        
	        loyCardMasterMapper.updateCardNoPool(ridTr);
	        
	        loyCardMasterMapper.deleteCardNoPoolTemp(ridTr);
	        
        }
        
        rtnValue.setSuccess(true);

        return rtnValue;
    }
	
}
