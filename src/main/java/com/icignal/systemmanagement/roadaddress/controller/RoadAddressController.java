package com.icignal.systemmanagement.roadaddress.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.filter.HTMLTagFilterRequestWrapper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.component.Messages;
import com.icignal.loyalty.operationpolicymgt.dto.request.OperationPolicyReqDto;
import com.icignal.systemmanagement.batchrgst.util.BatchRgstExcelFileUtil;
import com.icignal.systemmanagement.roadaddress.dto.request.RoadAddressReqDto;
import com.icignal.systemmanagement.roadaddress.dto.response.RoadAddressResDto;
import com.icignal.systemmanagement.roadaddress.service.RoadAddressService;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

@Controller
@RequestMapping("/system/roadaddress")
public class RoadAddressController extends BaseController {
	
	@Autowired
	private RoadAddressService roadAddressService;

	/**
	 * @name : getRoadAddressList
	 * @date : 2020. 12. 04.
	 * @author : jb.kim
	 * @return : 
	 * @description : 도로명주소 데이터 조회
	 */
	@RequestMapping(value="/getRoadAddressList.do", method=RequestMethod.POST) 
	public @ResponseBody GridPagingResDto<RoadAddressResDto> getRoadAddressList(@RequestBody RoadAddressReqDto rrd) {
		LogUtil.param(this.getClass(), rrd); // 공통 로그 기록 코드

		return roadAddressService.getRoadAddressList(rrd);
	}
	
	
	@RequestMapping(value = "/uploadExcelRoadAddress.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity uploadExcelRoadAddress(MultipartHttpServletRequest request, ModelMap model,
			HttpServletResponse response) throws IOException {
	
		
		BatchRgstExcelFileUtil excelUpld = new BatchRgstExcelFileUtil(); // 엑셀파일유틸 객체
		List<RoadAddressReqDto> batchUpload = new ArrayList<RoadAddressReqDto>(); // 결과물 담을 리스트객체 batchUpload
		StatusResDto rtnValue = new StatusResDto(); // 상태응답Dto객쳬
		LoginResDto loginInfo = this.checkLoginSession(request, response); // 로그인정보를 얻어낸다(create_by, modify_by를 위한) 
		RoadAddressReqDto raDto = new RoadAddressReqDto(); // RequestDto의 객체를 생성
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
			batchUpload = excelUpld.excelUploadRoadAddress(request, false, rid); 
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
				raDto.setArray(batchUpload);
				raDto.setRid(rid);
				raDto.setLoginInfo(loginInfo);

				rtnValue = roadAddressService.insertRoadAddressList(raDto);
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
