package com.icignal.loyalty.benefit.point.controller;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.cache.dto.response.ProgramCache;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.kepler.report.dto.request.KprReportPntReqDto;
import com.icignal.kepler.report.dto.response.KprReportPointOfMonthResDto;
import com.icignal.kepler.report.service.KprReportService;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransAddInfoReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransCpnListReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransDetailReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransListReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransPntItemListReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransPromoListReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransSearchTestInfoReqDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyProdRevwHistExcelListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyProdRevwHistListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyPurTxnHistListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransAddInfoResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransCpnListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransDetailResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransPntItemListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransPromoListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransSearchTestInfoResDto;
import com.icignal.loyalty.benefit.point.service.LoyTransService;
import com.icignal.loyalty.customer.controller.LoyCustomerController;
import com.icignal.systemmanagement.log.controller.SystemLogController;

/*
 * 1. 클래스명	: LoyTransController
 * 2. 파일명	: LoyTransController.java
 * 3. 패키지명	: com.icignal.loyalty.benefit.point.controller
 * 4. 작성자명	: kimjunki
 * 5. 작성일자	: 2017. 10. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *		로얄티 포인트 거래리스트 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/loyalty/trans")
public class LoyTransController extends BaseController {
	
	@Autowired
	private  AuthHelper authHelper;
	
	@Autowired
	private LoyTransService loyTransSerivce;
	
	@Autowired 
	private LoggingHelper loggingHelper;

	@Autowired
	private KprReportService kprReportService;
	
	@Autowired
	CommonService commonService;

	@Override
	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/include/" + name + ".modal-tiles";
	
		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;	
	}

	/**
	  * @programId :
	  * @name : getTransactionList
	  * @date : 2017. 10. 13.
	  * @author : kimjunki
	  * @table : GridPagingResDto
	  * @return : GridPagingResDto
	  * @description : 포인트 거래리스트 조회
	 **/
    @RequestMapping(value="/getTransactionList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyTransListResDto> getTransactionList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransListReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setLoginInfo(this.checkLoginSession(request, response));
        return loyTransSerivce.getTransactionList(param);
    }
    
    @RequestMapping(value = "/purTxnHistExcelList.do", method = RequestMethod.POST)
	public String ChnlExecDown(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransListReqDto reqDto, ModelMap model) {
//		LogUtil.param(LoyCustomerController.class, reqDto);
//		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		LogUtil.param(SystemLogController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
//		HttpSession session = request.getSession(true);
		//프로그램 경로 가져오기
//		String programPath = (String) session.getAttribute("URL_INCLUDE");
//		if("".equals(programPath)) programPath = (String) session.getAttribute("URL");
//		ProgramCache proResDto = null;
//		String ObjCode = reqDto.getObjCode();
		//MetaData 가져오기
		//commonService.getExcelMetaData(session,programPath,proResDto,ObjCode, model);
    	
		
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(reqDto.getRid());
//		if(StringUtil.isNotEmpty(reqDto.getStrWhere())) {
//			reqDto.setStrWhere(" AND "+reqDto.getStrWhere());
//		} else {
//			reqDto.setStrWhere("");
//		}
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.ORD_LIST,reqDto.getStrCondWhere()+reqDto.getStrWhere());

		GridPagingResDto<LoyPurTxnHistListResDto> data = loyTransSerivce.getMbrTxnHistList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "구매이력 목록");

		return "ExcelView";
	}
    /**
    * @programId :
    * @name : excelDownTransaction
    * @date : 2019. 1. 30.
    * @author : mj.kim
    * @table :
    * @return : GridPagingResDto
    * @description :
    */
    @RequestMapping(value="/excelDownTransaction.do", method = RequestMethod.POST)
    public  String  excelDownTransaction(HttpServletRequest request, HttpServletResponse response, 
    		@RequestBody LoyTransListReqDto reqDto,ModelMap model) throws Exception {
    	LogUtil.param(SystemLogController.class, reqDto);
  		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
  		HttpSession session = request.getSession(true);
  		//프로그램 경로 가져오기
  		String programPath = (String) session.getAttribute("URL_INCLUDE");
  		if("".equals(programPath)) programPath = (String) session.getAttribute("URL");
  		ProgramCache proResDto = null;
  		String ObjCode = reqDto.getObjCode();
  		//MetaData 가져오기
  		commonService.getExcelMetaData(session,programPath,proResDto,ObjCode, model);
      	
  		GridPagingResDto<LoyTransListResDto> data = loyTransSerivce.excelDownTransaction(reqDto);

  		model.addAttribute("result", data);
//  		model.addAttribute("excelHeader", reqDto.getExcelHeader());
//  		model.addAttribute("fileName", "구매이력 목록");

  		return "ExcelView";
    }

    /**
     * @programId :
     * @name : getTransactionListExcel
     * @date : 2018. 3. 22.
     * @author : dgh
     * @table :
     * @변경이력 :
     * @description : 상세조회,과거이력 조회 엑셀 다운오드
     * @param request
     * @param response
     * @param reqDto
     * @return
     */

    @RequestMapping(value="/getTransactionListExcel.do", method = RequestMethod.POST)
    public @ResponseBody  StatusResDto getTransactionListExcel(HttpServletRequest request, HttpServletResponse response,
    	   @RequestBody LoyTransListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return loyTransSerivce.getTransactionListExcel(reqDto, request);
    }


	/**
	  * @programId :
	  * @name : getPointDetailPop
	  * @date : 2017. 10. 13.
	  * @author : kimjunki
	  * @table : loy.loy_pnt_txn
	  * @return : GridPagingResDto
	  * @description :포인트 거래 상세 팝업 조회
	 **/
    @RequestMapping(value="/getPointDetailPop.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyTransListResDto> getPointDetailPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransListReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setLoginInfo(this.checkLoginSession(request, response));
        return loyTransSerivce.getPointDetailPop(param);
    }

	/**
	  * @programId :
	  * @name : getTransactionDetail
	  * @date : 2017. 10. 13.
	  * @author : kimjunki
	  * @table : loy.loy_pnt_txn
	  * @return : GridPagingResDto
	  * @description : 포인트 거래 상세 조회
	 **/
    @RequestMapping(value="/getTransactionDetail.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyTransDetailResDto> getTransactionDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransDetailReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setLoginInfo(this.checkLoginSession(request, response));
        return loyTransSerivce.getTransactionDetail(param);
    }

    /**
	  * @programId :
	  * @name : getTransArchiveDetail
	  * @date : 2018. 03. 19.
	  * @author : sw.lim
	  * @table : loy.loy_pnt_txn
	  * @return : GridPagingResDto
	  * @description : 과거 포인트 거래 상세 조회
	 **/
   @RequestMapping(value="/getTransArchiveDetail.do", method = RequestMethod.POST)
   public @ResponseBody GridPagingResDto<LoyTransDetailResDto> getTransArchiveDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransDetailReqDto param) {
       LogUtil.param(this.getClass(), param);
       param.setLoginInfo(this.checkLoginSession(request, response));
       return loyTransSerivce.getTransArchiveDetail(param);
   }


	/**
	  * @programId :
	  * @name : getTransAddInfo
	  * @date : 2017. 10. 13.
	  * @author : kimjunki
	  * @table : loy.loy_pnt_txn
	  * @return : GridPagingResDto
	  * @description : 추가 정보 탭 조회
	 **/
    @RequestMapping(value="/getTransactAddInfo.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyTransAddInfoResDto> getTransAddInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransAddInfoReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setLoginInfo(this.checkLoginSession(request, response));
        return loyTransSerivce.getTransAddInfo(param);
    }

	/**
	  * @programId :
	  * @name : getTransPromoList
	  * @date : 2017. 10. 13.
	  * @author : kimjunki
	  * @table : lpa.RID_PNT_TXN
	  * @return : GridPagingResDto
	  * @description : 프로모션 항목 조회
	 **/
    @RequestMapping(value="/getTransPromoList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyTransPromoListResDto> getTransPromoList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransPromoListReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyTransSerivce.getTransPromoList(param);
    }
    

	/**
	  * @programId :
	  * @name : getPointUseTxnList
	  * @date : 2021. 03. 31.
	  * @author : 2sh.park
	  * @table : 
	  * @return : GridPagingResDto
	  * @description : 거래상세(포인트 사용)
	 **/
    @RequestMapping(value="/getPointUseTxnList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyTransPromoListResDto> getPointUseTxnList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransPromoListReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setLoginInfo(authHelper.checkLoginSession(request, response));
        return loyTransSerivce.getPointUseTxnList(param);
    }

     /*
      * 1. 메소드명: getPntTxnItemList
      * 2. 클래스명: LoyTransController
      * 3. 작성자명: jh.seo 
      * 4. 작성일자: 2020. 4. 20.
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
    @RequestMapping(value="/getPntTxnItemList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyTransPntItemListResDto> getPntTxnItemList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransPntItemListReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setLoginInfo(this.checkLoginSession(request, response));
        return loyTransSerivce.getPntTxnItemList(param);
    }
	/**
	  * @programId :
	  * @name   : getTransPromoList
	  * @date   : 2018. 07. 20.
	  * @author : mj.kim
	  * @table  : loy.loy_pnt_acrl
	  * 		  loy.loy_pnt_rdm
	  * 		  loy.loy_pnt_txn
	  * @return : GridPagingResDto
	  * @description : 포인트 조회 테스트 정보
	 **/
    @RequestMapping(value="/getTransSearchTestList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<LoyTransSearchTestInfoResDto> getTransSearchTestList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransSearchTestInfoReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setLoginInfo(this.checkLoginSession(request, response));
        return loyTransSerivce.getTransSearchTestList(param);
    }

   
    
  
    //마스킹 해제
    @RequestMapping(value = "clearMaskTrans.do", method = RequestMethod.POST)
    public @ResponseBody LoyTransListResDto clearMaskTrans(
            HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));
        reqDto.setUri(request.getRequestURI());

        return loyTransSerivce.clearMaskTrans(reqDto);    	
    }
    
     /*
      * 1. 메소드명: pointCancelApiRequest
      * 2. 클래스명: LoyTransController
      * 3. 작성자명: Quintet 
      * 4. 작성일자: 2020. 4. 21.
      */
    /**
     * <PRE>
     * 1. 설명
     *		포인트취소API 호출
     * 2. 사용법
     *		
     * </PRE>
     *   @param request
     *   @param response
     *   @param reqDto
     *   @return	
     */
    @RequestMapping(value = "pointCancelApiRequest.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto pointCancelApiRequest(
            HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));
        reqDto.setUri(request.getRequestURI());

        return loyTransSerivce.pointCancelApiRequest(reqDto);
    }
    
    @RequestMapping(value="/gePurTxnHistList.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyPurTxnHistListResDto> gePurTxnHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransListReqDto reqDto){
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
 	       return loyTransSerivce.getMbrTxnHistList(reqDto);
   	}
    
    /*
     * 1. 메소드명: gePurNotMbrTxnHistList
     * 2. 클래스명: LoyTransController
     * 3. 작성자명: 2sh.park 
     * 4. 작성일자: 2020. 02. 09.
     */
   /**
    * <PRE>
    * 1. 설명
    *		비회원 구매
    * 2. 사용법
    *		
    * </PRE>
    *   @param request
    *   @param response
    *   @param reqDto
    *   @return	
    */
    @RequestMapping(value="/getPurNotMbrTxnHistList.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyPurTxnHistListResDto> getPurNotMbrTxnHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransListReqDto reqDto){
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
 	       return loyTransSerivce.getPurNotMbrTxnHistList(reqDto);
   	}
    
    
    @RequestMapping(value="/clearPutTxnMbr.do", method = RequestMethod.POST)
   	public @ResponseBody LoyPurTxnHistListResDto clearPutTxnMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransListReqDto reqDto){
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
 	       return loyTransSerivce.clearPutTxnMbr(reqDto);
   	}
    
    @RequestMapping(value="/getloyCouponList.do", method = RequestMethod.POST)
   	public @ResponseBody GridPagingResDto<LoyTransCpnListResDto> getloyCouponList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransCpnListReqDto reqDto){
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
 	       return loyTransSerivce.getloyCouponList(reqDto);
   	}
    
  
    
    /*
     * 1. 메소드명: gePurNotMbrTxnHistList
     * 2. 클래스명: LoyTransController
     * 3. 작성자명: 2sh.park 
     * 4. 작성일자: 2020. 02. 09.
     */
   /**
    * <PRE>
    * 1. 설명
    *		비회원 구매 엑셀 다운로드
    * 2. 사용법
    *		
    * </PRE>
    *   @param request
    *   @param response
    *   @param reqDto
    *   @return	
    */
    @RequestMapping(value = "/purTxnNotMbrHistExcelList.do", method = RequestMethod.POST)
	public String purTxnNotMbrHistExcelList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransListReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<LoyPurTxnHistListResDto> data = loyTransSerivce.getPurNotMbrTxnHistList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "비회원 구매이력 목록");

		return "ExcelView";
	}
    
    @RequestMapping(value = "/cpnHistListExcel.do", method = RequestMethod.POST)
	public String cpnHistListExcel(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransCpnListReqDto reqDto, ModelMap model) {
		LogUtil.param(LoyCustomerController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		GridPagingResDto<LoyTransCpnListResDto> data = loyTransSerivce.getloyCouponList(reqDto);

		model.addAttribute("result", data);
		model.addAttribute("excelHeader", reqDto.getExcelHeader());
		model.addAttribute("fileName", "쿠폰 목록");

		return "ExcelView";
	}

	 /*
	  * 1. 메소드명: getMonthOfPoint
	  * 2. 클래스명: LoyTransController
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2020. 1. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		트랜잭션 월별 포인트 현황
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return GridPagingResDto
	 */
	@RequestMapping(value = "/getMonthOfPoint.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<KprReportPointOfMonthResDto> getMonthOfPoint(HttpServletRequest request, HttpServletResponse response,
			@RequestBody KprReportPntReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
     reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyTransSerivce.getMonthOfPoint(reqDto);
	}
	
	 @RequestMapping(value="/gePurTxnOptionHistList.do", method = RequestMethod.POST)
	   	public @ResponseBody GridPagingResDto<LoyPurTxnHistListResDto> gePurTxnOptionHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransListReqDto reqDto){
	 	       LogUtil.param(this.getClass(), reqDto);
	 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	 	       return loyTransSerivce.getPurTxnOptionHistList(reqDto);
	   	}
	 
	 @RequestMapping(value = "/purTxnOptionHistExcelList.do", method = RequestMethod.POST)
		public String purTxnOptionHistExcelList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransListReqDto reqDto, ModelMap model) {
			LogUtil.param(SystemLogController.class, reqDto);
			reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
//			HttpSession session = request.getSession(true);
			//프로그램 경로 가져오기
//			String programPath = (String) session.getAttribute("URL_INCLUDE");
//			if("".equals(programPath)) programPath = (String) session.getAttribute("URL");
//			ProgramCache proResDto = null;
//			String ObjCode = reqDto.getObjCode();
//			//MetaData 가져오기
//			commonService.getExcelMetaData(session,programPath,proResDto,ObjCode, model);
	    	
			GridPagingResDto<LoyPurTxnHistListResDto> data = loyTransSerivce.getPurTxnOptionHistList(reqDto);

			model.addAttribute("result", data);
		 	model.addAttribute("excelHeader", reqDto.getExcelHeader());
		 	model.addAttribute("fileName", "구매 이력(품목)");

			return "ExcelView";
		}
	 
	  /*
	  * 1. 메소드명: gePurTxnHistList
	  * 2. 클래스명: LoyTransController
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 상품평 이력
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/geProdRevwHistList.do", method = RequestMethod.POST)
	   	public @ResponseBody GridPagingResDto<LoyProdRevwHistListResDto> geProdRevwTxnHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransListReqDto reqDto){
	 	       LogUtil.param(this.getClass(), reqDto);
	 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	 	       return loyTransSerivce.geProdRevwTxnHistList(reqDto);
	   	}
	
	@RequestMapping(value = "/prodRevwHistExcelList.do", method = RequestMethod.POST)
	public String prodRevwHistExcelList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransListReqDto reqDto, ModelMap model) {
//		LogUtil.param(LoyCustomerController.class, reqDto);
//		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		LogUtil.param(SystemLogController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		HttpSession session = request.getSession(true);
		//프로그램 경로 가져오기
		String programPath = (String) session.getAttribute("URL_INCLUDE");
		if("".equals(programPath)) programPath = (String) session.getAttribute("URL");
		ProgramCache proResDto = null;
		String ObjCode = reqDto.getObjCode();
		//MetaData 가져오기
		commonService.getExcelMetaData(session,programPath,proResDto,ObjCode, model);
    	
		
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(reqDto.getRid());
		if(StringUtil.isNotEmpty(reqDto.getStrWhere())) {
			reqDto.setStrWhere(" AND "+reqDto.getStrWhere());
		} else {
			reqDto.setStrWhere("");
		}
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.PROD_REVW_LIST,reqDto.getStrCondWhere()+reqDto.getStrWhere());
		
		GridPagingResDto<LoyProdRevwHistExcelListResDto> data = loyTransSerivce.prodRevwHistExcelList(reqDto);

		model.addAttribute("result", data);
//		model.addAttribute("excelHeader", reqDto.getExcelHeader());
//		model.addAttribute("fileName", "구매이력 목록");

		return "ExcelView";
	}
	
	@RequestMapping(value="/getProdRevwDetail.do", method = RequestMethod.POST)
   	public @ResponseBody LoyProdRevwHistListResDto getProdRevwDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyTransListReqDto reqDto){
 	       LogUtil.param(this.getClass(), reqDto);
 	       reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
 	       return loyTransSerivce.getProdRevwDetail(reqDto);
   	}
	 
	 
	
    
}