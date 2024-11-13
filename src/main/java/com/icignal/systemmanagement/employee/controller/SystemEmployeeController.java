
package com.icignal.systemmanagement.employee.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.employee.dto.request.SystemDeleteAuthGroupByRidReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemEmployeeDeleteReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemEmployeeDetailReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemEmployeeInfoReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemEmployeeReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemGetAuthGroupListByEIRUReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemGetIpAccessControlListReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemGetUserDetailRequestDto;
import com.icignal.systemmanagement.employee.dto.request.SystemGetUserListByEIRequestDto;
import com.icignal.systemmanagement.employee.dto.request.SystemInsertAuthGroupAndEmpIdReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemSetIpAccessControlReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemUserDetailReqDto;
import com.icignal.systemmanagement.employee.dto.response.SystemEmployeeItemDto;
import com.icignal.systemmanagement.employee.dto.response.SystemEmployeePopUpResDto;
import com.icignal.systemmanagement.employee.dto.response.SystemEmployeeResDto;
import com.icignal.systemmanagement.employee.dto.response.SystemGetAuthGroupListByEIRUResDto;
import com.icignal.systemmanagement.employee.dto.response.SystemGetIpAccessControlListResDto;
import com.icignal.systemmanagement.employee.dto.response.SystemGetUserDetailResDto;
import com.icignal.systemmanagement.employee.dto.response.SystemGetUserListByEIResDto;
import com.icignal.systemmanagement.employee.dto.response.SystemStoreInfoResDto;
import com.icignal.systemmanagement.employee.service.SystemEmployeeService;

@Controller

@RequestMapping("/system/employee")
public class SystemEmployeeController extends BaseController {

	@Autowired
	SystemEmployeeService systemEmployeeService;

	@Autowired
	AuthHelper authhelper;

	@RequestMapping(value = "/deleteEmployee.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteEmployee(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemEmployeeDeleteReqDto edr) {
		LogUtil.param(this.getClass(), edr);

		authhelper.checkLoginSession(request, response);

		return systemEmployeeService.deleteEmployee(edr);
	}

	/**
	 * @name : getAuthGroupListByEmpIdAndRidUser
	 * @date : 2017. 4. 5.
	 * @author : jun.lee
	 * @return : GridPagingResDto
	 * @description : 로그인 사용자 소유 권한그룹 조회 리스트 출력
	 */

	@RequestMapping(value = "/getAuthGroupListByEmpIdAndRidUser.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemGetAuthGroupListByEIRUResDto> getAuthGroupListByEmpIdAndRidUser(
			HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetAuthGroupListByEIRUReqDto plr) {

		LogUtil.param(this.getClass(), plr);

		authhelper.checkLoginSession(request, response);

		return systemEmployeeService.getAuthGroupListByEmpIdAndRidUser(plr);
	}

	/**
	 * @name : getUserListByEmpId
	 * @date : 2017. 4. 5.
	 * @author : jun.lee
	 * @return : GridPagingResDto
	 * @description : 로그인 사용자 정보 조회 리스트 출력
	 */

	@RequestMapping(value = "/getUserListByEmpId.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemGetUserListByEIResDto> getUserListByEmpId(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemGetUserListByEIRequestDto plr) {

		LogUtil.param(this.getClass(), plr);

		authhelper.checkLoginSession(request, response);

		return systemEmployeeService.getUserListByEmpId(plr);
	}

	@RequestMapping(value = "/selectEmployeeList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemEmployeeItemDto> selectEmployeeList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemEmployeeReqDto ber) {
		LogUtil.param(this.getClass(), ber);

//		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);

		return systemEmployeeService.selectEmployeeList(ber);
	}

	/**
	 * @name : getIpAccessControlList
	 * @date : 2017. 11. 22.
	 * @author : jun.lee
	 * @return : GridPagingResDto
	 * @description : 로그인 사용자 IP접근제어 리스트 조회
	 */

	@RequestMapping(value = "/getIpAccessControlList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemGetIpAccessControlListResDto> getIpAccessControlList(
			HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetIpAccessControlListReqDto plr) {

		LogUtil.param(this.getClass(), plr);

		authhelper.checkLoginSession(request, response);

		return systemEmployeeService.getIpAccessControlList(plr);
	}

	/**
	 * @name : removeIpAccessControl
	 * @date : 2017. 11. 22.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 로그인 사용자 IP접근제어 삭제
	 */

	@RequestMapping(value = "/removeIpAccessControl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeIpAccessControl(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemSetIpAccessControlReqDto plr) {

		LogUtil.param(this.getClass(), plr);

		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);

		plr.setEmpId(loginInfo.getId());

		return systemEmployeeService.removeIpAccessControl(plr);
	}

	/**
	 * @name : deleteAuthGroupByRid
	 * @date : 2017. 4. 5.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 로그인 사용자 소유 권한그룹 삭제
	 */

	@RequestMapping(value = "/deleteAuthGroupByRid.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteAuthGroupByRid(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemDeleteAuthGroupByRidReqDto darr) {

		LogUtil.param(this.getClass(), darr);

		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		darr.setEmpId(userInfo.getId());

		return systemEmployeeService.deleteAuthGroupByRid(darr);
	}

	/**
	 * @name : deleteUserDetail
	 * @date : 2017. 4. 5.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 로그인 사용자 정보 삭제
	 */

	@RequestMapping(value = "/deleteUserDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteUserDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemUserDetailReqDto bpdr) {

		LogUtil.param(this.getClass(), bpdr);

		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		bpdr.setLoginInfo(loginInfo);
		bpdr.setEmpId(loginInfo.getId());

		return systemEmployeeService.deleteUserDetail(bpdr);
	}

	@RequestMapping(value = "/selectEmployeeDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemEmployeeResDto selectEmployeeDetail(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemEmployeeDetailReqDto ber) {
		LogUtil.param(this.getClass(), ber);
		authhelper.checkLoginSession(request, response);

		return systemEmployeeService.selectEmployeeDetail(ber);
	}

	/**
	 * @name : getOrganizationDetailList
	 * @date : 2017. 2. 20.
	 * @author : jun.lee
	 * @return : MKTOrganizationDetailResponseDTO
	 * @description : 조직관리 상세 조회
	 */

	/*
	 * @RequestMapping(value = "/getOrganizationDetail.do", method =
	 * RequestMethod.POST) public @ResponseBody MKTOrganizationDetailResponseDTO
	 * getOrganizationDetail(HttpServletRequest request, HttpServletResponse
	 * response, @RequestBody MKTOrganizationDetailRequestDTO dto) {
	 * LogUtil.param(this.getClass(), dto);
	 * 
	 * LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
	 * dto.setLoginInfo(loginInfo);
	 * 
	 * return systemEmployeeService.getOrganizationDetail(dto); }
	 */

	@RequestMapping(value = "/insertEmployee.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertEmployee(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemEmployeeInfoReqDto eir) {
		LogUtil.param(this.getClass(), eir);

		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);

		StatusResDto rtnValue = new StatusResDto();
		eir.setLoginInfo(loginInfo);
		eir.setEmpId(loginInfo.getId());

		/*eir.setPassword(request.getHeader("password"));
		String desPWD = EncryptUtil.AES_Decode(eir.getPassword());
		eir.setPassword(desPWD);*/
		
		rtnValue = systemEmployeeService.insertEmployee(eir);
		return rtnValue;
	}

	@RequestMapping(value = "/updateEmployee.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateEmployee(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemEmployeeInfoReqDto bur) {
		LogUtil.param(this.getClass(), bur);

		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);

		StatusResDto rtnValue = new StatusResDto();
		bur.setMemId(loginInfo.getId());

		/*
		 * bur.setPassword(request.getHeader("password")); String desPWD =
		 * EncryptUtil.AES_Decode(bur.getPassword()); bur.setPassword(desPWD);
		 */

		rtnValue = systemEmployeeService.updateEmployee(bur);
		return rtnValue;
	}

	/**
	 * @name : getIpAccessControlDetail
	 * @date : 2017. 11. 22.
	 * @author : jun.lee
	 * @return : MKTGetIpAccessControlListResponseDTO
	 * @description : 로그인 사용자 IP접근제어 상세
	 */

	@RequestMapping(value = "/getIpAccessControlDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemGetIpAccessControlListResDto getIpAccessControlDetail(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemSetIpAccessControlReqDto plr) {

		LogUtil.param(this.getClass(), plr);

		authhelper.checkLoginSession(request, response);

		return systemEmployeeService.getIpAccessControlDetail(plr);
	}

	/**
	 * @name : modifyIpAccessControl
	 * @date : 2017. 11. 22.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 로그인 사용자 IP접근제어 수정
	 */

	@RequestMapping(value = "/modifyIpAccessControl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyIpAccessControl(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemSetIpAccessControlReqDto plr) {

		LogUtil.param(this.getClass(), plr);

		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);

		plr.setEmpId(loginInfo.getId());

		return systemEmployeeService.modifyIpAccessControl(plr);
	}

	/**
	 * @name : setIpAccessControl
	 * @date : 2017. 11. 22.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 로그인 사용자 IP접근제어 신규
	 */

	@RequestMapping(value = "/setIpAccessControl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setIpAccessControl(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemSetIpAccessControlReqDto plr) {

		LogUtil.param(this.getClass(), plr);

		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);

		plr.setEmpId(loginInfo.getId());

		return systemEmployeeService.setIpAccessControl(plr);
	}

	/**
	 * @name : getIpAccessControlHistList
	 * @date : 2017. 11. 22.
	 * @author : jun.lee
	 * @return : GridPagingResDto
	 * @description : 로그인 사용자 IP접근제어 이력 리스트 조회
	 */

	@RequestMapping(value = "/getIpAccessControlHistList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemGetIpAccessControlListResDto> getIpAccessControlHistList(
			HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetIpAccessControlListReqDto plr) {

		LogUtil.param(this.getClass(), plr);

		authhelper.checkLoginSession(request, response);

		return systemEmployeeService.getIpAccessControlHistList(plr);
	}

	/**
	 * @name : getAuthGroupListByRidUser
	 * @date : 2017. 4. 5.
	 * @author : jun.lee
	 * @return : GridPagingResDto
	 * @description : 권한그룹 추가 팝업 리스트 출력
	 */

	@RequestMapping(value = "/getAuthGroupListByRidUser.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemGetAuthGroupListByEIRUResDto> getAuthGroupListByRidUser(
			HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetAuthGroupListByEIRUReqDto plr) {

		LogUtil.param(this.getClass(), plr);

		authhelper.checkLoginSession(request, response);

		return systemEmployeeService.getAuthGroupListByRidUser(plr);
	}

	/**
	 * @name : insertAuthGroupAndEmpId
	 * @date : 2017. 4. 5.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 로그인 사용자 소유 권한그룹 추가
	 */

	@RequestMapping(value = "/insertAuthGroupAndEmpId.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertAuthGroupAndEmpId(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemInsertAuthGroupAndEmpIdReqDto bpdr) {

		LogUtil.param(this.getClass(), bpdr);

		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		bpdr.setCreateBy(loginInfo.getId());
		bpdr.setModifyBy(loginInfo.getId());

		return systemEmployeeService.insertAuthGroupAndEmpId(bpdr);
	}

	/**
	 * @name : getUserDetail
	 * @date : 2017. 4. 5.
	 * @author : jun.lee
	 * @return : MKTGetUserDetailResponseDTO
	 * @description : 로그인 사용자 정보 상세 팝업
	 */

	@RequestMapping(value = "/getUserDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemGetUserDetailResDto getUserDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemGetUserDetailRequestDto plr) {

		LogUtil.param(this.getClass(), plr);

		authhelper.checkLoginSession(request, response);

		return systemEmployeeService.getUserDetail(plr);
	}

	/**
	 * @name : insertUserDetail
	 * @date : 2017. 4. 5.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 로그인 사용자 정보 추가
	 */

	@RequestMapping(value = "/insertUserDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertUserDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemUserDetailReqDto bpdr) {

		LogUtil.param(this.getClass(), bpdr);

		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		bpdr.setEmpId(loginInfo.getId());
		bpdr.setLoginInfo(loginInfo);

		return systemEmployeeService.insertUserDetail(bpdr);
	}

	/**
	 * @name : updateUserDetail
	 * @date : 2017. 4. 5.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 로그인 사용자 정보 수정
	 */

	@RequestMapping(value = "/updateUserDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateUserDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemUserDetailReqDto bpdr) {

		LogUtil.param(this.getClass(), bpdr);

		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		bpdr.setEmpId(loginInfo.getId());

		return systemEmployeeService.updateUserDetail(bpdr);
	}

	@RequestMapping(value = "/selectEmployeePopUp.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemEmployeePopUpResDto> selectEmployeePopUp(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemEmployeeReqDto mer) {
		LogUtil.param(this.getClass(), mer);

		LoginResDto rtnValue = authhelper.checkLoginSession(request, response);
		// 권한체크 
		mer.setLoginInfo(rtnValue); 
		mer.setStoreId(rtnValue.getOrgId());
		return systemEmployeeService.selectEmployeePopUp(mer);
	}

	/**
	 * @name : setCurrentdivision
	 * @date : 2016. 3. 2.
	 * @author : 박지열
	 * @description : 부서 세션 정보 저장 - 부서 정보를 변경 시 세션에 정보 저장
	 */
	@RequestMapping(value = "/setCurrentdivision.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setCurrentdivision(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemStoreInfoResDto slir) {
		LogUtil.param(this.getClass(), slir);

		authhelper.checkLoginSession(request, response);
		HttpSession session = request.getSession(true);
		session.setAttribute(CommonUtil.CURR_DIVISION_PROP, slir);
		return new StatusResDto(true, "");
	}

	 /*
	  * 1. 메소드명: setActiveUserLoginHist
	  * 2. 클래스명: SystemEmployeeController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		활성회원 COM.LOGIN_HISTORY -> MODIFY_DATE, LOGIN_SUCCESS_YN 새로 넣어주기
	 *		회원이 로그인 기준일보다 전에 로그인이 되있어야하고, 로그인 성공된 기록이 있어야 다시 로그인 할수 있음
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param bpdr
	 *   @return	
	 */
	@RequestMapping(value = "/setActiveUserLoginHist.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setActiveUserLoginHist(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemUserDetailReqDto bpdr) {
		LogUtil.param(this.getClass(), bpdr);
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		bpdr.setEmpId(loginInfo.getId());

		return systemEmployeeService.setActiveUserLoginHist(bpdr);
	}
}
