package com.icignal.systemmanagement.object.controller;

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
import com.icignal.systemmanagement.object.dto.request.SystemDeleteObjectListReqDto;
import com.icignal.systemmanagement.object.dto.request.SystemGetObjectDetailReqDto;
import com.icignal.systemmanagement.object.dto.request.SystemGetUIObjectDetailReqDto;
import com.icignal.systemmanagement.object.dto.request.SystemInsertObjectDetailReqDto;
import com.icignal.systemmanagement.object.dto.request.SystemUIObjectListReqDto;
import com.icignal.systemmanagement.object.dto.response.SystemGetObjectDetailResDTO;
import com.icignal.systemmanagement.object.dto.response.SystemGetUIObjectDetailResDto;
import com.icignal.systemmanagement.object.dto.response.SystemUIObjectListResDto;
import com.icignal.systemmanagement.object.service.SystemObjectService;
import com.icignal.systemmanagement.program.dto.request.SystemDeleteUIObjectListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemInsertUIObjectDetailReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemObjectListReqDto;
import com.icignal.systemmanagement.program.dto.response.SystemObjectListResDto;

@Controller
@RequestMapping("/system/object")
public class SystemObjectController extends BaseController{

	@Autowired SystemObjectService systemObjectService;
	
	@Autowired AuthHelper authhelper;
	/**
	 * @name : getObjectList
	 * @date : 2017. 3. 13.
	 * @author : jun.lee
	 * @return : GridPagingResDto
	 * @description : 오브젝트 리스트 조회
	 */
	@RequestMapping(value="/getObjectList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemObjectListResDto> getObjectList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemObjectListReqDto reqDto) {		
		LogUtil.param(this.getClass(), reqDto);
		
		return systemObjectService.getObjectList(reqDto);
	}

	/**
	 * @name : insertObjectDetail
	 * @date : 2017. 3. 13.
	 * @author : jun.lee
	 * @return : StatusResDto 
	 * @description : 오브젝트 추가
	 */
	@RequestMapping(value="/insertObjectDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertObjectDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemInsertObjectDetailReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
		
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		
		return systemObjectService.insertObjectDetail(reqDto);
	}

	/**
	 * @name : getObjectDetail
	 * @date : 2017. 3. 13.
	 * @author : jun.lee
	 * @return : MKTGetObjectDetailResponseDTO
	 * @description : 오브젝트 상세 조회
	 */
	@RequestMapping(value="/getObjectDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemGetObjectDetailResDTO getObjectDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetObjectDetailReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
		
		authhelper.checkLoginSession(request, response);
		
		return systemObjectService.getObjectDetail(reqDto);
	}

	/**
	 * @name : updateObjectDetail
	 * @date : 2017. 3. 13.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 오브젝트 수정
	 */
	@RequestMapping(value="/updateObjectDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateObjectDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemInsertObjectDetailReqDto bpdr) {
		
		LogUtil.param(this.getClass(), bpdr);
		
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		bpdr.setEmpId(loginInfo.getId());
		
		return systemObjectService.updateObjectDetail(bpdr);
	}

	/**
	 * @name : deleteObjectList
	 * @date : 2017. 3. 13.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 오브젝트 리스트 삭제
	 */
	@RequestMapping(value="/deleteObjectList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteObjectList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDeleteObjectListReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
		
		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());
		
		return systemObjectService.deleteObjectList(reqDto);
	}

	/**
	 * @name : getUIObjectList
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : GridPagingResDto
	 * @description : UI오브젝트 리스트 조회
	 */
	@RequestMapping(value="/getUIObjectList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemUIObjectListResDto> getUIObjectList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemUIObjectListReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
		
		authhelper.checkLoginSession(request, response);
		
		return systemObjectService.getUIObjectList(reqDto);
	}

	/**
	 * @name : getObjectCode
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : GridPagingResDto
	 * @description : UI오브젝트 상세 조회 시, 오브젝트 코드 조회
	 */
	@RequestMapping(value="/getObjectCode.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemUIObjectListResDto> getObjectCode(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemUIObjectListReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
		
		authhelper.checkLoginSession(request, response);
		
		return systemObjectService.getObjectCode(reqDto);
	}

	/**
	 * @name : insertUIObjectDetail
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : UI오브젝트 추가
	 */
	@RequestMapping(value="/insertUIObjectDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertUIObjectDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemInsertUIObjectDetailReqDto bpdr) {
		
		LogUtil.param(this.getClass(), bpdr);
		
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		bpdr.setEmpId(loginInfo.getId());
		
		return systemObjectService.insertUIObjectDetail(bpdr);
	}

	/**
	 * @name : updateUIObjectDetail
	 * @date : 2017. 3. 15.
	 * @author : sn.lee
	 * @return : StatusResDto
	 * @description : UI오브젝트 수정
	 */
	@RequestMapping(value="/updateUIObjectDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateUIObjectDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemInsertUIObjectDetailReqDto bpdr) {
		
		LogUtil.param(this.getClass(), bpdr);
		
		LoginResDto loginInfo = authhelper.checkLoginSession(request, response);
		bpdr.setEmpId(loginInfo.getId());
		
		return systemObjectService.updateUIObjectDetail(bpdr);
	}

	/**
	 * @name : getUIObjectDetail
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : MKTGetUIObjectDetailResponseDTO
	 * @description : UI오브젝트 상세 조회 
	 */
	@RequestMapping(value="/getUIObjectDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemGetUIObjectDetailResDto getUIObjectDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemGetUIObjectDetailReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
		
		authhelper.checkLoginSession(request, response);
		
		return systemObjectService.getUIObjectDetail(reqDto);
	}

	/**
	 * @name : deleteUIObjectList
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : UI오브젝트 삭제
	 */
	@RequestMapping(value="/deleteUIObjectList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteUIObjectList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemDeleteUIObjectListReqDto reqDto) {
		
		LogUtil.param(this.getClass(), reqDto);
		
		LoginResDto userInfo = authhelper.checkLoginSession(request, response);
		reqDto.setEmpId(userInfo.getId());
		
		return systemObjectService.deleteUIObjectList(reqDto);
	}
	
	
}
