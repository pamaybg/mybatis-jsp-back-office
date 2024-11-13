/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTargetGrpService.java
 * 2. Package	: com.icignal.loyalty.targetgrp.service
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 9. 오후 2:48:44
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 9.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.targetgrp.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.AddBatchService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.targetgrp.dto.request.LoyTargetGrpDetailReqDto;
import com.icignal.loyalty.targetgrp.dto.request.LoyTargetGrpListReqDto;
import com.icignal.loyalty.targetgrp.dto.request.LoyTgtGrpXmListReqDto;
import com.icignal.loyalty.targetgrp.dto.response.LoyTargetGrpDetailResDto;
import com.icignal.loyalty.targetgrp.dto.response.LoyTargetGrpListResDto;
import com.icignal.loyalty.targetgrp.dto.response.LoyTargetGrpResDto;
import com.icignal.loyalty.targetgrp.dto.response.LoyTargetGrpXmListResDto;
import com.icignal.loyalty.targetgrp.mapper.LoyTargetGrpMapper;


/*
 * 1. 클래스명	: LoyTargetGrpService
 * 2. 파일명	: LoyTargetGrpService.java
 * 3. 패키지명	: com.icignal.loyalty.targetgrp.service
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyTargetGrpService {

	@Autowired 
	private LoyTargetGrpMapper loyTargetGrpMapper;
	
	@Autowired
	private AddBatchService addBatchService;
	
	 /*
	  * 1. 메소드명: getTargetGrpList
	  * 2. 클래스명: LoyTargetGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 9.
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
	
	public GridPagingResDto<LoyTargetGrpListResDto> getTargetGrpList(LoyTargetGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<LoyTargetGrpListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyTargetGrpMapper.selectTargetGrpList(bccr),AnnotationType.CommCode
				);
	}

	 /*
	  * 1. 메소드명: getTgtGrpDetail
	  * 2. 클래스명: LoyTargetGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
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
	
	public LoyTargetGrpDetailResDto getTgtGrpDetail(LoyTargetGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return loyTargetGrpMapper.selectTgtGrpDetail(bccr);
	}

	 /*
	  * 1. 메소드명: saveTgtDetail
	  * 2. 클래스명: LoyTargetGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
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
	
	public LoyTargetGrpResDto saveTgtDetail(LoyTargetGrpDetailReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		bccr.setRid(CommonUtil.newRid());
		LoyTargetGrpResDto rtnValue = new LoyTargetGrpResDto();
		rtnValue.setRid(bccr.getRid());
		loyTargetGrpMapper.insertTgtDetail(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyTgtDetail
	  * 2. 클래스명: LoyTargetGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
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
	
	public StatusResDto modifyTgtDetail(LoyTargetGrpDetailReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyTargetGrpMapper.updateTgtDetail(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTgtGrpXmList
	  * 2. 클래스명: LoyTargetGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
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
	
	public GridPagingResDto<LoyTargetGrpXmListResDto> getTgtGrpXmList(LoyTargetGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<LoyTargetGrpXmListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyTargetGrpMapper.selectTgtGrpXmList(bccr),AnnotationType.ALL
				);
	}

	 /*
	  * 1. 메소드명: removeTgtGrpXm
	  * 2. 클래스명: LoyTargetGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
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
	
	public StatusResDto removeTgtGrpXm(LoyTargetGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyTargetGrpMapper.deleteTgtGrpXm(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeAllTgtGrpXm
	  * 2. 클래스명: LoyTargetGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
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
	
	public StatusResDto removeAllTgtGrpXm(LoyTargetGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyTargetGrpMapper.deleteAllTgtGrpXm(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: insertProdList
	  * 2. 클래스명: LoyTargetGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param br
	 *   @return	
	 */
	
	public StatusResDto insertProdList(LoyTgtGrpXmListReqDto batchUpload) {
		
		StatusResDto rtnValue = new StatusResDto();
		
		rtnValue.setSuccess(false);
		List<LoyTgtGrpXmListReqDto> array = batchUpload.getArray();
		StringBuffer sql = new StringBuffer();
		try {
		sql.append("insert into LOY.LOY_TGT_GRP_XM");
		sql.append("(");
		sql.append("  RID");
		sql.append(", CREATE_BY");
		sql.append(", MODIFY_BY");
		sql.append(", RID_TGT_GRP");
		sql.append(", RID_MBR");
		sql.append(", RID_CUST");
		sql.append(", REG_DT");
		sql.append(") values (");
		sql.append("  ?");
		sql.append(", ?");
		sql.append(", ?");
		sql.append(", ?");
		sql.append(", ?");
		sql.append(", ?");
		sql.append(", sysdate");
		sql.append(")");
		}catch(Exception e) {
			LogUtil.error(e);
		}
		

		int cntUpload = array.size();
		int uploadcnt = 0;
		List<Map<Integer,Object>> params = new ArrayList<Map<Integer,Object>>();
		for(LoyTgtGrpXmListReqDto lplr : batchUpload.getArray()) {
			
				int idx = 1;
				Map<Integer,Object> param = new HashMap<Integer,Object>();
				
				LoyTgtGrpXmListReqDto lpl = new LoyTgtGrpXmListReqDto();
				lpl = loyTargetGrpMapper.selectMbrCustRid(lplr);
				lpl.setTgtGrpRid(batchUpload.getTgtGrpRid());
				Integer cnt = loyTargetGrpMapper.selectMbrRidCheck(lpl);
				if(cnt<=0) {
					param.put(idx++, StringUtil.convertNull(CommonUtil.newRid()));
					param.put(idx++, StringUtil.convertNull(batchUpload.getCreateBy(),""));
					param.put(idx++, StringUtil.convertNull(batchUpload.getModifyBy(),""));
					param.put(idx++, StringUtil.convertNull(batchUpload.getTgtGrpRid(),""));
					param.put(idx++, StringUtil.convertNull(lpl.getMbrRid(),""));
					param.put(idx++, StringUtil.convertNull(lpl.getCustRid(),""));
					params.add(param);
					uploadcnt++;
				}
		}
		int duplCnt = cntUpload-uploadcnt;
		try {
		addBatchService.addBatch(sql.toString(), params);
		
		rtnValue.setSuccess(true);
		rtnValue.setMessage("총 : "+cntUpload+"건, 정상입력 : "+uploadcnt+", 중복제외 : "+duplCnt+"건");
		}catch(Exception e) {
			LogUtil.error(e);
		}
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeTgtGrp
	  * 2. 클래스명: LoyTargetGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
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
	
	public StatusResDto removeTgtGrp(LoyTargetGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyTargetGrpMapper.deleteTgtGrp(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	

}
