package com.icignal.loyalty.survey.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.icignal.loyalty.survey.dto.response.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.cache.dto.response.ProgramCache;
import com.icignal.common.excel.vo.ExcelDownloadDto;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.survey.dto.request.LoySurveyDetailReqDto;
import com.icignal.loyalty.survey.dto.request.LoySurveyListReqDto;
import com.icignal.loyalty.survey.service.LoySurveyService;

/*
 * 1. 클래스명	: LoySurveyController
 * 2. 파일명	: LoySurveyController.java
 * 3. 패키지명	: com.icignal.loyalty.survey.controller
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 23.
 */

/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/survey")
public class LoySurveyController extends BaseController {

    final static private Logger log = LoggerFactory.getLogger(LoySurveyController.class);

    final private LoySurveyService loySurveyService;
    final private AuthHelper authHelper;
    final private LoggingHelper loggingHelper;
    final private CommonService commonService;

    public LoySurveyController(LoySurveyService loySurveyService, AuthHelper authHelper, CommonService commonService, LoggingHelper loggingHelper) {
        this.loySurveyService = loySurveyService;
        this.authHelper = authHelper;
        this.loggingHelper = loggingHelper;
        this.commonService = commonService;
    }

    /*
     * 1. 메소드명: getSurveyList
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/getSurveyList.do")
    @ResponseBody
    public GridPagingResDto<LoySurveyListResDto> getSurveyList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveyList(reqDto);
    }

    /*
     * 1. 메소드명: getSurveyDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/getSurveyDetail.do")
    @ResponseBody
    public LoySurveyDetailResDto getSurveyDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveyDetail(reqDto);
    }

    /*
     * 1. 메소드명: addSurveyDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/addSurveyDetail.do")
    @ResponseBody
    public LoySurveyResDto addSurveyDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.addSurveyDetail(reqDto);
    }

    /*
     * 1. 메소드명: modifySurveyDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/modifySurveyDetail.do")
    @ResponseBody
    public LoySurveyResDto modifySurveyDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.modifySurveyDetail(reqDto);
    }

    /*
     * 1. 메소드명: deleteSurveyDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/removeSurveyDetail.do")
    @ResponseBody
    public StatusResDto removeSurveyDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.removeSurveyDetail(reqDto);
    }

    /*
     * 1. 메소드명: getSurveySectionList
     * 2. 클래스명: LoySurveySectionController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/getSurveySectionList.do")
    @ResponseBody
    public GridPagingResDto<LoySurveySectionListResDto> getSurveySectionList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveySectionList(reqDto);
    }

    /*
     * 1. 메소드명: getSurveySectionDetail
     * 2. 클래스명: LoySurveySectionController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/getSurveySectionDetail.do")
    @ResponseBody
    public LoySurveySectionListResDto getSurveySectionDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveySectionDetail(reqDto);
    }

    /*
     * 1. 메소드명: addSurveySectionDetail
     * 2. 클래스명: LoySurveySectionController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/addSurveySectionDetail.do")
    @ResponseBody
    public StatusResDto addSurveySectionDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.addSurveySectionDetail(reqDto);
    }

    /*
     * 1. 메소드명: modifySurveySectionDetail
     * 2. 클래스명: LoySurveySectionController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/modifySurveySectionDetail.do")
    @ResponseBody
    public StatusResDto modifySurveySectionDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.modifySurveySectionDetail(reqDto);
    }

    /*
     * 1. 메소드명: deleteSurveySectionDetail
     * 2. 클래스명: LoySurveySectionController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/removeSurveySectionDetail.do")
    @ResponseBody
    public StatusResDto removeSurveySectionDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.removeSurveySectionDetail(reqDto);
    }

    /*
     * 1. 메소드명: getSurveyItemList
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/getSurveyItemList.do")
    @ResponseBody
    public GridPagingResDto<LoySurveyItemListResDto> getSurveyItemList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveyItemList(reqDto);
    }

    /*
     * 1. 메소드명: getSurveyItemDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/getSurveyItemDetail.do")
    @ResponseBody
    public LoySurveyItemListResDto getSurveyItemDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveyItemDetail(reqDto);
    }

    /*
     * 1. 메소드명: addSurveyItemDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/addSurveyItemDetail.do")
    @ResponseBody
    public StatusResDto addSurveyItemDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.addSurveyItemDetail(reqDto);
    }

    /*
     * 1. 메소드명: modifySurveyItemDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/modifySurveyItemDetail.do")
    @ResponseBody
    public StatusResDto modifySurveyItemDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.modifySurveyItemDetail(reqDto);
    }

    /*
     * 1. 메소드명: removeSurveyItemDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 1.
     */
    @PostMapping(value = "/removeSurveyItemDetail.do")
    @ResponseBody
    public StatusResDto removeSurveyItemDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.removeSurveyItemDetail(reqDto);
    }

    /*
     * 1. 메소드명: getSurveyItemAttrList
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @PostMapping(value = "/getSurveyItemAttrList.do")
    @ResponseBody
    public GridPagingResDto<LoySurveyItemAttrListResDto> getSurveyItemAttrList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveyItemAttrList(reqDto);
    }

    /*
     * 1. 메소드명: getSurveyItemAttrDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @PostMapping(value = "/getSurveyItemAttrDetail.do")
    @ResponseBody
    public LoySurveyItemAttrListResDto getSurveyItemAttrDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveyItemAttrDetail(reqDto);
    }

    /*
     * 1. 메소드명: addSurveyItemAttrDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @PostMapping(value = "/addSurveyItemAttrDetail.do")
    @ResponseBody
    public StatusResDto addSurveyItemAttrDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.addSurveyItemAttrDetail(reqDto);
    }

    /*
     * 1. 메소드명: modifySurveyItemAttrDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @PostMapping(value = "/modifySurveyItemAttrDetail.do")
    @ResponseBody
    public StatusResDto modifySurveyItemAttrDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.modifySurveyItemAttrDetail(reqDto);
    }

    /*
     * 1. 메소드명: removeSurveyItemAttrDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @PostMapping(value = "/removeSurveyItemAttrDetail.do")
    @ResponseBody
    public StatusResDto removeSurveyItemAttrDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.removeSurveyItemAttrDetail(reqDto);
    }

    /*
     * 1. 메소드명: getSurveyMemberList
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @PostMapping(value = "/getSurveyMemberList.do")
    @ResponseBody
    public GridPagingResDto<LoySurveyMemberListResDto> getSurveyMemberList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveyMemberList(reqDto);
    }

    /*
     * 1. 메소드명: clearSurveyMemberMaskingDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @PostMapping(value = "/clearSurveyMemberMaskingDetail.do")
    @ResponseBody
    public LoySurveyMemberListResDto clearSurveyMemberMaskingDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.authHelper.checkLoginSession(request, response));

        return this.loySurveyService.clearSurveyMemberMaskingDetail(reqDto);
    }

    /*
     * 1. 메소드명: getSurveyOfferList
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @PostMapping(value = "/getSurveyOfferList.do")
    @ResponseBody
    public GridPagingResDto<LoySurveyOfferListResDto> getSurveyOfferList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveyOfferList(reqDto);
    }

    /*
     * 1. 메소드명: getSurveyOfferDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @PostMapping(value = "/getSurveyOfferDetail.do")
    @ResponseBody
    public LoySurveyOfferListResDto getSurveyOfferDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveyOfferDetail(reqDto);
    }

    /*
     * 1. 메소드명: addSurveyOfferDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @PostMapping(value = "/addSurveyOfferDetail.do")
    @ResponseBody
    public StatusResDto addSurveyOfferDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.addSurveyOfferDetail(reqDto);
    }

    /*
     * 1. 메소드명: modifySurveyOfferDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @PostMapping(value = "/modifySurveyOfferDetail.do")
    @ResponseBody
    public StatusResDto modifySurveyOfferDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.modifySurveyOfferDetail(reqDto);
    }

    /*
     * 1. 메소드명: removeSurveyOfferDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @PostMapping(value = "/removeSurveyOfferDetail.do")
    @ResponseBody
    public StatusResDto removeSurveyOfferDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);
        LoginResDto loginInfo = this.authHelper.checkLoginSession(request, response);
        reqDto.setEmpId(loginInfo.getId());

        return this.loySurveyService.removeSurveyOfferDetail(reqDto);
    }

    @PostMapping(value = "/getSurveyResultSummary.do")
    @ResponseBody
    public LoySurveyResultSummaryResDto getSurveyResultSummary(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveyResultSummary(reqDto);
    }

    /*
     * 1. 메소드명: getSurveyResultList
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2020. 7. 2.
     */
    @PostMapping(value = "/getSurveyResultList.do")
    @ResponseBody
    public GridPagingResDto<LoySurveyResultListResDto> getSurveyResultList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);

        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveyResultList(reqDto);
    }

    /*
     * 1. 메소드명: getSurveyResultList
     * 2. 클래스명: getSurveyResultList
     * 3. 작성자명: sj.jung
     * 4. 작성일자: 2022. 3. 14.
     */
    @PostMapping(value = "/selectSurveyResultDtlList.do")
    @ResponseBody
    public GridPagingResDto<LoySurveyResultListResDto> selectSurveyResultDtlList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);

        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.selectSurveyResultDtlList(reqDto);
    }

    @PostMapping(value = "/downloadSurveyResultSummary.do")
    @ResponseBody
    public ExcelDownloadDto downloadSurveyResultSummary(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);

        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.downloadSurveyResultSummary(reqDto);
    }

    /*
     * 1. 메소드명: downloadSurveyResultDetail
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명:
     * 4. 작성일자:
     * 5. 변경일자: hr.noh - 2022. 2. 22.
     */
    //ExcelDownloadDto -> String
    @RequestMapping(value = "/downloadSurveyResultDetail.do", method = RequestMethod.POST)
    public String downloadSurveyResultDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto,ModelMap model) {
//        log.debug("{}", reqDto);
//        reqDto.setLoginInfo(this.checkLoginSession(request, response));
//        return this.loySurveyService.downloadSurveyResultDetail(reqDto);
        LogUtil.param(LoySurveyController.class, reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        HttpSession session = request.getSession(true);
        //프로그램 경로 가져오기
        String programPath = (String) session.getAttribute("URL_INCLUDE");
        if("".equals(programPath)) programPath = (String) session.getAttribute("URL");
        ProgramCache proResDto = null;
        String ObjCode = reqDto.getObjCode();
        //MetaData 가져오기
        commonService.getExcelMetaData(session,programPath,proResDto,ObjCode, model);

        //데이터 가져오기
        GridPagingResDto<LoySurvRsltExcelDnResDto> data = this.loySurveyService.downloadSurveyResultDetail(reqDto);

        model.addAttribute("result", data);
//		model.addAttribute("excelHeader", clhr.getExcelHeader());
//		model.addAttribute("fileName", "공통조회조건 조회 이력");

        //엑셀 로그
        ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
        edlr.setSystemColumn(reqDto.getSystemColumn());
        edlr.setTargetId(reqDto.getRid());
        //ExcelDownloadLogReqDto edlr, EXCEL_DOWNLOAD_TYPE excelDownlType
        this.loggingHelper.addExcelDownloadLog(request, edlr, CommonUtil.EXCEL_DOWNLOAD_TYPE.SURVEY_RSLT_LIST);

        return "ExcelView";
    }

    @PostMapping(value = "/copySurveyDetail.do")
    @ResponseBody
    public LoySurveyResDto copySurveyDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyDetailReqDto reqDto) {
        log.debug("{}", reqDto);

        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.copySurveyDetail(reqDto);
    }

    /*
     * 1. 메소드명: getContentSurveyList
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: gy.lee
     */
    @PostMapping(value = "/getContentSurveyList.do")
    @ResponseBody
    public GridPagingResDto<LoySurveyListResDto> getContentSurveyList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getContentSurveyList(reqDto);
    }

    /*
     * 1. 메소드명: survDetailGridExcelDown
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2022. 2. 22.
     */
    @RequestMapping(value = "/survDetailGridExcelDown.do", method = RequestMethod.POST)
    public String survDetailGridExcelDown(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto,ModelMap model) {
        LogUtil.param(LoySurveyController.class, reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        HttpSession session = request.getSession(true);
        //프로그램 경로 가져오기
        String programPath = (String) session.getAttribute("URL_INCLUDE");
        if("".equals(programPath)) programPath = (String) session.getAttribute("URL");
        ProgramCache proResDto = null;
        String ObjCode = reqDto.getObjCode();
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

        GridPagingResDto<LoySurveyResultListResDto> data = this.loySurveyService.getSurveyResultList(reqDto);

        model.addAttribute("result", data);
        model.addAttribute("excelHeader", reqDto.getExcelHeader());
        model.addAttribute("fileName", "설문 결과 이력");

        //엑셀 로그
        ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
        edlr.setSystemColumn(reqDto.getSystemColumn());
        edlr.setTargetId(reqDto.getRid());
        this.loggingHelper.addExcelDownloadLog(request, edlr, CommonUtil.EXCEL_DOWNLOAD_TYPE.SURVEY_RSLT_LIST);

        return "ExcelView";
    }
    
    /*
     * 1. 메소드명: getSurveyAnalysis
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: ps.lee
     * 4. 작성일자: 2022. 2. 23.
     */
    @PostMapping(value = "/getSurveyAnalysis.do")
    @ResponseBody
    public GridPagingResDto<LoySurveyAnalysisResDto> getSurveyAnalysis(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);

        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveyAnalysis(reqDto);
    }

    /*
     * 1. 메소드명: getTextItemList
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2022. 3. 2.
     */
    @PostMapping(value = "/getTextItemList.do")
    @ResponseBody
    public GridPagingResDto<LoySurveyTextItemListResDto> getTextItemList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getTextItemList(reqDto);
    }


    /*
     * 1. 메소드명: initSurveyItemControlled
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: bg.yoon
     * 4. 작성일자: 2022. 3. 14.
     */
    @PostMapping(value = "/initSurveyItemControlled.do")
    @ResponseBody
    public StatusResDto initSurveyItemControlled(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        StatusResDto rtnValue = new StatusResDto();
        reqDto.setLoginInfo(this.checkLoginSession(request, response));
        loySurveyService.initSurveyItemControlled(reqDto);
        rtnValue.setSuccess(true);
        return rtnValue;
    }

    /*
     * 1. 메소드명: getSurveyItemListPop
     * 2. 클래스명: LoySurveyController
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2022. 04. 05.
     */
    @PostMapping(value = "/getSurveyItemListPop.do")
    @ResponseBody
    public GridPagingResDto<LoySurveyItemListResDto> getSurveyItemListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySurveyListReqDto reqDto) {
        log.debug("{}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loySurveyService.getSurveyItemListPop(reqDto);
    }

}