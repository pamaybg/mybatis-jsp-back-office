package com.icignal.loyalty.membership.controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.loyalty.membership.dto.response.*;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.LoyCampaignExecListResDto;
import com.icignal.common.base.dto.response.LoyChnlListResDto;
import com.icignal.common.base.dto.response.LoyMbrListPopResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.AUTH_GROUP_TYPE_CD;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.loyalty.benefit.point.dto.request.LoyMbrPtnTxnHistReqDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyMbrPtnTxnHistListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyMbrPtnTxnHistResDto;
import com.icignal.loyalty.benefit.point.service.LoyTransService;
import com.icignal.loyalty.club.dto.request.LoyClubOfferDetailReqDto;
import com.icignal.loyalty.club.dto.response.LoyClubOfferListResDto;
import com.icignal.loyalty.common.dto.request.LoyCommonReqDto;
import com.icignal.loyalty.customer.controller.LoyCustomerController;
import com.icignal.loyalty.customer.dto.request.LoyCustBranchReqDto;
import com.icignal.loyalty.customer.dto.response.LoyCustBranchResDto;
import com.icignal.loyalty.family.dto.request.LoyFamilyListReqDto;
import com.icignal.loyalty.family.dto.response.LoyFamilyCallbackResDto;
import com.icignal.loyalty.loyprogram.dto.request.LoyCustItemConfReqDto;
import com.icignal.loyalty.loyprogram.dto.response.LoyCustItemConfListResDto;
import com.icignal.loyalty.membership.dto.request.LoyDropMbrReqDto;
import com.icignal.loyalty.membership.dto.request.LoyDropReasonReqDto;
import com.icignal.loyalty.membership.dto.request.LoyDupMbrReqDto;
import com.icignal.loyalty.membership.dto.request.LoyEmpSearchHelpReqDto;
import com.icignal.loyalty.membership.dto.request.LoyExecutivesViewReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrCarHistReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrChangeHistListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrChnlHistContentsReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrDetailInfoReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrDivListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrDormancyPntListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrEditPntUsePwReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrFamilyListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupAddInfoReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupCardListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupCardReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupClubReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrIntDetailReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrIntactPurReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrItemReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrMemberCardListResDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrMgtInfoReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPasswordReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPntYnReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPointAcrlReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPointAuthReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPointLimitReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrProcReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrProdCustListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrRecomHistoryReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrRenameReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrSearchHelpReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrStnPntTxnDetailListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrStnPntTxnListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrTierBenefitHistReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrTiersDetailReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrTmAgrHistReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrUploadItemReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrVocListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyNegativeAccReqDto;
import com.icignal.loyalty.membership.dto.request.LoyNewCustAddReqDto;
import com.icignal.loyalty.membership.dto.request.LoyPontBalanceB2cReqDto;
import com.icignal.loyalty.membership.dto.request.LoyTierApprovalReqDto;
import com.icignal.loyalty.membership.dto.request.LoyTransPointListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyVocPntTxnReqDto;
import com.icignal.loyalty.membership.service.LoyMbrService;
import com.icignal.loyalty.membershipcard.cardmember.dto.request.LoyMbrCardListReqDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.request.LoyMbrCardReqDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.response.LoyMbrCardListResDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.response.LoyMbrCardResDto;
import com.icignal.loyalty.membershipcard.cardmember.service.LoyMemberCardService;
import com.icignal.loyalty.terms.memberterm.dto.request.LoyMbrTermsHistListReqDto;
import com.icignal.loyalty.terms.memberterm.dto.response.LoyMbrTermsHistListResDto;
import com.icignal.loyalty.terms.memberterm.service.LoyMemberTermService;
import com.icignal.loyalty.terms.termmaster.dto.request.LoyTermsListReqDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsRcvChnlListResDto;
import com.icignal.loyalty.tiers.membertier.dto.request.LoyMbrTierHistListReqDto;
import com.icignal.loyalty.tiers.membertier.dto.request.LoyMbrTierHistReqDto;
import com.icignal.loyalty.tiers.membertier.dto.request.LoyMbrTierReqDto;
import com.icignal.loyalty.tiers.membertier.dto.response.LoyMbrTierHistListResDto;
import com.icignal.loyalty.tiers.membertier.dto.response.LoyMbrTierHistResDto;
import com.icignal.loyalty.tiers.membertier.dto.response.LoyMbrTierResDto;
import com.icignal.loyalty.tiers.membertier.service.LoyMemberTiersService;


/*
 * 1. 클래스명	: LoyMbrController
 * 2. 파일명	: LoyMbrController.java
 * 3. 패키지명	: com.icignal.loyalty.membership.controller
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 7.
 */
/**
 * <PRE>r
 * 1. 멤버십 회원 컨트롤러
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/member/mbr")
public class LoyMbrController extends BaseController {



	@Autowired
	private LoyMbrService loyMbrService;

	@Autowired
	private LoggingHelper loggingHelper;

	@Autowired
	private LoyTransService loyTransService;

	@Autowired
	private LoyMemberTiersService loyMemberTiersService;

	@Autowired
	private LoyMemberCardService loyMemberCardService;

	@Autowired
	private LoyMemberTermService loyMemberTermService;

	@Autowired
	private AuthHelper authHelper;

		 /*
		  * 1. 메소드명: getMbrList
		  * 2. 클래스명: LoyMbrController
		  * 3. 작성자명: jh.seo
		  * 4. 작성일자: 2020. 2. 27.
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
		 *   @throws Exception
		 */
		@RequestMapping(value="/getMbrList.do", method = RequestMethod.POST)
	    public @ResponseBody   GridPagingResDto<LoyMbrResDto> getMbrList( HttpServletRequest request, HttpServletResponse response,@RequestBody LoyMbrReqDto reqDto) throws Exception {
	    	LogUtil.param(this.getClass(), reqDto);
	    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        return loyMbrService.getMbrList(reqDto);

	    }

	     /*
	      * 1. 메소드명: getMbrDetail
	      * 2. 클래스명: LoyMbrController
	      * 3. 작성자명: jh.seo
	      * 4. 작성일자: 2020. 2. 27.
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
	     *   @throws Exception
	     */
	    @RequestMapping(value="/getMbrDetail.do", method = RequestMethod.POST)
	    public @ResponseBody  LoyMbrItemResDto getMbrDetail(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrItemReqDto reqDto) throws Exception {

	        LogUtil.param(this.getClass(), reqDto);
	        //서비스 요청 로그 등록
	    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	loggingHelper.addServiceReqLog(request, reqDto.getRid());
	        return loyMbrService.getMbrDetail(reqDto);
	    }

	     /*
	      * 1. 메소드명: addMbr
	      * 2. 클래스명: LoyMbrController
	      * 3. 작성자명: jh.seo
	      * 4. 작성일자: 2020. 2. 27.
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
	    @RequestMapping(value="/addMbr.do", method = RequestMethod.POST)
	    public @ResponseBody  StatusResDto addMbr(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        return loyMbrService.addMbr(reqDto);
	    }


	     /*
	      * 1. 메소드명: editMbr
	      * 2. 클래스명: LoyMbrController
	      * 3. 작성자명: jh.seo
	      * 4. 작성일자: 2020. 2. 27.
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
	    @RequestMapping(value="/editMbr.do", method = RequestMethod.POST)
	    public @ResponseBody  StatusResDto editMbr(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        return loyMbrService.editMbr(reqDto);
	    }


	    /**
	      * @programId :
	      * @name : getMbrstatus
	      * @date : 2017. 4. 17.
	      * @author : 유영진
	      * @table :
	      * @변경이력 :
	      * @description : 회원상태 조회
	      * @param request
	      * @param response
	      * @param reqDto
	      * @return
	      */
	    @RequestMapping(value="/getMbrstatus.do", method = RequestMethod.POST)
	    public @ResponseBody  LoyMbrResDto getMbrstatus(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        return loyMbrService.getMbrstatus(reqDto);
	    }

	    /**
	      * @programId :
	      * @name : dropMbr
	      * @date : 2017. 4. 17.
	      * @author : 유영진
	      * @table :
	      * @변경이력 :
	      * @description : 탈회
	      * @param request
	      * @param response
	      * @param reqDto
	      * @return
	      */
	   /* @RequestMapping(value="/dropMbr.do", method = RequestMethod.POST)
	    public @ResponseBody LoyMemberRemoveMemberResDto dropMbr(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LOYMbrRequestDTO reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        return loyMbrService.dropMbr(reqDto);
	    }*/


	    /**
	      * @programId :
	      * @name : getMbrCardList
	      * @date : 2017. 1. 3.
	      * @author : knlee
	      * @table :
	      * @변경이력 :
	      * @description : 회원카드리스트 조회
	      * @param request
	      * @param response
	      * @param reqDto
	      * @return
	      */
	    @RequestMapping(value="/getMbrCardList.do", method = RequestMethod.POST)
	    public @ResponseBody  GridPagingResDto<LoyMbrCardResDto> getMbrCardList(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrCardReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        return loyMemberCardService.getMbrCardList(reqDto);
	    }




	     /**
	      * @programId :
	      * @name : updateMbr
	      * @date : 2017. 1. 4.
	      * @author : knlee
	      * @table :
	      * @변경이력 :
	      * @description : 회원 카드 상태 변경
	      * @param request
	      * @param response
	      * @param reqDto
	      * @return
	      */
	    @RequestMapping(value="editMbrCardStat.do", method=RequestMethod.POST)
	    public @ResponseBody StatusResDto updateMbr(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrCardReqDto reqDto) {
	    	LogUtil.param(this.getClass(), reqDto);
	    	return loyMemberCardService.editMbrCardStat(reqDto);
	    }



	    /**
	      * @programId :
	      * @name : getMbrPtnTxnHistList
	      * @date : 2017. 1. 5.
	      * @author : knlee
	      * @table :
	      * @변경이력 :
	      * @description : 회원포인트거래내역 조회
	      * @param request
	      * @param response
	      * @param reqDto
	      * @return
	      */
	    @RequestMapping(value="/getMbrPtnTxnHistList.do", method = RequestMethod.POST)
	    public @ResponseBody  GridPagingResDto<LoyMbrPtnTxnHistResDto> getMbrPtnTxnHistList(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrPtnTxnHistReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	        return loyTransService.getMbrPtnTxnHistList(reqDto);
	    }

	    /**
	    * @programId :
	    * @name : getTotAcrlPoint
	    * @date : 2019. 9. 3.
	    * @author : dw.keum
	    * @table :
	    * @return : LOYMbrPtnTxnHistResponseDTO
	    * @description : 총 적립 포인트
	    */
	    @RequestMapping(value="/getTotAcrlPoint.do", method = RequestMethod.POST)
	    public @ResponseBody  LoyMbrPtnTxnHistResDto getTotAcrlPoint(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrPtnTxnHistReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	        return loyTransService.getTotAcrlPoint(reqDto);
	    }

	    /**
	    * @programId :
	    * @name : getTotRdmPoint
	    * @date : 2019. 9. 3.
	    * @author : dw.keum
	    * @table :
	    * @return : LOYMbrPtnTxnHistResponseDTO
	    * @description : 총사용 포인트
	    */
	    @RequestMapping(value="/getTotRdmPoint.do", method = RequestMethod.POST)
	    public @ResponseBody  LoyMbrPtnTxnHistResDto getTotRdmPoint(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrPtnTxnHistReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);

	        return loyTransService.getTotRdmPoint(reqDto);
	    }

	    /**
	      * @programId :
	      * @name : getMbrTierHistList
	      * @date : 2017. 1. 5.
	      * @author : knlee
	      * @table :
	      * @변경이력 :
	      * @description : 회원등급이력 조회
	      * @param request
	      * @param response
	      * @param reqDto
	      * @return
	      */
	    @RequestMapping(value="/getMbrTierHistList.do", method = RequestMethod.POST)
	    public @ResponseBody  GridPagingResDto<LoyMbrTierHistResDto> getMbrTierHistList(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrTierHistReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        return loyMemberTiersService.getMbrTierHistList(reqDto);
	    }




	    /**
	      * @programId :
	      * @name : getMbrPurHistList
	      * @date : 2017. 1. 6.
	      * @author : knlee
	      * @table :
	      * @변경이력 :
	      * @description : 회원 구매이력 조회
	      * @param request
	      * @param response
	      * @param reqDto
	      * @return
	      */
	    @RequestMapping(value="/getMbrPurHistList.do", method = RequestMethod.POST)
	    public @ResponseBody  GridPagingResDto<LoyMbrIntactPurResDto> getMbrPurHistList(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrIntactPurReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        return loyMbrService.getMbrPurHistList(reqDto);
	    }

	     /*
	      * 1. 메소드명: dropMbrCancel
	      * 2. 클래스명: LoyMbrController
	      * 3. 작성자명: jh.seo
	      * 4. 작성일자: 2020. 3. 9.
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
	    @RequestMapping(value="/dropMbrCancel.do", method = RequestMethod.POST)
		public @ResponseBody StatusResDto dropMbrCancel(HttpServletRequest request, HttpServletResponse response,
				@RequestBody LoyMbrReqDto reqDto){
			LogUtil.param(this.getClass(), reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
			return loyMbrService.dropMbrCancel(reqDto);
		}



	    /**
	      * @programId :
	      * @name : getMbrCampHistList
	      * @date : 2017. 1. 6.
	      * @author : knlee
	      * @table :
	      * @변경이력 :
	      * @description : 회원 캠페인 이력 조회
	      * @param request
	      * @param response
	      * @param reqDto
	      * @return
	      *//*
	    @RequestMapping(value="/getMbrCampHistList.do", method = RequestMethod.POST)
	    public @ResponseBody  GridPagingResDto getMbrCampHistList(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LOYMbrCampHistRequestDTO reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        return loyMbrService.getMbrCampHistList(reqDto);
	    }

    @RequestMapping(value = "/getMbrChnlRelList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto getMbrChnlRelList(HttpServletRequest request, HttpServletResponse response, @RequestBody LOYMbrChnlRelRequestDTO reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.getMbrChnlRelList(reqDto);
    }




    /**
     * @programId
     * @name clearMaskMbr
     * @date 2018. 10. 23.
     * @author jh.kim
     * @param request
     * @param response
     * @param reqDto
     * @return
     * @description 멤버십 회원 마스킹 해제
     */
    @RequestMapping(value = "clearMaskMbr.do", method = RequestMethod.POST)
    public @ResponseBody LoyMbrResDto clearMaskMbr(
            HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setUri(request.getRequestURI());
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.clearMaskMbr(reqDto);
    }

    /**
  	* @programId :
  	* @name : getMbrRecomHistoryList
  	* @date : 2019. 7. 2.
  	* @author : dw.keum
  	* @table :
  	* @return : GridPagingResDto
  	* @description : 추천인 이력 조회
  	*/
  	@RequestMapping(value="/getMbrRecomHistoryList.do", method = RequestMethod.POST)
  	public @ResponseBody GridPagingResDto<LoyMbrRecomHistoryResDto> getMbrRecomHistoryList(HttpServletRequest request, HttpServletResponse response,
  			@RequestBody LoyMbrRecomHistoryReqDto param){
  		LogUtil.param(this.getClass(), param);
  		param.setLoginInfo(authHelper.checkLoginSession(request, response));
  		return loyMbrService.getMbrRecomHistoryList(param);
  	}

  	/**
	* @programId :
	* @name : getAllTierList
	* @date : 2019. 7. 2.
	* @author :
	* @table :
	* @return :
	* @description : 등급 목록 수정
	*/
	@RequestMapping(value="/editMbrTier.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editMbrTier(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrTierReqDto param){
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyMemberTiersService.editMbrTier(param);
	}

		/**
	    * @programId :
	    * @name : getMbrTermsHistList
	    * @date : 2018. 12. 14.
	    * @author : hy.jun
	    * @table :
	    * @return : GridPagingResDto
	    * @description : 회원 채널동의정보 목록 조회
	    */
	    @RequestMapping(value="/getMbrTermsHistList.do", method = RequestMethod.POST)
	    public @ResponseBody  GridPagingResDto<LoyMbrTermsHistListResDto> getMbrTermsHistList(HttpServletRequest request, HttpServletResponse response,
	    		@RequestBody LoyMbrTermsHistListReqDto param) {
	    	LogUtil.param(this.getClass(), param);
	    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
	    	return loyMemberTermService.getMbrTermsHistList(param);
	    }

    /**
     * @programId :
     * @name : mbrPwdDetail
     * @date : 2017. 7. 18.
     * @author : jh.kim
     * @table :
     * @return : LOYMbrPasswordResponseDTO
     * @description : 비밀번호 정보 확인 ( 존재여부 )
     */
    @RequestMapping(value = "/getMbrPwdDetail.do",
                    method = RequestMethod.POST)
    public @ResponseBody LoyMbrPasswordResDto getMbrPwdDetail(
            HttpServletRequest request, HttpServletResponse response,
            @RequestBody LoyMbrPasswordReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

        return loyMbrService.getMbrPwdDetail(reqDto);

    }

    /**
     * @programId :
     * @name : editMbrPwd
     * @date : 2017. 7. 18.
     * @author : jh.kim
     * @table :
     * @return : StatusResDto
     * @description : 비밀번호 수정
     */
    @RequestMapping(value = "/editMbrPwd.do",
                    method = RequestMethod.POST)
    public @ResponseBody StatusResDto editMbrPwd(
            HttpServletRequest request, HttpServletResponse response,
            @RequestBody LoyMbrPasswordReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

        // 비밀번호 수정
        StatusResDto rtnDto = new StatusResDto();
        //rtnDto = loyMbrService.editMbrPwd(reqDto);

        return rtnDto;
    }





    /**
    * @programId :
    * @name :
    * @date : 2017. 10. 16.
    * @author : 이성원
    * @table :
    * @return : GridPagingResDto
    * @description :
    */
    @RequestMapping(value="/getMbrSearchHelp.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyMbrSearchHelpResDto> getMbrSearchHelp(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrSearchHelpReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        //if ( !ObjectUtil.isEmpty(reqDto.getFirst()) ) {
        	/*if(!reqDto.getFirst().equals("X"))  loggingHelper.insertSearchLog(reqDto);*/
        //}
        return loyMbrService.getMbrSearchHelp(reqDto);
    }



    /**
    * @programId :
    * @name : getDropMbrList
    * @date : 2017. 10. 16.
    * @author : 이성원
    * @table :
    * @return : GridPagingResDto
    * @description :
    */
    @RequestMapping(value="/getDropMbrList.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyDropMbrResDto> getDropMbrList(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyDropMbrReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

        return loyMbrService.getDropMbrList(reqDto);
    }

   //탈퇴회원 마스킹 해제
  	 @RequestMapping(value = "clearMaskDrop.do", method = RequestMethod.POST)
      public @ResponseBody LoyDropMbrResDto clearMaskDrop(
              HttpServletRequest request, HttpServletResponse response, @RequestBody LoyDropMbrReqDto reqDto) {
          LogUtil.param(this.getClass(), reqDto);
          reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
          reqDto.setUri(request.getRequestURI());
          return loyMbrService.clearMaskDrop(reqDto);
      }

  	 /*
  	  * 1. 메소드명: getMbrTierHistList2
  	  * 2. 클래스명: LoyMbrController
  	  * 3. 작성자명: jh.seo
  	  * 4. 작성일자: 2020. 3. 11.
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
  	 *   @param param
  	 *   @return
  	 */
  	@RequestMapping(value="/getMbrTierHistList2.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyMbrTierHistListResDto> getMbrTierHistList2(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyMbrTierHistListReqDto param){
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMemberTiersService.getMbrTierHistList2(param);
	}

  	 /**
     * @programId :
     * @name : getMbrChangeHistList
     * @date : 2017. 10. 25.
     * @author : 이성원
     * @table :
     * @return : GridPagingResDto
     * @description :
     */
     @RequestMapping(value="/getMbrChangeHistList.do", method = RequestMethod.POST)
        public @ResponseBody  GridPagingResDto<LoyMbrChangeHistListResDto> getMbrChangeHistList(HttpServletRequest request, HttpServletResponse response,
        	   @RequestBody LoyMbrChangeHistListReqDto reqDto) {

            LogUtil.param(this.getClass(), reqDto);
            reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
            return loyMbrService.getMbrChangeHistList(reqDto);
        }

    /**
    * @programId :
    * @name : getMbrGroupList
    * @date : 2017. 10. 16.
    * @author : 이성원
    * @table :
    * @return : GridPagingResDto
    * @description :
    */
    @RequestMapping(value="/getMbrGroupList.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyMbrGroupResDto> getMbrGroupList(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrGroupReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

        return loyMbrService.getMbrGroupList(reqDto);
    }




    /**
    * @programId :
    * @name : getMbrGroupDetail
    * @date : 2017. 10. 16.
    * @author : 이성원
    * @table :
    * @return : LOYMbrGroupResponseDTO
    * @description :
    */
    @RequestMapping(value="/getMbrGroupDetail.do", method = RequestMethod.POST)
    public @ResponseBody  LoyMbrGroupResDto getMbrGroupDetail(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrGroupReqDto reqDto) {

        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.getMbrGroupDetail(reqDto);
    }



    /**
    * @programId :
    * @name : getEmpSearchHelp
    * @date : 2017. 10. 16.
    * @author : 이성원
    * @table :
    * @return : GridPagingResDto
    * @description :
    */
    @RequestMapping(value="/getEmpSearchHelp.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyEmpSearchHelpResDto> getEmpSearchHelp(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyEmpSearchHelpReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.getEmpSearchHelp(reqDto);
    }




    /**
    * @programId :
    * @name : getMbrRenameReqList
    * @date : 2017. 10. 16.
    * @author : 이성원
    * @table :
    * @return : GridPagingResDto
    * @description :
    */
    @RequestMapping(value="/getMbrRenameReqList.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyMbrRenameResDto> getMbrRenameReqList(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrRenameReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.getMbrRenameReqList(reqDto);
    }

    /**
    * @programId :
    * @name : getMbrRenameReqDetail
    * @date : 2017. 10. 16.
    * @author : 이성원
    * @table :
    * @return : LOYMbrRenameResponseDTO
    * @description :
    */
    @RequestMapping(value="/getMbrRenameReqDetail.do", method = RequestMethod.POST)
    public @ResponseBody  LoyMbrRenameResDto getMbrRenameReqDetail(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrRenameReqDto reqDto) {

        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.getMbrRenameReqDetail(reqDto);
    }

    /**
    * @programId :
    * @name : saveMbrRenameReqDetail
    * @date : 2017. 10. 16.
    * @author : 이성원
    * @table :
    * @return : LOYMbrRenameResponseDTO
    * @description :
    */
    @RequestMapping(value="/saveMbrRenameReqDetail.do", method = RequestMethod.POST)
    public @ResponseBody  StatusResDto saveMbrRenameReqDetail(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrRenameReqDto reqDto) {

        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.saveMbrRenameReqDetail(reqDto);
    }

    /**
    * @programId :
    * @name : editMbrRenameReqDetail
    * @date : 2017. 10. 17.
    * @author : 이성원
    * @table :
    * @return : StatusResDto
    * @description :
    */
    @RequestMapping(value="/editMbrRenameReqDetail.do", method = RequestMethod.POST)
    public @ResponseBody  StatusResDto editMbrRenameReqDetail(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrRenameReqDto reqDto) {

        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.editMbrRenameReqDetail(reqDto);
    }

    /**
     * @programId :
     * @name : getMbrOrangeCardList
     * @date : 2017. 10. 18.
     * @author : 이성원
     * @table :
     * @return : GridPagingResDto
     * @description :
     */
    @RequestMapping(value = "/getMbrOrangeCardList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyMbrCardListResDto> getMbrOrangeCardList(
            HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrCardListReqDto reqDto) {

        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.getMbrOrangeCardList(reqDto);
    }

    /**
     * @programId :
     * @name : getMbrListCard
     * @date : 2017. 10. 18.
     * @author : 이성원
     * @table :
     * @return : GridPagingResDto
     * @description :
     */
    @RequestMapping(value = "/getMbrListCard.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyMbrCardListResDto> getMbrListCard(
    		HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrCardListReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyMemberCardService.getMbrListCard(reqDto);
    }

    /**
     * @programId :
     * @name : getChargeYM
     * @date : 2017. 10. 18.
     * @author : swlim
     * @table :
     * @return : GridPagingResDto
     * @description :
     */
    @RequestMapping(value = "/getChargeYM.do", method = RequestMethod.POST)
    public @ResponseBody List getChargeYM(
            HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {

        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.getChargeYM(reqDto);
    }

    /**
     * @programId :
     * @name : getChargeList
     * @date : 2017. 10. 18.
     * @author : 이성원
     * @table :
     * @return : GridPagingResDto
     * @description :
     */
    @RequestMapping(value = "/getChargeList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyMbrChargeResDto> getChargeList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {

        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.getChargeList(reqDto);
    }

    /**
    * @programId :
    * @name : getMbrVocList
    * @date : 2017. 10. 20.
    * @author : 이성원
    * @table :
    * @return : GridPagingResDto
    * @description :
    */
    @RequestMapping(value="/getMbrVocList.do", method = RequestMethod.POST)
      public @ResponseBody  GridPagingResDto<LoyMbrVocListResDto> getMbrVocList(HttpServletRequest request, HttpServletResponse response,
      	   @RequestBody LoyMbrVocListReqDto reqDto) {

          LogUtil.param(this.getClass(), reqDto);
          reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
          return loyMbrService.getMbrVocList(reqDto);
      }
    
    /**
    * @programId :
    * @name : getMbrVocList
    * @date : 2021. 01. 04.
    * @author : lee gyeong young
    * @table :
    * @return : GridPagingResDto
    * @description :
    */
    @RequestMapping(value="/getMbrVocListDesc.do", method = RequestMethod.POST)
      public @ResponseBody  LoyMbrVocListResDto getMbrVocListDesc(HttpServletRequest request, HttpServletResponse response,
      	   @RequestBody LoyMbrVocListReqDto reqDto) {

          LogUtil.param(this.getClass(), reqDto);
          reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
          return loyMbrService.getMbrVocListDesc(reqDto);
      }

    /**
     * @programId :
     * @name : getMbrVocList
     * @date : 2017. 10. 23.
     * @author : swlim
     * @table :
     * @return : GridPagingResDto
     * @description :
     */
     @RequestMapping(value="/getChargeInfo.do", method = RequestMethod.POST)
       public @ResponseBody  GridPagingResDto<LoyMbrChargeResDto> getChargeInfo(HttpServletRequest request, HttpServletResponse response,
       	   @RequestBody LoyMbrReqDto reqDto) {

           LogUtil.param(this.getClass(), reqDto);
           reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
           return loyMbrService.getChargeInfo(reqDto);
       }

    /**
    * @programId :
    * @name : getMbrStnPntTxnList
    * @date : 2017. 10. 23.
    * @author : 이성원
    * @table :
    * @return : GridPagingResDto
    * @description :
    */
    @RequestMapping(value="/getMbrStnPntTxnList.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyMbrStnPntTxnListResDto> getMbrStnPntTxnList(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrStnPntTxnListReqDto reqDto) {

        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.getMbrStnPntTxnList(reqDto);
    }

    /**
     * @programId :
     * @name : getMbrCarHistList
     * @date : 2017. 10. 24.
     * @author : swlim
     * @table :
     * @return : GridPagingResDto
     * @description :
     */
     @RequestMapping(value="/getMbrCarHistList.do", method = RequestMethod.POST)
     public @ResponseBody  GridPagingResDto<LoyMbrCarHistResDto> getMbrCarHistList(HttpServletRequest request, HttpServletResponse response,
     	   @RequestBody LoyMbrReqDto reqDto) {

         LogUtil.param(this.getClass(), reqDto);
         reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
         return loyMbrService.getMbrCarHistList(reqDto);
     }

     /**
      * @programId :
      * @name : getMbrSegHistList
      * @date : 2017. 10. 24.
      * @author : swlim
      * @table :
      * @return : GridPagingResDto
      * @description :
      */
      /*@RequestMapping(value="/getMbrSegHistList.do", method = RequestMethod.POST)
      public @ResponseBody  GridPagingResDto<> getMbrSegHistList(HttpServletRequest request, HttpServletResponse response,
      	   @RequestBody LoyMbrReqDto reqDto) {

          LogUtil.param(this.getClass(), reqDto);
          reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
          return loyMbrService.getMbrSegHistList(reqDto);
      }*/

      /**
       * @programId :
       * @name : getEMbrTierHistList
       * @date : 2017. 10. 24.
       * @author : swlim
       * @table :
       * @return : GridPagingResDto
       * @description :
       */
       @RequestMapping(value="/getEMbrTierHistList.do", method = RequestMethod.POST)
       public @ResponseBody  GridPagingResDto<LoyMbrTierHistResDto> getEMbrTierHistList(HttpServletRequest request, HttpServletResponse response,
       	   @RequestBody LoyMbrReqDto reqDto) {

           LogUtil.param(this.getClass(), reqDto);
           reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
           return loyMbrService.getEMbrTierHistList(reqDto);
       }

    /**
     * @programId :
     * @name : getMbrPointLimitInfo
     * @date : 2017. 10. 25.
     * @author : swlim
     * @table :
     * @return : LOYMbrPointLimitResponseDTO
     * @description :
     */
     @RequestMapping(value="/getMbrPointLimitInfo.do", method = RequestMethod.POST)
        public @ResponseBody  LoyMbrPointLimitResDto getMbrPointLimitInfo(HttpServletRequest request, HttpServletResponse response,
        	   @RequestBody LoyMbrReqDto reqDto) {

            LogUtil.param(this.getClass(), reqDto);
            reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
            return loyMbrService.getMbrPointLimitInfo(reqDto);
        }

      /**
       * @programId :
       * @name : getMbrPointLimitList
       * @date : 2017. 10. 25.
       * @author : swlim
       * @table :
       * @return : GridPagingResDto
       * @description :
       */
       @RequestMapping(value="/getMbrPointLimitList.do", method = RequestMethod.POST)
       public @ResponseBody  GridPagingResDto<LoyMbrPointLimitListResDto> getMbrPointLimitList(HttpServletRequest request, HttpServletResponse response,
       	   @RequestBody LoyMbrReqDto reqDto) {

           LogUtil.param(this.getClass(), reqDto);
           reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
           return loyMbrService.getMbrPointLimitList(reqDto);
       }

       /**
        * @programId :
        * @name : getMbrClubList
        * @date : 2017. 10. 25.
        * @author : swlim
        * @table :
        * @return : GridPagingResDto
        * @description :
        */
        @RequestMapping(value="/getMbrClubList.do", method = RequestMethod.POST)
        public @ResponseBody  GridPagingResDto<LoyMbrClupListResDto> getMbrClubList(HttpServletRequest request, HttpServletResponse response,
        	   @RequestBody LoyMbrReqDto reqDto) {

            LogUtil.param(this.getClass(), reqDto);
            reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
            return loyMbrService.getMbrClubList(reqDto);
        }

        /**
         * @programId :
         * @name : getMbrGroupCardList
         * @date : 2017. 10. 25.
         * @author : 이성원
         * @table :
         * @return : GridPagingResDto
         * @description :
         */
         @RequestMapping(value="/getMbrGroupCardList.do", method = RequestMethod.POST)
         public @ResponseBody  GridPagingResDto<LoyMbrGroupCardListResDto> getMbrGroupCardList(HttpServletRequest request, HttpServletResponse response,
         	   @RequestBody LoyMbrGroupCardListReqDto reqDto) {

             LogUtil.param(this.getClass(), reqDto);
             reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
             return loyMbrService.getMbrGroupCardList(reqDto);
         }



         @RequestMapping(value="/getMbrStnPntTxnDetailList.do", method = RequestMethod.POST)
         public @ResponseBody  GridPagingResDto<LoyMbrStnPntTxnDetailListReqDto> getMbrStnPntTxnDetailList(HttpServletRequest request, HttpServletResponse response,
         	   @RequestBody LoyMbrStnPntTxnDetailListReqDto reqDto) {

             LogUtil.param(this.getClass(), reqDto);
             reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
             return loyMbrService.getMbrStnPntTxnDetailList(reqDto);
         }

         /**
          * @programId :
          * @name : addMbrCarHist
          * @date : 2017. 10. 26.
          * @author : swlim
          * @table :
          * @return : StatusResDto
          * @description :
          */
        @RequestMapping(value="/addMbrCarHist.do", method = RequestMethod.POST)
 	    public @ResponseBody  StatusResDto addMbrCarHist(HttpServletRequest request, HttpServletResponse response,
 	    	   @RequestBody LoyMbrCarHistReqDto reqDto) {
 	        LogUtil.param(this.getClass(), reqDto);
 	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
 	        return loyMbrService.addMbrCarHist(reqDto);
 	    }


        @RequestMapping(value="/getMbrOrangeCardDetail.do", method = RequestMethod.POST)
        public @ResponseBody  LoyMbrCardResDto getMbrOrangeCardDetail(HttpServletRequest request, HttpServletResponse response,
        	   @RequestBody LoyMbrCardReqDto reqDto) {

            LogUtil.param(this.getClass(), reqDto);
            reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
            return loyMbrService.getMbrOrangeCardDetail(reqDto);
        }

      /**
       * @programId :
       * @name : setMbrPointLimit
       * @date : 2017. 10. 30.
       * @author : swlim
       * @table :
       * @return : StatusResDto
       * @description :
       */
     @RequestMapping(value="/setMbrPointLimit.do", method = RequestMethod.POST)
	    public @ResponseBody  StatusResDto setMbrPointLimit(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrPointLimitReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        return loyMbrService.setMbrPointLimit(reqDto);
	    }

        /**
         * @programId :
         * @name : getMbrSignInfo
         * @date : 2017. 10. 25.
         * @author : swlim
         * @table :
         * @return : LOYMbrSignInfoResponseDTO
         * @description :
         */
         @RequestMapping(value="/getMbrSignInfo.do", method = RequestMethod.POST)
         public @ResponseBody  LoyMbrSignInfoResDto getMbrSignInfo(HttpServletRequest request, HttpServletResponse response,
         	   @RequestBody LoyMbrReqDto reqDto) {

             LogUtil.param(this.getClass(), reqDto);
             reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
             return loyMbrService.getMbrSignInfo(reqDto);
         }

         /**
          * @programId :
          * @name : getMbrChnlHistList
          * @date : 2017. 10. 25.
          * @author : swlim
          * @table :
          * @return : GridPagingResDto
          * @description :
          */
          @RequestMapping(value="/getMbrChnlHistList.do", method = RequestMethod.POST)
          public @ResponseBody GridPagingResDto<LoyMbrChnlHistListResDto> getMbrChnlHistList(HttpServletRequest request, HttpServletResponse response,
          	   @RequestBody LoyMbrReqDto reqDto) {

              LogUtil.param(this.getClass(), reqDto);
              reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
              return loyMbrService.getMbrChnlHistList(reqDto);
          }


        /**
        * @programId :
        * @name : getMbrChnlHistContents
        * @date : 2018. 1. 31.
        * @author : 이성원
        * @table :
        * @return : LOYMbrChangeHistContentsResponseDTO
        * @description :
        */
        @RequestMapping(value="/getMbrChnlHistContents.do", method = RequestMethod.POST)
          public @ResponseBody  LoyMbrChnlHistContentsResDto getMbrChnlHistContents(HttpServletRequest request, HttpServletResponse response,
          	   @RequestBody LoyMbrChnlHistContentsReqDto reqDto) {

              LogUtil.param(this.getClass(), reqDto);
              reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
              return loyMbrService.getMbrChnlHistContents(reqDto);
          }

           /**
            * @programId :
            * @name : getMbrChnlHistSubList
            * @date : 2017. 10. 25.
            * @author : swlim
            * @table :
            * @return : GridPagingResDto
            * @description :
            */
            @RequestMapping(value="/getMbrChnlHistSubList.do", method = RequestMethod.POST)
            public @ResponseBody  GridPagingResDto<LoyMbrChnlHistListResDto> getMbrChnlHistSubList(HttpServletRequest request, HttpServletResponse response,
            	   @RequestBody LoyMbrReqDto reqDto) {

                LogUtil.param(this.getClass(), reqDto);
                reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
                return loyMbrService.getMbrChnlHistSubList(reqDto);
            }

            /**
             * @programId :
             * @name : getMbrDetailInfo
             * @date : 2017. 10. 25.
             * @author : swlim
             * @table :
             * @return : GridPagingResDto
             * @description :
             */
            @RequestMapping(value="/getMbrDetailInfo.do", method = RequestMethod.POST)
    	    public @ResponseBody  LoyMbrDetailInfoResDto getMbrDetailInfo(HttpServletRequest request, HttpServletResponse response,
    	    	   @RequestBody LoyMbrDetailInfoReqDto reqDto) {
            	LogUtil.param(this.getClass(), reqDto);
            	LoyMbrDetailInfoResDto resDto = new LoyMbrDetailInfoResDto();

    	        resDto = loyMbrService.getMbrDetailInfo(reqDto);
    	        resDto.setSuccess(true);
    	        return resDto;
    	    }


            /**
             * @programId :
             * @name : editMbrGroupDetail
             * @date : 2017. 11. 06.
             * @author : swlim
             * @table :
             * @return : StatusResDto
             * @description :
             */
           @RequestMapping(value="/editMbrGroupDetail.do", method = RequestMethod.POST)
     	    public @ResponseBody  StatusResDto editMbrGroupDetail(HttpServletRequest request, HttpServletResponse response,
     	    	   @RequestBody LoyMbrGroupReqDto reqDto) {
     	        LogUtil.param(this.getClass(), reqDto);
     	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
     	        return loyMbrService.editMbrGroupDetail(reqDto);
     	    }

           /**
            * @programId :
            * @name : getMbrGroupAddInfo
            * @date : 2017. 11. 07.
            * @author : swlim
            * @table :
            * @return : LOYMbrGroupAddInfoResponseDTO
            * @description :
            */
           @RequestMapping(value="/getMbrGroupAddInfo.do", method = RequestMethod.POST)
   	    	public @ResponseBody  LoyMbrGroupAddInfoResDto getMbrGroupAddInfo(HttpServletRequest request, HttpServletResponse response,
	   	    	   @RequestBody LoyMbrReqDto reqDto) {

	   	        LogUtil.param(this.getClass(), reqDto);
	   	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	   	        return loyMbrService.getMbrGroupAddInfo(reqDto);
           }

           /**
            * @programId :
            * @name : getMbrGroupUserList
            * @date : 2017. 11. 08.
            * @author : swlim
            * @table :
            * @return : GridPagingResDto
            * @description :
            */
            @RequestMapping(value="/getMbrGroupUserList.do", method = RequestMethod.POST)
            public @ResponseBody  GridPagingResDto<LoyMbrGroupClubListResDto> getMbrGroupUserList(HttpServletRequest request, HttpServletResponse response,
            	   @RequestBody LoyMbrReqDto reqDto) {

                LogUtil.param(this.getClass(), reqDto);
                reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
                return loyMbrService.getMbrGroupUserList(reqDto);
            }


            /**
             * @programId :
             * @name : getMbrGroupPointTxnHistList
             * @date : 2017. 11. 08.
             * @author : swlim
             * @table :
             * @return : GridPagingResDto
             * @description :
             */
             @RequestMapping(value="/getMbrGroupPointTxnHistList.do", method = RequestMethod.POST)
             public @ResponseBody  GridPagingResDto<LoyMbrGroupPointTxnHistListResDto> getMbrGroupPointTxnHistList(HttpServletRequest request, HttpServletResponse response,
             	   @RequestBody LoyMbrReqDto reqDto) {

                 LogUtil.param(this.getClass(), reqDto);
                 reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
                 return loyMbrService.getMbrGroupPointTxnHistList(reqDto);
             }
             /**
              * @programId :
              * @name : getMbrGroupChnList
              * @date : 2017. 11. 08.
              * @author : swlim
              * @table :
              * @return : GridPagingResDto
              * @description :
              */
              @RequestMapping(value="/getMbrGroupChnList.do", method = RequestMethod.POST)
              public @ResponseBody  GridPagingResDto<LoyMbrGroupCngListResDto> getMbrGroupChnList(HttpServletRequest request, HttpServletResponse response,
              	   @RequestBody LoyMbrReqDto reqDto) {

                  LogUtil.param(this.getClass(), reqDto);
                  reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
                  return loyMbrService.getMbrGroupChnList(reqDto);
              }

              /**
               * @programId :
               * @name : getChargeSum
               * @date : 2017. 11. 08.
               * @author : swlim
               * @table :
               * @return : GridPagingResDto
               * @description :
               */
               @RequestMapping(value="/getChargeSum.do", method = RequestMethod.POST)
               public @ResponseBody String getChargeSum(HttpServletRequest request, HttpServletResponse response,
               	   @RequestBody LoyMbrReqDto reqDto) {

                   LogUtil.param(this.getClass(), reqDto);
                   reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
                   return loyMbrService.getChargeSum(reqDto);
               }


               /**
                * @programId :
                * @name : getMbrPwChgDate
                * @date : 2017. 11. 27.
                * @author : swlim
                * @table :
                * @return : String
                * @description :
                */
               @RequestMapping(value="/getMbrPwChgDate.do", method = RequestMethod.POST)
               public @ResponseBody StatusResDto getMbrPwChgDate(HttpServletRequest request, HttpServletResponse response,
               	   @RequestBody LoyMbrReqDto reqDto) {

                   LogUtil.param(this.getClass(), reqDto);
                   reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
                   return loyMbrService.getMbrPwChgDate(reqDto);
               }

               /**
                * @programId :
                * @name : editMbrDetail
                * @date : 2017. 11. 06.
                * @author : swlim
                * @table :
                * @return : StatusResDto
                * @description :
                */
              @RequestMapping(value="/editMbrDetail.do", method = RequestMethod.POST)
        	    public @ResponseBody  StatusResDto editMbrDetail(HttpServletRequest request, HttpServletResponse response,
        	    	   @RequestBody LoyMbrItemReqDto reqDto) {
        	        LogUtil.param(this.getClass(), reqDto);
        	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        	        return loyMbrService.editMbrsDetail(reqDto);
        	    }

              /**
               * @programId :
               * @name : editMbrGroupAddInfo
               * @date : 2017. 11. 06.
               * @author : swlim
               * @table :
               * @return : StatusResDto
               * @description :
               */
             @RequestMapping(value="/editMbrGroupAddInfo.do", method = RequestMethod.POST)
       	    	public @ResponseBody  StatusResDto editMbrGroupAddInfo(HttpServletRequest request, HttpServletResponse response,
       	    	   @RequestBody LoyMbrGroupAddInfoReqDto reqDto) {
       	        LogUtil.param(this.getClass(), reqDto);
       	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
       	        return loyMbrService.editMbrGroupAddInfo(reqDto);
       	    }

             /**
              * @programId :
              * @name : editMbrDetailInfo
              * @date : 2017. 11. 06.
              * @author : swlim
              * @table :
              * @return : StatusResDto
              * @description :
              */
            @RequestMapping(value="/editMbrDetailInfo.do", method = RequestMethod.POST)
      	    public @ResponseBody  StatusResDto editMbrDetailInfo(HttpServletRequest request, HttpServletResponse response,
      	    	   @RequestBody LoyMbrDetailInfoReqDto reqDto) {
      	        LogUtil.param(this.getClass(), reqDto);
      	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
      	        return loyMbrService.editMbrDetailInfo(reqDto);
      	    }

          /**
           * @programId :
           * @name : getMbrTmAtrHistList
           * @date : 2017. 11. 27.
           * @author : sw.lim
           * @table :
           * @return : GridPagingResDto
           * @description :
           */
           @RequestMapping(value="/getMbrTmAtrHistList.do", method = RequestMethod.POST)
           public @ResponseBody  GridPagingResDto<LoyMbrTmAgrHistListResDto> getMbrTmAtrHistList(HttpServletRequest request, HttpServletResponse response,
           	   @RequestBody LoyMbrReqDto reqDto) {
               LogUtil.param(this.getClass(), reqDto);
               reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

               return loyMbrService.getMbrTmAtrHistList(reqDto);
           }

           /**
            * @programId :
            * @name : updateMbrCarHist
            * @date : 2017. 10. 26.
            * @author : swlim
            * @table :
            * @return : StatusResDto
            * @description :
            */
          @RequestMapping(value="/updateMbrCarHist.do", method = RequestMethod.POST)
    	    public @ResponseBody  StatusResDto updateMbrCarHist(HttpServletRequest request, HttpServletResponse response,
    	    	   @RequestBody LoyMbrCarHistReqDto reqDto) {
    	        LogUtil.param(this.getClass(), reqDto);
    	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
    	        return loyMbrService.updateMbrCarHist(reqDto);
    	    }

         /**
          * @programId :
          * @name : dropMbrProc
          * @date : 2017. 12. 05.
          * @author : swlim
          * @table :
          * @return : LOYMbrItemResponseDTO
          * @description :
          */
        @RequestMapping(value="/dropMbrProc.do", method = RequestMethod.POST)
  	    public @ResponseBody  LoyMbrProcResDto dropMbrProc(HttpServletRequest request, HttpServletResponse response,
  	    	   @RequestBody LoyMbrProcReqDto reqDto) {
  	        LogUtil.param(this.getClass(), reqDto);
  	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
  	        return loyMbrService.dropMbrProc(reqDto);
  	    }

        /**
         * @programId :
         * @name : addMbrGroupCard
         * @date : 2017. 12. 06.
         * @author : swlim
         * @table :
         * @return : StatusResDto
         * @description :
         */
       @RequestMapping(value="/addMbrGroupCard.do", method = RequestMethod.POST)
	    public @ResponseBody  StatusResDto addMbrGroupCard(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrGroupCardReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        return loyMbrService.addMbrGroupCard(reqDto);
	    }

       /**
        * @programId :
        * @name : joinMbrProc
        * @date : 2017. 12. 05.
        * @author : swlim
        * @table :
        * @return : LOYMbrProcResponseDTO
        * @description :
        */
      @RequestMapping(value="/joinMbrProc.do", method = RequestMethod.POST)
	    public @ResponseBody  LoyMbrProcResDto joinMbrProc(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrProcReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	        return loyMbrService.joinMbrProc(reqDto);
	    }


    /**
     * @programId :
     * @name : reqCertiCode
     * @date : 2017. 12. 05.
     * @author : swlim
     * @table :
     * @return : LOYMbrProcResponseDTO
     * @description :
     */
   @RequestMapping(value="/reqCertiCode.do", method = RequestMethod.POST)
	    public @ResponseBody  LoyMbrProcResDto reqCertiCode(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrProcReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	        return loyMbrService.reqCertiCode(reqDto);
	    }


	  /**
	   * @programId :
	   * @name : checkCertiCode
	   * @date : 2017. 12. 05.
	   * @author : swlim
	   * @table :
	   * @return : LOYMbrProcResponseDTO
	   * @description : 인증번호 홛인
	   */
	 @RequestMapping(value="/checkCertiCode.do", method = RequestMethod.POST)
	    public @ResponseBody  LoyMbrProcResDto checkCertiCode(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrProcReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
	        reqDto.setEmpId(loginInfo.getId());
	        return loyMbrService.checkCertiCode(reqDto);
	    }

	 /**
	   * @programId :
	   * @name : rereqCertiCode
	   * @date : 2017. 12. 21.
	   * @author : swlim
	   * @table :
	   * @return : LOYMbrProcResponseDTO
	   * @description : 인증번호 재전송
	   */
	 @RequestMapping(value="/rereqCertiCode.do", method = RequestMethod.POST)
	    public @ResponseBody  LoyMbrProcResDto rereqCertiCode(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrProcReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	        return loyMbrService.rereqCertiCode(reqDto);
	    }



	 /**
      * @programId :
      * @name : addMbrGroupUser
      * @date : 2017. 12. 22.
      * @author : swlim
      * @table :
      * @return : StatusResDto
      * @description :
      */
    @RequestMapping(value="/addMbrGroupUser.do", method = RequestMethod.POST)
	    public @ResponseBody  StatusResDto addMbrGroupUser(HttpServletRequest request, HttpServletResponse response,
		    	   @RequestBody LoyMbrGroupClubReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        return loyMbrService.addMbrGroupUser(reqDto);
	    }

    /**
     * @programId :
     * @name : addMbrGroupUser
     * @date : 2017. 12. 22.
     * @author : swlim
     * @table :
     * @return : StatusResDto
     * @description :
     */
   @RequestMapping(value="/dropMbrGroupUser.do", method = RequestMethod.POST)
	    public @ResponseBody  StatusResDto dropMbrGroupUser(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrGroupClubReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        return loyMbrService.dropMbrGroupUser(reqDto);
	    }

	 /**
	   * @programId :
	   * @name : editMbrName
	   * @date : 2017. 12. 28.
	   * @author : swlim
	   * @table :
	   * @return : LOYMbrItemResponseDTO
	   * @description : 가용포인트
	   */
	 @RequestMapping(value="/getAvlPoint.do", method = RequestMethod.POST)
	    public @ResponseBody  LoyMbrItemResDto viewAvlPoint(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrItemReqDto reqDto) throws ParseException {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	        return loyTransService.viewAvlPoint(reqDto);
	    }

	 /**
	   * @programId :
	   * @name : addMbrTmAgrHist
	   * @date : 2018. 01. 03.
	   * @author : swlim
	   * @table :
	   * @return : StatusResDto
	   * @description : 제휴 TM동의이력 신규
	   */
	 @RequestMapping(value="/addMbrTmAgrHist.do", method = RequestMethod.POST)
	    public @ResponseBody  StatusResDto addMbrTmAgrHist(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrTmAgrHistReqDto reqDto) {

	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        return loyMbrService.addMbrTmAgrHiat(reqDto);
	    }

	 /**
	   * @programId :
	   * @name : getChangeTaxiInfo
	   * @date : 2018. 01. 03.
	   * @author : swlim
	   * @table :
	   * @return : LOYMbrItemResponseDTO
	   * @description : 제휴 TM동의이력 상세
	   */
	 @RequestMapping(value="/getMbrTmAgrInfo.do", method = RequestMethod.POST)
	    public @ResponseBody  LoyMbrTmAgrHistListResDto getMbrTmAgrInfo(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrTmAgrHistReqDto reqDto) {

	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        return loyMbrService.getMbrTmAgrInfo(reqDto);
	    }

	 /**
	   * @programId :
	   * @name : updateMbrTmAgrHist
	   * @date : 2018. 01. 03.
	   * @author : swlim
	   * @table :
	   * @return : LOYMbrItemResponseDTO
	   * @description : 제휴 TM동의이력 수정
	   */
	 @RequestMapping(value="/updateMbrTmAgrHist.do", method = RequestMethod.POST)
	    public @ResponseBody  StatusResDto updateMbrTmAgrHist(HttpServletRequest request, HttpServletResponse response,
	    	   @RequestBody LoyMbrTmAgrHistReqDto reqDto) {

	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        return loyMbrService.updateMbrTmAgrHist(reqDto);
	    }

	 /**
      * @programId :
      * @name : getMbrSemiVipHistList
      * @date : 2017. 11. 27.
      * @author : sw.lim
      * @table :
      * @return : GridPagingResDto
      * @description :
      */
      @RequestMapping(value="/getMbrSemiVipHistList.do", method = RequestMethod.POST)
      public @ResponseBody  GridPagingResDto<LoyMbrSemiVipHistListResDto> getMbrSemiVipHistList(HttpServletRequest request, HttpServletResponse response,
      	   @RequestBody LoyMbrReqDto reqDto) {
          LogUtil.param(this.getClass(), reqDto);
          reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

          return loyMbrService.getMbrSemiVipHistList(reqDto);
      }

      /**
       * @programId :
       * @name : getMbrEventHistList
       * @date : 2017. 11. 27.
       * @author : sw.lim
       * @table :
       * @return : GridPagingResDto
       * @description : 이벤트 이력
       *//*
       @RequestMapping(value="/getMbrEventHistList.do", method = RequestMethod.POST)
       public @ResponseBody  GridPagingResDto<> getMbrEventHistList(HttpServletRequest request, HttpServletResponse response,
       	   @RequestBody LoyMbrReqDto reqDto) {
           LogUtil.param(this.getClass(), reqDto);
           reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

           return loyMbrService.getMbrEventHistList(reqDto);
       }*/


	    /**
	    * @programId :
	    * @name : getMbrCampaignResList
	    * @date : 2018. 2. 2.
	    * @author : 이성원
	    * @table :
	    * @return : GridPagingResDto
	    * @description :
	    */
	    @RequestMapping(value="/getMbrCampaignResList.do", method = RequestMethod.POST)
	       public @ResponseBody  GridPagingResDto<LoyMbrCampResResDto> getMbrCampaignResList(HttpServletRequest request, HttpServletResponse response,
	       	   @RequestBody LoyMbrReqDto reqDto) {
	           LogUtil.param(this.getClass(), reqDto);
	           reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	           return loyMbrService.getMbrCampaignResList(reqDto);
	       }

    /**
     * @programId :
     * @name : getMbrAllCount
     * @date : 2018. 02. 20.
     * @author : dg.ryu
     * @table :
     * @return : int
     * @description : 회원 전체 건수
     */
    @RequestMapping(value = "/getMbrAllCount.do", method = RequestMethod.POST)
    public @ResponseBody int getMbrAllCount(HttpServletRequest request, HttpServletResponse response) {
        LogUtil.param(this.getClass(), "");
        authHelper.checkLoginSession(request, response);

        return loyMbrService.getMbrAllCount();
    }

    /**
     * @programId :
     * @name : delPhoneNum
     * @date : 2018. 04. 06.
     * @author : swlim
     * @table :
     * @return : StatusResDto
     * @throws Exception
     * @description : 휴대폰 삭제
     */
    @RequestMapping(value = "/delPhoneNum.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto delPhoneNum(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) throws Exception {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.delPhoneNum(reqDto);
    }

    /**
     * @programId
     * @name addVocPntTxn
     * @date 2018. 10. 25.
     * @author jh.kim
     * @param request
     * @param response
     * @param lvptr
     * @return
     * @description VOC 포인트 등록
     */
    @RequestMapping(value = "/addVocPntTxn.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto addVocPntTxn(
            HttpServletRequest request, HttpServletResponse response, @RequestBody LoyVocPntTxnReqDto lvptr) {
        LogUtil.param(this.getClass(), lvptr);

        lvptr.setLoginInfo(authHelper.checkLoginSession(request, response));

        return loyMbrService.addVocPntTxn(lvptr, request);
    }

    /**
     * @programId
     * @name getPontBalanceB2c
     * @date 2018. 10. 25.
     * @author jh.kim
     * @param request
     * @param response
     * @param lpbbr
     * @return
     * @description B2C 포인트 조회
     */
    @RequestMapping(value = "/getPontBalanceB2c.do", method = RequestMethod.POST)
    public @ResponseBody LoyPontBalanceB2cReqDto getPontBalanceB2c(
            HttpServletRequest request, HttpServletResponse response, @RequestBody LoyPontBalanceB2cReqDto lpbbr) {
        LogUtil.param(this.getClass(), lpbbr);

        return loyMbrService.selectPontBalanceB2c(lpbbr);
    }

    /**
     * @programId
     * @name daisoDropMember
     * @date 2018. 10. 31.
     * @author jh.kim
     * @param request
     * @param response
     * @param dmdr
     * @return
     * @description 다이소 회원탈회
     *//*
    @RequestMapping(value = "/daisoDropMember.do", method = RequestMethod.POST)
    public @ResponseBody LOYDaisoMbrDropResponseDTO daisoDropMember(
            HttpServletRequest request, HttpServletResponse response, @RequestBody LOYDaisoMbrDropRequestDTO dmdr) {
        LogUtil.param(this.getClass(), dmdr);

        MKTLoginResponseDTO loginInfo = authHelper.checkLoginSession(request, response);
        dmdr.setModifyBy(loginInfo.getId());

        // 탈회URL
        String b2cApiUrl = CommonUtil.getInstance().getServletProp("daiso.b2c.host")
                + CommonUtil.getInstance().getServletProp("daiso.b2c.api.mbr.drop");

        // 회원탈회
        LOYDaisoMbrDropResponseDTO rtnValue = (LOYDaisoMbrDropResponseDTO) IFVMRestAPIUtility.jsonPost(b2cApiUrl, dmdr, LOYDaisoMbrDropResponseDTO.class);
        return rtnValue;
    }

    /**
    * @programId :
    * @name : getDormancyPntListByMbr
    * @date : 2018. 12. 11.
    * @author : hy.jun
    * @table :
    * @return : GridPagingResDto
    * @description : 회원 별 소멸된 포인트 목록 조회
    */
    @RequestMapping(value="/getDormancyPntListByMbr.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyMbrDormancyPntListResDto> getDormancyPntListByMbr(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrDormancyPntListReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyTransService.getDormancyPntListByMbr(param);
    }


    @RequestMapping(value="/getDupMbrList.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyDupMbrListResDto> getDupMbrList(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrReqDto reqDto) throws Exception {

        StandardPBEStringEncryptor encrypor = new StandardPBEStringEncryptor();
        encrypor.setPassword("9pwc3dke");
      	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	        return loyMbrService.getDupMbrList(reqDto);
	 }

    /**
    * @programId :
    * @name : editMbrPntUsePw
    * @date : 2018. 12. 18.
    * @author : mj.kim
    * @table :
    * @return : StatusResDto
    * @description : 중복회원
    */
    @RequestMapping(value="/editMbrPntUsePw.do", method = RequestMethod.POST)
    public @ResponseBody  StatusResDto editMbrPntUsePw(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyMbrEditPntUsePwReqDto param) throws Exception {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyMbrService.editMbrPntUsePw(param);
    }

	@RequestMapping(value="/clearDupMbr.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyDupMbrListResDto> clearDupMbr(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyDupMbrReqDto reqDto) throws Exception  {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		reqDto.setUri(request.getRequestURI());
		return loyMbrService.clearDupMbr(reqDto);
	}

	@RequestMapping(value="/dropReason.do")
	public @ResponseBody StatusResDto dropReason(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyDropReasonReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.dropReason(reqDto);
	}

    /**
    * @programId :
    * @name : getMbrPntAcrlUseYn
    * @date : 2019. 1. 25.
    * @author : hy.jun
    * @table :
    * @return : LOYMbrPntYnResponseDTO
    * @description :
    */
    @RequestMapping(value="/getMbrPntAcrlUseYn.do", method = RequestMethod.POST)
    public @ResponseBody  LoyMbrPntYnResDto getMbrPntAcrlUseYn(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrPntYnReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.getMbrPntAcrlUseYn(reqDto);
    }

	/**
	* @programId :
	* @name : selectTransList
	* @date : 2019. 2. 11.
	* @author : mj.kim
	* @table :
	* @return : GridPagingResDto
	* @description :
	*/
	@RequestMapping(value="/selectTransList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyTransPointListResDto> selectTransList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyTransPointListReqDto reqDto) throws Exception  {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.selectTransList(reqDto);
	}

	/**
	* @programId :
	* @name : dropReason
	* @date : 2019. 2. 12.
	* @author : mj.kim
	* @table :
	* @return : StatusResDto
	* @description :
	*/
	@RequestMapping(value="/transPntReason.do")
	public @ResponseBody StatusResDto transPntReason(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyDropReasonReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.transPntReason(reqDto);
	}

     /*
      * 1. 메소드명: transPointExec
      * 2. 클래스명: LoyMbrController
      * 3. 작성자명: jh.seo
      * 4. 작성일자: 2020. 3. 23.
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
    @RequestMapping(value="/transPointExec.do", method = RequestMethod.POST)
    public @ResponseBody  LoyTransCallExecResDto transPointExec(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyTransPointListReqDto reqDto) {

        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.transPointExec(reqDto);
    }

	 /*
	  * 1. 메소드명: transPointHist
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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
	@RequestMapping(value="/transPointHist.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyTransPntHistResDto> transPointHist(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  LoyTransPointListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.transPointHist(reqDto);
	}

	 /*
	  * 1. 메소드명: editMbrCustName
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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
	@RequestMapping(value="/editCustName.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editMbrCustName(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoyMbrRenameReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.editCustName(reqDto);
	}


     /*
      * 1. 메소드명: getMbrDivList
      * 2. 클래스명: LoyMbrController
      * 3. 작성자명: jh.seo
      * 4. 작성일자: 2020. 3. 23.
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
     *   @param param
     *   @return
     */
    @RequestMapping(value="/getMbrDivList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyMbrDivListResDto> getMbrDivList(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyMbrDivListReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.getMbrDivList(param);
    }

     /*
      * 1. 메소드명: getMbrUpldItemList
      * 2. 클래스명: LoyMbrController
      * 3. 작성자명: jh.seo
      * 4. 작성일자: 2020. 3. 23.
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
     *   @param param
     *   @return
     */
    @RequestMapping(value="/getMbrUpldItemList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyMbrUploadItemResDto> getMbrUpldItemList(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyMbrUploadItemReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.getMbrUpldItemList(param);
    }

     /*
      * 1. 메소드명: mbrDivUploadexcelSampleDown
      * 2. 클래스명: LoyMbrController
      * 3. 작성자명: jh.seo
      * 4. 작성일자: 2020. 3. 23.
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
     *   @throws IOException
     */
    @RequestMapping(value="/mbrDivUploadexcelSampleDown")
    public void  mbrDivUploadexcelSampleDown(HttpServletRequest request, HttpServletResponse response) throws IOException {

    	OutputStream os = null;
		FileInputStream fis = null;

    	String fileName = null;
    	String filePath = null;
    	String offerType = request.getParameter("offerType");



		if(offerType.equals("HHP_NO")){
			fileName="mbr_sample_telephone_sample_data.xls";

  	  try {

			String fileRootPath = CommonUtil.getInstance().getExcelFileSampleDownPath().replaceAll("/", Matcher.quoteReplacement(File.separator));

			filePath = fileRootPath + fileName;

			String realPath = request.getSession().getServletContext().getRealPath("/").replaceAll("/", Matcher.quoteReplacement(File.separator));
			File orgFile = new File(realPath  + filePath);

	         if(orgFile.exists()) {
//				fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
				fileName = SecurityUtil.chkPath(fileName);

				//ContentType 설정
				String mime = request.getSession().getServletContext().getMimeType(fileName);
				if (ObjectUtil.isEmpty(mime)) {
					mime = "application/octet-stream;charset=euc-kr";
				} else {
					mime = "application/octet-stream";
				}
				response.setContentType(mime);

				//헤더 설정
				String userAgent = request.getHeader("User-Agent");
				if (userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
					response.setHeader("Content-Disposition", "filename="+ URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+","\\ ") + ";");
				} else if (userAgent.indexOf("MSIE") > -1) { // MS IE (보통은 6.x 이상 가정)
					response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "\\ ") + ";");
				} else if (userAgent.indexOf("Trident") > -1) { //MS IE 11
					response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "\\ ") + ";");
				} else { // 모질라나 오페라
					response.setHeader("Content-Disposition", "attachment; filename=" + new String(fileName.getBytes("UTF-8"), "latin1").replaceAll("\\+", "\\ ") + ";");
				}

				//파일 출력
				fis = new FileInputStream(orgFile.getAbsolutePath());
				if(fis != null) {
					os = response.getOutputStream();
					int n = 0;
					byte[] b = new byte[1024];
					while ((n = fis.read(b)) != -1) {
						os.write(b, 0, n);
					}
				}
	         } else {
	        	 throw new FileNotFoundException();
	         }
  	} catch (UnsupportedEncodingException e) {
		     LogUtil.error(e);
  	} catch(IOException io){
  		LogUtil.error(io);
		}finally {
			try {
				if(fis != null ) fis.close();
			} catch (IOException e2) {
				{LogUtil.error(e2);  fis = null;}
			}
			try {
				if(os != null)	os.close();
			}catch (IOException io){LogUtil.error(io);  os = null;}
		}
    }
    }

	//추천인 마스킹 해제
	 @RequestMapping(value = "clearMaskRecomm.do", method = RequestMethod.POST)
	    public @ResponseBody LoyMbrRecomHistoryResDto clearMaskRecomm(
	            HttpServletRequest request, HttpServletResponse response,
	            @RequestBody LoyMbrRecomHistoryReqDto reqDto) {
	        LogUtil.param(this.getClass(), reqDto);
	        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	        reqDto.setUri(request.getRequestURI());
	        return loyMbrService.clearMaskRecomm(reqDto);
	    }


	/**
	* @programId :
	* @name : getAllTierList
	* @date : 2019. 7. 2.
	* @author :
	* @table :
	* @return :
	* @description : 등급 목록 조회
	*/
   @RequestMapping(value="/getMbrAllTierList.do", method = RequestMethod.POST)
   public @ResponseBody  GridPagingResDto<LoyMbrTierResDto> getAllTierList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrTierReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyMemberTiersService.getAllTierList(reqDto);
   }

    /**
	* @programId :
	* @name : validAuthCheck
	* @date : 2019. 7. 12.
	* @author : dw.keum
	* @table :
	* @return : StatusResDto
	* @description :
	*/
   @RequestMapping(value="/validAuthCheck.do", method = RequestMethod.POST)
   public @ResponseBody  StatusResDto validAuthCheck(HttpServletRequest request, HttpServletResponse response,
   	   @RequestBody CommonDataAuthReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
       StatusResDto rtnValue = new StatusResDto();

       boolean adviser =  authHelper.checkAuthGroupType(request, AUTH_GROUP_TYPE_CD.ADVISER);
       boolean adviserMgt =  authHelper.checkAuthGroupType(request, AUTH_GROUP_TYPE_CD.ADVISER_MGT);
       boolean adminMaster = authHelper.checkAuthGroupType(request, AUTH_GROUP_TYPE_CD.MKT_MASTER);

       if(adviser || adviserMgt || adminMaster) {
    	   rtnValue.setSuccess(true);
       }else {
    	   rtnValue.setSuccess(false);
       }
       return rtnValue;
   }

   /**
	* @programId :
	* @name : getMaxPointLabel
	* @date : 2019. 7. 15.
	* @author : dw.keum
	* @table :
	* @return : StatusResDto
	* @description :
	*/
   @RequestMapping(value="/maxPointLabel.do", method = RequestMethod.POST)
   public @ResponseBody  LoyMbrPointAuthResDto getMaxPointLabel(HttpServletRequest request, HttpServletResponse response,
   	   @RequestBody LoyMbrPointAuthReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
       reqDto.setRid(reqDto.getLoginId());
       LoyMbrPointAuthResDto rtnValue = new LoyMbrPointAuthResDto();

       rtnValue = loyMbrService.getMaxPointLabel(reqDto);
       return rtnValue;
   }




		/*
    	  * 1. 메소드명: excelMbrPointTxnList
    	  * 2. 클래스명: LoyMbrController
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
    	 *   @param param
    	 *   @param model
    	 *   @return
    	 *   @throws Exception
    	 */
    	@RequestMapping(value="/excelMbrPointTxnList.do", method = RequestMethod.POST)
		public String excelMbrPointTxnList(HttpServletRequest request, HttpServletResponse response,
					@RequestBody LoyMbrPtnTxnHistReqDto param,ModelMap model) throws Exception {
			LogUtil.param(this.getClass(), param);
	        param.setLoginInfo(authHelper.checkLoginSession(request, response));

//			 ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
//			 edlr.setSystemColumn(param.getSystemColumn());
//	         edlr.setTargetId(null);
//			 edlr.setExcelDownlType(EXCEL_DOWNLOAD_TYPE.PNT_TRANS);
//
//	        // 개인정보가 저장되있는 엑셀을 다운로드 할때 DownFilePath를 넣어 준다.
//	        edlr.setDownFilePath(BeansUtil.getApplicationProperty("icignal.context.resource.personal-file-path")+param.getLoginId());
//	        loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.PNT_TRANS);

	        GridPagingResDto<LoyMbrPtnTxnHistResDto> data = loyTransService.excelMbrPointTxnList(param);
	        //id, createBy, modifyBy, lang	, reqTypeCd, reqUrl, reqIp, reqSessnId, reqLoginId, targetId, downFilePath, excelDownlType 을 PersonalDataExcelViewf로 보내준다
	        model.addAttribute("targetId", null);
	        model.addAttribute("excelDownlType", EXCEL_DOWNLOAD_TYPE.PNT_TRANS);
	        model.addAllAttributes(param.getSystemColumn());
	        model.addAttribute("result", data);
	        model.addAttribute("excelHeader", param.getExcelHeader());
	        model.addAttribute("fileName", "회원 포인트 거래리스트 ");

	        return "PersonalDataExcelView";
		}

    	 /*
    	  * 1. 메소드명: getMbrListNewPage
    	  * 2. 클래스명: LoyMbrController
    	  * 3. 작성자명: 서정환
    	  * 4. 작성일자: 2020. 5. 8.
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
    	@RequestMapping(value="/getMbrListNewPage.do", method = RequestMethod.POST)
    	   public @ResponseBody  GridPagingResDto<LoyMbrListNewPageResDto> getMbrListNewPage(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
    	       LogUtil.param(this.getClass(), reqDto);
    	       reqDto.setLoginInfo(this.checkLoginSession(request, response));
			   reqDto.setStrAuthDataIn(this.getSessionAuthority(request));
    	       return loyMbrService.getMbrListNewPage(reqDto);
    	}

    	 /*
    	  * 1. 메소드명: clearMaskListMbr
    	  * 2. 클래스명: LoyMbrController
    	  * 3. 작성자명: 서정환
    	  * 4. 작성일자: 2020. 5. 15.
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
    	@RequestMapping(value="/clearMaskListMbr.do", method = RequestMethod.POST)
 	   	public @ResponseBody  LoyMbrListNewPageResDto clearMaskListMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

 	       return loyMbrService.clearMaskListMbr(reqDto);
 	    }

    	 /*
    	  * 1. 메소드명: getMmbrDetailNewPage
    	  * 2. 클래스명: LoyMbrController
    	  * 3. 작성자명: 서정환
    	  * 4. 작성일자: 2020. 5. 15.
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
    	@RequestMapping(value="/getMmbrDetailNewPage.do", method = RequestMethod.POST)
 	   	public @ResponseBody  LoyMbrDetailNewPageResDto getMmbrDetailNewPage(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

 	       return loyMbrService.getMmbrDetailNewPage(reqDto);
 	    }

    	 /*
    	  * 1. 메소드명: getmbrCustList
    	  * 2. 클래스명: LoyMbrController
    	  * 3. 작성자명: 서정환
    	  * 4. 작성일자: 2020. 5. 15.
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
    	@RequestMapping(value="/getmbrCustList.do", method = RequestMethod.POST)
 	   	public @ResponseBody  GridPagingResDto<LoyMbCustListResDto> getmbrCustList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

 	       return loyMbrService.getmbrCustList(reqDto);
    	}

    	 /*
    	  * 1. 메소드명: getMbrPointHistList
    	  * 2. 클래스명: LoyMbrController
    	  * 3. 작성자명: 서정환
    	  * 4. 작성일자: 2020. 5. 15.
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
    	@RequestMapping(value="/getMbrPointHistList.do", method = RequestMethod.POST)
 	   	public @ResponseBody  GridPagingResDto<LoyMbrPtnTxnHistListResDto> getMbrPointHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrPtnTxnHistReqDto reqDto) {
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

 	       return loyMbrService.getMbrPointHistList(reqDto);
    	}

    	 /*
    	  * 1. 메소드명: getChnlRelHistList
    	  * 2. 클래스명: LoyMbrController
    	  * 3. 작성자명: 서정환
    	  * 4. 작성일자: 2020. 5. 15.
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
    	@RequestMapping(value="/getChnlRelHistList.do", method = RequestMethod.POST)
 	   	public @ResponseBody  GridPagingResDto<LoyMbrChnlRelListResDto> getChnlRelHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

 	       return loyMbrService.getChnlRelHistList(reqDto);
    	}

    	 /*
    	  * 1. 메소드명: getCouponList
    	  * 2. 클래스명: LoyMbrController
    	  * 3. 작성자명: 서정환
    	  * 4. 작성일자: 2020. 5. 15.
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
    	@RequestMapping(value="/getCouponList.do", method = RequestMethod.POST)
 	   	public @ResponseBody  GridPagingResDto<LoyMbrCouponListResDto> getCouponList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

 	       return loyMbrService.getCouponList(reqDto);
    	}

    	 /*
    	  * 1. 메소드명: getAlterHistList
    	  * 2. 클래스명: LoyMbrController
    	  * 3. 작성자명: 서정환
    	  * 4. 작성일자: 2020. 5. 15.
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
    	@RequestMapping(value="/getAlterHistList.do", method = RequestMethod.POST)
 	   	public @ResponseBody  GridPagingResDto<LoyMbrAlterHistListResDto> getAlterHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

 	       return loyMbrService.getAlterHistList(reqDto);
    	}
    	
     /*
   	  * 1. 메소드명: getAllAboutAlterHistConts
   	  * 2. 클래스명: LoyMbrController
   	  * 3. 작성자명: jb.kim
   	  * 4. 작성일자: 2021. 02. 03.
   	  */
   	/**
   	 * <PRE>
   	 * 1. 설명
   	 *  : 회원의 알림이력 탭에서 각 알림이력에 대한 '내용(컨텐츠)'에 관련된 것을 모두 조회하는 쿼리
   	 * 2. 사용법
   	 *
   	 * </PRE>
   	 *   @param request
   	 *   @param response
   	 *   @param reqDto
   	 *   @return
   	 */
   	@RequestMapping(value="/getAlterHistConts.do", method = RequestMethod.POST)
   	public @ResponseBody  LoyMbrAlterHistContsResDto getAllAboutAlterHistConts(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyMbrService.getAllAboutAlterHistConts(reqDto);
	}

    	 /*
    	  * 1. 메소드명: getMemberCardList
    	  * 2. 클래스명: LoyMbrController
    	  * 3. 작성자명: 서정환
    	  * 4. 작성일자: 2020. 5. 15.
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
    	@RequestMapping(value="/getMemberCardList.do", method = RequestMethod.POST)
 	   	public @ResponseBody  GridPagingResDto<LoyMbrMemberCardListResDto> getMemberCardList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

 	       return loyMbrService.getMemberCardList(reqDto);
    	}

    	 /*
    	  * 1. 메소드명: getBlackHistList
    	  * 2. 클래스명: LoyMbrController
    	  * 3. 작성자명: 서정환
    	  * 4. 작성일자: 2020. 5. 15.
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
    	@RequestMapping(value="/getBlackHistList.do", method = RequestMethod.POST)
 	   	public @ResponseBody  GridPagingResDto<LoyMbrBlackHistListResDto> getBlackHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

 	       return loyMbrService.getBlackHistList(reqDto);
    	}

    	@RequestMapping(value="/getRecommendHistList.do", method = RequestMethod.POST)
 	   	public @ResponseBody  GridPagingResDto<LoyMbrRecommendHistListResDto> getRecommendHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

 	       return loyMbrService.getRecommendHistList(reqDto);
    	}

    	@RequestMapping(value="/getMbrTierListNew.do", method = RequestMethod.POST)
 	   	public @ResponseBody  GridPagingResDto<LoyMbrTiersListResDto> getMbrTierListNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

 	       return loyMbrService.getMbrTierListNew(reqDto);
    	}

    	@RequestMapping(value="/getMbrEventHistListNew.do", method = RequestMethod.POST)
 	   	public @ResponseBody  GridPagingResDto<LoyMbrEventHistListResDto> getMbrEventHistListNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

 	       return loyMbrService.getMbrEventHistListNew(reqDto);
    	}
    	 /*
    	  * 1. 메소드명: saveNewCust
    	  * 2. 클래스명: LoyMbrController
    	  * 3. 작성자명: hr.noh
    	  * 4. 작성일자: 2020. 6. 10.
    	  */
    	/**
    	 * <PRE>
    	 * 1. 설명
    	 *		회원 가입(대한항공)
    	 * 2. 사용법
    	 *
    	 * </PRE>
    	 *   @param request
    	 *   @param response
    	 *   @param reqDto
    	 *   @return
    	 */
//    	@RequestMapping(value="/saveNewCust.do", method = RequestMethod.POST)
//    	public @ResponseBody LoyCallAddNewCustResDto saveNewCust(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNewCustAddReqDto reqDto) {
//    		LogUtil.param(this.getClass(), reqDto);
//  	       	LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
//  	       	reqDto.setEmpId(loginInfo.getId());
//
//  	       	return loyMbrService.saveNewCust(reqDto);
//    	}

    	 /*
    	  * 1. 메소드명: saveNewCust
    	  * 2. 클래스명: LoyMbrController
    	  * 3. 작성자명: hr.noh
    	  * 4. 작성일자: 2020. 7. 10.
    	  */
    	/**
    	 * <PRE>
    	 * 1. 설명
    	 *		회원가입 (신규 type)
    	 * 2. 사용법
    	 *
    	 * </PRE>
    	 *   @param request
    	 *   @param response
    	 *   @param reqDto
    	 *   @return
    	 */
    	@RequestMapping(value="/saveJoinCustAll.do", method = RequestMethod.POST)
    	public @ResponseBody LoyCallAddNewCustResDto saveJoinCustAll(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNewCustAddReqDto reqDto) {
    		LogUtil.param(this.getClass(), reqDto);
    		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
    		reqDto.setEmpId(loginInfo.getId());

    		return loyMbrService.saveJoinCustAll(reqDto);
    	}

    	 /*
    	  * 1. 메소드명: custItemConfVal
    	  * 2. 클래스명: LoyMbrController
    	  * 3. 작성자명: hr.noh
    	  * 4. 작성일자: 2020. 6. 10.
    	  */
    	/**
    	 * <PRE>
    	 * 1. 설명
    	 *		고객정보수집 항목 가져오기(대표 프로그램)
    	 * 2. 사용법
    	 *
    	 * </PRE>
    	 *   @param request
    	 *   @param response
    	 *   @param reqDto
    	 *   @return
    	 */
    	@RequestMapping(value="/custItemConfVal.do", method = RequestMethod.POST)
    	public @ResponseBody GridPagingResDto<LoyCustItemConfListResDto> custItemConfVal(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustItemConfReqDto reqDto){
  	       LogUtil.param(this.getClass(), reqDto);
  	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
  	       return loyMbrService.custItemConfVal(reqDto);
    	}


   	@RequestMapping(value="/getMbrTxnHistList.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyMbrTxnHistListResDto> getMbrTxnHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto){
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
 	       return loyMbrService.getMbrTxnHistList(reqDto);
   	}

   	@RequestMapping(value="/getMbrOnBoardHistList.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyMbrOnBoardTxnHistListResDto> getMbrOnBoardHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto){
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
 	       return loyMbrService.getMbrOnBoardHistList(reqDto);
   	}

   	@RequestMapping(value="/getCouponHistList.do", method = RequestMethod.POST)
   		public @ResponseBody  GridPagingResDto<LoyMbrCouponListResDto> getCouponHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
   		LogUtil.param(this.getClass(), reqDto);
   		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyMbrService.getCouponHistList(reqDto);
   	}

   	@RequestMapping(value="/getMbrAgreList.do", method = RequestMethod.POST)
		public @ResponseBody  GridPagingResDto<LoyMbrAgreListResDto> getMbrAgreList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyMbrService.getMbrAgreList(reqDto);
	}

   	@RequestMapping(value = "/mbrOnBoardHistExcelListGrid.do", method = RequestMethod.POST)
	public String mbrOnBoardHistExcelListGrid(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<LoyMbrOnBoardTxnHistListResDto> data = loyMbrService.getMbrOnBoardExcelHistList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "회원  자격 마일리지 목록");

		return "ExcelView";
	}

   	@RequestMapping(value = "/mbrPointExcelList.do", method = RequestMethod.POST)
	public String mbrPointExcelList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrPtnTxnHistReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<LoyMbrPtnTxnHistListResDto> data = loyMbrService.getMbrPointExcelHistList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "회원  마일리지 목록");

		return "ExcelView";
	}

   	@RequestMapping(value = "/mbrTxnHistExcelList.do", method = RequestMethod.POST)
	public String mbrTxnHistExcelList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<LoyMbrTxnHistListResDto> data = loyMbrService.getMbrTxnHistList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "회원  구매이력 목록");

		return "ExcelView";
	}

   	 /*
   	  * 1. 메소드명: getMbrFamilyList
   	  * 2. 클래스명: LoyMbrController
   	  * 3. 작성자명: hr.noh
   	  * 4. 작성일자: 2020. 6. 22.
   	  */
   	/**
   	 * <PRE>
   	 * 1. 설명
   	 *		회원 패밀리 리스트
   	 * 2. 사용법
   	 *
   	 * </PRE>
   	 *   @param request
   	 *   @param response
   	 *   @param reqDto
   	 *   @return
   	 */
   	@RequestMapping(value="/getMbrFamilyList.do", method = RequestMethod.POST)
	public @ResponseBody  GridPagingResDto<LoyMbrFamilyListResDto> getMbrFamilyList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrFamilyListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyMbrService.getMbrFamilyList(reqDto);
	}

	 /*
	  * 1. 메소드명: saveNewFmlyMbr
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 회원 가입
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/saveNewFmlyMbr.do", method = RequestMethod.POST)
	public @ResponseBody LoyFamilyCallbackResDto saveNewFmlyMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyFamilyListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       	return loyMbrService.saveNewFmlyMbr(reqDto);
	}

	 /*
	  * 1. 메소드명: checkFmlyChief
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		대표 회원여부 확인 (가입 버튼 제어 - 대표회원의 상세 일때만 구성원 가입이 가능하다)
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/checkFmlyChief.do", method = RequestMethod.POST)
	public @ResponseBody LoyMbrFmlyResDto checkFmlyChief(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrFamilyListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       	return loyMbrService.checkFmlyChief(reqDto);
	}

	 /*
	  * 1. 메소드명: removeFmlyMbr
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 회원 탈퇴
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/removeFmlyMbr.do", method = RequestMethod.POST)
	public @ResponseBody LoyFamilyCallbackResDto removeFmlyMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyFamilyListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       	return loyMbrService.removeFmlyMbr(reqDto);
	}

	 /*
	  * 1. 메소드명: termsListVal
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입 약관리스트 불러오기
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/termsListVal.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyTermsListResDto> termsListVal(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTermsListReqDto reqDto){
	       LogUtil.param(this.getClass(), reqDto);
	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	       return loyMbrService.termsListVal(reqDto);
	}

	 /*
	  * 1. 메소드명: termsMktRcvListVal
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 약관 마켓팅 수신동의 항목 리스트 불러오기
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/termsMktRcvListVal.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyTermsRcvChnlListResDto> termsMktRcvListVal(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTermsListReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.termsMktRcvListVal(reqDto);
	}

	 /*
	  * 1. 메소드명: getMbrDetailPop
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 정보 수정팝업 상세
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/getMbrDetailPop.do", method = RequestMethod.POST)
	public @ResponseBody LoyMbrDetailPopResDto getMbrDetailPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.getMbrDetailPop(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCorpMbrDetailPop
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: lee gyeong young
	  * 4. 작성일자: 2020. 12. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 회원 정보 수정팝업 상세
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/getCorpMbrDetailPop.do", method = RequestMethod.POST)
	public @ResponseBody LoyCorpMbrDetailPopResDto getCorpMbrDetailPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.getCorpMbrDetailPop(reqDto);
	}

	 /*
	  * 1. 메소드명: getMbrTermsDetailList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 정보 수정팝업 동의이력 리스트
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/getMbrTermsDetailList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyAgreTermsResDto> getMbrTermsDetailList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.getMbrTermsDetailList(reqDto);
	}

	 /*
	  * 1. 메소드명: saveMbrDetailPop
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원정보 상세 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/saveMbrDetailPop.do", method = RequestMethod.POST)
	public @ResponseBody LoyCallAddNewCustResDto saveMbrDetailPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNewCustAddReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.saveMbrDetailPop(reqDto);
	}
	
	 /*
	  * 1. 메소드명: saveCorpMbrDetailPop
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: lee gyeong young
	  * 4. 작성일자: 2020. 12. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원정보 상세 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/saveCorpMbrDetailPop.do", method = RequestMethod.POST)
	public @ResponseBody LoyCallAddNewCustResDto saveCorpMbrDetailPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNewCustAddReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.saveCorpMbrDetailPop(reqDto);
	}

	 /*
	  * 1. 메소드명: getCorpMbrListPop
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인회원 조회 (회원번호 뽑기)
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/getCorpMbrListPop.do", method=RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyMbrListPopResDto> getCorpMbrListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

    	return loyMbrService.getCorpMbrListPop(reqDto);
	}

	 /*
	  * 1. 메소드명: getCorpMbrListPop
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인회원 (고객) 브랜치 리스트 popup
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/getCorpBranchListPop.do", method=RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCustBranchResDto> getCorpBranchListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCustBranchReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

    	return loyMbrService.getCorpBranchListPop(reqDto);
	}

	 /*
	  * 1. 메소드명: withdrawMbr
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 탈퇴
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/withdrawMbr.do", method=RequestMethod.POST)
	public @ResponseBody LoyWithdrawMbrCallResDto  withdrawMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyMbrService.withdrawMbr(reqDto);
	}

	 /*
	  * 1. 메소드명: checkCardNumber
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입 법인카드번호 인증
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/checkCardNumber.do", method=RequestMethod.POST)
	public @ResponseBody LoyMbrCCardResDto  checkCardNumber(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyMbrService.checkCardNumber(reqDto);
	}

	@RequestMapping(value="/getMbrCouponHistList.do", method = RequestMethod.POST)
		public @ResponseBody  GridPagingResDto<LoyMbrCouponListResDto> getMbrCouponHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyMbrService.getMbrCouponHistList(reqDto);
	}
	
	
	 /*
	  * 1. 메소드명: checkUserId
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입 웹아이디 검증
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/checkUserId.do", method=RequestMethod.POST)
	public @ResponseBody LoyMbrCCardResDto  checkUserId(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyMbrService.checkUserId(reqDto);
	}
	
	 /*
	  * 1. 메소드명: checkRcmmdNo
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입 추천인코드 검증
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/checkRcmmdNo.do", method=RequestMethod.POST)
	public @ResponseBody LoyMbrCCardResDto  checkRcmmdNo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyMbrService.checkRcmmdNo(reqDto);
	}
	 /*
	  * 1. 메소드명: getCustSegmentHistList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: sh.park
	  * 4. 작성일자: 2020. 7. 23.
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
	@RequestMapping(value="/getCustSegmentHistList.do", method = RequestMethod.POST)
   	public @ResponseBody  GridPagingResDto<LoyMbrSegmentHistListResDto> getCustSegmentHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyMbrService.getCustSegmentHistList(reqDto);
	}
	
	@RequestMapping(value="/getMbrTierHistListNew.do", method = RequestMethod.POST)
	   	public @ResponseBody  GridPagingResDto<LoyMbrTiersListResDto> getMbrTierHistListNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
	       LogUtil.param(this.getClass(), reqDto);
	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	       return loyMbrService.getMbrTierHistListNew(reqDto);
	}
	
	@RequestMapping(value="/saveApproval.do", method = RequestMethod.POST)
    public @ResponseBody  StatusResDto saveApproval(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyTierApprovalReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.saveApproval(reqDto);
    }
	
	@RequestMapping(value="/getTierMgtPlcy.do", method = RequestMethod.POST)
    public @ResponseBody  StatusResDto getTierMgtPlcy(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.getTierMgtPlcy(reqDto);
    }
	
	@RequestMapping(value="/getTierDetailPop.do", method = RequestMethod.POST)
   	public @ResponseBody  LoyMbrTiersDetailResDto getTierDetailPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyMbrService.getTierDetailPop(reqDto);
}
	
	@RequestMapping(value="/modifyTiers.do", method = RequestMethod.POST)
    public @ResponseBody  StatusResDto modifyTiers(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrTiersDetailReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.modifyTiers(reqDto);
    }
	
	 /*
	  * 1. 메소드명: purAcrlPointProc
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 구매이력 적립
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/purAcrlPointProc.do", method = RequestMethod.POST)
	public @ResponseBody  StatusResDto purAcrlPointProc(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.purAcrlPointProc(reqDto);
	}
	
	 /*
	  * 1. 메소드명: searchMbrGiftPntTgtMbr
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 포인트양도 타켓 회원 찾기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/searchMbrGiftPntTgtMbr.do", method = RequestMethod.POST)
   	public @ResponseBody  GridPagingResDto<LoyMbrListPopResDto> searchMbrGiftPntTgtMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyMbrService.searchMbrGiftPntTgtMbr(reqDto);
	}
	
	 /*
	  * 1. 메소드명: setMbrPointGiftProc
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 포인트 양도하기 프로시져
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/setMbrPointGiftProc.do", method = RequestMethod.POST)
	public @ResponseBody  LoyWithdrawMbrCallResDto setMbrPointGiftProc(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.setMbrPointGiftProc(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getGiftPointHistList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 포인트 양도 이력 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getGiftPointHistList.do", method = RequestMethod.POST)
   	public @ResponseBody  GridPagingResDto<LoyMbrPointHistListResDto> getGiftPointHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyMbrService.getGiftPointHistList(reqDto);
	}
	
   	 /*
   	  * 1. 메소드명: getMbrUsePurMax
   	  * 2. 클래스명: LoyMbrController
   	  * 3. 작성자명: hr.noh
   	  * 4. 작성일자: 2020. 8. 6.
   	  */
   	/**
   	 * <PRE>
   	 * 1. 설명
   	 *		양도 포인트 1회 한도 
   	 * 2. 사용법
   	 *		
   	 * </PRE>
   	 *   @param request
   	 *   @param response
   	 *   @param reqDto
   	 *   @return	
   	 */
   	@RequestMapping(value="/getMbrUsePurMax.do", method = RequestMethod.POST)
	public @ResponseBody LoyMbrPointAuthResDto getMbrUsePurMax(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyMbrService.getMbrUsePurMax(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getMbrPgmChnlPop
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 포인트 양도시 프로그램에 하위 채널 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getMbrPgmChnlPop.do", method = RequestMethod.POST)
   	public @ResponseBody  GridPagingResDto<LoyChnlListResDto> getMbrPgmChnlPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyMbrService.getMbrPgmChnlPop(reqDto);
	}
	
   	 /*
   	  * 1. 메소드명: getPgmMgtPlcy
   	  * 2. 클래스명: LoyMbrController
   	  * 3. 작성자명: hr.noh
   	  * 4. 작성일자: 2020. 8. 10.
   	  */
   	/**
   	 * <PRE>
   	 * 1. 설명
   	 *		프로그램별 법인회원가입 운영정책있는지 여부(1 : 있다 ,0 : 없다)
   	 * 2. 사용법
   	 *		
   	 * </PRE>
   	 *   @param request
   	 *   @param response
   	 *   @param reqDto
   	 *   @return	
   	 */
   	@RequestMapping(value="/getPgmMgtPlcy.do", method = RequestMethod.POST)
	public @ResponseBody int getPgmMgtPlcy(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyMbrService.getPgmMgtPlcy(reqDto);
	}
   	
   	@RequestMapping(value="/getMbrIntList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyMbrIntListResDto> getMbrIntList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyMbrService.getMbrIntList(reqDto);
	}
   	
   	@RequestMapping(value="/saveMbrInt.do", method = RequestMethod.POST)
	public @ResponseBody  StatusResDto saveMbrInt(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrIntDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.saveMbrInt(reqDto);
	}
   	
   	@RequestMapping(value="/removeMbrInt.do", method = RequestMethod.POST)
	public @ResponseBody  StatusResDto removeMbrInt(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrIntDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.removeMbrInt(reqDto);
	}
   	
   	@RequestMapping(value="/clearMaskMbrInt.do", method = RequestMethod.POST)
	public @ResponseBody LoyMbrIntListResDto clearMaskMbrInt(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyMbrService.clearMaskMbrInt(reqDto);
	}
   	
	 /*
	  * 1. 메소드명: blackRuleFmly
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 이상거래정책 심사
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/blackRuleFmly.do", method = RequestMethod.POST)
	public @ResponseBody LoyFamilyCallbackResDto blackRuleFmly(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyFamilyListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());

		return loyMbrService.blackRuleFmly(reqDto);
	}
	
	 /*
	  * 1. 메소드명: executivesViewSelect
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 11. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 임직원 변경
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/executivesViewSelect.do", method = RequestMethod.POST)
	public @ResponseBody LoyExecutivesViewResDto executivesViewSelect(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyExecutivesViewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyMbrService.executivesViewSelect(reqDto);
	}
	 /*
	  * 1. 메소드명: executivesExistSelect
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 11. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사번에 대한 임직원 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/executivesExistSelect.do", method = RequestMethod.POST)
	public @ResponseBody LoyExecutivesViewResDto executivesExistSelect(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyExecutivesViewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyMbrService.executivesExistSelect(reqDto);
	}	
	 /*
	  * 1. 메소드명: empNoUpdateExecutives
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 11. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		임직원 사원 번호 변경
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/empNoUpdateExecutives.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto  empNoUpdateExecutives(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyExecutivesViewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyMbrService.empNoUpdateExecutives(reqDto);
	}
	 /*
	  * 1. 메소드명: StatCdUpdateExecutives
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 11. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		임직원 변경
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/StatCdUpdateExecutives.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto StatCdUpdateExecutives(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyExecutivesViewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyMbrService.StatCdUpdateExecutives(reqDto);
	}	
	 /*
	  * 1. 메소드명: buyDetailSelect(오프라인)
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 11. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		구입 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
   	@RequestMapping(value="/buyDetailSelect.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyMbrTxnHistListResDto> buyDetailSelect(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto){
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
 	       return loyMbrService.buyDetailSelect(reqDto);
   	}
   	
    /*
	  * 1. 메소드명: buyDetailSelectOnline(온라인)
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2021. 03. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		구입 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
  	@RequestMapping(value="/buyDetailSelectOnline.do", method = RequestMethod.POST)
  	public @ResponseBody GridPagingResDto<LoyMbrTxnHistListResDto> buyDetailSelectOnline(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto){
	       LogUtil.param(this.getClass(), reqDto);
	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	       return loyMbrService.buyDetailSelectOnline(reqDto);
  	}
   	
   	
	 /*
	  * 1. 메소드명: getProdCustList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 11. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 상품평 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
    @RequestMapping(value="/getProdCustList.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyMbrProdCustListResDto> getProdCustList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.getProdCustList(reqDto);
    }
	 /*
	  * 1. 메소드명: prodCustListDetail
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 11. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객상품평 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
    @RequestMapping(value="/prodCustListDetail.do", method = RequestMethod.POST)
    public @ResponseBody  LoyMbrProdCustDetailResDto prodCustListDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrProdCustListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.prodCustListDetail(reqDto);
    }
	 /*
	  * 1. 메소드명: getDorMantList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 11. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		휴면 회원 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getDorMantList.do", method = RequestMethod.POST)
	   public @ResponseBody  GridPagingResDto<LoyMbrListNewPageResDto> getDorMantList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
	       LogUtil.param(this.getClass(), reqDto);
	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	       return loyMbrService.getDorMantList(reqDto);
	}
	 /*
	  * 1. 메소드명: getBeforeDorMantList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 11. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		휴면 예정 회원 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getBeforeDorMantList.do", method = RequestMethod.POST)
	   public @ResponseBody  GridPagingResDto<LoyMbrListNewPageResDto> getBeforeDorMantList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
	       LogUtil.param(this.getClass(), reqDto);
	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	       return loyMbrService.getBeforeDorMantList(reqDto);
	}
	 /*
	  * 1. 메소드명: getexecutivesList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 11. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 임직원 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getexecutivesList.do", method = RequestMethod.POST)
	   public @ResponseBody  GridPagingResDto<LoyMbrListNewPageResDto> getexecutivesList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
	       LogUtil.param(this.getClass(), reqDto);
	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	       return loyMbrService.getexecutivesList(reqDto);
	}	
	
	 /*
	  * 1. 메소드명: getExecutivesPopComm
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 11. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 임직원 상태 코드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getExecutivesPopComm.do", method = RequestMethod.POST)
	   public @ResponseBody  List<LoyMbrCommResDto> getExecutivesPopComm(HttpServletRequest request, HttpServletResponse response) {
	       
		return loyMbrService.getExecutivesPopComm();
	}
	
	 /*
	  * 1. 메소드명: getPrStoreNmPopList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 12. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 주 거래 매장 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getPrStoreNmPopList.do", method=RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlListResDto> getPrStoreNmPopList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCommonReqDto reqDto) {
   	LogUtil.param(this.getClass(), reqDto);
   	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

   	return loyMbrService.getPrStoreNmPopList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getCampaignExecList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 12. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		캠페인 이력
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getCampaignExecList.do", method=RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCampaignExecListResDto> getCampaignExecList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
  	LogUtil.param(this.getClass(), reqDto);
  	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

  	return loyMbrService.getCampaignExecList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getNegativeAccList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2021. 01. 04.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		부정회원 적립
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getNegativeAccList.do", method=RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyNegativeAccResDto> getNegativeAccList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNegativeAccReqDto reqDto) {
 	LogUtil.param(this.getClass(), reqDto);
 	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

 	return loyMbrService.getNegativeAccList(reqDto);
	}
	
    /**
     * @programId
     * @name clearMaskNegativeAccList
     * @date 2021. 01. 04.
     * @author lee gyeong young
     * @param request
     * @param response
     * @param reqDto
     * @return
     * @description 마스킹 해제 
     */
    @RequestMapping(value = "clearMaskNegativeAccList.do", method = RequestMethod.POST)
    public @ResponseBody LoyNegativeAccResDto clearMaskNegativeAccList(
            HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNegativeAccReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setUri(request.getRequestURI());
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.clearMaskNegativeAccList(reqDto);
    }
   	@RequestMapping(value = "/negativeAccListExcelList.do", method = RequestMethod.POST)
	public String negativeAccListExcelList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNegativeAccReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<LoyNegativeAccResDto> data = loyMbrService.negativeAccListExcelList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "부정적립 회원 조회");

		return "ExcelView";
	}
   	

   	/**
     * @programId
     * @name 		getMbrMgtInfoList
     * @date 		2021. 01. 08.
     * @author 		jb.kim
     * @param 		request
     * @param 		response
     * @param 		reqDto
     * @return 		resDto
     * @description '회원관리정보'에서  한 회원에 대해 각 회원관리속성 별 정보를 나타낸 리스트를 불러오는 기능 
     */
   	@RequestMapping(value="/getMbrMgtInfoList.do", method=RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyMbrMgtInfoResDto> getMbrMgtInfoList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrMgtInfoReqDto reqDto) {
   		LogUtil.param(this.getClass(), reqDto);
   		reqDto.setLoginInfo(authHelper.checkLoginSession(request,response));
   		
   		return loyMbrService.getMbrMgtInfoList(reqDto);
   	}
   	
   	/**
     * @programId
     * @name 		addMbrMgtInfo
     * @date 		2021. 01. 11.
     * @author		jb.kim
     * @param 		request
     * @param 		response
     * @param 		reqDto
     * @return 		resDto
     * @description 회원관리정보 신규 추가 	
     */
   	@RequestMapping(value="/addMbrMgtInfo.do", method=RequestMethod.POST)
   	public @ResponseBody StatusResDto addMbrMgtInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrMgtInfoReqDto reqDto) {
   		LogUtil.param(this.getClass(), reqDto);
   		reqDto.setLoginInfo(authHelper.checkLoginSession(request,response));
   		
   		return loyMbrService.addMbrMgtInfo(reqDto);
   	}
   	
	/**
     * @programId
     * @name 			updateMbrMgtInfo
     * @date 			2021. 01. 11.
     * @author			jb.kim
     * @param 			request
     * @param 			response
     * @param 			reqDto
     * @return 			resDto
     * @description  	회원관리정보 수정
     */
   	@RequestMapping(value="/updateMbrMgtInfo.do", method=RequestMethod.POST)
   	public @ResponseBody StatusResDto updateMbrMgtInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrMgtInfoReqDto reqDto) {
   		LogUtil.param(this.getClass(), reqDto);
   		reqDto.setLoginInfo(authHelper.checkLoginSession(request,response));
   		
   		return loyMbrService.updateMbrMgtInfo(reqDto);
   	}
   	
   	/**
     * @programId
     * @name 			getMbrMgtInfoHistList
     * @date 			2021. 01. 12.
     * @author 			jb.kim
     * @param 			request
     * @param 			response
     * @param 			reqDto
     * @return 			resDto
     * @description 	회원관리정보 이력 내역을 리스트로 조회해오는 기능
     */
   	@RequestMapping(value="/getMbrMgtInfoHistList.do", method=RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyMbrMgtInfoResDto> getMbrMgtInfoHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrMgtInfoReqDto reqDto) {
   		LogUtil.param(this.getClass(), reqDto);
   		reqDto.setLoginInfo(authHelper.checkLoginSession(request,response));// 조회해오는 상황에선 꼭 필요하진 않지만, authHelper.checkLoginSession()행위 자체로 관련기록도 남겨지게 되고, 시스템에 좀 깊은 긴밀한 내용을 건드리는 것을 방지할 수 있다고 한다.
   		
   		return loyMbrService.getMbrMgtInfoHistList(reqDto);
   	}
   	
   	/**
     * @programId
     * @name			 deleteMbrMgtInfo
     * @date 			2021. 01. 11.
     * @author 			jb.kim
     * @param 			request
     * @param 			response
     * @param 			reqDto
     * @return 			resDto
     * @description  	회원관리정보 삭제(논리삭제)
     */
   	@RequestMapping(value="/deleteMbrMgtInfo.do", method=RequestMethod.POST)
   	public @ResponseBody StatusResDto deleteMbrMgtInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrMgtInfoReqDto reqDto) {
   		LogUtil.param(this.getClass(), reqDto);
   		reqDto.setLoginInfo(authHelper.checkLoginSession(request,response));
   		
   		return loyMbrService.deleteMbrMgtInfo(reqDto);
   	}
   	
   	/**
     * @programId
     * @name			getMbrMgtInfoBeforeUpdate
     * @date 			2021. 01. 11.
     * @author 			jb.kim
     * @param 			request
     * @param 			response
     * @param			reqDto
     * @return			resDto
     * @description 	회원정보관리 수정 팝업 시 수정할 필드 내용들을 조회해 로드하는 기능  
     */
   	@RequestMapping(value="/getMbrMgtInfoBeforeUpdate.do", method=RequestMethod.POST)
   	public @ResponseBody LoyMbrMgtInfoResDto getMbrMgtInfoBeforeUpdate(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrMgtInfoReqDto reqDto) {
   		LogUtil.param(this.getClass(), reqDto); 
   		
   		return loyMbrService.getMbrMgtInfoBeforeUpdate(reqDto);
   	}
   	
   	/**
 	 * @programId
 	 * @name :		checkAttrCdAttrSubCd
 	 * @date :		2021. 01. 12.
 	 * @author : 	jb.kim
 	 * @table : 	LOY.LOY_MBR_MGT_ATTR
 	 * @return : 	rtnValue
 	 * @description : 회원관리속성에서 '신규/수정' 저장 시, 유효성검사로 현재 처리되려는 건의
 	 *                ATTR_CD와 ATTR_SUB_CD값과 동일한 것이 해당 테이블 안에 존재하고 있는지 확인
 	 */
	@RequestMapping(value="/checkAttrCdAttrSubCd.do", method=RequestMethod.POST) 
	public @ResponseBody StatusResDto checkAttrCdAttrSubCd(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrMgtInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
				
		return loyMbrService.checkAttrCdAttrSubCd(reqDto);
	}
   	
	 /*
	  * 1. 메소드명: getOnlineCouponHistList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2020. 1. 14.
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
	@RequestMapping(value="/getOnlineMallCouponHistList.do", method = RequestMethod.POST)
   	public @ResponseBody  GridPagingResDto<LoyMbrCouponListResDto> getOnlineMallCouponHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyMbrService.getOnlineMallCouponHistList(reqDto);
	}

	 /*
	  * 1. 메소드명: getNewMallCouponList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2021. 03. 05.
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
	@RequestMapping(value="/getNewMallCouponList.do", method = RequestMethod.POST)
  	public @ResponseBody  GridPagingResDto<LoyMbrCouponListResDto> getNewMallCouponList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
      LogUtil.param(this.getClass(), reqDto);
      reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

      return loyMbrService.getNewMallCouponList(reqDto);
	}
	
	
	/*
	  * 1. 메소드명: getTierBenefitHistList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2020. 1. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 	: 회원의 (RID_MBR) 등급혜택이력을 조회하는 메소드
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value = "/getTierBenefitHistList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyMbrTierBenefitHistResDto> getTierBenefitHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrTierBenefitHistReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request,response));
		
		return loyMbrService.getTierBenefitHistList(reqDto);
	}
	
	/**
	 * <PRE>
	 * 1. 메소드명 : getMbrCustTypeCd
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/getMbrCustTypeCd.do", method = RequestMethod.POST)
	   public @ResponseBody  LoyMbrListNewPageResDto getMbrCustTypeCd(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
	       LogUtil.param(this.getClass(), reqDto);
	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	       return loyMbrService.getMbrCustTypeCd(reqDto);
	}
	
	/*
	  * 1. 메소드명: getMbrTxnHistSumList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2020. 2. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 	: 구매이력 판매금액,할인금액,최종 결제 금액 합계
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
   	@RequestMapping(value="/getMbrTxnHistSumList.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyMbrTxnHistListResDto> getMbrTxnHistSumList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto){
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
 	       return loyMbrService.getMbrTxnHistSumList(reqDto);
   	}

	/*
	  * 1. 메소드명: getMbrPntHistSumList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2020. 2. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 	: 포인트 결제금액, 포인트 합계
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
   	@RequestMapping(value="/getMbrPntHistSumList.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyMbrTxnHistListResDto> getMbrPntHistSumList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto){
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
 	       return loyMbrService.getMbrPntHistSumList(reqDto);
   	}
   	
   	@RequestMapping(value="/getCpnIssueOfferList.do", method = RequestMethod.POST)
		public @ResponseBody  GridPagingResDto<LoyClubOfferListResDto> getCpnIssueOfferList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubOfferDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyMbrService.getCpnIssueOfferList(reqDto);
	}
   	
	@RequestMapping(value="/getMbrCouponTxnHistList.do", method = RequestMethod.POST)
	public @ResponseBody  GridPagingResDto<LoyMbrCouponListResDto> getMbrCouponTxnHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
	LogUtil.param(this.getClass(), reqDto);
	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	return loyMbrService.getMbrCouponTxnHistList(reqDto);
}
	
    @RequestMapping(value="/updatePntYn.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto updatePntYn(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.updatePntYn(reqDto);
    }
    
    
    @RequestMapping(value="/updateRdmPntYn.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto updateRdmPntYn(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyMbrReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyMbrService.updateRdmPntYn(reqDto);
    }


    /**
    * @programId :
    * @name : editMbrPntUsePwLL
    * @date : 2021. 03.24.
    * @author : 2sh.park
    * @table :
    * @return : StatusResDto
    * @description : 락앤락 포인트 비밀번호 변경
    */
    @RequestMapping(value="/editMbrPntUsePwLL.do", method = RequestMethod.POST)
    public @ResponseBody  StatusResDto editMbrPntUsePwLL(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyMbrEditPntUsePwReqDto param) throws Exception {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyMbrService.editMbrPntUsePwLL(param);
    }
	

    /**
    * @programId :
    * @name : editMbrPntUsePwLL
    * @date : 2021. 03.29.
    * @author : 2sh.park
    * @table :
    * @return : StatusResDto
    * @description : 락앤락 로그인 비밀번호 변경
    */
    @RequestMapping(value="/editMbrLoiginPwLL.do", method = RequestMethod.POST)
    public @ResponseBody  StatusResDto editMbrLoiginPwLL(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyMbrEditPntUsePwReqDto param) throws Exception {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyMbrService.editMbrLoiginPwLL(param);
    }
    /**
    * @programId :
    * @name : getOfrPntList
    * @date : 2021.04.06.
    * @author : 2sh.park
    * @table :
    * @return : StatusResDto
    * @description : 가용포인트 상세
    */
    @RequestMapping(value="/getOfrPntList.do", method = RequestMethod.POST)
	public @ResponseBody  GridPagingResDto<LoyClubOfferListResDto> getOfrPntList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubOfferDetailReqDto reqDto) {
	LogUtil.param(this.getClass(), reqDto);
	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

	return loyMbrService.getOfrPntList(reqDto);
}
    
    
      /*
      * 1. 메소드명: editMbrLoiginPwLL
      * 2. 클래스명: LoyMbrController
      * 3. 작성자명: jh.seo 
      * 4. 작성일자: 2021. 4. 19.
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
     *   @param param
     *   @return
     *   @throws Exception	
     */
    @RequestMapping(value="/mbrSecsnMbrToAble.do", method = RequestMethod.POST)
     public @ResponseBody  StatusResDto mbrSecsnMbrToAble(HttpServletRequest request, HttpServletResponse response,
     		@RequestBody LoyMbrReqDto param) throws Exception {
     	LogUtil.param(this.getClass(), param);
     	param.setLoginInfo(authHelper.checkLoginSession(request, response));
     	return loyMbrService.mbrSecsnMbrToAble(param);
     }
    
    
     /*
      * 1. 메소드명: getMbrIntListSearch
      * 2. 클래스명: LoyMbrController
      * 3. 작성자명: jh.seo 
      * 4. 작성일자: 2021. 4. 21.
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
     *   @param param
     *   @return
     *   @throws Exception	
     */
    @RequestMapping(value="/getMbrIntListSearch.do", method = RequestMethod.POST)
    public @ResponseBody  GridPagingResDto<LoyMbrResDto> getMbrIntListSearch(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyMbrReqDto param) throws Exception {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyMbrService.getMbrIntListSearch(param);
    }
    
    @RequestMapping(value="/saveTgtMbrInt.do", method = RequestMethod.POST)
    public @ResponseBody  StatusResDto saveTgtMbrInt(HttpServletRequest request, HttpServletResponse response,
    		@RequestBody LoyMbrReqDto param) throws Exception {
    	LogUtil.param(this.getClass(), param);
    	param.setLoginInfo(authHelper.checkLoginSession(request, response));
    	return loyMbrService.saveMbrInt(param);
    }
	 /*
	  * 1. 메소드명: setCustDorChange
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2021. 04. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		휴면 회원으로 전환 프로시저
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/setCustDorChange.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setCustDorChange(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyExecutivesViewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyMbrService.setCustDorChange(reqDto);
	}
	
    /**
    * @programId :
    * @name :
    * @date : 2021.04.22.
    * @author : LEE GYEONG YOUNG
    * @table :
    * @return : StatusResDto
    * @description : 익월 소멸예정 상세
    */
    @RequestMapping(value="/getExtncList.do", method = RequestMethod.POST)
	public @ResponseBody  GridPagingResDto<LoyClubOfferListResDto> getExtncList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyClubOfferDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.getExtncList(reqDto);
    }

	/*
	 * 1. 메소드명: getMbrListNewPageExcelDown
	 * 2. 클래스명: LoyMbrController
	 * 3. 작성자명:
	 * 4. 작성일자: 2021. 01. 01.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 리스트 엑셀 다운로드(개인정보 엑셀 다운)
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
   	@RequestMapping(value = "/getMbrListNewPageExcelDown.do", method = RequestMethod.POST)
	public String getMbrListNewPageExcelDown(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
	 	edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(reqDto.getRid());
		//ExcelDownloadLogReqDto edlr, EXCEL_DOWNLOAD_TYPE excelDownlType
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.MBR_LIST);

		GridPagingResDto<LoyMbrListNewPageResDto> data = loyMbrService.getMbrListNewPage(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "회원 리스트");

		//return "ExcelView";
		return "PersonalDataExcelView";
	}
   	
   	@RequestMapping(value = "/getExecutivesListExcelDown.do", method = RequestMethod.POST)
	public String getExecutivesListExcelDown(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<LoyMbrListNewPageResDto> data = loyMbrService.getexecutivesList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "임직원 리스트");

		return "ExcelView";
	}    	
   	
   	/*
	  * 1. 메소드명: getMbrTxnHistSumList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2020. 2. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 	: 구매이력 판매금액,할인금액,최종 결제 금액 합계
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
  	@RequestMapping(value="/getMbrTxnHistDeliSumList.do", method = RequestMethod.POST)
  	public @ResponseBody GridPagingResDto<LoyMbrTxnHistListResDto> getMbrTxnHistDeliSumList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto){
	       LogUtil.param(this.getClass(), reqDto);
	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	       return loyMbrService.getMbrTxnHistDeliSumList(reqDto);
  	}
  	
  	@RequestMapping(value="/getMbrDorHistList.do", method = RequestMethod.POST)
   	public @ResponseBody  GridPagingResDto<LoyMbrDorHistResDto> getMbrDorHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto) {
       LogUtil.param(this.getClass(), reqDto);
       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

       return loyMbrService.getMbrDorHistList(reqDto);
	}
  	
    /**
    * @programId :
    * @name : dropMbrListExcelDown
    * @date : 2021.05.21
    * @author : LEE GYEONG YOUNG 
    * @table :
    * @return : excel
    * @description :
    */
  	
    @RequestMapping(value="/dropMbrListExcelDown.do", method = RequestMethod.POST)
    public String dropMbrListExcelDown(HttpServletRequest request, HttpServletResponse response,@RequestBody LoyDropMbrReqDto reqDto, ModelMap model) {

		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<LoyDropMbrResDto> data = loyMbrService.getDropMbrList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "탈회회원 리스트");
		
		return "ExcelView";
    }
    
    /*
	  * 1. 메소드명: saveMbrDetailPop
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원정보 상세 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/saveMbrDorDetailPop.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveMbrDorDetailPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyNewCustAddReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.saveMbrDorDetailPop(reqDto);
	}
	
	/*
	  * 1. 메소드명: saveMbrDetailPop
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원정보 상세 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/modifyPntValidDate.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyPntValidDate(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrPointAcrlReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.modifyPntValidDate(reqDto);
	}

	/*
	 * 1. 메소드명: getMbrSurveyList
	 * 2. 클래스명: LoyMbrController
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 1. 10.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 * 	회원상세 - 설문 탭 리스트
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/getMbrSurveyList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyMbrSurveyListResDto> getMbrSurveyList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.getMbrSurveyList(reqDto);
	}

	/*
	 * 1. 메소드명: getMbrSurveyDetailPop
	 * 2. 클래스명: LoyMbrController
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 1. 11.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 * 	회원상세 - 설문 탭 - 설문결과 상세 팝업
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/getMbrSurveyDetailPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyMbrSurveyListResDto> getMbrSurveyDetailPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.getMbrSurveyDetailPop(reqDto);
	}

	/*
	 * 1. 메소드명: purDetailSelect
	 * 2. 클래스명: LoyMbrController
	 * 3. 작성자명: suji Jung
	 * 4. 작성일자: 2022. 01. 14.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		구입 상세
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */
	@RequestMapping(value="/purDetailSelect.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyMbrTxnHistListResDto> purDetailSelect(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyMbrReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return loyMbrService.purDetailSelect(reqDto);
	}

}