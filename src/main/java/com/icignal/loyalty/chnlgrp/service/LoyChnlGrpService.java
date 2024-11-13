/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlGrpService.java
 * 2. Package	: com.icignal.loyalty.chnlgrp.service
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 14. 오후 5:01:09
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 14.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.chnlgrp.service;

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
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.chnlgrp.dto.request.LoyChnlGrpDetailReqDto;
import com.icignal.loyalty.chnlgrp.dto.request.LoyChnlGrpListReqDto;
import com.icignal.loyalty.chnlgrp.dto.response.LoyChnlGrpDetailResDto;
import com.icignal.loyalty.chnlgrp.dto.response.LoyChnlGrpItemListResDto;
import com.icignal.loyalty.chnlgrp.dto.response.LoyChnlGrpListResDto;
import com.icignal.loyalty.chnlgrp.dto.response.LoyChnlGrpResDto;
import com.icignal.loyalty.chnlgrp.mapper.LoyChnlGrpMapper;

/*
 * 1. 클래스명	: LoyChnlGrpService
 * 2. 파일명	: LoyChnlGrpService.java
 * 3. 패키지명	: com.icignal.loyalty.chnlgrp.service
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 14.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyChnlGrpService {
	@Autowired 
	private LoyChnlGrpMapper loyChnlGrpMapper;
	
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
	
	public GridPagingResDto<LoyChnlGrpListResDto> getChnlGrpList(LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<LoyChnlGrpListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyChnlGrpMapper.selectChnlGrpList(bccr),AnnotationType.CommCode
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
	
	public LoyChnlGrpDetailResDto getChnlGrpDetail(LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return loyChnlGrpMapper.selectChnlGrpDetail(bccr);
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
	
	public StatusResDto saveChnlGrpDetail(LoyChnlGrpDetailReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		LoyChnlGrpResDto rtnValue = new LoyChnlGrpResDto();
		bccr.setRid(CommonUtil.newRid());
		rtnValue.setRid(bccr.getRid());
		loyChnlGrpMapper.insertChnlGrpDetail(bccr);
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
	
	public StatusResDto modifyChnlGrpDetail(LoyChnlGrpDetailReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyChnlGrpMapper.updateChnlGrpDetail(bccr);
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
	
	public GridPagingResDto<LoyChnlGrpItemListResDto> getChnlItemList(LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<LoyChnlGrpItemListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyChnlGrpMapper.selectChnlItemList(bccr),AnnotationType.ALL
				);
	}

	/*
	  * 1. 메소드명: removeAllTProdItem
	  * 2. 클래스명: LoyProdGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 14.
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
	
	public StatusResDto removeChnlItem(LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyChnlGrpMapper.deleteChnlItem(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeProdItem
	  * 2. 클래스명: LoyProdGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 14.
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
	
	public StatusResDto removeAllTChnlItem(LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyChnlGrpMapper.deleteAllTChnlItem(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: insertProdList
	  * 2. 클래스명: LoyProdGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 14.
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
	
	public StatusResDto insertChnlList(LoyChnlGrpListReqDto batchUpload) {
		StatusResDto rtnValue = new StatusResDto();
		
		rtnValue.setSuccess(false);
		List<LoyChnlGrpListReqDto> array = batchUpload.getArray();
		StringBuffer sql = new StringBuffer();

		sql.append("insert into LOY.LOY_CHNL_GRP_XM")
		.append("(")
		.append("  RID")
		.append(", CREATE_BY")
		.append(", MODIFY_BY")
		.append(", RID_CHNL_GRP")
		.append(", RID_CHNL")
		.append(", LVL_CD")
		.append(") values (")
		.append("  ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(")");

		
		int cntUpload = array.size();
		int uploadcnt = 0;
		List<Map<Integer,Object>> params = new ArrayList<Map<Integer,Object>>();
		for(LoyChnlGrpListReqDto lplr : batchUpload.getArray()) {
			    LoyChnlGrpListReqDto chnlList = new LoyChnlGrpListReqDto();
			    chnlList = loyChnlGrpMapper.selectChnlRidCheck(lplr);
				lplr.setChnlRid(chnlList.getRid());
				lplr.setChnlGrpRid(batchUpload.getChnlGrpRid());
				Integer cnt = loyChnlGrpMapper.selectChnlIdCheck(lplr);
				int idx = 1;
			if(cnt<=0) {
				Map<Integer,Object> param = new HashMap<Integer,Object>();
				
				// 이쯤 에다가 법정동주소데이터를 시도/시군구/법정동 기준으로 split해서 처리하는 로직을 짜넣으면 될
				
				param.put(idx++, StringUtil.convertNull(CommonUtil.newRid()));
				param.put(idx++, StringUtil.convertNull(batchUpload.getCreateBy(),""));
				param.put(idx++, StringUtil.convertNull(batchUpload.getModifyBy(),""));
				param.put(idx++, StringUtil.convertNull(batchUpload.getChnlGrpRid(),""));
				param.put(idx++, StringUtil.convertNull(chnlList.getRid(),""));
				param.put(idx++, StringUtil.convertNull(chnlList.getLvlCd(),""));
				params.add(param);
				uploadcnt++;
			}
		}
		int duplCnt = cntUpload-uploadcnt;
		addBatchService.addBatch(sql.toString(), params);
		
		//Integer prodXmCnt = loyChnlGrpMapper.selectProdXmCnt(batchUpload);
		//batchUpload.setGrpCnt(prodXmCnt);
		//loyChnlGrpMapper.updateProdXmCnt(batchUpload);
		
		rtnValue.setSuccess(true);
		rtnValue.setMessage("총 : "+cntUpload+"건, 정상입력 : "+uploadcnt+", 중복제외 : "+duplCnt+"건");

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: addProdItem
	  * 2. 클래스명: LoyProdGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 14.
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
	
	public StatusResDto addChnlItem(LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		
		StatusResDto rtnValue = new StatusResDto();
		int addCnt=0;
		int addAllCnt = bccr.getRidList().size();
		if(ObjectUtil.isNotEmpty(bccr.getRidList())) {
			for(LoyChnlGrpListReqDto chnlList : bccr.getRidList()) {
				chnlList.setChnlGrpRid(bccr.getChnlGrpRid());
				Integer cnt = loyChnlGrpMapper.selectChnlIdCheck(chnlList);
				if(cnt<=0) {
					chnlList.setModifyBy(bccr.getModifyBy());
					chnlList.setCreateBy(bccr.getCreateBy());
					chnlList.setChnlGrpRid(bccr.getChnlGrpRid());
					chnlList.setRid(CommonUtil.newRid());
					loyChnlGrpMapper.insertChnlItem(chnlList);
					addCnt++;
				}
			}
		}
		int addResutCnt = addAllCnt - addCnt;
		
		rtnValue.setMessage("총 : "+addAllCnt+"건, 정상입력 : "+addCnt+", 중복제외 : "+addResutCnt+"건");
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeChnlGrp
	  * 2. 클래스명: LoyChnlGrpService
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
	
	public StatusResDto removeChnlGrp(LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyChnlGrpMapper.deleteChnlGrp(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: addChnlExc
	  * 2. 클래스명: LoyChnlGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 21.
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
	
	public StatusResDto addChnlExc(LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		
		StatusResDto rtnValue = new StatusResDto();
		int addCnt=0;
		int addAllCnt = bccr.getRidList().size();
		if(ObjectUtil.isNotEmpty(bccr.getRidList())) {
			for(LoyChnlGrpListReqDto chnlList : bccr.getRidList()) {
				chnlList.setChnlGrpRid(bccr.getChnlGrpRid());
				Integer cnt = loyChnlGrpMapper.selectChnlExcIdCheck(chnlList);
				if(cnt<=0) {
					chnlList.setModifyBy(bccr.getModifyBy());
					chnlList.setCreateBy(bccr.getCreateBy());
					chnlList.setChnlGrpRid(bccr.getChnlGrpRid());
					chnlList.setRid(CommonUtil.newRid());
					loyChnlGrpMapper.insertChnlExc(chnlList);
					addCnt++;
				}
			}
		}
		int addResutCnt = addAllCnt - addCnt;
		
		rtnValue.setMessage("총 : "+addAllCnt+"건, 정상입력 : "+addCnt+", 중복제외 : "+addResutCnt+"건");
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeChnlExc
	  * 2. 클래스명: LoyChnlGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 21.
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
	
	public StatusResDto removeChnlExc(LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyChnlGrpMapper.deleteChnlExc(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeAllTChnlExc
	  * 2. 클래스명: LoyChnlGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 21.
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
	
	public StatusResDto removeAllTChnlExc(LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyChnlGrpMapper.deleteAllTChnlExc(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getChnlExcList
	  * 2. 클래스명: LoyChnlGrpService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 21.
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
	
	public GridPagingResDto<LoyChnlGrpItemListResDto> getChnlExcList(LoyChnlGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<LoyChnlGrpItemListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyChnlGrpMapper.selectChnlExcList(bccr),AnnotationType.ALL
				);
	}
}	
