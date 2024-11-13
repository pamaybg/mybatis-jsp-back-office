package com.icignal.loyalty.promotion.offer.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.promotion.offer.dto.request.LoyGetOfferReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferDeleteRequestDTO;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferInsertReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferMstReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferProdReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferReqDto;
import com.icignal.loyalty.promotion.offer.dto.response.LOYGetOfferChnlResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LOYGetOfferProdResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferMstListResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferMstResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferUseLmtChnlResDto;
import com.icignal.loyalty.promotion.offer.service.LoyOfferService;




/**
 * @name : LOYOfferController.java
 * @date : 2017. 01. 03.
 * @author : 류동균
 * @description : 로얄티 오퍼 Controller
 */
@Controller
@RequestMapping("/loyalty/offer")
public class LoyOfferController extends BaseController {
	
	@Autowired
	private LoyOfferService loyOfferService;
	
	
	
	/**
	 * @programId : MKT_OFR_001
	 * @name : getListOffer
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_offer (오퍼마스터 테이블)
	 * @return : List<MKTOfferResponseDTO>
	 * 
	 * @description : 오퍼 목록 조회
	 */
	@RequestMapping(value = "/getListOffer.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyOfferResDto> getListOffer(
            HttpServletRequest request, HttpServletResponse response,
            @RequestBody LoyOfferReqDto mor) {
        LogUtil.param(this.getClass(), mor);
        
        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mor.setLoginInfo(loginInfo);
        
        GridPagingResDto<LoyOfferResDto> gprdto = loyOfferService.getListOffer(mor);
        
        return gprdto;
    }
	
    /**
     * @programId : PLOY_051
     * @name : getLoyOfferMstList
     * @date : 2017. 1. 3.
     * @author : dg.ryu
     * @table : mkt.mkt_offer_mst
     * @return : 
     * @description : 로얄티 오퍼 마스터 목록
     */
    @RequestMapping(value="/getLoyOfferMstList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyOfferMstListResDto> getLoyOfferMstList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyOfferMstReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	
    	param.setLoginInfo(this.checkLoginSession(request, response));
    	
    	return loyOfferService.getLoyOfferMstList(param);
    }
    
    /**
     * @programId : PLOY_051
     * @name : getLoyOfferDetail
     * @date : 2017. 1. 3.
     * @author : dg.ryu
     * @table : 
     * @return : 
     * @description : 로얄티 오퍼 상세 조회
     */
    @RequestMapping(value="/getLoyOfferDetail.do", method = RequestMethod.POST)
    public @ResponseBody LoyOfferMstResDto getLoyOfferDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyOfferMstReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        param.setLoginInfo(this.checkLoginSession(request, response));
        
        LoyOfferMstResDto rtnValue = new LoyOfferMstResDto();        
        rtnValue = loyOfferService.getLoyOfferDetail(param);
        
        return rtnValue;
    }
    
    /**
     * @programId : PLOY_051
     * @name : saveLoyOffer
     * @date : 2017. 1. 3.
     * @author : dg.ryu
     * @table : 
     * @return : 
     * @description : 로얄티 오퍼 저장
     */
    @RequestMapping(value="/saveLoyOffer.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto saveLoyOffer(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyOfferMstReqDto param) {
        LogUtil.param(this.getClass(), param);
         
        param.setLoginInfo(this.checkLoginSession(request, response));
        
        StatusResDto rtnValue = new StatusResDto();        
        rtnValue = loyOfferService.saveLoyOffer(param);
        
        return rtnValue;
    }
    
    /**
     * @programId : 
     * @name : checkActivatedCampaignUsingOffer
     * @date : 2017. 7. 12.
     * @author : jh.kim
     * @table : 
     * @return : Integer
     * @description : 오퍼를 사용하고 있는 활성화된 마케팅 개수 확인 
     */
    @RequestMapping(value="/checkActCamUsingOffer.do", method = RequestMethod.POST)
    public @ResponseBody Integer checkActCamUsingOffer(
            HttpServletRequest request, HttpServletResponse response, 
            @RequestBody LoyOfferMstReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        Integer rtnValue = loyOfferService.checkActCamUsingOffer(param);

        return rtnValue;
    }
    
    
    /**
     * @name : getOfferChnlList
     * @date : 2017. 7. 25.
     * @author : jun.lee
     * @return : GridPagingResDto
     * @description : 오퍼 관리 상세 내, 매장 리스트 출력
     */
    @RequestMapping(value="/getOfferChnlList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LOYGetOfferChnlResDto> getOfferChnlList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetOfferReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		param.setMemId(loginInfo.getId());
        
        return loyOfferService.getOfferChnlList(param);
    }
    
    /**
     * @name : insertOfferChnl
     * @date : 2017. 7. 25.
     * @author : jun.lee
     * @return : StatusResDto
     * @description : 오퍼 관리 상세 내, 매장 추가s
     */
    @RequestMapping(value="/insertOfferChnl.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto insertOfferChnl(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetOfferReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		param.setMemId(loginInfo.getId());
		StatusResDto rtnValue = new StatusResDto();        
        rtnValue = loyOfferService.insertOfferChnl(param);
        
        return rtnValue;
    }
    
    /**
     * @name : deleteOfferChnl
     * @date : 2017. 7. 25.
     * @author : jun.lee
     * @return : StatusResDto
     * @description : 오퍼 관리 상세 내, 매장 삭제
     */
    @RequestMapping(value="/deleteOfferChnl.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto deleteOfferChnl(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetOfferReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		param.setMemId(loginInfo.getId());
        
		StatusResDto rtnValue = new StatusResDto();        
        rtnValue = loyOfferService.deleteOfferChnl(param);
        
        return rtnValue;
    }
    
    /**
     * @name : getOfferProdList
     * @date : 2017. 7. 26.
     * @author : jun.lee
     * @return : GridPagingResDto
     * @description : 오퍼 관리 상세 내, 상품 리스트 조회
     */
    @RequestMapping(value="/getOfferProdList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LOYGetOfferProdResDto> getOfferProdList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetOfferReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		param.setMemId(loginInfo.getId());
        
        return loyOfferService.getOfferProdList(param);
    }
    
    /**
     * @name : insertOfferProd
     * @date : 2017. 7. 26.
     * @author : jun.lee
     * @return : StatusResDto
     * @description : 오퍼 관리 상세 내, 상품 추가
     */
    @RequestMapping(value="/insertOfferProd.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto insertOfferProd(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyOfferProdReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
	
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		param.setMemId(loginInfo.getId());
		StatusResDto rtnValue = new StatusResDto();        
        rtnValue = loyOfferService.insertOfferProd(param);
        
        return rtnValue;
    }
    
    /**
     * @name : deleteOfferProd
     * @date : 2017. 7. 26.
     * @author : jun.lee
     * @return : StatusResDto
     * @description : 오퍼 관리 상세 내, 상품 삭제
     */
    @RequestMapping(value="/deleteOfferProd.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto deleteOfferProd(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyOfferProdReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		param.setMemId(loginInfo.getId());
        
		StatusResDto rtnValue = new StatusResDto();        
        rtnValue = loyOfferService.deleteOfferProd(param);
        
        return rtnValue;
    }

    /**
     * @programId : 
     * @name : getLoyOfferUseLmtChnlList
     * @date : 2017. 11. 21.
     * @author : jh.kim
     * @table : 
     * @return : List<LOYLoyOfferUseLmtChnlResponseDTO>
     * @description : 오퍼별 제한채널 목록 조회
     */
    @RequestMapping(value="/getLoyOfferUseLmtChnlList.do", method = RequestMethod.POST)
    public @ResponseBody List<LoyOfferUseLmtChnlResDto> getLoyOfferUseLmtChnlList(
            HttpServletRequest request, HttpServletResponse response, 
            @RequestBody LoyGetOfferReqDto param) {
        LogUtil.param(this.getClass(), param);
         
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        
        return loyOfferService.getLoyOfferUseLmtChnlList(param);
    }
    
	/**
	 * @programId : MKT_OFR_002
	 * @name : setOffer
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_offer (오퍼마스터 테이블)
	 * @return : StatusResponseDTO
	 * @description : 오퍼 등록
	 */
	
	@RequestMapping(value = "/setOffer.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto setOffer(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyOfferInsertReqDto mor) {
		LogUtil.param(this.getClass(), mor);
		
        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mor.setLoginInfo(loginInfo);
        
        mor.setLoginInfo(loginInfo);
        mor.setMemId(loginInfo.getId());
		
	    return loyOfferService.setOffer(mor);
	}
	
	/**
	 * @programId : MKT_OFR_001
	 * @name : removeOffer
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_offer (오퍼마스터 테이블)
	 * @return : StatusResponseDTO
	 * @description : 오퍼 삭제
	 */
    @RequestMapping(value = "/removeOffer.do",
                    method = RequestMethod.POST)
    public @ResponseBody StatusResDto removeOffer(
            HttpServletRequest request, HttpServletResponse response, 
            @RequestBody LoyOfferDeleteRequestDTO mor) {
        LogUtil.param(this.getClass(), mor);
        
        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴 
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        
        //세션에 저장되어 있는 지원의 아이디를 셋팅 
        mor.setLoginInfo(loginInfo);
        
        StatusResDto rtn = loyOfferService.removeOffer(mor);
        return rtn;
    }

}