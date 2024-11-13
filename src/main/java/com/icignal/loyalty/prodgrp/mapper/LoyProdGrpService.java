/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyProdGrpService.java
 * 2. Package	: com.icignal.loyalty.prodgrp.mapper
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 13. 오후 5:31:09
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 13.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.prodgrp.mapper;

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
import com.icignal.loyalty.prodgrp.dto.request.LoyCategoryGrpListReqDto;
import com.icignal.loyalty.prodgrp.dto.request.LoyProdGrpDetailReqDto;
import com.icignal.loyalty.prodgrp.dto.request.LoyProdGrpListReqDto;
import com.icignal.loyalty.prodgrp.dto.response.LoyCategoryListResDto;
import com.icignal.loyalty.prodgrp.dto.response.LoyProdGrpDetailResDto;
import com.icignal.loyalty.prodgrp.dto.response.LoyProdGrpItemListResDto;
import com.icignal.loyalty.prodgrp.dto.response.LoyProdGrpListResDto;
import com.icignal.loyalty.prodgrp.dto.response.LoyProdGrpResDto;

/*
 * 1. 클래스명	: LoyProdGrpService
 * 2. 파일명	: LoyProdGrpService.java
 * 3. 패키지명	: com.icignal.loyalty.prodgrp.mapper
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyProdGrpService {
	
	@Autowired
	private LoyProdGrpMapper loyProdGrpMapper;
	
	@Autowired
	private AddBatchService addBatchService;
	
	 /*
	  * 1. 메소드명: getProdGrpList
	  * 2. 클래스명: LoyProdGrpService
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
	
	public GridPagingResDto<LoyProdGrpListResDto> getProdGrpList(LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<LoyProdGrpListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyProdGrpMapper.selectProdGrpList(bccr),AnnotationType.CommCode
				);
	}

	 /*
	  * 1. 메소드명: getProdGrpDetail
	  * 2. 클래스명: LoyProdGrpService
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
	
	public LoyProdGrpDetailResDto getProdGrpDetail(LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return loyProdGrpMapper.selectProdGrpDetail(bccr);
	}

	 /*
	  * 1. 메소드명: saveProdGrpDetail
	  * 2. 클래스명: LoyProdGrpService
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
	
	public StatusResDto saveProdGrpDetail(LoyProdGrpDetailReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		LoyProdGrpResDto rtnValue = new LoyProdGrpResDto();
		bccr.setRid(CommonUtil.newRid());
		rtnValue.setRid(bccr.getRid());
		loyProdGrpMapper.insertProdGrpDetail(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	public StatusResDto modifyProdGrpDetail(LoyProdGrpDetailReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyProdGrpMapper.updateProdGrpDetail(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getProdItemList
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
	
	public GridPagingResDto<LoyProdGrpItemListResDto> getProdItemList(LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<LoyProdGrpItemListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyProdGrpMapper.selectProdItemList(bccr),AnnotationType.Nothing
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
	
	public StatusResDto removeAllTProdItem(LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyProdGrpMapper.deleteAllTProdItem(bccr);
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
	
	public StatusResDto removeProdItem(LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyProdGrpMapper.deleteProdItem(bccr);
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
	
	public StatusResDto insertProdList(LoyProdGrpListReqDto batchUpload) {
		StatusResDto rtnValue = new StatusResDto();
		
		rtnValue.setSuccess(false);
		List<LoyProdGrpListReqDto> array = batchUpload.getArray();
		StringBuffer sql = new StringBuffer();
		sql.append("insert into LOY.LOY_PROD_GRP_XM")
		.append("(")
		.append("  RID")
		.append(", CREATE_BY")
		.append(", MODIFY_BY")
		.append(", RID_PROD_GRP")
		.append(", RID_PROD")
		.append(") values (")
		.append("  ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(")");

		
		int cntUpload = array.size();
		int uploadcnt = 0;
		List<Map<Integer,Object>> params = new ArrayList<Map<Integer,Object>>();
		for(LoyProdGrpListReqDto lplr : batchUpload.getArray()) {
				String prodRid = loyProdGrpMapper.selectProdRidCheck(lplr);
				lplr.setProdRid(prodRid);
				lplr.setProdGrpRid(batchUpload.getProdGrpRid());
				Integer cnt = loyProdGrpMapper.selectProdIdCheck(lplr);
				int idx = 1;
			if(cnt<=0) {
				Map<Integer,Object> param = new HashMap<Integer,Object>();
				
				param.put(idx++, StringUtil.convertNull(CommonUtil.newRid()));
				param.put(idx++, StringUtil.convertNull(batchUpload.getCreateBy(),""));
				param.put(idx++, StringUtil.convertNull(batchUpload.getModifyBy(),""));
				param.put(idx++, StringUtil.convertNull(batchUpload.getProdGrpRid(),""));
				param.put(idx++, StringUtil.convertNull(prodRid,""));
				params.add(param);
				uploadcnt++;
			}
		}
		int duplCnt = cntUpload-uploadcnt;
		addBatchService.addBatch(sql.toString(), params);
		
		//Integer prodXmCnt = loyProdGrpMapper.selectProdXmCnt(batchUpload);
		//batchUpload.setGrpCnt(prodXmCnt);
		//loyProdGrpMapper.updateProdXmCnt(batchUpload);
		
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
	
	public StatusResDto addProdItem(LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		
		StatusResDto rtnValue = new StatusResDto();
		int addCnt=0;
		int addAllCnt = bccr.getRidList().size();
		if(ObjectUtil.isNotEmpty(bccr.getRidList())) {
			for(LoyProdGrpListReqDto prodList : bccr.getRidList()) {
				prodList.setProdGrpRid(bccr.getProdGrpRid());
				Integer cnt = loyProdGrpMapper.selectProdIdCheck(prodList);
				if(cnt<=0) {
					prodList.setModifyBy(bccr.getModifyBy());
					prodList.setCreateBy(bccr.getCreateBy());
					prodList.setProdGrpRid(bccr.getProdGrpRid());
					prodList.setRid(CommonUtil.newRid());
					loyProdGrpMapper.insertProdItem(prodList);
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
	  * 1. 메소드명: getCategoryList
	  * 2. 클래스명: LoyProdGrpService
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
	
	public GridPagingResDto<LoyCategoryListResDto> getCategoryList(LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<LoyCategoryListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyProdGrpMapper.selectCategoryList(bccr),AnnotationType.Nothing
				);
	}

	 /*
	  * 1. 메소드명: insertCategoryList
	  * 2. 클래스명: LoyProdGrpService
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
	 *   @param br
	 *   @return	
	 */
	
	public StatusResDto insertCategoryList(LoyCategoryGrpListReqDto batchUpload) {
		StatusResDto rtnValue = new StatusResDto();
		
		rtnValue.setSuccess(false);
		List<LoyCategoryGrpListReqDto> array = batchUpload.getArray();
		StringBuffer sql = new StringBuffer()
		.append("insert into LOY.LOY_PROD_GRP_XM")
		.append("(")
		.append("  RID")
		.append(", CREATE_BY")
		.append(", MODIFY_BY")
		.append(", RID_PROD_GRP")
		.append(", RID_CATEGORY")
		.append(") values (")
		.append("  ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(")");
		
		int cntUpload = array.size();
		int uploadcnt = 0;
		List<Map<Integer,Object>> params = new ArrayList<Map<Integer,Object>>();
		for(LoyCategoryGrpListReqDto lplr : batchUpload.getArray()) {
				String catRid = loyProdGrpMapper.selectCatRidCheck(lplr);
				lplr.setCatRid(catRid);
				lplr.setProdGrpRid(batchUpload.getProdGrpRid());
				Integer cnt = loyProdGrpMapper.selectCatIdCheck(lplr);
				int idx = 1;
			if(cnt<=0) {
				Map<Integer,Object> param = new HashMap<Integer,Object>();
				
				param.put(idx++, StringUtil.convertNull(CommonUtil.newRid()));
				param.put(idx++, StringUtil.convertNull(batchUpload.getCreateBy(),""));
				param.put(idx++, StringUtil.convertNull(batchUpload.getModifyBy(),""));
				param.put(idx++, StringUtil.convertNull(batchUpload.getProdGrpRid(),""));
				param.put(idx++, StringUtil.convertNull(catRid,""));
				params.add(param);
				uploadcnt++;
			}
		}
		int duplCnt = cntUpload-uploadcnt;
		addBatchService.addBatch(sql.toString(), params);
		
		//Integer prodXmCnt = loyProdGrpMapper.selectProdXmCnt(batchUpload);
		//batchUpload.setGrpCnt(prodXmCnt);
		//loyProdGrpMapper.updateProdXmCnt(batchUpload);
		
		rtnValue.setSuccess(true);
		rtnValue.setMessage("총 : "+cntUpload+"건, 정상입력 : "+uploadcnt+", 중복제외 : "+duplCnt+"건");
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeCategory
	  * 2. 클래스명: LoyProdGrpService
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
	
	public StatusResDto removeCategory(LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyProdGrpMapper.deleteCategory(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeAllTCategory
	  * 2. 클래스명: LoyProdGrpService
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
	
	public StatusResDto removeAllTCategory(LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyProdGrpMapper.deleteAllTCategory(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: addCategory
	  * 2. 클래스명: LoyProdGrpService
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
	
	public StatusResDto addCategory(LoyCategoryGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		
		StatusResDto rtnValue = new StatusResDto();
		int addCnt=0;
		int addAllCnt = bccr.getRidList().size();
		if(ObjectUtil.isNotEmpty(bccr.getRidList())) {
			for(LoyCategoryGrpListReqDto prodList : bccr.getRidList()) {
				prodList.setProdGrpRid(bccr.getProdGrpRid());
				Integer cnt = loyProdGrpMapper.selectCatIdCheck(prodList);
				if(cnt<=0) {
					prodList.setModifyBy(bccr.getModifyBy());
					prodList.setCreateBy(bccr.getCreateBy());
					prodList.setProdGrpRid(bccr.getProdGrpRid());
					prodList.setRid(CommonUtil.newRid());
					loyProdGrpMapper.insertCategoryItem(prodList);
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
	  * 1. 메소드명: removeProdGrp
	  * 2. 클래스명: LoyProdGrpService
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
	
	public StatusResDto removeProdGrp(LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(),bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyProdGrpMapper.deleteProdGrp(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	public GridPagingResDto<LoyProdGrpItemListResDto> getProdListItemPop(LoyProdGrpListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<LoyProdGrpItemListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyProdGrpMapper.getProdListItemPop(bccr),AnnotationType.Nothing
				);
	}
	
	public GridPagingResDto<LoyProdGrpItemListResDto> getGiftsPopList(LoyProdGrpListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyProdGrpItemListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyProdGrpMapper.getGiftsPopList(reqDto), AnnotationType.CommCode);
	}

	 
}
