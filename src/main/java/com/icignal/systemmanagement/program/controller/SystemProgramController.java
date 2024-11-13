package com.icignal.systemmanagement.program.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.dto.response.TempUploadResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.cache.dto.response.ProgramCache;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.outtable.controller.SystemOutTableController;
import com.icignal.systemmanagement.program.dto.request.SystemAuthGroupListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemAuthListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemDeleteUIObjectListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemExcelDataMapReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemExcelDownloadListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemInsertAuthObjRelReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemInsertProgDetailReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemInsertUIObjectDetailReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemObjectListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemProgListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemProgRelExcelDnReqDto;
import com.icignal.systemmanagement.program.dto.response.SystemAuthGroupListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemAuthListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemExcelDataMapResDto;
import com.icignal.systemmanagement.program.dto.response.SystemExcelDownloadListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemObjectListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemProgDetailResDto;
import com.icignal.systemmanagement.program.dto.response.SystemProgListResDto;
import com.icignal.systemmanagement.program.service.SystemProgramService;

/*
 * 1. 클래스명	: SystemProgramController
 * 2. 파일명	: SystemProgramController.java
 * 3. 패키지명	: com.icignal.systemmanagement.program.controller
 * 4. 작성자명	: Quintet
 * 5. 작성일자	: 2017. 3. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템운영 프로그램 관리 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/system/program") 
public class SystemProgramController extends BaseController {

	@Autowired
	SystemProgramService systemProgramService;

	@Autowired
	AuthHelper authHelper;

	@Autowired
	CommonService commonService;

	/*
	 * 1. 메소드명: getProgAllList 
	 * 2. 클래스명: MKTAuthController 
	 * 3. 작성자명: hr.noh 
	 * 4. 작성일자: 2020. 2. 5.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램관리 목록 리스트
	 * 2. 사용법
	 *		모든 프로그램을 불러온다.
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/getProgAllList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemProgListResDto> getProgAllList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {

		LogUtil.param(this.getClass(), reqDto);

		authHelper.checkLoginSession(request, response);

		return systemProgramService.getProgAllList(reqDto);
	}

	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 *  |_ deleteProgList()
	 * </pre>
	 * 
	 * @Method이름 : deleteProgList
	 * @Method설명 : 프로그램 리스트 삭제
	 * @param request MKTProgListRequestDTO
	 * @return StatusResDto
	 * @history =================================================================================
	 *          변경일 작성자 변경내용
	 *          =================================================================================
	 *          2017. 3. 3. 표민종 신규 생성
	 *          =================================================================================
	 */
	@RequestMapping(value = "/deleteProgList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteProgList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {

		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());
		return systemProgramService.deleteProgList(reqDto);
	}

	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 *  |_ insertProgramDetail()
	 * </pre>
	 * 
	 * @Method이름 : insertProgramDetail
	 * @Method설명 : 프로그램 신규 등록
	 * @param request MKTInsertProgDetailRequestDTO
	 * @return StatusResDto
	 * @history =================================================================================
	 *          변경일 작성자 변경내용
	 *          =================================================================================
	 *          2017. 3. 3. 표민종 신규 생성
	 *          =================================================================================
	 */
	@RequestMapping(value = "/insertProgramDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertProgramDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemInsertProgDetailReqDto reqDto) {

		LogUtil.param(this.getClass(), reqDto);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());

		return systemProgramService.insertProgramDetail(reqDto);
	}

	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 *  |_ progListDetail()
	 * </pre>
	 * 
	 * @Method이름 : progListDetail
	 * @Method설명 : 프로그램 상세
	 * @param MKTProgListRequestDTO
	 * @return MKTProgDetailResponseDTO
	 * @history =================================================================================
	 *          변경일 작성자 변경내용
	 *          =================================================================================
	 *          2017. 3. 3. 표민종 신규 생성
	 *          =================================================================================
	 */
	@RequestMapping(value = "/progListDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemProgDetailResDto progListDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) { 
		LogUtil.param(this.getClass(), reqDto);

		authHelper.checkLoginSession(request, response);

		return systemProgramService.progListDetail(reqDto);
	}

	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 *  |_ updateProgramDetail()
	 * </pre>
	 * 
	 * @Method이름 : updateProgramDetail
	 * @Method설명 : 프로그램 상세 수정
	 * @param MKTInsertProgDetailRequestDTO
	 * @return StatusResDto
	 * @history =================================================================================
	 *          변경일 작성자 변경내용
	 *          =================================================================================
	 *          2017. 3. 3. 표민종 신규 생성
	 *          =================================================================================
	 */
	@RequestMapping(value = "/updateProgramDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateProgramDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemInsertProgDetailReqDto reqDto) { 
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());

		return systemProgramService.updateProgramDetail(reqDto);
	}

	/**
	 * @name : getObjAuthList
	 * @date : 2020.01.30
	 * @author : sh.park
	 * @return : GridPagingResponseDTO
	 * @description : obj 권한 리스트
	 */
	@RequestMapping(value = "/getObjAuthList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAuthGroupListResDto> getObjAuthList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAuthGroupListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		return systemProgramService.getObjAuthList(reqDto);
	}

	/**
	 * @name : deleteUIObjectList
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : UI오브젝트 삭제
	 */
	@RequestMapping(value = "/deleteUIObjectList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteUIObjectList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDeleteUIObjectListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());

		return systemProgramService.deleteUIObjectList(reqDto);
	}

	/**
	 * @name : getObjectListNew
	 * @date : 2017. 3. 13.
	 * @author : sh.park
	 * @return : GridPagingResDto
	 * @description : 오브젝트 리스트 조회 팝업(이미 프로그램 관리에 등록된 버튼 제외 리스트)
	 */
	@RequestMapping(value = "/getObjectListNew.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemObjectListResDto> getObjectListNew(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemObjectListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		return systemProgramService.getObjectListNew(reqDto);
	}

	/**
	 * @name : insertUIObjectDetail
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : UI오브젝트 추가
	 */
	@RequestMapping(value = "/insertUIObjectDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertUIObjectDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemInsertUIObjectDetailReqDto reqDto) { 
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());

		return systemProgramService.insertUIObjectDetail(reqDto);
	}

	/**
	 * @name : getAuthListPop
	 * @date : 2020. 1. 31.
	 * @author : sh.park
	 * @history :
	 * @description : 프로그램 관리 오브젝트 권한 팝업 리스트
	 * @param requ
	 * @param response
	 * @param reqDto
	 * @return : StatusResDto
	 */
	@RequestMapping(value = "/getAuthListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAuthListResDto> getAuthListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAuthListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		return systemProgramService.getAuthListPop(reqDto);
	}

	/**
	 * @name : setAuthObjRelPopup
	 * @date : 2020. 1. 31.
	 * @author : sh.park
	 * @history :
	 * @description : 프로그램 관리 오브젝트 권한 등록
	 * @param requ
	 * @param response
	 * @param reqDto
	 * @return : StatusResDto
	 */
	@RequestMapping(value = "/setAuthObjRelPopup.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setAuthObjRelPopup(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemInsertAuthObjRelReqDto reqDto) { 
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());

		return systemProgramService.setAuthObjRelPopup(reqDto);

	}

	/*
	 * 1. 메소드명: getAuthListPop 2. 클래스명: SystemProgramController 3. 작성자명: jh.seo 4.
	 * 작성일자: 2020. 3. 3.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/getProgramAuthList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemProgListResDto> getProgramAuthList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		return systemProgramService.getProgramAuthList(reqDto);
	}

	/*
	 * 1. 메소드명: getProgramListPop 2. 클래스명: SystemProgramController 3. 작성자명: jh.seo 4.
	 * 작성일자: 2020. 3. 3.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/getProgramListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemProgListResDto> getProgramListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		return systemProgramService.getProgramListPop(reqDto);
	}

	/*
	 * 1. 메소드명: getProgramListPop 
	 * 2. 클래스명: SystemProgramController 
	 * 3. 작성자명: jh.seo 
	 * 4. 작성일자: 2020. 3. 3.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/editProgramDown.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editProgramDown(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		return systemProgramService.editProgramDown(reqDto);
	}

	/*
	 * 1. 메소드명: removeProgramDown 
	 * 2. 클래스명: SystemProgramController 
	 * 3. 작성자명: jh.seo 
	 * 4. 작성일자: 2020. 3. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/removeProgramDown.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeProgramDown(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		return systemProgramService.removeProgramDown(reqDto);
	}

	/*
	 * 1. 메소드명: programAuthCheck 
	 * 2. 클래스명: SystemProgramController 
	 * 3. 작성자명: jh.seo 
	 * 4. 작성일자: 2020. 3. 5.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/programAuthCheck.do", method = RequestMethod.POST)
	public @ResponseBody SystemProgListResDto programAuthCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		return systemProgramService.programAuthCheck(reqDto);
	}

	/*
	 * 1. 메소드명: programAuthCheck 
	 * 2. 클래스명: SystemProgramController 
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
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/removeProgramAuth.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeProgramAuth(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		StatusResDto rtnValue = new StatusResDto();
		systemProgramService.removeProgramAuth(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: removeProgramAuth 
	 * 2. 클래스명: SystemProgramController 
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
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/getAuthProgramList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAuthListResDto> getAuthProgramList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAuthListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		return systemProgramService.getAuthProgramList(reqDto);
	}

	/*
	 * 1. 메소드명: setAuthProgramAddRel 
	 * 2. 클래스명: SystemProgramController 
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
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/setAuthProgramAddRel.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setAuthProgramAddRel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemInsertAuthObjRelReqDto reqDto) { 
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());

		return systemProgramService.setAuthProgramAddRel(reqDto);

	}

	/*
	 * 1. 메소드명: getLowProgramRel 
	 * 2. 클래스명: SystemProgramController 
	 * 3. 작성자명: hr.noh 
	 * 4. 작성일자: 2020. 3. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		하위프로그램 목록(프로그램간 상,하 관계(트리구조))
	 *		상위 프로그램 다음으로 속해있는 하위 프로그램 의 관계를 확인한다.
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/getLowProgramRel.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemProgListResDto> getLowProgramRel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		return systemProgramService.getLowProgramRel(reqDto);
	}
	
	@RequestMapping(value = "/getProgramChildTab.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemProgListResDto> getProgramChildTab(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		return systemProgramService.getProgramChildTab(reqDto);
	}

	/*
	 * 1. 메소드명: editParProgramDown 
	 * 2. 클래스명: SystemProgramController 
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2020. 3. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/editParProgramDown.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editParProgramDown(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		return systemProgramService.editParProgramDown(reqDto);
	}

	/*
	 * 1. 메소드명: removeParProgramDown 
	 * 2. 클래스명: SystemProgramController 
	 * 3. 작성자명: hr.noh 
	 * 4. 작성일자: 2020. 3. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/removeParProgramDown.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeParProgramDown(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);
		return systemProgramService.removeParProgramDown(reqDto);
	}

	/*
	 * 1. 메소드명: getLowProgList 
	 * 2. 클래스명: SystemProgramController 
	 * 3. 작성자명: hr.noh 
	 * 4. 작성일자: 2020. 3. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		하위 프로그램 목록에 추가할 프로그램 리스트 팝업
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/getLowProgListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemProgListResDto> getLowProgList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);

		return systemProgramService.getLowProgListPop(reqDto);
	}

	/*
	 * 1. 메소드명: getDetailParProgList 
	 * 2. 클래스명: SystemProgramController 
	 * 3. 작성자명: hr.noh 
	 * 4. 작성일자: 2020. 3. 24.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 목록 상세 상위프로그램 등록 리스트
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/getDetailParProgList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemProgListResDto> getDetailParProgList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);

		return systemProgramService.getDetailParProgList(reqDto);
	}

	/*
	 * 1. 메소드명: getDetailProgramList 
	 * 2. 클래스명: SystemProgramController 
	 * 3. 작성자명: hr.noh 
	 * 4. 작성일자: 2020. 3. 24.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 목록 상세 메인프로그램 등록 리스트
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/getDetailProgramList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemProgListResDto> getDetailProgramList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);

		return systemProgramService.getDetailProgramList(reqDto);
	}

	/**
	 * @name : getExcelDownloadList
	 * @date : 2020. 04. 02
	 * @author : sm.lee
	 * @return : GridPagingResDto<SystemExcelDownloadListResDto>
	 * @description : 프로그램 목록 엑셀 다운로드 목록 리스트
	 */
	@RequestMapping(value = "/getExcelDownloadList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemExcelDownloadListResDto> getExcelDownloadList( HttpServletRequest request, HttpServletResponse response, @RequestBody SystemExcelDownloadListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);

		return systemProgramService.getExcelDownloadList(reqDto);
	}

	/**
	 * @name : setProgramExcelFile
	 * @date : 2020. 04. 02
	 * @author : sm.lee
	 * @return : StatusResDto
	 * @description : 엑셀 파일 생성 등록
	 */
	@RequestMapping(value = "/setProgramExcelFile.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setProgramExcelFile(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemExcelDownloadListReqDto reqDto) { 
		LogUtil.param(this.getClass(), reqDto);

		authHelper.checkLoginSession(request, response);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());

		return systemProgramService.setProgramExcelFile(reqDto);
	}

	/**
	 * @name : deleteExcelFile
	 * @date : 2020. 04. 02
	 * @author : sm.lee
	 * @return :
	 * @description : 엑셀 다운로드 관리 리스트 삭제
	 */
	@RequestMapping(value = "/deleteExcelFile.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteExcelFile(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemExcelDownloadListReqDto reqDto) { 
		LogUtil.param(this.getClass(), reqDto);

		//String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath")+"template/";

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);

		reqDto.setEmpId(userInfo.getId());
		return systemProgramService.deleteExcelFile(reqDto);
	}

	/**
	 * @name : excelTempUpload
	 * @date : 2020. 04. 02
	 * @author : sm.lee
	 * @return :
	 * @description : 엑셀 템플릿 등록
	 */
	@RequestMapping(value = "/excelTempUpload.do", method = RequestMethod.POST, headers = "content-type=multipart/*")
	public @ResponseBody List<TempUploadResDto> excelTempUpload(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
		LogUtil.param(this.getClass(), null);
		authHelper.checkLoginSession(request, response);

//		String filePath = request.getSession().getServletContext().getRealPath("/");
		
		String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath");
		
		return systemProgramService.excelTempUpload(filePath, file);
	}

	/**
	 * @name : getDtlExcel
	 * @date : 2020. 04. 02
	 * @author : sm.lee
	 * @return : SystemExcelDownloadListResDto
	 * @description : 엑셀 파일 생성
	 */
	@RequestMapping(value = "/getDtlExcel.do", method = RequestMethod.POST)
	public @ResponseBody SystemExcelDownloadListResDto getDtlExcel(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemExcelDownloadListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		authHelper.checkLoginSession(request, response);

		return systemProgramService.getDtlExcel(reqDto);
	}

	/*
	 * 1. 메소드명: progRelExcelDown 
	 * 2. 클래스명: SystemProgramController 
	 * 3. 작성자명: hr.noh 
	 * 4. 작성일자: 2020. 4. 2.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 (상하)관계 엑셀 다운로드
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @param model
	 *   @return	
	 */
	@RequestMapping(value="/progRelExcelDown.do", method = RequestMethod.POST)
	public String progRelExcelDown(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemProgRelExcelDnReqDto reqDto, ModelMap model) {
		LogUtil.param(SystemProgramController.class, reqDto)	;
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		HttpSession session = request.getSession(true);
		//내부페이지 url
		String programPath = (String) session.getAttribute("URL_INCLUDE");
		//메인페이지 url		
		if("".equals(programPath)) programPath = (String) session.getAttribute("URL");

		ProgramCache proResDto = null;
		String ObjCode = reqDto.getObjCode();
		commonService.getExcelMetaData(session,programPath,proResDto,ObjCode, model);
		
		//일반 엑셀 예시 : @RequestBody SystemProgRelExcelDnReqDto reqDto,
		GridPagingResDto<SystemProgListResDto> data = systemProgramService.getProgRelList(reqDto);
		//템플릿 엑셀 예시 : @RequestBody  SystemProgListReqDto reqDto,
		//GridPagingResDto<SystemProgListResDto> data = systemProgramService.templateTestProgAllList(reqDto);

		model.addAttribute("result", data);

		return "ExcelView";
	}

	/**
	 * @name : editExcelFile
	 * @date : 2020. 04. 03
	 * @author : sm.lee
	 * @return : StatusResDto
	 * @description : 엑셀 파일 생성 수정
	 */
	@RequestMapping(value = "/editExcelFile.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editExcelFile(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemExcelDownloadListReqDto reqDto) {
		LogUtil.param(SystemOutTableController.class, reqDto);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());

		String filePath = request.getSession().getServletContext().getRealPath("/");

		return systemProgramService.editExcelFile(reqDto, filePath);
	}

	/**
	 * @name : getdataMapList
	 * @date : 2020. 04. 03
	 * @author : sm.lee
	 * @return : SystemExcelDataMapResDto
	 * @description : 데이터 매핑 룰 리스트
	 */
	@RequestMapping(value = "/getDataMapList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemExcelDataMapResDto> getDataMapList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemExcelDataMapReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);

		return systemProgramService.getDataMapList(reqDto);
	}

	/**
	 * @name : setExcelData
	 * @date : 2020. 04. 06
	 * @author : sm.lee
	 * @return : StatusResDto
	 * @description : 엑셀 파일 생성
	 */
	@RequestMapping(value = "/setExcelData.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setExcelData(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemExcelDataMapReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());

		return systemProgramService.setExcelData(reqDto);
	}
	/**
	 * @name : getDtlExcelData
	 * @date : 2020. 04. 03
	 * @author : sm.lee
	 * @return : SystemExcelDataMapResDto
	 * @description : 데이터 매핑 룰 리스트
	 */
	@RequestMapping(value = "/getDtlExcelData.do", method = RequestMethod.POST)
	public @ResponseBody SystemExcelDataMapResDto getDtlExcelData(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemExcelDataMapReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		authHelper.checkLoginSession(request, response);

		return systemProgramService.getDtlExcelData(reqDto);
	}
	
	/**
	 * @name : setExcelData
	 * @date : 2020. 04. 07
	 * @author : sm.lee
	 * @return : StatusResDto
	 * @description : 데이터 매핑룰 수정
	 */
	@RequestMapping(value = "/editExcelData.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editExcelData(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemExcelDataMapReqDto reqDto) { 
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());

		return systemProgramService.editExcelData(reqDto);
	}
	/**
	 * @name : setExcelData
	 * @date : 2020. 04. 07
	 * @author : sm.lee
	 * @return : StatusResDto
	 * @description : 데이터 매핑 룰 삭제
	 */
	@RequestMapping(value = "/deleteDataMap.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteDataMap(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemExcelDataMapReqDto reqDto) { 
		LogUtil.param(this.getClass(), reqDto);
		
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return systemProgramService.deleteDataMap(reqDto);
	}
	
	
	
	 /*
	  * 1. 메소드명: fileDownload
	  * 2. 클래스명: SystemProgramController
	  * 3. 작성자명: sm.lee
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		엑셀 다운로드 관리에 등록된 템플릿 파일 다운로드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param response
	 *   @param request
	 *   @param paramMap
	 *   @throws IOException	
	 */
	@RequestMapping(value="/tempFileDownload.do")
	public void tempFileDownload( HttpServletResponse response, HttpServletRequest request, @RequestParam Map<String, String> paramMap) throws IOException { 
		//String filePath = System.getProperty("user.dir");
		//String fileFullPath = (String) filePath + paramMap.get("templateFile").replaceAll("/", Matcher.quoteReplacement(File.separator)); //파일 전체경로(파일명도 포함)
		//paramMap.get("templateFile") //이것만해도 저장된 경로가 뽑힌다.
	    String fileName = paramMap.get("templateFile").substring(paramMap.get("templateFile").lastIndexOf("/")); //파일명
	    
	    String fileFullPath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath") + File.separator+"template/"+fileName; //파일 전체경로(파일명도 포함)
	    FileInputStream fileInputStream = null;
	    ServletOutputStream servletOutputStream = null;
	    
	    File file = new File(fileFullPath);
	    
	    if (file.exists() && file.isFile()) {
	        String downName = null;
	        String browser = request.getHeader("User-Agent");
	        //파일 인코딩
			if(browser.contains("MSIE") || browser.contains("Trident") ||
				browser.contains("Chrome")){//브라우저 확인 파일명 encode
				downName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
			}else{
				downName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
			}
	        response.setHeader("Content-Disposition","attachment;filename=\"" + fileName+"\"");             
	        response.setContentType("application/octer-stream");
	        response.setHeader("Content-Transfer-Encoding", "binary;");
	 
	        fileInputStream = new FileInputStream(file);
	        servletOutputStream = response.getOutputStream();
	 
	        byte b [] = new byte[1024];
	        int data = 0;
	        while((data=(fileInputStream.read(b, 0, b.length))) != -1){
	            servletOutputStream.write(b, 0, data);
	        }
	        servletOutputStream.flush();//출력
	        servletOutputStream.close();
	        fileInputStream.close();
	    }
	    response.setContentType("text/html;charset=UTF-8");
	    PrintWriter out = response.getWriter();
	    out.println("<script>alert('파일이 존재하지 않습니다.');history.go(-1);</script>");	     
	    out.flush();
	    out.close();
	}
}
