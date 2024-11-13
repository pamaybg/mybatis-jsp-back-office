package com.icignal.marketing.executionStatus.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.marketing.executionStatus.dto.request.MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonReqDto;
import com.icignal.marketing.executionStatus.dto.request.MktexecutionStatusSelectCampaignDetailForExecResultOfListReqDto;
import com.icignal.marketing.executionStatus.dto.request.MktexecutionStatusSelectCampaignListForExecResultOfListReqDto;
import com.icignal.marketing.executionStatus.dto.request.MktexecutionStatusSelectCampaignListForExecResultReqDto;
import com.icignal.marketing.executionStatus.dto.response.MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonResDto;
import com.icignal.marketing.executionStatus.dto.response.MktexecutionStatusSelectCampaignDetailForExecResultOfListResDto;
import com.icignal.marketing.executionStatus.dto.response.MktexecutionStatusSelectCampaignListForExecResultOfListResDto;
import com.icignal.marketing.executionStatus.dto.response.MktexecutionStatusSelectCampaignListForExecResultResDto;
import com.icignal.marketing.executionStatus.service.MktexecutionStatusService;

@Controller
@RequestMapping("/marketing/executionStatus")
public class MktexecutionStatusController extends BaseController {
	@Autowired
	private MktexecutionStatusService MktexecutionStatusService;
	@Autowired
    private LoggingHelper loggingHelper;

	//캠페인 목록 그리드 조회
    @RequestMapping(value="/getCampaignListForExecResult.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MktexecutionStatusSelectCampaignListForExecResultResDto> getCampaignListForExecResult(HttpServletRequest request, HttpServletResponse response, @RequestBody MktexecutionStatusSelectCampaignListForExecResultReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        param.setStrAuthDataIn(this.getSessionAuthority(request));

        return MktexecutionStatusService.selectCampaignListForExecResult(param);
    }
	//캠페인 특정 목록 그리드 조회
    @RequestMapping(value="/getCampaignListForExecResultOfList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MktexecutionStatusSelectCampaignListForExecResultOfListResDto> getCampaignListForExecResultOfList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktexecutionStatusSelectCampaignListForExecResultOfListReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        param.setStrAuthDataIn(this.getSessionAuthority(request));

        return MktexecutionStatusService.selectCampaignListForExecResultOfList(param);
    }
	//캠페인 상세 특정 목록 그리드 조회
    @RequestMapping(value="/getCampaignDetailForExecResultOfList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MktexecutionStatusSelectCampaignDetailForExecResultOfListResDto> getCampaignDetailForExecResultOfList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktexecutionStatusSelectCampaignDetailForExecResultOfListReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        param.setStrAuthDataIn(this.getSessionAuthority(request));

        return MktexecutionStatusService.selectCampaignDetailForExecResultOfList(param);
    }
    //캠페인 상세 특정 목록 엑셀 다운로드
  	@RequestMapping(value = "/getCampaignDetailForExecResultOfListDown.do", method = RequestMethod.POST)
  	public  
  	String ChnlExecDown(HttpServletRequest request, HttpServletResponse response, @RequestBody MktexecutionStatusSelectCampaignDetailForExecResultOfListReqDto param, ModelMap model) {
  		
  		LogUtil.param(this.getClass(), param);
  		param.setLoginInfo(this.checkLoginSession(request, response));
  		
		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(param.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.TGT_IMPORT_TGT);
  		
  		GridPagingResDto<MktexecutionStatusSelectCampaignDetailForExecResultOfListResDto> data = MktexecutionStatusService.selectCampaignDetailForExecResultOfList(param);

  		model.addAttribute("result", data);
  		model.addAttribute("excelHeader", param.getExcelHeader());
  		model.addAttribute("fileName", "Campaign_List");

  		return "ExcelView";
  	}
	//MKT.MKT_TGT_DTL_RMV 채널 실패 사유 조회
    @RequestMapping(value="/getExecutionStatusErrorList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonResDto> getExecutionStatusErrorList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktexecutionStatusSelectCampaignDetailForExecResultErrorReasonReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        param.setStrAuthDataIn(this.getSessionAuthority(request));

        return MktexecutionStatusService.selectCampaignDetailForExecResultErrorReason(param);
    }
    //캠페인 PUSH 상세 목록 그리드 조회
    @RequestMapping(value="/getPushCampaignDetailForExecResultOfList.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MktexecutionStatusSelectCampaignDetailForExecResultOfListResDto> getPushCampaignDetailForExecResultOfList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktexecutionStatusSelectCampaignDetailForExecResultOfListReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        param.setStrAuthDataIn(this.getSessionAuthority(request));

        return MktexecutionStatusService.selectPushCampaignDetailForExecResultOfList(param);
    }
    //캠페인 상세 특정 목록 엑셀 다운로드
  	@RequestMapping(value = "/getPushCampaignDetailForExecResultOfListDown.do", method = RequestMethod.POST)
  	public  
  	String ChnlPushExecDown(HttpServletRequest request, HttpServletResponse response, @RequestBody MktexecutionStatusSelectCampaignDetailForExecResultOfListReqDto param, ModelMap model) {
  		
  		LogUtil.param(this.getClass(), param);
  		param.setLoginInfo(this.checkLoginSession(request, response));
  		
		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(param.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.TGT_IMPORT_TGT);
  		
  		GridPagingResDto<MktexecutionStatusSelectCampaignDetailForExecResultOfListResDto> data = MktexecutionStatusService.selectPushCampaignDetailForExecResultOfList(param);

  		model.addAttribute("result", data);
  		model.addAttribute("excelHeader", param.getExcelHeader());
  		model.addAttribute("fileName", "Campaign_List");

  		return "ExcelView";
  	}
    //캠페인 상세 특정 목록 엑셀 다운로드
  	@RequestMapping(value = "/downCampaignListStatus.do", method = RequestMethod.POST)
  	public  
  	String downCampaignListStatus(HttpServletRequest request, HttpServletResponse response, @RequestBody MktexecutionStatusSelectCampaignListForExecResultOfListReqDto param, ModelMap model) {
  		
  		LogUtil.param(this.getClass(), param);
  		param.setLoginInfo(this.checkLoginSession(request, response));
  		
		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(param.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.TGT_IMPORT_TGT);
  		
  		GridPagingResDto<MktexecutionStatusSelectCampaignListForExecResultOfListResDto> data = MktexecutionStatusService.selectCampaignListForExecResultOfList(param);

  		model.addAttribute("result", data);
  		model.addAttribute("excelHeader", param.getExcelHeader());
  		model.addAttribute("fileName", "캠페인 실행 결과");

  		return "ExcelView";
  	}

	//캠페인 구매반응정보 조회
	@RequestMapping(value="/selectPurReaction.do", method = RequestMethod.POST)
	public @ResponseBody
	GridPagingResDto<MktexecutionStatusSelectCampaignListForExecResultResDto> selectPurReaction(HttpServletRequest request, HttpServletResponse response, @RequestBody MktexecutionStatusSelectCampaignListForExecResultReqDto param) {
		LogUtil.param(this.getClass(), param);

		LoginResDto loginInfo = this.checkLoginSession(request, response);

		return MktexecutionStatusService.selectPurReaction(param);
	}

}
