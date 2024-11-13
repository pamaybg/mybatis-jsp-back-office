package com.icignal.systemmanagement.outtable.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.outtable.dto.request.SystemColTypeReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteChnlRelReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteColConChnlRelReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteOutColumnReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteOutTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteOutTgtLvlReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteTvlConTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemEditOutColumnReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemEditOutTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemEditOutTgtLvlReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetChannelListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetChannelRelListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetDetailOutColumnReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetDetailOutTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetDetailOutTgtLvlReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetEmailHostListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetFtpConnectListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetOutColumnListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetOutTableListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetOutTgtLvllListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetPermissionListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetWebServiceListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemSetChnlRelReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemSetOutColumnReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemSetOutTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemSetOutTgtLvlReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemTableTypeCheckReqDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetChannelListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetChannelRelListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetDetailOutColumnlResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetDetailOutTalbleResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetDetailOutTgtLvllResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetEmailHostListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetFtpConnectListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetOutColumnListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetOutTalbleListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetOutTgtLvllListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetPermissionListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetWebServiceListResDto;
import com.icignal.systemmanagement.outtable.service.SystemOutTableService;

/*
 * 1. 클래스명	: SystemOutTableController
 * 2. 파일명	: SystemOutTableController.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.controller
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 9. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - 외부 테이블 관리 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/marketing/outTable")
public class SystemOutTableController extends BaseController {
	
	@Autowired
	private SystemOutTableService systemOutTableService;
	
	@Autowired
	private StandardPBEStringEncryptor encrypor;
	
	@Autowired
	AuthHelper authHelper;
	
	/**
	 * @programId : MKT_ADM_005
	 * @name : getchannel
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : comm_code
	 * @return : GridPagingResDto
	 * @description : 채널 목록 조회
	 */
	@RequestMapping(value = "/getchannel.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemGetChannelListResDto> getchannel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetChannelListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		
		return systemOutTableService.getchannel(mor);
	}
	
	/**
	 * @programId : MKT_ADM_005
	 * @name : getchannelrel
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TARGET_LEVEL
	 * @return : GridPagingResDto
	 * @description : 채널 관계 테이블 조회
	 */
	@RequestMapping(value = "/getchannelrel.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemGetChannelRelListResDto> getchannelrel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetChannelRelListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getchannelrel(mor);
	}
	
	/**
	 * @programId : MKT_ADM_005
	 * @name : getpermissionList
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TARGET_LEVEL
	 * @return : GridPagingResDto
	 * @description : 퍼미션 테이블 컬럼 목록 조회
	 */
	@RequestMapping(value = "/getpermissionList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemGetPermissionListResDto> getpermissionList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetPermissionListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getpermissionList(mor);
	}
	
	
	/**
	 * @programId : MKT_ADM_004 
	 * @name : getTgtLevelList
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TARGET_LEVEL
	 * @return : GridPagingResDto
	 * @description : 외부 타겟 레벨 리스트 조회
	 */
	@RequestMapping(value = "/getTgtLevelList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemGetOutTgtLvllListResDto> getTgtLevelList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetOutTgtLvllListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getTgtLevelList(mor);
	}

	/**
	 * @programId : MKT_ADM_004
	 * @name : getTableList
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TBL
	 * @return : GridPagingResDto
	 * @description : 외부 테이블 리스트 조회
	 */
	@RequestMapping(value = "/getTableList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemGetOutTalbleListResDto> getTableList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetOutTableListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getTableList(mor);
	}
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : getcolumnList
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : GridPagingResDto
	 * @description : 외부 컬럼 리스트 조회
	 */
	@RequestMapping(value = "/getcolumnList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemGetOutColumnListResDto> getcolumnList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetOutColumnListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getcolumnList(mor);
	}
	
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : setOutColumn
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : GridPagingResDto
	 * @description : 컬럼 추가
	 */
	@RequestMapping(value = "/setOutColumn.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto setOutColumn(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemSetOutColumnReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		mor.setMemId(loginInfo.getId());
		
		return systemOutTableService.setOutColumn(mor);
	}
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : setOutTable
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TBL
	 * @return : GridPagingResDto
	 * @description : 외부 테이블 추가
	 */
	@RequestMapping(value = "/setOutTable.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto setOutTable(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemSetOutTableReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		mor.setMemId(loginInfo.getId());
		
		return systemOutTableService.setOutTable(mor);
	}
	
	/**
	 * @programId : MKT_ADM_004 
	 * @name : setTgtLevel
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TARGET_LEVEL
	 * @return : GridPagingResDto
	 * @description : 외부 타겟 레벨 추가
	 */
	@RequestMapping(value = "/setTgtLevel.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto setTgtLevel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemSetOutTgtLvlReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		mor.setMemId(loginInfo.getId());
		
		return systemOutTableService.setTgtLevel(mor);
	}
	
	
	
	/**
	 * @programId : MKT_ADM_004 
	 * @name : getDtlTgtLevel
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TARGET_LEVEL
	 * @return : GridPagingResDto
	 * @description : 외부 타겟 레벨 상세 조회
	 */
	@RequestMapping(value = "/getDtlTgtLevel.do", method = RequestMethod.POST)
	public @ResponseBody
	SystemGetDetailOutTgtLvllResDto getDtlTgtLevel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetDetailOutTgtLvlReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getDtlTgtLevel(mor);
	}
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : getDtlTable
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TBL
	 * @return : GridPagingResDto
	 * @description : 외부 테이블 상세 조회
	 */
	@RequestMapping(value = "/getDtlTable.do", method = RequestMethod.POST)
	public @ResponseBody
	SystemGetDetailOutTalbleResDto getDtlTable(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetDetailOutTableReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getDtlTable(mor);
	}
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : getcolumnList
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : GridPagingResDto
	 * @description : 외부 컬럼 상세 조회
	 */
	@RequestMapping(value = "/getDtlcolumn.do", method = RequestMethod.POST)
	public @ResponseBody
	SystemGetDetailOutColumnlResDto getDtlcolumn(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetDetailOutColumnReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getDtlcolumn(mor);
	}
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : deleteOutTgtLvl
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : StatusResDto
	 * @description : 외부 타겟 레벨 삭제
	 */
	@RequestMapping(value = "/removeOutTgtLvl.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeOutTgtLvl(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDeleteOutTgtLvlReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		mdtl.setMemId(loginInfo.getId());

		return systemOutTableService.removeOutTgtLvl(mdtl);
	}
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : deleteOutColumn
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : StatusResDto
	 * @description : 외부 컬럼 삭제
	 */
	@RequestMapping(value = "/removeOutColumn.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeOutColumn(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDeleteOutColumnReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		mdtl.setMemId(loginInfo.getId());

		return systemOutTableService.removeOutColumn(mdtl);
	}
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : deleteOutTbl
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : StatusResDto
	 * @description : 외부 테이블 삭제
	 */
	@RequestMapping(value = "/removeOutTbl.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeOutTbl(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDeleteOutTableReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		mdtl.setMemId(loginInfo.getId());

		return systemOutTableService.removeOutTbl(mdtl);
	}
	
	
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : editOutTgtLvl
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : StatusResDto
	 * @description : 외부 타겟 레벨 수정
	 */
	@RequestMapping(value = "/editOutTgtLvl.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto editOutTgtLvl(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemEditOutTgtLvlReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		mdtl.setMemId(loginInfo.getId());

		return systemOutTableService.editOutTgtLvl(mdtl);
	}
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : editOutColumn
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : StatusResDto
	 * @description : 외부 컬럼 수정
	 */
	@RequestMapping(value = "/editOutColumn.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto editOutColumn(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemEditOutColumnReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		mdtl.setMemId(loginInfo.getId());

		return systemOutTableService.editOutColumn(mdtl);
	}
	
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : editOutTbl
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : StatusResDto
	 * @description : 외부 테이블 수정
	 */
	@RequestMapping(value = "/editOutTbl.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto editOutTbl(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemEditOutTableReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		mdtl.setMemId(loginInfo.getId());

		return systemOutTableService.editOutTbl(mdtl);
	}
	
	
	/**
	 * @programId : MKT_ADM_005
	 * @name : setChnlRel
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL_chnl_rel
	 * @return : StatusResDto
	 * @description : 챈러 관계 수정
	 */
	@RequestMapping(value = "/setChnlRel.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto setChnlRel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemSetChnlRelReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		mdtl.setMemId(loginInfo.getId());
		
		return systemOutTableService.setChnlRel(mdtl);
	}
	
	
	/**
	 * @programId : MKT_ADM_005
	 * @name : removeChnlRel
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL_chnl_rel
	 * @return : StatusResDto
	 * @description : 채널 관꼐 삭제
	 */
	@RequestMapping(value = "/removeChnlRel.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeChnlRel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDeleteChnlRelReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);

		return systemOutTableService.removeChnlRel(mdtl);
	}
	
	/**
	 * @programId : MKT_ADM_005
	 * @name : getcolCountCheck
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL_chnl_rel
	 * @return : StatusResDto
	 * @description : 컬럼 타입 체크
	 */
	@RequestMapping(value = "/getcolCountCheck.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto getcolCountCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemColTypeReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getcolCountCheck(mdtl);
	}
	
	
	/**
	 * @programId : MKT_ADM_005
	 * @name : getTblcountCheck
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TBL
	 * @return : StatusResDto
	 * @description : 테이블 카운트 체크
	 */
	@RequestMapping(value = "/getTblcountCheck.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto getTblcountCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemTableTypeCheckReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getTblcountCheck(mdtl);
	}
	
	
	
	/**
	 * @programId : MKT_ADM_005
	 * @name : removeColConChnlRel
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL_chnl_rel
	 * @return : StatusResDto
	 * @description : 채널 관계 삭제
	 */
	@RequestMapping(value = "/removeColConChnlRel.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeColConChnlRel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDeleteColConChnlRelReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.removeColConChnlRel(mdtl);
	}
	
	/**
	 * @programId : MKT_ADM_005
	 * @name : removeTblConCol
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : StatusResDto
	 * @description : 테이블 하위 컬럼 삭제
	 */
//	@RequestMapping(value = "/removeTblConCol.do", method = RequestMethod.POST)
//	public @ResponseBody
//	StatusResDto removeTblConCol(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDeleteTblConColReqDto mdtl) {
//		LogUtil.param(SystemOutTableController.class, mdtl);
//		
//		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
//		authHelper.checkLoginSession(request, response);
//		
//		return systemOutTableService.removeTblConCol(mdtl);
//	}
	
	
	/**
	 * @programId : MKT_ADM_005
	 * @name : removeTvlConTable
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TBL
	 * @return : StatusResDto
	 * @description : 타겟레벨 하위 테이블 삭제
	 */
	@RequestMapping(value = "/removeTvlConTable.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeTvlConTable(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDeleteTvlConTableReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);

		return systemOutTableService.removeTvlConTable(mdtl);
	}
	
	/**
	 * @programId : 
	 * @name : getFtpConnect
	 * @date : 2016. 04. 04
	 * @author : 송원희
	 * @table : COM_EXTR_FTP
	 * @return : GridPagingResDto
	 * @description : 외부 테이블 FTP 리스트 조회
	 */
	@RequestMapping(value = "/getFtpConnect.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemGetFtpConnectListResDto> getFtpConnect(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetFtpConnectListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getFtpConnect(mor);
	}
	
	/**
	 * @programId : 
	 * @name : getFtpConnect
	 * @date : 2020. 08. 31
	 * @author : 서정횐
	 * @table : 
	 * @return : GridPagingResDto
	 * @description : 외부 테이블 이메일 호스트 정보 조회
	 */
	@RequestMapping(value = "/getEmailHost.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemGetEmailHostListResDto> getEmailHost(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetEmailHostListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getEmailHost(mor);
	}
	
	/**
	 * @programId : 
	 * @name : getFtpConnect
	 * @date : 2020. 08. 31
	 * @author : 서정횐
	 * @table : 
	 * @return : GridPagingResDto
	 * @description : 외부 테이블 이메일 호스트 상세정보 조회
	 */
	@RequestMapping(value = "/getDetailEmailHost.do", method = RequestMethod.POST)
	public @ResponseBody
	SystemGetEmailHostListResDto getDetailEmailHost(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetEmailHostListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getDetailEmailHost(mor);
	}
	
	
	 /*
	  * 1. 메소드명: saveEmailHost
	  * 2. 클래스명: SystemOutTableController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	외부테이블 이메일 호스트 신규 등록	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mdtl
	 *   @return	
	 */
	@RequestMapping(value = "/saveEmailHost.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto saveEmailHost(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetEmailHostListReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		mdtl.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemOutTableService.saveEmailHost(mdtl);
	}
	
	/*
	  * 1. 메소드명: editemailHost
	  * 2. 클래스명: SystemOutTableController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	외부테이블 이메일 호스트 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mdtl
	 *   @return	
	 */
	@RequestMapping(value = "/editemailHost.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto editemailHost(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetEmailHostListReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		mdtl.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemOutTableService.editemailHost(mdtl);
	}
	
	 /*
	  * 1. 메소드명: removeEmailHost
	  * 2. 클래스명: SystemOutTableController
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	외부테이블 이메일호스트 삭제	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param mdtl
	 *   @return	
	 */
	@RequestMapping(value = "/removeEmailHost.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeEmailHost(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetEmailHostListReqDto mdtl) {
		LogUtil.param(SystemOutTableController.class, mdtl);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);

		return systemOutTableService.removeEmailHost(mdtl);
	}
	
	/**
	 * @programId : 
	 * @name : setFtpConnect
	 * @date : 2016. 04. 05
	 * @author : 송원희
	 * @table : COM_EXTR_FTP
	 * @return : StatusResDto
	 * @description : 외부 테이블 FTP 등록
	 */
	@RequestMapping(value = "/setFtpConnect.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto setFtpConnect(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetFtpConnectListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		mor.setMemId(loginInfo.getId());
		mor.setCon_pw( encrypor.encrypt( mor.getCon_pw() ) );
		
		return systemOutTableService.setFtpConnect(mor);
	}
	
	/**
	 * @programId : 
	 * @name : editFtpConnect
	 * @date : 2016. 04. 05
	 * @author : 송원희
	 * @table : COM_EXTR_FTP
	 * @return : StatusResDto
	 * @description : 외부 테이블 FTP 수정
	 */
	@RequestMapping(value = "/editFtpConnect.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto editFtpConnect(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetFtpConnectListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		mor.setMemId(loginInfo.getId());
		if("Y".equals( mor.getPwChk() )) {
			mor.setCon_pw( encrypor.encrypt( mor.getCon_pw() ) );
		}
		
		return systemOutTableService.editFtpConnect(mor);
	}
	
	/**
	 * @programId : 
	 * @name : removeFtpConnect
	 * @date : 2016. 04. 05
	 * @author : 송원희
	 * @table : COM_EXTR_FTP
	 * @return : StatusResDto
	 * @description : 외부 테이블 FTP 삭제
	 */
	@RequestMapping(value = "/removeFtpConnect.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeFtpConnect(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetFtpConnectListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		mor.setMemId(loginInfo.getId());
		
		return systemOutTableService.removeFtpConnect(mor);
	}
	/**
	 * @programId : 
	 * @name : getwebService
	 * @date : 2020. 12. 08
	 * @author :  LEE GYEONG YOUNG
	 * @table : 
	 * @return : GridPagingResDto
	 * @description : 외부 테이블 웹 서비스 조회
	 */
	@RequestMapping(value = "/getwebService.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<SystemGetWebServiceListResDto> getwebService(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetWebServiceListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getwebService(mor);
	}
	/**
	 * @programId : 
	 * @name : getwebServiceDetailPop
	 * @date : 2020. 12. 08
	 * @author :  LEE GYEONG YOUNG
	 * @table : 
	 * @return : GridPagingResDto
	 * @description : 외부 테이블 웹 서비스 조회
	 */
	@RequestMapping(value = "/getwebServiceDetailPop.do", method = RequestMethod.POST)
	public @ResponseBody
	SystemGetWebServiceListResDto getwebServiceDetailPop(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetWebServiceListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.getwebServiceDetailPop(mor);
	}
	/**
	 * @programId : 
	 * @name : insertWebService
	 * @date : 2020. 12. 08
	 * @author :  LEE GYEONG YOUNG
	 * @table : 
	 * @return : success log
	 * @description : 외부 테이블 웹 서비스 삽입
	 */
	@RequestMapping(value = "/insertWebService.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto insertWebService(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetWebServiceListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.insertWebService(mor);
	}	
	/**
	 * @programId : 
	 * @name : updateWebService
	 * @date : 2020. 12. 08
	 * @author :  LEE GYEONG YOUNG
	 * @table : 
	 * @return : success log
	 * @description : 외부 테이블 웹 서비스 수정
	 */
	@RequestMapping(value = "/updateWebService.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto updateWebService(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetWebServiceListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.updateWebService(mor);
	}	
	/**
	 * @programId : 
	 * @name : deleteWebService
	 * @date : 2020. 12. 08
	 * @author :  LEE GYEONG YOUNG
	 * @table : 
	 * @return : success log
	 * @description : 외부 테이블 웹 서비스 삭제
	 */
	@RequestMapping(value = "/deleteWebService.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto deleteWebService(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetWebServiceListReqDto mor) {
		LogUtil.param(SystemOutTableController.class, mor);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		authHelper.checkLoginSession(request, response);
		
		return systemOutTableService.deleteWebService(mor);
	}		
}
