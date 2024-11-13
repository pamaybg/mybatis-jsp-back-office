package com.icignal.loyalty.qna.controller;

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
import com.icignal.loyalty.qna.dto.request.LoyQnaReqDto;
import com.icignal.loyalty.qna.dto.response.LoyQnaResDto;
import com.icignal.loyalty.qna.service.LoyQnaService;

@Controller
@RequestMapping("/loyalty/custChnl/qna")
public class LoyQnaController extends BaseController{
	
	@Autowired LoyQnaService loyQnaService;
	
	@Autowired AuthHelper authhelper;
	
	/**
	* @programId :
	* @name : getSrList
	* @date : 2019. 7. 5.
	* @author : dw.keum
	* @table :
	* @return : GridPagingResponseDTO
	* @description :
	*/
	@RequestMapping(value = "/getQnaList.do" , method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyQnaResDto> getQnaList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyQnaReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authhelper.checkLoginSession(request, response));
		return loyQnaService.getQnaList(reqDto);
	}
	
	/**
	* @programId :
	* @name : getQnaDetail
	* @date : 2019. 7. 5.
	* @author : dw.keum
	* @table :
	* @return : LOYQnaResponseDTO
	* @description :
	*/
	@RequestMapping(value = "/getQnaDetail.do" , method = RequestMethod.POST)
	public @ResponseBody LoyQnaResDto getQnaDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyQnaReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authhelper.checkLoginSession(request, response));
		return loyQnaService.getQnaDetail(reqDto);
	}
	
	/**
	* @programId :
	* @name : updateQnaDetail
	* @date : 2019. 7. 5.
	* @author : dw.keum
	* @table :
	* @return : StatusResponseDTO
	* @description :
	*/
	@RequestMapping(value = "/updateQnaDetail.do" , method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateQnaDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyQnaReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authhelper.checkLoginSession(request, response));
		return loyQnaService.updateQnaDetail(reqDto);
	}
	
	/**
	* @programId :
	* @name : getQnaDetail
	* @date : 2019. 7. 5.
	* @author : dw.keum
	* @table :
	* @return : LOYQnaResponseDTO
	* @description :
	*/
	@RequestMapping(value = "/qnaClearMaskMbr.do" , method = RequestMethod.POST)
	public @ResponseBody LoyQnaResDto qnaClearMaskMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyQnaReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authhelper.checkLoginSession(request, response));
		reqDto.setUri(request.getRequestURI());
		return loyQnaService.qnaClearMaskMbr(reqDto);
	}
}
