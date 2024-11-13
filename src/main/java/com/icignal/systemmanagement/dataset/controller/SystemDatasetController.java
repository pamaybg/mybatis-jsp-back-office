/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemDatasetController.java
 * 2. Package	: com.icignal.systemmanagement.dataset.controller
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 16. 오전 10:28:28
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 16.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.dataset.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.dataset.dto.request.SystemDatasetDetailReqDto;
import com.icignal.systemmanagement.dataset.dto.request.SystemDatasetItemReqDto;
import com.icignal.systemmanagement.dataset.dto.request.SystemDatasetMasterReqDto;
import com.icignal.systemmanagement.dataset.dto.response.SystemDatasetItemListResDto;
import com.icignal.systemmanagement.dataset.dto.response.SystemDatasetListResDto;
import com.icignal.systemmanagement.dataset.dto.response.SystemGetDatasetListResDto;
import com.icignal.systemmanagement.dataset.service.SystemDatasetService;


/*
 * 1. 클래스명	: SystemDatasetController
 * 2. 파일명	: SystemDatasetController.java
 * 3. 패키지명	: com.icignal.systemmanagement.dataset.controller
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/system/dataset")
public class SystemDatasetController extends BaseController{
	
	@Autowired
	public SystemDatasetService SystemDatasetService;
	
	@Autowired
	public AuthHelper authHelper;

	@RequestMapping(value="/getDataSetMasterList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemDatasetListResDto> getDataSetMasterList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDatasetMasterReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		scl.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return SystemDatasetService.getDataSetMasterList(scl);
	}
	
	@RequestMapping(value="/removeDataSet.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeDataSet(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDatasetMasterReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		scl.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return SystemDatasetService.removeDataSet(scl);
	}
	
	@RequestMapping(value="/getDataSetItem.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemDatasetItemListResDto> getDataSetItem(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDatasetMasterReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		scl.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return SystemDatasetService.getDataSetItem(scl);
	}
	
	@RequestMapping(value="/getDataSetDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemDatasetListResDto getDataSetDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDatasetMasterReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		scl.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return SystemDatasetService.getDataSetDetail(scl);
	}
	
	@RequestMapping(value="/saveDataSet.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveDataSet(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDatasetDetailReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		scl.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return SystemDatasetService.saveDataSet(scl);
	}
	
	@RequestMapping(value="/modifyDataSet.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyDataSet(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDatasetDetailReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		scl.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return SystemDatasetService.modifyDataSet(scl);
	}
	
	@RequestMapping(value="/getDataSetItemDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemDatasetItemListResDto getDataSetItemDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDatasetMasterReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		scl.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return SystemDatasetService.getDataSetItemDetail(scl);
	}
	
	@RequestMapping(value="/saveDataSetItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveDataSetItem(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDatasetItemReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		scl.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return SystemDatasetService.saveDataSetItem(scl);
	}
	
	@RequestMapping(value="/modifyDataSetItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyDataSetItem(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDatasetItemReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		scl.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return SystemDatasetService.modifyDataSetItem(scl);
	}
	
	@RequestMapping(value="/removeDataSetItem.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeDataSetItem(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDatasetItemReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		scl.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return SystemDatasetService.removeDataSetItem(scl);
	}
	
	@RequestMapping(value="/getSysDataSetList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemGetDatasetListResDto> getSysDataSetList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDatasetMasterReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		scl.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return SystemDatasetService.getDataSetList(scl);
	}
	@RequestMapping(value="/getDataItemSetList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemGetDatasetListResDto> getDataItemSetList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDatasetMasterReqDto scl) {
		LogUtil.param(this.getClass(),scl);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		scl.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return SystemDatasetService.getDataItemSetList(scl);
	}
	
	/**
	 * @name : getSrcQuery
	 * @date : 2021. 1. 28.
	 * @author : jb.kim
	 * @return : 
	 * @description : [데이터셋 > 상세] 테이블소스 확인 팝업('소스보기') 실행 시 해당 소스쿼리를 조회하는 컨트롤러 
	 */
	@RequestMapping(value = "/getSrcQuery.do", method = RequestMethod.POST)
	public @ResponseBody SystemGetDatasetListResDto getSrcQuery(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDatasetMasterReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return SystemDatasetService.getSrcQuery(reqDto);
	}
	

}
