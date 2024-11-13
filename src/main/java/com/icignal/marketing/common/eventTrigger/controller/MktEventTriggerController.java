 package com.icignal.marketing.common.eventTrigger.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.common.base.controller.BaseController;
import com.icignal.common.util.LogUtil;
import com.icignal.marketing.common.eventTrigger.dto.request.MktEventTriggerReqDto;
import com.icignal.marketing.common.eventTrigger.dto.response.MktEventTriggerResDto;
import com.icignal.marketing.common.eventTrigger.service.MktEventTriggerService;


/**
 * @name : MKTCommonController.java
 * @date : 2016. 06. 09.
 * @author : 류동균
 * @description : 공통
 */
@Controller
@RequestMapping("/marketing/api")
public class MktEventTriggerController extends BaseController {
	
	@Autowired
	private MktEventTriggerService mktEventTriggerService;
	
	
    /**
     * @programId : 
     * @name : eventTrigger
     * @date : 2016. 11. 24.
     * @author : dg.ryu
     * @table : 
     * @return : 
     * @description : 이벤트 트리거
     */
    @RequestMapping(value="/eventTrigger.do", method = RequestMethod.POST)
    public @ResponseBody MktEventTriggerResDto eventTrigger(HttpServletRequest request, HttpServletResponse response, @RequestBody MktEventTriggerReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        //param.setLoginInfo(this.checkLoginSession(request, response));
        
        MktEventTriggerResDto rtnValue = new MktEventTriggerResDto();        
        rtnValue = mktEventTriggerService.eventTrigger(param);
        
        return rtnValue;
    }
    
    @RequestMapping(value="/syncEventTrigger.do", method = RequestMethod.POST)
    public @ResponseBody MktEventTriggerResDto syncEventTrigger(HttpServletRequest request, HttpServletResponse response, @RequestBody MktEventTriggerReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        //param.setLoginInfo(this.checkLoginSession(request, response));
        
        MktEventTriggerResDto rtnValue = new MktEventTriggerResDto();        
        rtnValue = mktEventTriggerService.syncEventTrigger(param);
        
        return rtnValue;
    }
    

}