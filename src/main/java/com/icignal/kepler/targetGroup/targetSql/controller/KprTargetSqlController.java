package com.icignal.kepler.targetGroup.targetSql.controller;

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
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.targetGroup.targetGroup.controller.KprTargetGroupController;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlDetailReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlEditReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlListReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlTargetListReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlValidationReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.response.KprTargetSqlDetailResDto;
import com.icignal.kepler.targetGroup.targetSql.dto.response.KprTargetSqlListResDto;
import com.icignal.kepler.targetGroup.targetSql.service.KprTargetSqlService;

/**
 * 대상자 쿼리 Controller
 *
 * @name : infavor.kepler.targetGroup.controller.KprTargetSqlController
 * @date : 2018. 4. 11.
 * @author : jh.kim
 * @description :
 */
@Controller
@RequestMapping("/kepler/targetSql")
public class KprTargetSqlController extends BaseController {

    @Autowired
    private KprTargetSqlService kprTargetSqlService;
    
    @Autowired
    private LoggingHelper loggingHelper;

    /**
     * 대상자 쿼리 그룹정보 상세 조회
     *
     * @programId :
     * @name : getTargetSqlDetail
     * @date : 2018. 4. 11.
     * @author : jh.kim
     * @table :
     * @param request
     * @param response
     * @param param
     * @return
     * @description :
     */
    @RequestMapping(value = "/getTargetSqlDetail.do", method = RequestMethod.POST)
    public @ResponseBody KprTargetSqlDetailResDto getTargetSqlDetail(
            HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetSqlDetailReqDto param) {
        LogUtil.param(this.getClass(), param);

        param.setLoginInfo(this.checkLoginSession(request, response));

        return kprTargetSqlService.getTargetSqlDetail(param);
    }

    /**
     * SQL쿼리 검증
     *
     * @programId :
     * @name : targetSqlValidation
     * @date : 2018. 4. 13.
     * @author : jh.kim
     * @table :
     * @param request
     * @param response
     * @param param
     * @return
     * @description :
     */
    @RequestMapping(value = "/targetSqlValidation.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto targetSqlValidation(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetSqlValidationReqDto param) {
        LogUtil.param(this.getClass(), param);

        param.setLoginInfo(this.checkLoginSession(request, response));

        return kprTargetSqlService.targetSqlValidation(param);
    }

    /**
     * 타겟 SQL 저장
     *
     * @programId :
     * @name : saveTargetSql
     * @date : 2018. 4. 18.
     * @author : jh.kim
     * @table :
     * @param request
     * @param response
     * @param param
     * @return
     * @description :
     */
    @RequestMapping(value = "/saveTargetSql.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto saveTargetSql(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetSqlEditReqDto param) {
        LogUtil.param(this.getClass(), param);

        param.setLoginInfo(this.checkLoginSession(request, response));

        return kprTargetSqlService.saveTargetSql(param);
    }

    /**
     * 타겟SQL 대상자 목록 조회
     *
     * @programId :
     * @name : getTargetSqlTargetList
     * @date : 2018. 4. 23.
     * @author : jh.kim
     * @table :
     * @param request
     * @param response
     * @param tgtlr
     * @return
     * @description :
     */
    @RequestMapping(value="/getTargetSqlTargetList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto getTargetSqlTargetList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetSqlTargetListReqDto tgtlr) {
        LogUtil.param(this.getClass(), tgtlr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        tgtlr.setLoginInfo(loginInfo);

        return kprTargetSqlService.getTargetSqlTargetList(tgtlr);
    }

    /**
     * @programId : ANL_TGT_002
     * @name : exportExcelTargetGroupTargetList
     * @date : 2016. 8. 10.
     * @author : 류동균
     * @table :
     * @return :
     * @description : export excel 타겟그룹 대상자 목록
     */
    @RequestMapping(value="/exportExcelTargetSqlTargetList.do", method = RequestMethod.POST)
    public String exportExcelTargetGroupImportTargetList (HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetSqlTargetListReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		
		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.TGT_SQL_TGT);
		
		// 데이터 조회
		GridPagingResDto data = kprTargetSqlService.getAllTargetSqlTargetList(reqDto);

		model.addAttribute("result", data);
        model.addAttribute("excelHeader", reqDto.getExcelHeader());
        model.addAttribute("fileName", "타겟 그룹");

		return "ExcelView";
    }

    /**
     * 타겟SQL 타겟팅 수 조회
     *
     * @programId :
     * @name : getTargetSqlCount
     * @date : 2018. 4. 25.
     * @author : jh.kim
     * @table :
     * @param request
     * @param response
     * @param param
     * @return
     * @description :
     */
    @RequestMapping(value = "/getTargetSqlCount.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto getTargetSqlCount(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetSqlValidationReqDto param) {
        LogUtil.param(this.getClass(), param);

        param.setLoginInfo(this.checkLoginSession(request, response));

        return kprTargetSqlService.getTargetSqlCount(param);
    }

    /**
     * 타겟SQL 목록 조회
     *
     * @programId :
     * @name : getTargetSqlList
     * @date : 2018. 4. 25.
     * @author : jh.kim
     * @table :
     * @param request
     * @param response
     * @param param
     * @return
     * @description :
     */
    @RequestMapping(value = "/getTargetSqlList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto<KprTargetSqlListResDto> getTargetSqlList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetSqlListReqDto param) {
        LogUtil.param(this.getClass(), param);

        param.setLoginInfo(this.checkLoginSession(request, response));

        return kprTargetSqlService.getTargetSqlList(param);
    }
    
    
    /**
     * @programId :
     * @name : saveCf24TargetGroup
     * @date : 2020. 11. 23.
     * @author : yj.choi
     * @table : 
     * @return :
     * @throws ParseException 
     * @description : 카페24 타겟그룹 저장
     */
    @RequestMapping(value="/saveCf24TargetGroup.do", method = RequestMethod.POST)
    public @ResponseBody
    StatusResDto saveCf24TargetGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetSqlEditReqDto stgr){
        LogUtil.param(KprTargetGroupController.class,stgr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        stgr.setCreateBy(loginInfo.getId());
        stgr.setModifyBy(loginInfo.getId());

        return kprTargetSqlService.saveCf24TargetGroup(stgr);
    }
    
    
    /**
     * @programId :
     * @name : getTargetCafe24List
     * @date : 2020. 12. 15.
     * @author : yj.choi
     * @table : 
     * @return :
     * @throws ParseException 
     * @description : 카페24 타겟그룹 조회
     */
    @RequestMapping(value="/getTargetCafe24List.do", method = RequestMethod.POST)
    public @ResponseBody
    GridPagingResDto getTargetCafe24List(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetSqlTargetListReqDto stgr){
    	LogUtil.param(KprTargetGroupController.class,stgr);
    	
    	LoginResDto loginInfo = this.checkLoginSession(request, response);
    	stgr.setCreateBy(loginInfo.getId());
    	stgr.setModifyBy(loginInfo.getId());
    	
    	return kprTargetSqlService.getTargetCafe24List(stgr);
    }
    
    /**
     * @programId :
     * @name : exportExcelTargetCafe24List
     * @date : 2020. 12. 15.
     * @author : yj.choi
     * @table : 
     * @return :
     * @throws ParseException 
     * @description : 카페24 타겟그룹 조회
     */
    @RequestMapping(value="/exportExcelTargetCafe24List.do", method = RequestMethod.POST)
    public String exportExcelTargetCafe24List(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetSqlTargetListReqDto stgr, ModelMap model){
    	LogUtil.param(KprTargetGroupController.class,stgr);
    	
    	LoginResDto loginInfo = this.checkLoginSession(request, response);
    	stgr.setCreateBy(loginInfo.getId());
    	stgr.setModifyBy(loginInfo.getId());
    	
    	// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(stgr.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.TGT_SQL_TGT);
		
		stgr.setExcelFlag(true);
		GridPagingResDto data = kprTargetSqlService.getTargetCafe24List(stgr);
		
		model.addAttribute("result", data);
        model.addAttribute("excelHeader", stgr.getExcelHeader());
        model.addAttribute("fileName", "타겟 그룹");
        
    	return "ExcelView";
    }
    
    /**
     * select cafe24 Flag
     *
     * @programId :
     * @name : getTargetCafe24YnFlag
     * @date : 2021. 4. 14.
     * @author : lee.gy
     * @table :
     * @param request
     * @param response
     * @param param
     * @return
     * @description :
     */
    @RequestMapping(value="/getTargetCafe24YnFlag.do", method = RequestMethod.POST)
    public @ResponseBody KprTargetSqlDetailResDto getTargetCafe24YnFlag(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetSqlDetailReqDto param) {
        LogUtil.param(this.getClass(), param);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        
        return kprTargetSqlService.getTargetCafe24YnFlag(param);
    }
   
}
