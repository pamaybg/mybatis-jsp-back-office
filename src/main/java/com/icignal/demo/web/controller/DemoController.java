package com.icignal.demo.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.icignal.common.base.controller.BaseController;

@Controller
@RequestMapping("/demo")
public class DemoController extends BaseController {

	//이스타항공
    @RequestMapping(value = "/eastarJet/{name:.+}", method = RequestMethod.GET)
    public String NavigateMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response) {
        return this.checkUserInfoInclude(request, response, "demo/eastarJet/" + name + ".default-tiles");
    }
    
    //제주항공
    @RequestMapping(value = "/jejuair/{name:.+}", method = RequestMethod.GET)
    public String jejuairMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response) {
		return "demo/jejuair/" + name;
    }
    
    //한국인삼공사
	@RequestMapping(value = "/kgc/{name:.+}", method = RequestMethod.GET)
	public String kgcMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response) {
		return "demo/kgc/" + name;
	}

	//한국인삼공사
	@RequestMapping({ "/kgc/popup/{name:.+}" })
	public String kgcPopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response) {
		return "demo/kgc/popup/" + name;
	}
	
	//한국인삼공사
	@RequestMapping(value = "/kgc/front/{name:.+}", method = RequestMethod.GET)
	public String kgcFrontMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response) {
		return "demo/kgc/" + name;
	}
	
	//오픈캠페인
	@RequestMapping(value = "/openCampaign/{name:.+}", method = RequestMethod.GET)
	public String fbMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response) {
		return "demo/openCampaign/" + name;
	}
	
	//메가뱅크
	@RequestMapping(value = "/bankmega/{name:.+}", method = RequestMethod.GET)
	public String bankmegaMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response) {
		return "demo/bankmega/" + name + ".popup-tiles";
	}
	
	//한국인삼공사
	@RequestMapping({ "/koreanair/popup/{name:.+}" })
	public String kePopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response) {
		return "demo/koreanair/popup/" + name;
	}
	
	//한국인삼공사
	@RequestMapping({ "/koreanair/winpopup/{name:.+}" })
	public String keWinPopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response) {
		return "demo/koreanair/popup/" + name +".popup-tiles";
	}


}
