package com.icignal.offer.controller;

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
import com.icignal.offer.dto.request.ChildOfferReqDto;
import com.icignal.offer.dto.request.OfferGroupReqDto;
import com.icignal.offer.dto.response.ChildOfferResDto;
import com.icignal.offer.dto.response.OfferGroupResDto;
import com.icignal.offer.service.OfferGroupService;

/*
 * 1. 클래스명	: OfferGroupController
 * 2. 파일명	: OfferGroupController.java
 * 3. 패키지명	: com.icignal.loyalty.membership.controller
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/offerGroup")
public class OfferGroupController extends BaseController {
	
	@Autowired
	private OfferGroupService offerGroupService;
	
	@Autowired
	AuthHelper authHelper;

	
	@RequestMapping(value = "/getOfferGroupList.do", method = RequestMethod.POST )
	public @ResponseBody GridPagingResDto<OfferGroupResDto> getOfferGroupList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody OfferGroupReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerGroupService.getOfferGroupList(slr);
	}

	@RequestMapping(value = "/getOfferGroupDetail.do", method = RequestMethod.POST)
	public @ResponseBody OfferGroupResDto getOfferGroupDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferGroupReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerGroupService.getOfferGroupDetail(slr);
	}
	
	@RequestMapping(value = "/addOfferGroup.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertOfferGroup(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferGroupReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerGroupService.insertOfferGroup(slr);

		return rtnValue;
	}
	
	@RequestMapping(value = "/editOfferGroup.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateOfferGroup(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferGroupReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerGroupService.updateOfferGroup(slr);

		return rtnValue;
	}
	
	@RequestMapping(value = "/removeOfferGroup.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteOfferGroup(HttpServletRequest request, HttpServletResponse response,
			@RequestBody OfferGroupReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerGroupService.deleteOfferGroup(slr);

		return rtnValue;
	}
	
	@RequestMapping(value = "/getChildOfferList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<ChildOfferResDto> getChildOfferList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody ChildOfferReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerGroupService.getChildOfferList(slr);
	}

	@RequestMapping(value = "/getChildOfferDetail.do", method = RequestMethod.POST)
	public @ResponseBody ChildOfferResDto getChildOfferDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody ChildOfferReqDto slr) {

		LogUtil.param(this.getClass(), slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return offerGroupService.getChildOfferDetail(slr);
	}
	
	@RequestMapping(value = "/addChildOffer.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertChildOffer(HttpServletRequest request, HttpServletResponse response,
			@RequestBody ChildOfferReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerGroupService.insertChildOffer(slr);

		return rtnValue;
	}
	
	@RequestMapping(value = "/editChildOffer.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateChildOffer(HttpServletRequest request, HttpServletResponse response,
			@RequestBody ChildOfferReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerGroupService.updateChildOffer(slr);

		return rtnValue;
	}
	
	@RequestMapping(value = "/removeChildOffer.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteChildOffer(HttpServletRequest request, HttpServletResponse response,
			@RequestBody ChildOfferReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = offerGroupService.deleteChildOffer(slr);

		return rtnValue;
	}
}
