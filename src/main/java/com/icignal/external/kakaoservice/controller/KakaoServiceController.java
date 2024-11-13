package com.icignal.external.kakaoservice.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.util.LogUtil;
import com.icignal.external.kakaoservice.dto.request.LoyChannelAdrSearchReqDto;
import com.icignal.external.kakaoservice.dto.request.LoyChannelLocationReqDto;
import com.icignal.external.kakaoservice.service.KakaoService;
import com.icignal.loyalty.channel.dto.request.LoyChnlMasterReqDto;
import com.icignal.systemmanagement.auth.service.SystemAuthService;

@Controller
@RequestMapping("/external/kakaoservice")
public class KakaoServiceController extends BaseController {
	
	@Autowired
    KakaoService kakaoService;
	
	@Autowired
	AuthHelper authHelper;
	
	@Autowired SystemAuthService systemAuthService;
	
    /**
    * @programId :
    * @name : callGetAddrApi
    * @date : 2018. 10. 19.
    * @author : hy.jun
    * @table :
    * @return : JSONObject
    * @description : 채널 주소 검색 (B2C 웹서비스 호출 (=카카오 로컬api))
    */
    @RequestMapping(value="/callGetAddrApi.do", method = RequestMethod.POST)
    public @ResponseBody JSONObject callGetAddrApi(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChannelAdrSearchReqDto param) {
    	LogUtil.param(KakaoServiceController.class, param);

    	return kakaoService.callGetAddrApi(param);
    }
    
    
    
    /**
     * @programId :
     * @name : callGetAddrXYApi
     * @date : 2018. 10. 19.
     * @author : hy.jun
     * @table :
     * @return : JSONObject
     * @description : 채널 위경도 검색 (B2C 웹서비스 호출 (=카카오 로컬api))
     */
    @RequestMapping(value="/callGetAddrXYApi.do", method = RequestMethod.POST)
    public @ResponseBody JSONObject callGetAddrXYApi(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChannelAdrSearchReqDto param) {
    	LogUtil.param(KakaoServiceController.class, param);
    	
    	return kakaoService.callGetAddrXYApi(param);
    }
    


     /*
      * 1. 메소드명: callKakaoApi
      * 2. 클래스명: KakaoServiceController
      * 3. 작성자명: dw.keum
      * 4. 작성일자: 2019. 10. 15.
      */
    /**
     * <PRE>
     * 1. 설명
     *		
     * 2. 사용법
     *		
     * </PRE>
     *   @param request
     *   @param response
     *   @param reqDTO
     *   @return	
     */
    @RequestMapping(value="/callKakaoApi.do", method = RequestMethod.POST)
    public @ResponseBody JSONObject callKakaoApi(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlMasterReqDto reqDTO) {
    	LogUtil.param(KakaoServiceController.class, reqDTO);
    	
    	return kakaoService.callKakaoApi(reqDTO);
    }
    
    @RequestMapping(value="/callGetSiGugun.do", method = RequestMethod.POST)
    public @ResponseBody JSONObject callGetSiGugun(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChannelLocationReqDto param) {
    	LogUtil.param(KakaoServiceController.class, param);

    	return kakaoService.callGetSiGugun(param);
    }
    
    

}
