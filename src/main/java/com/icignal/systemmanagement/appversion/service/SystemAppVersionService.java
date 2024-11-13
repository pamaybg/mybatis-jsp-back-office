/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: AppVersionService.java
 * 2. Package	: com.icignal.systemmanagement.appversion.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 10. 오후 4:31:56
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 10.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.appversion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.appversion.dto.request.SystemAppVerDetailReqDto;
import com.icignal.systemmanagement.appversion.dto.request.SystemAppVerInsertReqDto;
import com.icignal.systemmanagement.appversion.dto.request.SystemAppVerListReqDto;
import com.icignal.systemmanagement.appversion.dto.response.SystemAppVerDetailResDto;
import com.icignal.systemmanagement.appversion.dto.response.SystemAppVerListResDto;
import com.icignal.systemmanagement.appversion.mapper.SystemAppVersionMapper;

/*
 * 1. 클래스명	: AppVersionService
 * 2. 파일명	: AppVersionService.java
 * 3. 패키지명	: com.icignal.systemmanagement.appversion.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class SystemAppVersionService {
	
	@Autowired
	private SystemAppVersionMapper appVersionMapper;

	
	/**
	 * @name : getAppVerList
	 * @date : 2017. 03. 27
	 * @author : mjpyo
	 * @description : appVer 리스트
	 */
	public GridPagingResDto<SystemAppVerListResDto> getAppVerList(SystemAppVerListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("mv");
		return new GridPagingResHelper<SystemAppVerListResDto>().newGridPagingResDto(
				 reqDTO.init(CommonUtil.getInstance().getDBType()),
	    		 appVersionMapper.selectAppVerList(reqDTO));
	}

	/**
	 * @name : insertAppVer
	 * @date : 2017. 03. 28
	 * @author : mjpyo
	 * @description : appVer 등록
	 */
	public StatusResDto insertAppVer(SystemAppVerInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		if(reqDTO.getUpdateFlag()){
			appVersionMapper.updateAppVersion(reqDTO);
			rtnValue.setSuccess(true);
		}
		else{
			reqDTO.setAppVerId(CommonUtil.newRid());
			appVersionMapper.insertAppVersion(reqDTO);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getAppDetail
	  * 2. 클래스명: SystemAppVersionService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public SystemAppVerDetailResDto getAppDetail(SystemAppVerDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("mv");
		
		return appVersionMapper.selectAppDetail(reqDTO);
	}
}
