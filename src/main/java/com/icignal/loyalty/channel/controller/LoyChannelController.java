package com.icignal.loyalty.channel.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.cache.dto.response.ProgramCache;
import com.icignal.common.filter.HTMLTagFilterRequestWrapper;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.core.component.Messages;
import com.icignal.loyalty.channel.dto.response.*;
import com.icignal.loyalty.event.dto.request.LOYProdRequestDTO;
import com.icignal.loyalty.survey.controller.LoySurveyController;
import com.icignal.loyalty.survey.dto.request.LoySurveyListReqDto;
import com.icignal.loyalty.survey.dto.response.LoySurvRsltExcelDnResDto;
import com.icignal.systemmanagement.batchrgst.util.BatchRgstExcelFileUtil;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.channel.dto.request.LoyChnlAddInfoDetailResDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlAddInfoReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlChangeHistListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlDetailReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlLoyProgramReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlMasterReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlMbrRelListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlNewDetailReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlPointChangeHistListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlSearchHelpListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlSettleMasterReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlSettleReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlSubTxnHistListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlTxnHistListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyProgramListReqDto;
import com.icignal.loyalty.channel.service.LoyChannelService;
import com.icignal.marketing.plan.dto.request.MktPlanListReqDto;
import com.icignal.marketing.plan.dto.response.MktPlanListResDto;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/*
 * 1. 클래스명	: LoyChannelController
 * 2. 파일명	: LoyChannelController.java
 * 3. 패키지명	: com.icignal.loyalty.channel.controller
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 2. 19.
 */
/**
 * <PRE>
 * 1. 설명
 *		기준정보 - 채널 controller
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/channel")
public class LoyChannelController extends BaseController {
	
	@Autowired
	private LoyChannelService loyChannelService;
	
	@Autowired
	AuthHelper authHelper;

	@Autowired
	CommonService commonService;

	@Autowired
	LoggingHelper loggingHelper;

	/*
	 * 1. 메소드명: getChannelList 
	 * 2. 클래스명: LoyChannelController 
	 * 3. 작성자명:  
	 * 4. 작성일자: 2020. 2. 19.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param param
	 * @return
	 */
//	@RequestMapping(value = "/getChannelList.do", method = RequestMethod.POST)
//	public @ResponseBody GridPagingResDto<LoyChnlListResDto> getChannelList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlListReqDto param) {
//		LogUtil.param(this.getClass(), param);
//		param.setLoginInfo(authHelper.checkLoginSession(request, response));
//
//		return  loyChannelService.getChannelList(param);
//	}

	 /*
	  * 1. 메소드명: getChannelSearchHelp
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 이성원 
	  * 4. 작성일자: 2017. 10. 17.
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
	@RequestMapping(value = "/getChannelSearchHelp.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlSearchHelpListReqDto> getChannelSearchHelp(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlSearchHelpListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChannelSearchHelp(param);
	}

	 /*
	  * 1. 메소드명: ChnlExecDown
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 2. 26.
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
	 *   @param model
	 *   @return	
	 */
//	@RequestMapping(value = "/ChnlExecDown.do", method = RequestMethod.POST)
//	public String ChnlExecDown(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlListReqDto reqDto, ModelMap model) {
//		LogUtil.param(LoyChannelController.class, reqDto);
//		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
//		
//		GridPagingResDto<LoyChnlListResDto> data = loyChannelService.getChannelList(reqDto);
//
//		model.addAttribute("result", data);
//		model.addAttribute("excelHeader", reqDto.getExcelHeader());
//		model.addAttribute("fileName", "채널 리스트");
//
//		return "ExcelView";
//	}

	 /*
	  * 1. 메소드명: getChannelDetail
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 이성원
	  * 4. 작성일자: 2017. 10. 17.
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
	@RequestMapping(value = "/getChannelDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyChnlDetailResDto getChannelDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlDetailResDto param) {
		LogUtil.param(this.getClass(), param);

		return loyChannelService.getChannelDetail(param);
	}

	 /*
	  * 1. 메소드명: getChnlTxnMemList
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 이성원
	  * 4. 작성일자: 2017. 10. 17.
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
	@RequestMapping(value = "/getChnlTxnMemList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlDetailReqDto> getChnlTxnMemList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlTxnMemList(param);
	}

	 /*
	  * 1. 메소드명: getChnlSubList
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 이성원
	  * 4. 작성일자: 2017. 10. 17.
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
	@RequestMapping(value = "/getChnlSubList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlDetailReqDto> getChnlSubList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlSubList(param);
	}

	 /*
	  * 1. 메소드명: getChnlAcrlInfoList
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 이성원
	  * 4. 작성일자: 2017. 10. 17.
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
	@RequestMapping(value = "/getChnlAcrlInfoList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlDetailReqDto> getChnlAcrlInfoList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyChannelService.getChnlAcrlInfoList(param);
	}

	 /*
	  * 1. 메소드명: getChnlRdmInfoList
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 이성원 
	  * 4. 작성일자: 2017. 10. 17.
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
	@RequestMapping(value = "/getChnlRdmInfoList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlDetailReqDto> getChnlRdmInfoList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlRdmInfoList(param);
	}

	 /*
	  * 1. 메소드명: getChnlStlInfoList
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 이성원
	  * 4. 작성일자: 2017. 10. 17.
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
	@RequestMapping(value = "/getChnlStlInfoList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlDetailReqDto> getChnlStlInfoList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlStlInfoList(param);
	}

	 /*
	  * 1. 메소드명: getChnlAddInfo
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 이성원 
	  * 4. 작성일자: 2017. 10. 17.
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
	@RequestMapping(value = "/getChnlAddInfo.do", method = RequestMethod.POST)
	public @ResponseBody LoyChnlAddInfoResDto getChnlAddInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlAddInfo(param);
	}

	 /*
	  * 1. 메소드명: editChnlAddInfo
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 이성원 
	  * 4. 작성일자: 2017. 10. 27.
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
	@RequestMapping(value = "/editChnlAddInfo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editChnlAddInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlAddInfoReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.editChnlAddInfo(param);
	}

	 /*
	  * 1. 메소드명: getChnlChangeHistList
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 이성원
	  * 4. 작성일자: 2017. 10. 31.
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
	@RequestMapping(value = "/getChnlChangeHistList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlChangeHistListReqDto> getChnlChangeHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlChangeHistListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlChangeHistList(param);
	}

	 /*
	  * 1. 메소드명: getChnlPointChangeHistList
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 이성원
	  * 4. 작성일자: 2017. 10. 31.
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
	@RequestMapping(value = "/getChnlPointChangeHistList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlPointChangeHistListReqDto> getChnlPointChangeHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlPointChangeHistListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlPointChangeHistList(param);
	}

	/*
	 * 1. 메소드명: getChnlTxnHistList 
	 * 2. 클래스명: LoyChannelController 
	 * 3. 작성자명: 
	 * 4. 작성일자: 2020. 2. 20.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/getChnlTxnHistList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlTxnHistListReqDto> getChnlTxnHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlTxnHistListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlTxnHistList(param);
	}

	 /*
	  * 1. 메소드명: getChnlSubTxnHistList
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 이성원
	  * 4. 작성일자: 2017. 11. 2.
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
	@RequestMapping(value = "/getChnlSubTxnHistList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlSubTxnHistListReqDto> getChnlSubTxnHistList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlSubTxnHistListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlSubTxnHistList(param);
	}

	 /*
	  * 1. 메소드명: saveChannelDetail
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: hy.jun 
	  * 4. 작성일자: 2018. 10. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		채널상세 신규등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/saveChannelDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveChannelDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlMasterReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.saveChannelDetail(param);
	}

	 /*
	  * 1. 메소드명: editChannelDetail
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: hy.jun
	  * 4. 작성일자: 2018. 10. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		채널상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/editChannelDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editChannelDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlMasterReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.editChannelDetail(param);
	}

	 /*
	  * 1. 메소드명: removeChannel
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: hy.jun
	  * 4. 작성일자: 2018. 10. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		채널 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/removeChannel.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeChannel(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlMasterReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.removeChannel(param);
	}

	 /*
	  * 1. 메소드명: getChannelDefaultInfo
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: hy.jun
	  * 4. 작성일자: 2018. 10. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		채널상세 상단 기본정보 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getChannelDefaultInfo.do", method = RequestMethod.POST)
	public @ResponseBody LoyChnlDefaultInfoResDto getChannelDefaultInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlMasterReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyChannelService.getChannelDefaultInfo(param);
	}
	
	
    /**
	* @programId :
	* @name : getStoreCd
	* @date : 2019. 9. 6.
	* @author : seony.lee
	* @table :
	* @return :
	* @description : 스토어코드 생성
	*/
    @RequestMapping(value="/getStoreCd.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto getStoreCd(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlMasterReqDto reqDTO) {
    	reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
    	
    	return loyChannelService.getStoreCd(reqDTO);
    }

	 /*
	  * 1. 메소드명: setChnlMbr
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: seony.lee 
	  * 4. 작성일자: 2019. 9. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		채널에 관련회원 추가
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/setChnlMbr.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setChnlMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlMasterReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);

		return loyChannelService.setChnlMbr(reqDTO);
	}

	 /*
	  * 1. 메소드명: deleteChnlMbr
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: seony.lee
	  * 4. 작성일자: 2019. 10. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		채널에 관련회원 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDTO
	 *   @return	
	 */
	@RequestMapping(value = "/removeChnlMbr.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteChnlMbr(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlMasterReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);

		return loyChannelService.removeChnlMbr(reqDTO);
	}
	
	 /*
	  * 1. 메소드명: getChnlListPage
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 18.
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
	@RequestMapping(value = "/getChnlListPage.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChannelListPageResDto> getChnlListPage(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlSubTxnHistListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlListPage(param);
	}
	
	 /*
	  * 1. 메소드명: saveChnlDetail
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 19.
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
	@RequestMapping(value = "/saveChnlDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveChnlDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlNewDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.saveChnlDetail(param);
	}
	
	 /*
	  * 1. 메소드명: getParentChnlTList
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 19.
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
	@RequestMapping(value = "/getParentChnlTList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChannelListPageResDto> getParentChnlTList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getParentChnlTList(param);
	}
	
	 /*
	  * 1. 메소드명: getChnlDetailNew
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 19.
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
	@RequestMapping(value = "/getChnlDetailNew.do", method = RequestMethod.POST)
	public @ResponseBody LoyChnlDetailNewResDto getChnlDetailNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlNewDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlDetailNew(param);
	}
	
	 /*
	  * 1. 메소드명: modifyChnlDetail
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 19.
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
	@RequestMapping(value = "/modifyChnlDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyChnlDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlNewDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.modifyChnlDetail(param);
	}
	
	 /*
	  * 1. 메소드명: getChnlAddInfoDetailNew
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 19.
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
	@RequestMapping(value = "/getChnlAddInfoDetailNew.do", method = RequestMethod.POST)
	public @ResponseBody LoyChnlAddInfoDetailNewResDto getChnlAddInfoDetailNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlNewDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlAddInfoDetailNew(param);
	}
	
	 /*
	  * 1. 메소드명: saveChnlAddInfoDetail
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 21.
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
	@RequestMapping(value = "/saveChnlAddInfoDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveChnlAddInfoDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlAddInfoDetailResDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.saveChnlAddInfoDetail(param);
	}
	
	 /*
	  * 1. 메소드명: modifyChnlAddInfoDetail
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 21.
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
	@RequestMapping(value = "/modifyChnlAddInfoDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyChnlAddInfoDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlAddInfoDetailResDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.modifyChnlAddInfoDetail(param);
	}
	
	 /*
	  * 1. 메소드명: getChnlLoyPgmList
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 21.
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
	@RequestMapping(value = "/getChnlLoyPgmList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlLoyPgmListResDto> getChnlLoyPgmList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlLoyPgmList(param);
	}
	
	 /*
	  * 1. 메소드명: getLoyPgmListNew
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 21.
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
	@RequestMapping(value = "/getLoyPgmListNew.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyProgramListResDto> getLoyPgmListNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProgramListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getLoyPgmListNew(param);
	}
	
	 /*
	  * 1. 메소드명: saveChnlLoyPgm
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 21.
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
	@RequestMapping(value = "/saveChnlLoyPgm.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveChnlLoyPgm(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlLoyProgramReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.saveChnlLoyPgm(param);
	}
	
	 /*
	  * 1. 메소드명: modifyChnlLoyPgm
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 21.
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
	@RequestMapping(value = "/modifyChnlLoyPgm.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyChnlLoyPgm(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlLoyProgramReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.modifyChnlLoyPgm(param);
	}
	
	 /*
	  * 1. 메소드명: getLoyPgmDetailNew
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 21.
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
	@RequestMapping(value = "/getLoyPgmDetailNew.do", method = RequestMethod.POST)
	public @ResponseBody LoyChnlPgmDetailResDto getLoyPgmDetailNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlLoyProgramReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getLoyPgmDetailNew(param);
	}
	
	 /*
	  * 1. 메소드명: getChnlMbrRelList
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 21.
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
	@RequestMapping(value = "/getChnlMbrRelList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlMbrRelResDto> getChnlMbrRelList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlMbrRelListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlMbrRelList(param);
	}
	
	 /*
	  * 1. 메소드명: getChnlMbrRelList
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 21.
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
	@RequestMapping(value = "/getChnlSettleList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlSettleListResDto> getChnlSettleList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlSettleMasterReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlSettleList(param);
	}
	
	 /*
	  * 1. 메소드명: getChnlLoyPgmListNew
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 27.
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
	@RequestMapping(value = "/getChnlLoyPgmListNew.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlLoyPgmListResDto> getChnlLoyPgmListNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProgramListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlLoyPgmListNew(param);
	}
	
	 /*
	  * 1. 메소드명: saveChnlSettle
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 27.
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
	@RequestMapping(value = "/saveChnlSettle.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveChnlSettle(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlSettleReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.saveChnlSettle(param);
	}
	
	 /*
	  * 1. 메소드명: modifyChnlSettle
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 27.
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
	@RequestMapping(value = "/modifyChnlSettle.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto modifyChnlSettle(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlSettleReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.modifyChnlSettle(param);
	}
	
	 /*
	  * 1. 메소드명: getLoyChnlPgmDetailNew
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 27.
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
	@RequestMapping(value = "/getLoyChnlPgmDetailNew.do", method = RequestMethod.POST)
	public @ResponseBody LoyChnlSettleResDto getLoyChnlPgmDetailNew(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlLoyProgramReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getLoyChnlPgmDetailNew(param);
	}
	
	 /*
	  * 1. 메소드명: getChnlLoyPgmHist
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 27.
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
	@RequestMapping(value = "/getChnlLoyPgmHist.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlLoyPgmListResDto> getChnlLoyPgmHist(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProgramListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlLoyPgmHist(param);
	}
	
	 /*
	  * 1. 메소드명: getChnlSettleHist
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 27.
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
	@RequestMapping(value = "/getChnlSettleHist.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlSettleListResDto> getChnlSettleHist(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlSettleMasterReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlSettleHist(param);
	}
	
	 /*
	  * 1. 메소드명: removeChnlChannel
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 27.
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
	@RequestMapping(value = "/removeChnlChannel.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeChnlChannel(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.removeChnlChannel(param);
	}
	
	 /*
	  * 1. 메소드명: removeChnlLoyPgm
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 27.
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
	@RequestMapping(value = "/removeChnlLoyPgm.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeChnlLoyPgm(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.removeChnlLoyPgm(param);
	}
	
	 /*
	  * 1. 메소드명: removeChnlSettle
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 27.
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
	@RequestMapping(value = "/removeChnlSettle.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeChnlSettle(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.removeChnlSettle(param);
	}

	 /*
	  * 1. 메소드명: getChnlLoyPgmList
	  * 2. 클래스명: LoyChannelController
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 21.
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
	@RequestMapping(value = "/getChnlLoyImgInfoList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlLoyPgmListResDto> getChnlLoyImgInfoList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getChnlLoyImgInfoList(param);
	}
	//getLoyImgDesc
	@RequestMapping(value = "/getLoyImgDesc.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChnlLoyPgmListResDto> getLoyImgDesc(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getLoyImgDesc(param);
	}
	//
	@RequestMapping(value = "/getLoyImgDel.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto getLoyImgDel(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.getLoyImgDel(param);
	}
	//
	@RequestMapping(value = "/addChnlImgInfo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addChnlImgInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.addChnlImgInfo(param);
	}
	
	@RequestMapping(value = "/saveImgDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveImgDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyChannelService.saveImgDetail(param);
	}

	/*
	 * 1. 메소드명: excelDownChannel
	 * 2. 클래스명: LoyChannelController
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 05. 10.
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
	 *   @return String
	 */
	@RequestMapping(value = "/excelDownChannel.do", method = RequestMethod.POST)
	public 	String excelDownChannel(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyChnlReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		HttpSession session = request.getSession(true);

		//프로그램 경로 가져오기
		String programPath = (String) session.getAttribute("URL_INCLUDE");
		if("".equals(programPath)) programPath = (String) session.getAttribute("URL");
		ProgramCache proResDto = null;
		String ObjCode = reqDto.getObjCode();

		//MetaData 가져오기
		commonService.getExcelMetaData(session,programPath,proResDto,ObjCode, model);

		//데이터 가져오기
		GridPagingResDto<LoyChnlExcelDnDto> data = loyChannelService.getChnlListExcelDown(reqDto);

		model.addAttribute("result", data);
		//model.addAttribute("excelHeader", reqDto.getExcelHeader());
		//model.addAttribute("fileName", "채널 리스트");

		//엑셀 로그
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(reqDto.getRid());
		//ExcelDownloadLogReqDto edlr, EXCEL_DOWNLOAD_TYPE excelDownlType
		loggingHelper.addExcelDownloadLog(request, edlr, CommonUtil.EXCEL_DOWNLOAD_TYPE.CHANNEL_LIST);

		return "ExcelView";
	}

	@RequestMapping(value = "/setChnlMultiUpload.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity setChnlMultiUpload(MultipartHttpServletRequest request, ModelMap param, HttpServletResponse response) throws IOException {
		LogUtil.param(this.getClass(), param);
		BatchRgstExcelFileUtil excelUpld = new BatchRgstExcelFileUtil(); // 엑셀파일유틸 객체
		List<LoyChnlReqDto> batchUpload = new ArrayList<LoyChnlReqDto>(); // 결과물 담을 리스트객체 batchUpload
		StatusResDto rtnValue = new StatusResDto(); // 상태응답Dto객쳬
		LoginResDto loginInfo = this.checkLoginSession(request, response); // 로그인정보를 얻어낸다(create_by, modify_by를 위한)
		LoyChnlReqDto reqDto = new LoyChnlReqDto(); // RequestDto의 객체를 생성
		// request 객체
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;

		String[] rs = mptRequest.getParameterValues("param");
		String ns = new String(rs[0].getBytes("iso-8859-1"), "utf-8");
		ns = HTMLTagFilterRequestWrapper.decodeXSS(ns);
		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
		JSONObject obj = (JSONObject) json.get("data");

		// 랜덤하게 rid값을 생성
		String rid = CommonUtil.newRid();

		try {
			batchUpload = excelUpld.excelUploadChnlList(request, false, rid);
		} catch (Exception e) {
			LogUtil.error(e);
		}
		// 업로드한 자료의 유효성 검사(크기/양식 등)
		if (batchUpload.size() > 0) { // 크기가 0 인지
			if (batchUpload.get(0).getUploadValidCheck() != null) { // 유효성검사메소드 통과 여부
				if (batchUpload.get(0).getUploadValidCheck().equals("EXT")) { // 파일형식이 맞지 않은 경우
					rtnValue.setSuccess(false);
					rtnValue.setMessage("Excel File (xlsx, xls)만 가능 합니다.");
				} else if (batchUpload.get(0).getUploadValidCheck().equals("SIZE")) { // size가 범위를 초과한 경우
					rtnValue.setSuccess(false);
					rtnValue.setMessage("파일 용량은 12메가를 초과할 수 없습니다.");
				} else if (batchUpload.get(0).getUploadValidCheck().equals("NOTUPLD")) { // 업로드할 데이터가 없는 경우
					rtnValue.setSuccess(false);
					rtnValue.setMessage("업로드 할 데이터가 없습니다.");
				}
			} else { // 유효성 검사를 무사히 통과한 경우
				int idx = 1;
				int size = batchUpload.size();
				reqDto.setRid(rid);
				reqDto.setLoginInfo(loginInfo);
				List<LoyChnlReqDto> arr = new ArrayList<>();

				for (LoyChnlReqDto memId : batchUpload) {
					arr.add(memId);
					//1000단위로 나누어 실행 또는 마지막
					if (idx % 699 == 0 || idx == size) {
						//업데이트
						reqDto.setArray(arr);
						rtnValue = loyChannelService.updateChnlList(reqDto);
						//초기화
						arr = new ArrayList<>();
					}
					idx++;
				}


			}
		} else { // 업로드 유형과 파일양식이 불일치하는 경우
			rtnValue.setSuccess(false);
			rtnValue.setMessage(Messages.getMessage("L01685", loginInfo.getLang()));
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("data", rtnValue);
		String jsonData = "";

		try {
			jsonData = new ObjectMapper().writeValueAsString(map);
		} catch (JsonProcessingException e) {
			LogUtil.error(e);
		}

		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/plain; charset=utf-8");

		return new ResponseEntity(jsonData, responseHeaders, HttpStatus.CREATED);
	}

}
