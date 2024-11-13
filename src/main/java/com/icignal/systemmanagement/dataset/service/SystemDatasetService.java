/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: systemDatasetService.java
 * 2. Package	: com.icignal.systemmanagement.dataset.service
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 16. 오전 10:29:24
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 16.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.dataset.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.dataset.dto.request.SystemDatasetDetailReqDto;
import com.icignal.systemmanagement.dataset.dto.request.SystemDatasetItemReqDto;
import com.icignal.systemmanagement.dataset.dto.request.SystemDatasetMasterReqDto;
import com.icignal.systemmanagement.dataset.dto.response.SystemDatasetItemListResDto;
import com.icignal.systemmanagement.dataset.dto.response.SystemDatasetListResDto;
import com.icignal.systemmanagement.dataset.dto.response.SystemGetDatasetListResDto;
import com.icignal.systemmanagement.dataset.mapper.SystemDatasetMapper;

/*
 * 1. 클래스명	: systemDatasetService
 * 2. 파일명	: systemDatasetService.java
 * 3. 패키지명	: com.icignal.systemmanagement.dataset.service
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class SystemDatasetService {
	
	@Autowired
	public SystemDatasetMapper SystemDatasetMapper;

	 /*
	  * 1. 메소드명: getDataSetMasterList
	  * 2. 클래스명: SystemDatasetService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scl
	 *   @return	
	 */
	
	public GridPagingResDto<SystemDatasetListResDto> getDataSetMasterList(SystemDatasetMasterReqDto mlr) {
		LogUtil.param(this.getClass(), mlr);
		
		return new GridPagingResHelper<SystemDatasetListResDto>().newGridPagingResDto(
				mlr.init(CommonUtil.getInstance().getDBType()),
				SystemDatasetMapper.selectDataSetMasterList(mlr), AnnotationType.CommCode
				);
	}

	 /*
	  * 1. 메소드명: removeDataSet
	  * 2. 클래스명: SystemDatasetService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scl
	 *   @return	
	 */
	
	public StatusResDto removeDataSet(SystemDatasetMasterReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		SystemDatasetMapper.deleteDataSet(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getDataSetItem
	  * 2. 클래스명: SystemDatasetService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scl
	 *   @return	
	 */
	
	public GridPagingResDto<SystemDatasetItemListResDto> getDataSetItem(SystemDatasetMasterReqDto mlr) {
		LogUtil.param(this.getClass(), mlr);
		
		return new GridPagingResHelper<SystemDatasetItemListResDto>().newGridPagingResDto(
				mlr.init(CommonUtil.getInstance().getDBType()),
				SystemDatasetMapper.selectDataSetItem(mlr), AnnotationType.Nothing
				);
	}

	 /*
	  * 1. 메소드명: getDataSetDetail
	  * 2. 클래스명: SystemDatasetService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scl
	 *   @return	
	 */
	
	public SystemDatasetListResDto getDataSetDetail(SystemDatasetMasterReqDto scl) {
		LogUtil.param(this.getClass(), scl);
		
		return SystemDatasetMapper.selectDataSetDetail(scl);
		
	}

	 /*
	  * 1. 메소드명: saveDataSet
	  * 2. 클래스명: SystemDatasetService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scl
	 *   @return	
	 */
	
	public StatusResDto saveDataSet(SystemDatasetDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		reqDto.setRid(CommonUtil.newRid());
		SystemDatasetMapper.insertDataSet(reqDto);
		rtnValue.setSuccess(true);
		rtnValue.setMessage(reqDto.getRid());

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyDataSet
	  * 2. 클래스명: SystemDatasetService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scl
	 *   @return	
	 */
	
	public StatusResDto modifyDataSet(SystemDatasetDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		SystemDatasetMapper.updateDataSet(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getDataSetItemDetail
	  * 2. 클래스명: SystemDatasetService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scl
	 *   @return	
	 */
	
	public SystemDatasetItemListResDto getDataSetItemDetail(SystemDatasetMasterReqDto scl) {
		LogUtil.param(this.getClass(), scl);
		
		return SystemDatasetMapper.selectDataSetItemDetail(scl);
	}

	 /*
	  * 1. 메소드명: saveDataSetItem
	  * 2. 클래스명: SystemDatasetService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scl
	 *   @return	
	 */
	
	public StatusResDto saveDataSetItem(SystemDatasetItemReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		reqDto.setRid(CommonUtil.newRid());
		SystemDatasetMapper.insertDataSetItem(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyDataSetItem
	  * 2. 클래스명: SystemDatasetService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scl
	 *   @return	
	 */
	
	public StatusResDto modifyDataSetItem(SystemDatasetItemReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		SystemDatasetMapper.updateDataSetItem(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeDataSetItem
	  * 2. 클래스명: SystemDatasetService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scl
	 *   @return	
	 */
	
	public StatusResDto removeDataSetItem(SystemDatasetItemReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		SystemDatasetMapper.deleteDataSetItem(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}
	
	public GridPagingResDto<SystemGetDatasetListResDto> getDataSetList(SystemDatasetMasterReqDto mlr) {
		LogUtil.param(this.getClass(), mlr);
		
		return new GridPagingResHelper<SystemGetDatasetListResDto>().newGridPagingResDto(
				mlr.init(CommonUtil.getInstance().getDBType()),
				SystemDatasetMapper.getDataSetList(mlr), AnnotationType.CommCode
				);
	}
	public GridPagingResDto<SystemGetDatasetListResDto> getDataItemSetList(SystemDatasetMasterReqDto mlr) {
		LogUtil.param(this.getClass(), mlr);
		
		return new GridPagingResHelper<SystemGetDatasetListResDto>().newGridPagingResDto(
				mlr.init(CommonUtil.getInstance().getDBType()),
				SystemDatasetMapper.getDataItemSetList(mlr), AnnotationType.CommCode
				);
	}
	
	/*
	  * 1. 메소드명: getSrcQuery
	  * 2. 클래스명: SystemDatasetService
	  * 3. 작성자명: jb.kim 
	  * 4. 작성일자: 2021. 1. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 : 데이터셋 > 상세 화면에서 '소스보기'버튼 클릭으로 테이블 소스보는 팝업을 열 시 해당 소스쿼리를 조회하는 메소드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	*/
	public SystemGetDatasetListResDto getSrcQuery(SystemDatasetMasterReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return SystemDatasetMapper.getSrcQuery(reqDto);
	}
	
}
