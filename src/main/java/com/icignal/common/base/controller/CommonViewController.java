package com.icignal.common.base.controller;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.apiservice.dto.response.WebServiceSearchZipCodeResDto;
import com.icignal.common.base.dto.request.ComCondLogInsertReqDto;
import com.icignal.common.base.dto.request.CommonCodeReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.LoyChnlListResDto;
import com.icignal.common.base.dto.response.LoyMbrListPopResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonViewService;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.campaign.dto.request.LoyCamMstListReqDto;
import com.icignal.loyalty.channel.dto.response.LoyCamMstListResDto;
import com.icignal.loyalty.club.dto.request.LoyClubListReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubOfferDetailReqDto;
import com.icignal.loyalty.club.dto.response.LoyClubOfferListResDto;
import com.icignal.loyalty.common.dto.request.LoyCommonReqDto;
import com.icignal.loyalty.common.dto.request.LoyExcelExportReqDto;
import com.icignal.loyalty.common.dto.request.LoyWebServiceSearchZipCodeReqDto;
import com.icignal.loyalty.common.dto.response.LOYChnlTransReqDto;
import com.icignal.loyalty.common.dto.response.LoyMbrMstListResDto;
import com.icignal.loyalty.common.dto.response.LoyPointDtlListResDto;
import com.icignal.loyalty.common.dto.response.LoyPurItemListResDto;
import com.icignal.loyalty.common.dto.response.LoyPurPayListResDto;
import com.icignal.loyalty.common.dto.response.LoyTierGrpListResDto;
import com.icignal.loyalty.product.dto.response.LoyCategoryListResDto;
import com.icignal.loyalty.product.dto.response.LoyPgmListResDto;
import com.icignal.loyalty.product.dto.response.LoyProdListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierNewPageReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierListNewPageResDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthGroupEmployeeModalReqDto;
import com.icignal.systemmanagement.auth.dto.response.SystemAuthGroupEmployeeModalResDto;
import com.icignal.systemmanagement.commcode.dto.request.CommonSelectBoxListReqDto;
import com.icignal.systemmanagement.commcode.dto.request.ICNCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.CommonSelectBoxListResDto;
import com.icignal.systemmanagement.commcode.dto.response.ICNCommonCodeResponseDTO;
import com.icignal.systemmanagement.systemmgt.dto.request.SystemMgtListReqDto;
import com.icignal.systemmanagement.systemmgt.dto.response.SystemMgtListResDto;

@Controller
@RequestMapping("/common/view")
public class CommonViewController extends BaseController {

	@Autowired
	private CommonViewService commonViewService;

	@Autowired
	AuthHelper authHelper;
	
		@Override
		@RequestMapping(value = "/popup/{name:.+}")
		public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
			//System.out.println("NavigatePopMenu start.....");
			
			RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
			Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
			String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
			String respUrl = requestPath + "/popup/" +  name + ".modal-tiles";

			if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
			return null;		}
	
		@Override
		@RequestMapping(value = "/include/{name:.+}")
		public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
			RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
			Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
			String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
			String respUrl = requestPath + "/include/" + name + ".include-tiles";
			if( checkIncludeProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
			return null;
		}
	
		@RequestMapping(value = "/winpop/{name:.+}")
		public String NavigateWinpopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response) {
			return authHelper.checkUserInfoInclude(request, response, "/common/view/winpop/" + name + ".popup-tiles");
		}


	  /**
     * @programId : POP_901
     * @name : getTierGrpList
     * @date : 2016. 11. 14.
     * @author : 이경남
     * @table :
     * @return :
     * @description : 등급그룹 목록 조회
     */
    @RequestMapping(value="/getTierGrpPopup.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyTierGrpListResDto> getTierGrpList(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyCommonReqDto slr) {

        LogUtil.param(this.getClass(), slr);

        slr.setLoginInfo(authHelper.checkLoginSession(request, response));

        return commonViewService.getTierGrpList(slr);

    }


	  /**
     * @programId : POP_900
     * @name : getChnlList
     * @date : 2016. 11. 14.
     * @author : 이경남
     * @table : loy_channel
     * @return : GridPagingResDto
     * @description : 채널마스터 조회
     */
    @RequestMapping(value="/getChnlPopup.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyChnlListResDto> getChnlList(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyCommonReqDto slr) {

        LogUtil.param(this.getClass(), slr);

        slr.setLoginInfo(authHelper.checkLoginSession(request, response));

        return commonViewService.getChnlList(slr);

    }
    
    /**
     * @programId : POP_900
     * @name : getChnlList
     * @date : 2016. 11. 14.
     * @author : 이경남
     * @table : loy_channel
     * @return : GridPagingResDto
     * @description : 채널마스터 조회
     */
    @RequestMapping(value="/getChnlMulitPopup.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyChnlListResDto> getChnlMulitPopup(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyCommonReqDto slr) {

        LogUtil.param(this.getClass(), slr);

        slr.setLoginInfo(authHelper.checkLoginSession(request, response));

        return commonViewService.getChnlMulitPopup(slr);

    }
    
    /**
     * @programId : POP_900
     * @name : getChnlList
     * @date : 2016. 11. 14.
     * @author : 이경남
     * @table : loy_channel
     * @return : GridPagingResDto
     * @description : 채널마스터 조회
     */
    @RequestMapping(value="/getChnlMulitExcPopup.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyChnlListResDto> getChnlMulitExcPopup(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyCommonReqDto slr) {

        LogUtil.param(this.getClass(), slr);

        slr.setLoginInfo(authHelper.checkLoginSession(request, response));

        return commonViewService.getChnlMulitExcPopup(slr);

    }


    /**
	 *
	 * @programId : POP_906
	 * @name : getCamMstListPop
	 * @date : 2016. 12. 07.
	 * @author : 이원준
	 * @table : mkt_cam_mst, mkt_cam_offer_rel, mkt_offer_mst
	 * @return : GridPagingResDto
	 * @description : 캠페인 마스터 조회
	 */
    @RequestMapping(value="/getCamMstListPop.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyCamMstListResDto> getCamMstListPop(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyCamMstListReqDto slr) {
    	LogUtil.param(this.getClass(), slr);

    	slr.setLoginInfo(authHelper.checkLoginSession(request, response));
    	
    	return commonViewService.getCamMstListPop(slr);
    }

    /**
	 *
	 * @programId : POP_908
	 * @name : getCategoryList
	 * @date : 2016. 12. 13.
	 * @author : 이원준
	 * @table : loy_prod_category
	 * @return : GridPagingResDto
	 * @description : 상품 카테고리 조회
	 */
    @RequestMapping(value="/getCategoryListPop.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyCategoryListResDto> getCategoryList(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyCommonReqDto slr) {
    	LogUtil.param(this.getClass(), slr);

    	slr.setLoginInfo(authHelper.checkLoginSession(request, response));

    	return commonViewService.getCategoryList(slr);
    }

    /**
	 *
	 * @programId : POP_908
	 * @name : getCategoryList
	 * @date : 2016. 12. 13.
	 * @author : 이원준
	 * @table : loy_prod
	 * @return : GridPagingResDto
	 * @description : 상품  조회
	 */
    @RequestMapping(value="/getProdListPop.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyProdListResDto> getProdListPop(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyCommonReqDto slr) {
    	LogUtil.param(this.getClass(), slr);

    	slr.setLoginInfo(authHelper.checkLoginSession(request, response));

    	return commonViewService.getProdListPop(slr);
    }


    /**
   	 *
   	 * @programId : POP_909
   	 * @name : getPgmList
   	 * @date : 2016. 12. 25.
   	 * @author : knlee
   	 * @table : loy_pgm
   	 * @return : GridPagingResDto
   	 * @description : 상품 카테고리 조회
   	 */
       @RequestMapping(value="/getPgmPopup.do", method = RequestMethod.POST)
       public @ResponseBody  GridPagingResDto<LoyPgmListResDto> getPgmList(HttpServletRequest request, HttpServletResponse response,
       		@RequestBody LoyCommonReqDto reqDto) {
       	LogUtil.param(this.getClass(), reqDto);
       	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       	return commonViewService.getPgmList(reqDto);
       }

       /**
        *
        * @programId : POP_902
        * @name : getMbrMstPop
        * @date : 2016. 01. 05
        * @author : knlee
        * @table : loy_mbr, loy_chnl_mbr, loy_cust
        * @return : GridPagingResDto
        * @description : 회원마스터  조회
        */
       @RequestMapping(value="/getMbrMstPop.do", method = RequestMethod.POST)
       public @ResponseBody  GridPagingResDto<LoyMbrMstListResDto> getMbrMstPop(HttpServletRequest request, HttpServletResponse response,
    		   @RequestBody LoyCommonReqDto reqDto) {
    	   LogUtil.param(this.getClass(), reqDto);
    	   reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

    	   return commonViewService.getMbrMstPop(reqDto);
       }

       /**
       *
       * @programId :
       * @name : getPointDtlPopupList
       * @date : 2016. 02. 20
       * @author : 이성원
       * @table : loy_pnt_txn , loy_pnt_arcl, loy_pnt_rdm
       * @return : GridPagingResDto
       * @description : 포인트 상세 조회 팝업
       */

   	@RequestMapping(value = "/getPointDtlPopupList.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyPointDtlListResDto> getPointDtlPopupList(HttpServletRequest request, HttpServletResponse response,
   			@RequestBody LoyCommonReqDto reqDto) {

    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
    	
    	return commonViewService.getPointDtlListPop(reqDto);
   	}



	 /*
	  * 1. 메소드명: getZipCodeList
	  * 2. 클래스명: CommonViewController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
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
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getZipCodeList.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<WebServiceSearchZipCodeResDto> getZipCodeList(HttpServletRequest request, HttpServletResponse response,
   			@RequestBody LoyWebServiceSearchZipCodeReqDto reqDto) throws ParseException {

    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return commonViewService.getZipCodeList(reqDto);
   	}

    /**
     * @programId :
     * @name : getPurItemDtlPopList
     * @date : 2017. 6. 29.
     * @author : "jh.kim"
     * @table :
     * @return : GridPagingResDto
     * @description : 항목 상세 목록 조회
     */
    @RequestMapping(value = "/getPurItemDtlPopList.do",
                    method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyPurItemListResDto> getPurItemDtlPopList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCommonReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return commonViewService.getPurItemList(reqDto);
    }

    /**
     * @programId :
     * @name : getPurPayDtlPopList
     * @date : 2017. 6. 29.
     * @author : "jh.kim"
     * @table :
     * @return : GridPagingResDto
     * @description : 결제 상세 목록 조회
     */
    @RequestMapping(value = "/getPurPayDtlPopList.do",
                    method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyPurPayListResDto> getPurPayDtlPopList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCommonReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return commonViewService.getPurPayList(reqDto);
    }

    /**
     * @programId :
     * @name : clearMaskPurPayDtl
     * @date : 2017. 7. 11.
     * @author : jh.kim
     * @table :
     * @return : GridPagingResDto
     * @description : 결제 상세 마스킹 해제 정보 조회
     */
    @RequestMapping(value = "/clearMaskPurPayDtl.do",
                    method = RequestMethod.POST)
    public @ResponseBody LoyPurPayListResDto clearMaskPurPayDtl(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCommonReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        reqDto.setUri(request.getRequestURI());
        
        return commonViewService.clearMaskPurPayDtl(reqDto);
    }

	/**
     *
     * @programId :
     * @name : excelExport
     * @date : 2017. 04. 26
     * @author : 이성원
     * @table :
     * @return : StatusResDto
	 * @throws IOException
	 * @description : 엑셀 export
     */
    @RequestMapping(value = "/excelExport.do",
                    method = RequestMethod.POST)
    public @ResponseBody StatusResDto excelExport(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyExcelExportReqDto reqDto) throws IOException {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        reqDto.setRequest(request);
        reqDto.setResponse(response);
        return commonViewService.excelExport(reqDto);

    }
    
	    /**
	     * @programId :
	     * @name : transChnl
	     * @date : 2017. 12. 27.
	     * @author : swlim
	     * @table :
	     * @return : StatusResDto
	     * @description : 채널 전송
	     */
	   @RequestMapping(value="/transChnl.do", method = RequestMethod.POST)
 	    public @ResponseBody  StatusResDto transChnl(HttpServletRequest request, HttpServletResponse response,
 	    	   @RequestBody LOYChnlTransReqDto reqDto) {
 	        LogUtil.param(this.getClass(), reqDto);
 	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
 	        return commonViewService.transChnl(reqDto);
 	    }
	   
	    /*
	  * 1. 메소드명: getCommCodeList2
	  * 2. 클래스명: CommonViewController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
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
	 *   @param bccr
	 *   @return	
	 */
	@RequestMapping(value="/getCommCodeList2.do", method = RequestMethod.POST)
		public @ResponseBody
		GridPagingResDto<ICNCommonCodeResponseDTO> getCommCodeList2(HttpServletRequest request, HttpServletResponse response, @RequestBody CommonCodeReqDto bccr) {
			LogUtil.param(this.getClass(), bccr);

			authHelper.checkLoginSession(request, response);
			return commonViewService.getCommCodeList2(bccr);
		}
	
	 /*
	  * 1. 메소드명: getCommCodeList
	  * 2. 클래스명: CommonViewController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
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
	 *   @param bccr
	 *   @return	
	 */
	@RequestMapping(value="/getCommCodeList1.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<ICNCommonCodeResponseDTO> getCommCodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody ICNCommonCodeRequestDTO bccr) {
		LogUtil.param(this.getClass(), bccr);
		authHelper.checkLoginSession(request, response);
		
		return commonViewService.getCommCodeList1(bccr);
	}
	
	/**
	* @programId :
	* @name : setComCondLog
	* @date : 2019. 1. 25.
	* @author : hy.jun
	* @table :
	* @return : StatusResponseDTO
	* @description : 공통조회조건 포함한 조회쿼리 호출 로그 등록
	*/
	@RequestMapping(value="/setComCondLog.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setComCondLog(HttpServletRequest request, HttpServletResponse response,
			@RequestBody ComCondLogInsertReqDto param) {
		LogUtil.param(this.getClass(), param);

		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		return commonViewService.setComCondLog(param);
	}
	
	 /*
	  * 1. 메소드명: getOfferListPop
	  * 2. 클래스명: CommonViewController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오퍼 목록 조회 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/getOfferListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyClubOfferListResDto> getOfferListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubOfferDetailReqDto param){
		LogUtil.param(this.getClass(),param);
		
		return commonViewService.getOfferListPop(param);
	}
	
	@RequestMapping(value="/getOfferIssListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyClubOfferListResDto> getOfferIssListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubOfferDetailReqDto param){
		LogUtil.param(this.getClass(),param);
		
		return commonViewService.getOfferIssListPop(param);
	}
	
	@RequestMapping(value="/getSelectBoxList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<CommonSelectBoxListResDto> getSelectBoxList(HttpServletRequest request, HttpServletResponse response, @RequestBody CommonSelectBoxListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		authHelper.checkLoginSession(request, response);
		return commonViewService.getSelectBoxList(bccr);
	}

	@RequestMapping(value="/getCommTierListPop.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<LoyTierListNewPageResDto> getTierListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTierNewPageReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		authHelper.checkLoginSession(request, response);
		return commonViewService.getTierListPop(bccr);
	}
	
	@RequestMapping(value="/getEmpList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAuthGroupEmployeeModalResDto> getEmpList(HttpServletRequest request, HttpServletResponse response, 
			@RequestBody SystemAuthGroupEmployeeModalReqDto bagem) {
		
		LogUtil.param(this.getClass(), bagem);
		
		LoginResDto userInfo =  this.checkLoginSession(request, response);
		bagem.setEmpId(userInfo.getId());
		return commonViewService.getEmpList(bagem);
	}
	
	 /*
	  * 1. 메소드명: getSystemMgtList
	  * 2. 클래스명: CommonViewController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사이트 관리 리스트 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param bagem
	 *   @return	
	 */
	@RequestMapping(value="/getSystemMgtListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemMgtListResDto> getSystemMgtListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemMgtListReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		return commonViewService.getSystemMgtListPop(param);
	}
	
	 /*
	  * 1. 메소드명: getMbrListPop
	  * 2. 클래스명: CommonViewController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 찾기 팝업(같은 프로그램)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getMbrListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyMbrListPopResDto> getMbrListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubListReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return commonViewService.getMbrListPop(reqDto);
	}
	
	@RequestMapping(value="/getCommCodeListNew.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<ICNCommonCodeResponseDTO> getCommCodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody CommonCodeReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		authHelper.checkLoginSession(request, response);
		return commonViewService.getCommCodeListNew(bccr);
	}
	
	@RequestMapping(value="/getCommCodeItemList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<ICNCommonCodeResponseDTO> getCommCodeItemList(HttpServletRequest request, HttpServletResponse response, @RequestBody CommonCodeReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		authHelper.checkLoginSession(request, response);
		return commonViewService.getCommCodeItemList(bccr);
	}
	 /*
	  * 1. 메소드명: getOfferListPop
	  * 2. 클래스명: CommonViewController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오퍼 목록 조회 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value="/getOfferListPopVoc.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyClubOfferListResDto> getOfferListPopVoc(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubOfferDetailReqDto param){
		LogUtil.param(this.getClass(),param);
		
		return commonViewService.getOfferListPopVoc(param);
	}
	
}
