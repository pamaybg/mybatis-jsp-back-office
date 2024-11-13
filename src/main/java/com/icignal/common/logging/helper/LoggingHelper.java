/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoggingHelper.java
 * 2. Package	: com.icignal.common.logging.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 19. 오후 7:29:27
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 19.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.common.logging.helper;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.common.logging.dto.request.*;
import com.icignal.common.logging.mapper.LoggingMapper;
import com.icignal.loyalty.operationpolicymgt.dto.response.OperationPolicyDetailResDto;
import com.icignal.systemmanagement.apispec.dto.vo.LoySurveyInfoApiVo;
import com.icignal.systemmanagement.apispec.mapper.LoyRestApiMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.logging.service.LoggingService;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.exception.DataUnauthrizedException;

/*
 * 1. 클래스명	: LoggingHelper
 * 2. 파일명	: LoggingHelper.java
 * 3. 패키지명	: com.icignal.common.logging.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 19.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Component
public class LoggingHelper{
	
	@Autowired
	LoggingMapper loggingMapper;

	@Autowired
	LoyRestApiMapper loyRestApiMapper;
	
	@Autowired LoggingService loggingService;
	
	public void addServiceReqLog(HttpServletRequest request, Object param) {
		
		ServiceReqLogReqDto reqDto = new ServiceReqLogReqDto();
		
		 if(param != null &&param.getClass().getName().equalsIgnoreCase("string")){
			
			reqDto.setReqParams(param.toString());
		} else {
			reqDto.setReqParams(StringUtil.getJSONtoObject(param).trim().replace("\r\n", ""));
		}
		
		LoginResDto loginInfo = null;
		
		HttpSession session = request.getSession(true);
		
		//세션 확인
		if (session != null && session.getAttribute(CommonUtil.USER_INFO_PROP) != null) {
			loginInfo = (LoginResDto) session.getAttribute(CommonUtil.USER_INFO_PROP);
			reqDto.setLoginInfo(loginInfo);
		} else {
			throw new DataUnauthrizedException();
		}
		
		//요청 IP
		String reqIp = CommonUtil.getClientIP(request);
		//요청 URL
		String reqUrl = request.getRequestURL().toString();
		//요청 세션ID
		String reqSessnId = request.getRequestedSessionId();
		//요청 로그인 아이디
		String reqLoginId = loginInfo.getId();
		
		//파라메터 확인
		if (ObjectUtil.isNotEmpty(request.getParameterMap())) {
			Map<String, String[]> map = request.getParameterMap();
			
			String mapStr = ObjectUtil.ConvertMapToJSONString(map);
			reqDto.setReqParams(mapStr);
		}
		
		reqDto.setReqIp(reqIp);
		reqDto.setReqUrl(reqUrl);
		reqDto.setReqSessnId(reqSessnId);
		reqDto.setReqLoginId(reqLoginId);
		
		//엑셀 다운로드 로그 등록
		String id =CommonUtil.newRid();
		reqDto.setId(id);
				
		
		loggingService.registServiceReqLog( reqDto);
		
      
	}	
	
	 /*
	  * 1. 메소드명: insertCustReleaLog
	  * 2. 클래스명: LoggingHelper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param obj
	 *   @param infoType
	 *   @return	
	 */
	public StatusResDto insertCustReleaLog(Object obj, String infoType) {
		LogUtil.param(this.getClass(), obj);

		LOYCustMaskReleaLogReqDto logReq = new LOYCustMaskReleaLogReqDto();
		
		logReq.setInfoType(infoType);

		  Class<?> cls = obj.getClass();
		    try {
				String pageInfo = "";
				if(ObjectUtil.isNotEmpty(cls.getMethod("getUri").invoke(obj)))
					pageInfo = (String)cls.getMethod("getUri").invoke(obj);
				else
					pageInfo = (String)cls.getMethod("getUrlInclude").invoke(obj);
				logReq.setPageInfo(pageInfo.substring(0,pageInfo.lastIndexOf(".")));
			    logReq.setInfoRid((String)cls.getMethod("getRid").invoke(obj));
			    logReq.setCreateBy((String)cls.getMethod("getCreateBy").invoke(obj));
				logReq.setModifyBy((String)cls.getMethod("getModifyBy").invoke(obj));
			} catch (IllegalAccessException e) {
				LogUtil.error(e.getMessage(),e);
			} catch (IllegalArgumentException e) {
				LogUtil.error(e.getMessage(),e);
			} catch (InvocationTargetException e) {
				LogUtil.error(e.getMessage(),e);
			} catch (NoSuchMethodException e) {
				LogUtil.error(e.getMessage(),e);
			} catch (SecurityException e) {
				LogUtil.error(e.getMessage(),e);
			}

		return loggingService.registCustMaskReleaLog(logReq);



	}
	
	/*public StatusResDto insertSearchLog(Object param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnVal = new StatusResDto();
		
		
		
		try{
		CommonDataAuthReqDto searchParam = (CommonDataAuthReqDto) param;
		
		
		
		LogUtil.param(this.getClass(), param);		
		searchMongoLogRequestDto log = new searchMongoLogRequestDTO();
		
		BasicDBList logList = new BasicDBList();
	    
	    String searchKey = UUID.randomUUID().toString();
	  
	    
		
		log.setDate(new Date());		
		log.setSearch_key(UUID.randomUUID().toString());
		log.setUrl(searchParam.getUrl());
		log.setUrl_include(searchParam.getUrlInclude());
		log.setUser_rid(searchParam.getLoginId());
		
		if(searchParam.getItem() != null || searchParam.getItem().size() > 0){
			for(int i=0; i<searchParam.getItem().size(); i++){
				BasicDBObject dbObject = new BasicDBObject();
				String type = searchParam.getItem().get(i).getCondType().trim();					
				String operation = searchParam.getItem().get(i).getOperationType().trim();
				String field = searchParam.getItem().get(i).getSrcCol(); 
				String value = searchParam.getItem().get(i).getWhereVal();	
				
				dbObject.put("date", new Date());
			    dbObject.put("searchKey",searchKey);
			    dbObject.put("url", searchParam.getUrl());
			    dbObject.put("urlInclude", searchParam.getUrlInclude());
			    dbObject.put("userRid", searchParam.getLoginId());
				dbObject.put("type",type );
				dbObject.put("operation", operation);
				dbObject.put("field", field);
				dbObject.put("value",value );
				
				
				
				log.setField(field);
				log.setOperation(operation);
				if (type.equals("DATE") && operation.equals("BETWEEN") ) {
					dbObject.put("value1",searchParam.getItem().get(i).getStartDate() );
					dbObject.put("value2",searchParam.getItem().get(i).getEndDate() );
					
					log.setValue1(searchParam.getItem().get(i).getStartDate());
					log.setValue2(searchParam.getItem().get(i).getEndDate());
				}else{
					dbObject.put("value1",value );
					log.setValue1(value);
				}
				
				logList.add(dbObject);
//				iMKTMongoDBDAO.insert(dbObject, "search_log");
			}
		}else{
				// 전체 조회 
				log.setField("ALL");				
//				iMKTMongoDBDAO.insert(log, "search_log");
		}
		
		rtnVal.setSuccess(true);
		}catch(Exception e){
			rtnVal.setSuccess(false);
		    LogUtil.error(e);
		}
		return rtnVal;
	
	}*/
	
	/*
	  * 1. 메소드명: addExcelDownloadLog
	  * 2. 클래스명: LoggingService
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
	 *   @param edlr
	 *   @param excelDownlType
	 *   @return	
	 */
	public StatusResDto addExcelDownloadLog(HttpServletRequest request, ExcelDownloadLogReqDto edlr, EXCEL_DOWNLOAD_TYPE excelDownlType) {
		LogUtil.param(this.getClass(), edlr);
		
		
		LoginResDto loginInfo = null;
		
		HttpSession session = request.getSession(true);
		
		//세션 확인
		if (session != null && session.getAttribute(CommonUtil.USER_INFO_PROP) != null) {
			loginInfo = (LoginResDto) session.getAttribute(CommonUtil.USER_INFO_PROP);
		} else {
			throw new DataUnauthrizedException();
		}
		
		//요청 IP
		String reqIp = CommonUtil.getClientIP(request);
		//요청 URL
		String reqUrl = request.getRequestURL().toString();
		//요청 세션ID
		String reqSessnId = request.getRequestedSessionId();
		//요청 로그인 아이디
		String reqLoginId = loginInfo.getId();
		
		edlr.setReqIp(reqIp);
		edlr.setReqUrl(reqUrl);
		edlr.setReqSessnId(reqSessnId);
		edlr.setReqLoginId(reqLoginId);
		edlr.setReqTypeCd(excelDownlType.toString());
		
		//엑셀 다운로드 로그 등록
		String id = CommonUtil.newRid();
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		edlr.setId(id);
		rtnValue = loggingService.getExcelDownloadLog(edlr);       
    
       rtnValue.setSuccess(true);
       rtnValue.setMessage(id);
		
		return rtnValue;
	
	
	}
	
	public StatusResDto addExcelDownloadLog(HttpServletRequest request, ExcelDownloadLogReqDto edlr, EXCEL_DOWNLOAD_TYPE excelDownlType,String condWhere) {
		LogUtil.param(this.getClass(), edlr);
		
		
		LoginResDto loginInfo = null;
		
		HttpSession session = request.getSession(true);
		
		//세션 확인
		if (session != null && session.getAttribute(CommonUtil.USER_INFO_PROP) != null) {
			loginInfo = (LoginResDto) session.getAttribute(CommonUtil.USER_INFO_PROP);
		} else {
			throw new DataUnauthrizedException();
		}
		
		//요청 IP
		String reqIp = CommonUtil.getClientIP(request);
		//요청 URL
		String reqUrl = request.getRequestURL().toString();
		//요청 세션ID
		String reqSessnId = request.getRequestedSessionId();
		//요청 로그인 아이디
		String reqLoginId = loginInfo.getId();
		
		edlr.setReqIp(reqIp);
		edlr.setReqUrl(reqUrl);
		edlr.setReqSessnId(reqSessnId);
		edlr.setReqLoginId(reqLoginId);
		edlr.setReqTypeCd(excelDownlType.toString());
		edlr.setCondWhere(condWhere);
		//엑셀 다운로드 로그 등록
		String id = CommonUtil.newRid();
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		edlr.setId(id);
		rtnValue = loggingService.getExcelDownloadLog(edlr);       
    
       rtnValue.setSuccess(true);
       rtnValue.setMessage(id);
		
		return rtnValue;
	
	
	}

	/*
	 * 1. 메소드명: addApiLogPorcMsgLog
	 * 2. 클래스명: LoggingHelper
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 02. 10.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		API MSG LOG Helper
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param obj
	 *   @param msgType
	 */
	public StatusResDto addApiLogPorcMsgLog(Object obj, String msgType){
		StatusResDto rtnValue = new StatusResDto();
		ApiLogReqDto apiLog = new ApiLogReqDto();
		ObjectMapper mapper = new ObjectMapper();
		Class<?> cls = obj.getClass();
		try {
			apiLog.setMsgType(msgType);
			for(Method f : obj.getClass().getDeclaredMethods()){
				//지역변수 private 값 허용
				f.setAccessible(true);
				switch (f.getName()){
					case "getApiNo":
						apiLog.setApiNo((String)cls.getMethod("getApiNo").invoke(obj));
						break;
					case "getTrNo":
						apiLog.setTrNo((String)cls.getMethod("getTrNo").invoke(obj));
						break;
					case "getTrDt":
						apiLog.setTrDt((String)cls.getMethod("getTrDt").invoke(obj));
						break;
					case "getChnlNo":
						apiLog.setChnlNo((String)cls.getMethod("getChnlNo").invoke(obj));
						break;
					case "getDvcNo":
						apiLog.setDvcNo((String)cls.getMethod("getDvcNo").invoke(obj));
						break;
					case "getRst":
						apiLog.setRst((String)cls.getMethod("getRst").invoke(obj));
						break;
					case "getRstCd":
						apiLog.setRstCd((String)cls.getMethod("getRstCd").invoke(obj));
						break;
					case "getRstMsg":
						apiLog.setRstMsg((String)cls.getMethod("getRstMsg").invoke(obj));
						break;
					default:
						break;
				}

			}

			apiLog.setMsg(mapper.writeValueAsString(obj));

			rtnValue = loggingService.insertApiLogPorcMsgLog(apiLog);
		} catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException | JsonProcessingException e) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage(e.getMessage());
			LogUtil.error(e.getMessage());
		}

		return rtnValue;
	}

	/*
	 * 1. 메소드명: addApiSystemErrAlt
	 * 2. 클래스명: LoggingHelper
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 03. 10.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		API SYSTEM ERROR ALERT
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param apiNo
	 *   @param rstMsg
	 */
	public StatusResDto addApiSystemErrAlt(String apiNo, String rstMsg) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		ApiSystemErrorAlertLogReqDto apiAlt = new ApiSystemErrorAlertLogReqDto();
		apiAlt.setApiNo(apiNo);
		apiAlt.setContent(rstMsg);

		// 오늘 추가된 로그 수
		int todayLogs = Integer.parseInt(loyRestApiMapper.selectCurrentTodayLogCount(apiAlt));

		// 하루에 추가 가능한 로그 수 ( 운영정책 )
		String oneDayMax = loyRestApiMapper.selectOprPlcyDtlSysErrAltVal(apiAlt);
		if(ObjectUtil.isEmpty(oneDayMax)) oneDayMax = "0";


		if(Integer.parseInt(oneDayMax) > todayLogs){
			// 수신자 이메일 주소
			apiAlt.setToEmail(loyRestApiMapper.selectOprPlcyDtlSysErrAltEmail(apiAlt));
			// 발송상태
			apiAlt.setSendStatCd("WAIT");
			loyRestApiMapper.insertApiSysErrAlt(apiAlt);
			rtnValue.setSuccess(true);
			LogUtil.info("addApiSystemErrAlt: 알림 추가 성공");
		}else{
			LogUtil.info("addApiSystemErrAlt: 하루에 입력 가능한 알림 개수 "+oneDayMax+"개를 초과하는 요청입니다.");
		}
		return rtnValue;
	}

}
