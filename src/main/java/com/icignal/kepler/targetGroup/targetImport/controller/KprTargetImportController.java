package com.icignal.kepler.targetGroup.targetImport.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.component.Messages;
import com.icignal.kepler.targetGroup.targetGroup.controller.KprTargetGroupController;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprSetTargetGroupReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupColumnListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupItemListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupItemReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupColumnListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupItemListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupResDto;
import com.icignal.kepler.targetGroup.targetImport.service.KprTargetImportService;
import com.icignal.systemmanagement.batchrgst.util.BatchRgstExcelFileUtil;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/**
 * @name : infavor.kepler.targetGroup.controller
 * @date : 2019. 11. 11.
 * @author : dg.ryu
 * @description : 타겟 임포트
 */
@Controller
@RequestMapping("/kepler/targetImport")
public class KprTargetImportController extends BaseController {

    @Autowired
    private KprTargetImportService KprTargetImportService;
    
    @Autowired
    private LoggingHelper loggingHelper;
    
    @Autowired
    private CommonService commonService;
    
	@Autowired
	private AuthHelper authHelper;

    /**
     * @programId :
     * @name : getTargetGroupDetail
     * @date : 2019. 11. 11.
     * @author : dg.ryu
     * @table :
     * @description : 타겟그룹 상세 조회
     */
    @RequestMapping(value = "/getTargetGroupImportDetail.do", method = RequestMethod.POST)
    public @ResponseBody KprTargetGroupResDto getTargetGroupImportDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        // 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return KprTargetImportService.getTargetGroupDetail(reqDto);
    }

    /**
     * @programId :
     * @name : saveTargetGroupImport
     * @date : 2019. 11. 11.
     * @author : dg.ryu
     * @table :
     * @description : 타겟그룹 저장
     */
    @RequestMapping(value="/saveTargetGroupImport.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto saveTargetGroupImport(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetTargetGroupReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);

        // 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return KprTargetImportService.saveTargetGroup(reqDto);
    }
    
	/**
	* @programId :
	* @name : setEventWinnerMultiUpload
	* @date : 2019. 6. 27.
	* @author : dw.keum
	* @table :
	* @return : StatusResDto
	* @description :
	*/
	@RequestMapping(value = "/setTargetGroupItemUpload.do", method = RequestMethod.POST)
	public @ResponseBody ResponseEntity  setTargetGroupItemUpload(MultipartHttpServletRequest request,  ModelMap model, HttpServletResponse response) throws IOException {
		LogUtil.param(this.getClass(), "");
		
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		
		BatchRgstExcelFileUtil excelUpld= new BatchRgstExcelFileUtil();
 		KprTargetGroupItemReqDto reqDto = new KprTargetGroupItemReqDto();
 		StatusResDto rtnValue = new StatusResDto();
 		
 		String[] rs = request.getParameterValues("param");
 		String ns = new String(rs[0].getBytes("iso-8859-1"),"utf-8");
 		
 		// xss 문자열 변환(복구)
 		ns = StringUtil.toWEB_BOX2(ns);
 		
 		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
 		JSONObject obj  = (JSONObject) json.get("data");
 		String rid = commonService.getRowID();
 		
 			try {
				reqDto = excelUpld.excelUploadTargetGroupItem( request, false, rid);
			} catch (Exception e1) {
				LogUtil.error(e1);
			}
 		
 		if (reqDto.getItemList().size()>0) {
 			if (reqDto.getUploadValidCheck()!=null) {
 				if (reqDto.getUploadValidCheck().equals("EXT")) {
 	 	 			rtnValue.setSuccess(false);
 	 		    	rtnValue.setMessage("Excel File (xlsx, xls)만 가능 합니다.");
 	 			} else if (reqDto.getUploadValidCheck().equals("SIZE")) {
 	 	 			rtnValue.setSuccess(false);
 	 	 			rtnValue.setMessage("파일 용량은 12메가를 초과할 수 없습니다.");
 	 			} else if (reqDto.getUploadValidCheck().equals("NOTUPLD")) {
	 	 			rtnValue.setSuccess(false);
	 	 			rtnValue.setMessage("업로드 할 데이터가 없습니다.");
	 			}
 			} else {
 		 		reqDto.setLoginInfo(loginInfo);
 		 		reqDto.setTargetGroupId((String) obj.get("targetGroupId"));
 				
  	 	 		rtnValue = KprTargetImportService.addTargetGroupItem(reqDto);
  			}
  		}else{
  			rtnValue.setSuccess(false);
	    	rtnValue.setMessage(Messages.getMessage("L01685", loginInfo.getLang()));
  		}
 		
 		HashMap<String, Object> map  = new HashMap<String, Object>();
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
	
    /**
     * @programId : ANL_TGT_002, ANL_TGT_P01
     * @name : getTargetGroupColumnList
     * @date : 2016. 7. 25.
     * @author : 류동균
     * @table : anl.anl_tgt_group, anl.anl_tgt_group_column
     * @return :
     * @description : 타겟그룹 컬럼 목록 조회
     */
    @RequestMapping(value="/getTargetGroupImportColumnList.do", method = RequestMethod.POST)
    public @ResponseBody
    List<KprTargetGroupColumnListResDto>  getTargetGroupColumnList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupColumnListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setLoginInfo(this.checkLoginSession(request, response));
        
        return KprTargetImportService.getTargetGroupColumnList(reqDto);
    }
	
    /**
     * @programId : ANL_TGT_002
     * @name : getTargetList
     * @date : 2016. 7. 21.
     * @author : 류동균
     * @table :
     * @return :
     * @description : 대상 목록
     */
    @RequestMapping(value="/getTargetGroupImportTargetList.do", method = RequestMethod.POST)
    public @ResponseBody GridPagingResDto getTargetGroupTargetList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupItemListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return KprTargetImportService.getTargetGroupTargetList(reqDto);
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
    @RequestMapping(value="/exportExcelTargetGroupImportTargetList.do", method = RequestMethod.POST)
    public String exportExcelTargetGroupImportTargetList (HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupItemListReqDto reqDto, ModelMap model) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setLoginInfo(this.checkLoginSession(request, response));
		
		// 엑셀 다운로드 로그 등록
		ExcelDownloadLogReqDto edlr = new ExcelDownloadLogReqDto();
		edlr.setSystemColumn(reqDto.getSystemColumn());
		edlr.setTargetId(null);
		loggingHelper.addExcelDownloadLog(request, edlr, EXCEL_DOWNLOAD_TYPE.TGT_IMPORT_TGT);
		
		reqDto.setExcelFlag(true);
		
		// 데이터 조회
		GridPagingResDto data = KprTargetImportService.getTargetGroupTargetList(reqDto);

		model.addAttribute("result", data);
        model.addAttribute("excelHeader", reqDto.getExcelHeader());
        model.addAttribute("fileName", "타겟 그룹");

		return "ExcelView";
    }
    
	//워크플로우 조건추출 목록 조회
    @RequestMapping(value="/copytgtImportData.do", method = RequestMethod.POST)
    public @ResponseBody
    GridPagingResDto<KprTargetGroupListResDto> copytgtImportData(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupListReqDto tglr) {
        LogUtil.param(KprTargetGroupController.class, tglr);

        tglr.setLoginInfo(this.checkLoginSession(request, response));

        GridPagingResDto<KprTargetGroupListResDto> rtnValue = new GridPagingResDto<>();
        rtnValue = KprTargetImportService.selectImportList(tglr);

        return rtnValue;
    }
    
    /**
     * @programId : ANL_TGT_002
     * @name : clearMaskImportTgtList
     * @date : 2021. 02. 03.
     * @author : yj.choi
     * @table :
     * @return :
     * @description : 마스킹 해제 
     */
    @RequestMapping(value="/clearMaskImportTgtList.do", method = RequestMethod.POST)
    public @ResponseBody KprTargetGroupItemListResDto clearMaskImportTgtList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTargetGroupItemListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

        return KprTargetImportService.clearMaskImportTgtList(reqDto);
    }
    
    
}
