package com.icignal.systemmanagement.alert.controller;

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
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.alert.dto.request.SystemAlertListReqDto;
import com.icignal.systemmanagement.alert.dto.response.SystemAlertDetailResDto;
import com.icignal.systemmanagement.alert.dto.response.SystemAlertListResDto;
import com.icignal.systemmanagement.alert.service.SystemAlertService;
import com.icignal.systemmanagement.menu.controller.SystemMenuController;

@Controller
@RequestMapping("/system/alert")
public class SystemAlertController extends BaseController {

	@Autowired
	private SystemAlertService systemAlertService;
	
	@Autowired
	AuthHelper authHelper;
	
	
	@RequestMapping(value="/getSystemAlertList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAlertListResDto> getSystemAlertList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAlertListReqDto mlr) {
		LogUtil.param(SystemMenuController.class, mlr);
		authHelper.checkLoginSession(request, response);
		 	
		return systemAlertService.getSystemAlertList(mlr);
	}
	
	
	@RequestMapping(value="/getSystemAlertDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemAlertDetailResDto getSystemAlertDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemAlertListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
	    return systemAlertService.getSystemAlertDetail(reqDto);
	}
}
