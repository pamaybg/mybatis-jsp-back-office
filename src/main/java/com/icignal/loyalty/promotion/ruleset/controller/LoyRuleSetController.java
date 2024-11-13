package com.icignal.loyalty.promotion.ruleset.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignStatusCheckReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyBrdCategoryListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyChannelListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyProdCategoryListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyProdListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyPromProdListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRuleSetReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetPromProductListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyTierListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyBrdCategoryListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyChannelListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyProdCategoryListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyProdListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyPromProdListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRuleSetResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetExcelUploadResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyTierListResDto;
import com.icignal.loyalty.promotion.ruleset.service.LoyRuleSetService;



@Controller
@RequestMapping("/loyalty/ruleSet")
public class LoyRuleSetController  extends BaseController{

	
	@Autowired private LoyRuleSetService loyRuleSetService;
	
	    /**
	     * 룰셋 정보조회
	     * 
	     * @programId : 
	     * @name : getRuleSet
	     * @date : 2017. 11. 30.
	     * @author : jh.kim
	     * @table : 
	     * @return : LOYRuleSetResponseDTO
	     * @description : 
	     */
	    @RequestMapping(value="/getRuleSet.do", method = RequestMethod.POST)
	    public @ResponseBody LoyRuleSetResDto getRuleSet(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyRuleSetReqDto param) {
	        LogUtil.param(this.getClass(), param);
	        
	        // 세션정보 조회
	        param.setLoginInfo(this.checkLoginSession(request, response));
	        
	        // 룰셋 정보조회
	        LoyRuleSetResDto rtnValue = new LoyRuleSetResDto();        
	        rtnValue = loyRuleSetService.getRuleSet(param);
	        
	        return rtnValue;
	    }
	    
	    /**
	     * @programId : 
	     * @name : saveRuleSet
	     * @date : 2016. 12. 19.
	     * @author : dg.ryu
	     * @table : 
	     * @return : 
	     * @description : RuleSet 저장
	     */
	    @RequestMapping(value="/saveRuleSet.do", method = RequestMethod.POST)
	    public @ResponseBody StatusResDto saveRuleSet(
	            HttpServletRequest request, HttpServletResponse response, 
	            @RequestBody LoyRuleSetReqDto param) {
	        //LogUtil.param(this.getClass(), param);
	         
	        param.setLoginInfo(this.checkLoginSession(request, response));
	        StatusResDto rtnValue = new StatusResDto();        
	        
	        rtnValue = loyRuleSetService.saveRuleSet(param);
	        return rtnValue;
	    }
	    
	    /**
	     * @programId : 
	     * @name : getTierList
	     * @date : 2016. 12. 19.
	     * @author : dg.ryu
	     * @table : loy.loy_tiers, loy.loy_tier_group
	     * @return : 
	     * @description : 등급 목록 조회
	     */
	    @RequestMapping(value="/getTierList.do", method = RequestMethod.POST)
	    public @ResponseBody GridPagingResDto<LoyTierListResDto> getTierList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierListReqDto param) {
	        LogUtil.param(this.getClass(), param);
	         
	        param.setLoginInfo(this.checkLoginSession(request, response));
	        
	        GridPagingResDto<LoyTierListResDto> rtnValue = new GridPagingResDto<>();
	        rtnValue = loyRuleSetService.getTierList(param);
	        
	        return rtnValue;
	    }
	    
	    /**
	     * @programId : PLOY_071
	     * @name : getLoyProdList
	     * @date : 2016. 12. 20.
	     * @author : dg.ryu
	     * @table : loy.loy_prod, loy.loy_prod_category
	     * @return : 
	     * @description : 상품 목록 조회
	     */
	    @RequestMapping(value="/getLoyProdList.do", method = RequestMethod.POST)
	    public @ResponseBody GridPagingResDto<LoyProdListResDto> getLoyProdList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdListReqDto param) {
	        LogUtil.param(this.getClass(), param);
	         
	        param.setLoginInfo(this.checkLoginSession(request, response));
	        
	        GridPagingResDto<LoyProdListResDto> rtnValue = new GridPagingResDto<>();
	        rtnValue = loyRuleSetService.getLoyProdList(param);
	        
	        return rtnValue;
	    }
	    
	    /**
	     * @programId : PLOY_071
	     * @name : getLoyProdCategoryList
	     * @date : 2016. 12. 20.
	     * @author : dg.ryu
	     * @table : loy.loy_prod, loy.loy_prod_category
	     * @return : 
	     * @description : 상품 카테고리 목록 조회
	     */
	    @RequestMapping(value="/getLoyProdCategoryList.do", method = RequestMethod.POST)
	    public @ResponseBody GridPagingResDto<LoyProdCategoryListResDto> getLoyProdCategoryList(
	    		HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdCategoryListReqDto param) {
	        LogUtil.param(this.getClass(), param);
	         
	        param.setLoginInfo(this.checkLoginSession(request, response));
	        
	        GridPagingResDto<LoyProdCategoryListResDto> rtnValue = new GridPagingResDto<>();
	        rtnValue = loyRuleSetService.getLoyProdCategoryList(param);
	        
	        return rtnValue;
	    }
	    
	    /**
	     * @programId : PLOY_071
	     * @name : getLoyBrdCategoryList
	     * @date : 2016. 12. 21.
	     * @author : dg.ryu
	     * @table : loy.loy_brd_category
	     * @return : 
	     * @description : 브랜드 카테고리 목록 조회
	     */
	    @RequestMapping(value="/getLoyBrdCategoryList.do", method = RequestMethod.POST)
	    public @ResponseBody GridPagingResDto<LoyBrdCategoryListResDto> getLoyBrdCategoryList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyBrdCategoryListReqDto param) {
	        LogUtil.param(this.getClass(), param);
	         
	        param.setLoginInfo(this.checkLoginSession(request, response));
	        
	        GridPagingResDto<LoyBrdCategoryListResDto> rtnValue = new GridPagingResDto<>();
	        rtnValue = loyRuleSetService.getLoyBrdCategoryList(param);
	        
	        return rtnValue;
	    }
	    
	    /**
	     * @programId : PLOY_071
	     * @name : getLoyChannelList
	     * @date : 2016. 12. 21.
	     * @author : dg.ryu
	     * @table : loy.loy_channel
	     * @return : 
	     * @description : 채널 목록 조회
	     */
	    @RequestMapping(value="/getLoyChannelList.do", method = RequestMethod.POST)
	    public @ResponseBody GridPagingResDto<LoyChannelListResDto> getLoyChannelList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChannelListReqDto param) {
	        LogUtil.param(this.getClass(), param);
	         
	        param.setLoginInfo(this.checkLoginSession(request, response));
	        
	        GridPagingResDto<LoyChannelListResDto> rtnValue = new GridPagingResDto<>();
	        rtnValue = loyRuleSetService.getLoyChannelList(param);
	        
	        return rtnValue;
	    }
	    
	    @RequestMapping(value="/excelDownloadChannelTemplate.do", method = RequestMethod.GET)
	    public void excelDownloadChannel(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    	LogUtil.debug("LOYRulesetController.excelDownloadChannelTemplate START");
	         
	        LoginResDto loginInfo = this.checkLoginSession(request, response);
	        //엑셀 템플릿 생성 (채널 전체목록 기본세팅)
	        //최신일 경우 기존 서버의 엑셀파일을 그대로 다운로드한다. (채널 최근 수정일시 기준)
	        String fileServerLocation = loyRuleSetService.createDownloadChannelTemplate(request, loginInfo);
	        if(ObjectUtil.isNotEmpty(fileServerLocation)) {
	        	loyRuleSetService.exportExcel(fileServerLocation, request, response);
	        }
	        
	        LogUtil.debug("LOYRulesetController.excelDownloadChannelTemplate END");
	    }
	    
	    @RequestMapping(value="/excelUploadChannelTemplate.do", method = RequestMethod.POST)
	    public @ResponseBody LoyRulesetExcelUploadResDto excelUploadChannelTemplate(
	            @RequestParam("file") MultipartFile file,
	            @RequestParam("camId") String camId,
	            @RequestParam("ridRuleset") String uploadFileType,
	    		HttpServletRequest request, HttpServletResponse response) {
	    	LoyRulesetExcelUploadResDto rtnValue = null;
	    	try {
		        LogUtil.debug("LOYRulesetController.excelUploadChannelTemplate START");
		         
		        rtnValue = new LoyRulesetExcelUploadResDto();
		        
		        LoginResDto loginInfo = this.checkLoginSession(request, response);
		        rtnValue = loyRuleSetService.excelUploadChannelTemplate(file, loginInfo);
		        
		        LogUtil.debug("LOYRulesetController.excelUploadChannelTemplate END. size : " + rtnValue.getAllUploadCnt());
		    } catch (IOException e) {
		    	LogUtil.error(e);
		    }
	        return rtnValue;
	    }
	    
	    
	    /**
	     * @programId : 
	     * @name : getAllTierList
	     * @date : 2019. 03. 07.
	     * @author : mj.pyo
	     * @table : loy.loy_tiers
	     * @return : 
	     * @description : 전체 등급 목록 조회
	     */
	    @RequestMapping(value="/getAllTierList.do", method = RequestMethod.POST)
	    public @ResponseBody GridPagingResDto<LoyTierListResDto> getAllTierList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierListReqDto param) {
	        LogUtil.param(this.getClass(), param);
	         
	        param.setLoginInfo(this.checkLoginSession(request, response));
	        
	        GridPagingResDto<LoyTierListResDto> rtnValue = new GridPagingResDto<>();
	        rtnValue = loyRuleSetService.getAllTierList(param);
	        
	        return rtnValue;
	    }
	    
	    /**
	     * @programId : 
	     * @name : getPromProdListNew
	     * @date : 2019. 04. 08.
	     * @author : dw.keum
	     * @table : 
	     * @return : 
	     * @description : 프로모션 상품 목록
	     */
	    @RequestMapping(value="/getPromProdListNew.do", method = RequestMethod.POST)
	    public @ResponseBody GridPagingResDto<LoyPromProdListResDto> getPromProdListNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromProdListReqDto param) {
	        LogUtil.param(this.getClass(), param);
	         
	        param.setLoginInfo(this.checkLoginSession(request, response));
	        
	        GridPagingResDto<LoyPromProdListResDto> rtnValue = new GridPagingResDto<>();
	        rtnValue = loyRuleSetService.getPromProdListNew(param);
	        
	        return rtnValue;
	    }
	    
	    /**
	     * @programId : 
	     * @name : getPromProductPopList
	     * @date : 2019. 04. 08.
	     * @author : dw.keum
	     * @table : 
	     * @return : 
	     * @description : 프로모션 상품 목록 팝업
	     */
	    @RequestMapping(value="/getPromProductPopListNew.do", method = RequestMethod.POST)
	    public @ResponseBody GridPagingResDto<LoyPromProdListResDto> getPromProductPopList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPromProdListReqDto param) {
	        LogUtil.param(this.getClass(), param);
	         
	        param.setLoginInfo(this.checkLoginSession(request, response));
	        
	        GridPagingResDto<LoyPromProdListResDto> rtnValue = new GridPagingResDto<>();
	        rtnValue = loyRuleSetService.getPromProductPopList(param);
	        
	        return rtnValue;
	    }
	    
	    /**
	     * @programId : 
	     * @name : getPromProductPopList
	     * @date : 2019. 04. 08.
	     * @author : dw.keum
	     * @table : 
	     * @return : 
	     * @description : 프로모션 상품 목록 팝업
	     */
	    @RequestMapping(value="/setPromProduct.do", method = RequestMethod.POST)
	    public @ResponseBody StatusResDto setPromProduct(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyRuleSetReqDto param) {
	        LogUtil.param(this.getClass(), param);
	         
	        param.setLoginInfo(this.checkLoginSession(request, response));
	        
	        StatusResDto rtnValue = new StatusResDto();
	        rtnValue = loyRuleSetService.setPromProduct(param);
	        
	        return rtnValue;
	    }
	    
	    /**
	     * @programId : 
	     * @name : getProductPromValid
	     * @date : 2019. 04. 08.
	     * @author : dw.keum
	     * @table : 
	     * @return : 
	     * @description : 프로모션 상품 중복체크
	     */
	    @RequestMapping(value="/getProductPromValid.do", method = RequestMethod.POST)
	    public @ResponseBody StatusResDto getProductPromValid(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyRuleSetReqDto param) {
	        LogUtil.param(this.getClass(), param);
	         
	        param.setLoginInfo(this.checkLoginSession(request, response));
	        
	        StatusResDto rtnValue = new StatusResDto();
	        rtnValue =	loyRuleSetService.getProductPromValid(param);
	        
	        return rtnValue;
	    }
	    
	    /**
	     * @programId : 
	     * @name : removeProductPromValid
	     * @date : 2019. 04. 08.
	     * @author : dw.keum
	     * @table : 
	     * @return : 
	     * @description : 프로모션 상품 삭제
	     */
	    @RequestMapping(value="/removeProductPromValid.do", method = RequestMethod.POST)
	    public @ResponseBody StatusResDto removeProductPromValid(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyRuleSetReqDto rsmr) { 
	        LogUtil.param(this.getClass(), rsmr);
	        StatusResDto rtnValue = new StatusResDto();
	        rsmr.setLoginInfo(this.checkLoginSession(request, response));
	        
	        rtnValue =	loyRuleSetService.removeProductPromValid(rsmr);
	        return rtnValue;
	    }
	    
	    /**
	     * @programId : 
	     * @name : removeProductPromValid
	     * @date : 2019. 04. 08.
	     * @author : dw.keum
	     * @table : 
	     * @return : 
	     * @description : 프로모션 상품 전체삭제
	     */
	    @RequestMapping(value="/removeProductPromAll.do", method = RequestMethod.POST)
	    public @ResponseBody StatusResDto removeProductPromAll(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyRulesetPromProductListReqDto rsmr) { 
	        LogUtil.param(this.getClass(), rsmr);
	        StatusResDto rtnValue = new StatusResDto();
	        rsmr.setLoginInfo(this.checkLoginSession(request, response));
	        
	        rtnValue =	loyRuleSetService.removeProductPromAll(rsmr);
	        return rtnValue;
	    }
	    
	    /**
	     * @programId : 
	     * @name : removeProductPromValid
	     * @date : 2019. 04. 08.
	     * @author : dw.keum
	     * @table : 
	     * @return : 
	     * @description : 프로모션 저장시 상품등록 여부 판단
	     */
	    @RequestMapping(value="/selectValidPromProd.do", method = RequestMethod.POST)
	    public @ResponseBody StatusResDto selectValidPromProd(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCampaignStatusCheckReqDto rsmr) { 
	        LogUtil.param(this.getClass(), rsmr);
	        StatusResDto rtnValue = new StatusResDto();
	        rsmr.setLoginInfo(this.checkLoginSession(request, response));
	        
	        rtnValue =	loyRuleSetService.selectValidPromProd(rsmr);
	        return rtnValue;
	    }
}
