
package com.icignal.systemmanagement.authgroup.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.icignal.systemmanagement.authgroup.dto.request.AuthAuthModalReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthGroupDeleteReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthGroupDetailReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthGroupEmployeeModalReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthGroupEmployeeReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthGroupInsertReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthGroupListReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthInsertAuthReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthInsertEmployeeReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.DeleteAuthGroupDetailReqDto;
import com.icignal.systemmanagement.authgroup.dto.response.AuthAuthModalResDto;
import com.icignal.systemmanagement.authgroup.dto.response.AuthGroupDetailResDto;
import com.icignal.systemmanagement.authgroup.dto.response.AuthGroupEmployeeModalResDto;
import com.icignal.systemmanagement.authgroup.dto.response.AuthGroupEmployeeResDto;
import com.icignal.systemmanagement.authgroup.dto.response.AuthGroupInsertResDto;
import com.icignal.systemmanagement.authgroup.dto.response.AuthGroupListResDto;
import com.icignal.systemmanagement.authgroup.service.SystemAuthGroupService;

@Controller

@RequestMapping("/system/authgroup")
public class SystemAuthGroupController extends BaseController {

	@Autowired
	SystemAuthGroupService systemAuthGroupService;

	@Autowired
	AuthHelper authhelper;

	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 *  |_ getAuthGroupList()
	 * </pre>
	 * 
	 * @Method이름 : getAuthGroupList
	 * @Method설명 : 권한 그룹 리스트 출력
	 * @param MKTAuthGroupListRequestDTO
	 * @return GridPagingResponseDTO MKTAuthGroupListResponse
	 * @history =================================================================================
	 *          변경일 작성자 변경내용
	 *          =================================================================================
	 *          2017. 3. 3. 표민종 신규 생성
	 *          =================================================================================
	 */

	@RequestMapping(value = "/getAuthGroupList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<AuthGroupListResDto> getAuthGroupList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody AuthGroupListReqDto reqDto) {

		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authhelper.checkLoginSession(request, response);

		return systemAuthGroupService.getAuthGroupList(reqDto);
	}

	/**
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 * deleteAuthGroupList()
	 * 
	 * @Method이름 : deleteAuthGroupList
	 * @Method설명 : 권한 그룹 리스트 삭제
	 * @param MKTAuthGroupDeleteRequestDTO
	 * @return StatusResDto
	 * @history =================================================================================
	 *          변경일 작성자 변경내용
	 *          =================================================================================
	 *          2017. 3. 02. 표민종 신규 생성
	 *          =================================================================================
	 */

	@RequestMapping(value = "/deleteAuthGroupList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteAuthGroupList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody AuthGroupDeleteReqDto reqDto) {

		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		reqDto.setLoginInfo(userInfo);
		reqDto.setEmpId(userInfo.getId());
		return systemAuthGroupService.deleteAuthGroupList(reqDto);
	}

	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 *  |_ insertGroupDetail()
	 * </pre>
	 * 
	 * @Method이름 : insertGroupDetail
	 * @Method설명 : 권한 그룹 상세 등록
	 * @param MKTAuthGroupInsertRequestDTO
	 * @return MKTAuthGroupInsertResponseDTO
	 * @history =================================================================================
	 *          변경일 작성자 변경내용
	 *          =================================================================================
	 *          2017. 3. 6. 표민종 신규 생성
	 *          =================================================================================
	 */

	@RequestMapping(value = "/insertGroupDetail.do", method = RequestMethod.POST)
	public @ResponseBody AuthGroupInsertResDto insertGroupDetail(HttpServletRequest request,
			HttpServletResponse response, @RequestBody AuthGroupInsertReqDto reqDto) {

		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		reqDto.setLoginInfo(userInfo);
		reqDto.setEmpId(userInfo.getId());

		return systemAuthGroupService.insertGroupDetail(reqDto);
	}

	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 *  |_ updateGroupDetail()
	 * </pre>
	 * 
	 * @Method이름 : updateGroupDetail
	 * @Method설명 : 권한 그룹 상세 수정
	 * @param MKTAuthGroupInsertRequestDTO
	 * @return StatusResDto
	 * @history =================================================================================
	 *          변경일 작성자 변경내용
	 *          =================================================================================
	 *          2017. 3. 3. 표민종 신규 생성
	 *          =================================================================================
	 */

	@RequestMapping(value = "/updateGroupDetail.do", method = RequestMethod.POST)
	public @ResponseBody AuthGroupInsertResDto updateGroupDetail(HttpServletRequest request,
			HttpServletResponse response, @RequestBody AuthGroupInsertReqDto reqDto) {

		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());

		return systemAuthGroupService.updateGroupDetail(reqDto);

	}

	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 *  |_ getAuthEmpList()
	 * </pre>
	 * 
	 * @Method이름 : getAuthEmpList
	 * @Method설명 : 권한그룹에 등록된 직원 목록
	 * @param MKTAuthGroupEmployeeRequestDTO
	 * @return GridPagingResponseDTO MKTAuthGroupEmployeeResponseDTO
	 * @history =================================================================================
	 *          변경일 작성자 변경내용
	 *          =================================================================================
	 *          2017. 3. 6. 표민종 신규 생성
	 *          =================================================================================
	 */

	@RequestMapping(value = "/getAuthEmpList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<AuthGroupEmployeeResDto> getAuthEmpList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody AuthGroupEmployeeReqDto reqDto) {

		LogUtil.param(this.getClass(), reqDto);

		authhelper.checkLoginSession(request, response);

		return systemAuthGroupService.getAuthEmpList(reqDto);
	}

	/**
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 * deleteEmpList()
	 * 
	 * @Method이름 : deleteEmpList
	 * @Method설명 :
	 * @param request
	 * @param response
	 * @param mlr
	 * @return
	 * @history =================================================================================
	 *          변경일 작성자 변경내용
	 *          =================================================================================
	 *          2017. 3. 03. 표민종 신규 생성
	 *          =================================================================================
	 */

	@RequestMapping(value = "/deleteEmpList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteEmpList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody DeleteAuthGroupDetailReqDto reqDto) {

		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		reqDto.setLoginInfo(userInfo);
		reqDto.setEmpId(userInfo.getId());

		return systemAuthGroupService.deleteEmpList(reqDto);

	}

	/**
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 * getAuthGroupAuthList()
	 * 
	 * @Method이름 : getAuthGroupAuthList
	 * @Method설명 :
	 * @param request
	 * @param response
	 * @param mlr
	 * @return
	 * @history =================================================================================
	 *          변경일 작성자 변경내용
	 *          =================================================================================
	 *          2017. 3. 02. 표민종 신규 생성
	 *          =================================================================================
	 */

	@RequestMapping(value = "/getAuthGroupAuthList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<AuthAuthModalResDto> getAuthGroupAuthList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody AuthAuthModalReqDto reqDto) {

		LogUtil.param(this.getClass(), reqDto);

		authhelper.checkLoginSession(request, response);

		return systemAuthGroupService.getAuthGroupAuthList(reqDto);
	}

	/**
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 * deleteGroupAuthList()
	 * 
	 * @Method이름 : deleteGroupAuthList
	 * @Method설명 :
	 * @param request
	 * @param response
	 * @param mlr
	 * @return
	 * @history =================================================================================
	 *          변경일 작성자 변경내용
	 *          =================================================================================
	 *          2017. 3. 03. 표민종 신규 생성
	 *          =================================================================================
	 */

	@RequestMapping(value = "/deleteGroupAuthList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteGroupAuthList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody DeleteAuthGroupDetailReqDto reqDto) {

		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		reqDto.setLoginInfo(userInfo);
		reqDto.setEmpId(userInfo.getId());

		return systemAuthGroupService.deleteGroupAuthList(reqDto);

	}

	/**
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 * getAuthGroupDetailNew()
	 * 
	 * @Method이름 : getAuthGroupDetailNew
	 * @Method설명 : 권한 그룹 상세
	 * @param MKTAuthGroupDetailRequestDTO
	 * @return MKTAuthGroupDetailResponseDTO
	 * @history =================================================================================
	 *          변경일 작성자 변경내용
	 *          =================================================================================
	 *          2017. 3. 02. 표민종 신규 생성
	 *          =================================================================================
	 */

	@RequestMapping(value = "/getAuthGroupDetailNew.do", method = RequestMethod.POST)
	public @ResponseBody AuthGroupDetailResDto getAuthGroupDetailNew(HttpServletRequest request,
			HttpServletResponse response, @RequestBody AuthGroupDetailReqDto reqDto) {

		LogUtil.param(this.getClass(), reqDto);

		authhelper.checkLoginSession(request, response);

		return systemAuthGroupService.getAuthGroupDetailNew(reqDto);
	}
	
	
	/**
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 * getAuthAddListModal()
	 * @Method이름	: getAuthAddListModal
	 * @Method설명	: 
	 * @param request
	 * @param response
	 * @param mlr
	 * @return
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 02.		표민종			신규 생성
	 * =================================================================================
	 */
	
	@RequestMapping(value="/getAuthAddListModal.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<AuthAuthModalResDto> getAuthAddListModal(HttpServletRequest request, HttpServletResponse response, @RequestBody AuthAuthModalReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
		
		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		
	    return systemAuthGroupService.getAuthAddListModal(reqDto);
	}
	
	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 *  |_ getEmpAddListModal()
	 * </pre>
	 * @Method이름	: getEmpAddListModal
	 * @Method설명	: Account계정 하위 직원 목록을 보여주는 모달창 
	 * @param MKTAuthGroupEmployeeModalRequestDTO
	 * @return GridPagingResponseDTO MKTAuthGroupEmployeeModalResponseDTO
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 6.			표민종			신규 생성
	 * =================================================================================
	 */
	@RequestMapping(value="/getEmpAddListModal.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<AuthGroupEmployeeModalResDto> getEmpAddListModal(HttpServletRequest request, HttpServletResponse response, @RequestBody AuthGroupEmployeeModalReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
		
		LoginResDto userInfo =  authhelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());
		return systemAuthGroupService.getEmpAddListModal(reqDto);
	}
	
	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 *  |_ addEmpList()
	 * </pre>
	 * @Method이름	: addEmpList
	 * @Method설명	: 권한그룹에 직원 등록
	 * @param MKTAuthInsertEmployeeRequestDTO
	 * @return StatusResponseDTO
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 2. 27.		표민종			신규 생성
	 * =================================================================================
	 */
	
	@RequestMapping(value="/addEmpList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addEmpList(HttpServletRequest request, HttpServletResponse response, @RequestBody AuthInsertEmployeeReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
		
		LoginResDto userInfo =  authhelper.checkLoginSession(request, response);
		reqDto.setLoginInfo(userInfo);
		reqDto.setEmpId(userInfo.getId());
		return systemAuthGroupService.addEmpList(reqDto);
	}
	
	/**
	 * infavor.beacon.enterprise.auth.controller.MKTAuthController.java
	 * addAuthList()
	 * @Method이름	: addAuthList
	 * @Method설명	: 
	 * @param request
	 * @param response
	 * @param mlr
	 * @return
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 02.		표민종			신규 생성
	 * =================================================================================
	 */
	
	@RequestMapping(value="/addAuthList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addAuthList(HttpServletRequest request, HttpServletResponse response, @RequestBody AuthInsertAuthReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
		
		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		reqDto.setLoginInfo(userInfo);
		reqDto.setEmpId(userInfo.getId());
		
	    return systemAuthGroupService.addAuthList(reqDto);
	   
	}
	

}
