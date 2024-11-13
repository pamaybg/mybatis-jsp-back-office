package com.icignal.systemmanagement.log.controller;

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
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.log.dto.request.MKTLogManageListReqDto;
import com.icignal.systemmanagement.log.dto.response.MKTLogManageListResDto;
import com.icignal.systemmanagement.log.service.MKTLogManageService;


/*
 * 1. 클래스명	: MKTLogManageController
 * 2. 파일명	: MKTLogManageController.java
 * 3. 패키지명	: com.icignal.systemmanagement.log.controller
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 3. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - 마켓팅 로그 관리 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/marketing/logManage")
public class MKTLogManageController extends BaseController {

	@Autowired
	private MKTLogManageService MKTLogManageService;
	
	@Autowired
	AuthHelper authHelper;
	
	
    @RequestMapping(value="/getLogList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MKTLogManageListResDto> getLogList(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTLogManageListReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	
    	LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
    	param.setLoginInfo(loginInfo);
        //param.setStrAuthDataIn(this.getSessionAuthority(request));
        
        return MKTLogManageService.getLogList(param);
    }
}
