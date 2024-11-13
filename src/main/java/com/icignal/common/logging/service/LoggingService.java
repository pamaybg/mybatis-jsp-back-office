/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: ICNLogService.java
 * 2. Package	: com.icignal.common.logging.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 19. 오후 7:40:07
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 19.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.common.logging.service;

import com.icignal.common.logging.dto.request.ApiLogReqDto;
import com.icignal.systemmanagement.apispec.mapper.LoyRestApiMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.logging.dto.request.ExcelDownloadLogReqDto;
import com.icignal.common.logging.dto.request.LOYCustMaskReleaLogReqDto;
import com.icignal.common.logging.dto.request.ServiceReqLogReqDto;
import com.icignal.common.logging.mapper.LoggingMapper;

/*
 * 1. 클래스명	: ICNLogService
 * 2. 파일명	: ICNLogService.java
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
@Service
public class LoggingService {
	
	@Autowired LoggingMapper loggingMapper;

	@Autowired
	LoyRestApiMapper loyRestApiMapper;
	
	public StatusResDto registServiceReqLog( ServiceReqLogReqDto reqDto) {
		
		StatusResDto rtnValue = new StatusResDto();
	
		
		/*LoginResDto loginInfo = null;
		
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
		reqDto.setId(id);*/
		
		loggingMapper.insertServiceReqLog(reqDto);
        rtnValue.setSuccess(true);

		
		return rtnValue;
	}
	
	
	 /*
	  * 1. 메소드명: registCustMaskReleaLog
	  * 2. 클래스명: LoggingService
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	고객정보 마스킹해제 이력을 등록한다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto registCustMaskReleaLog(LOYCustMaskReleaLogReqDto reqDto) {
		StatusResDto status = new StatusResDto();
		
		loggingMapper.insertCustMaskReleaLog(reqDto);
		
		
		status.setSuccess(true);
		return status;
		
	}


	 /*
	  * 1. 메소드명: insertExcelDownloadLog
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
	 *   @param edlr
	 *   @return	
	 */
	
	public StatusResDto getExcelDownloadLog(ExcelDownloadLogReqDto edlr) {
		StatusResDto rtnValue = new StatusResDto();
		loggingMapper.insertExcelDownloadLog(edlr);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	/*
	 * 1. 메소드명: insertApiLogPorcMsgLog
	 * 2. 클래스명: LoggingService
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 02. 10.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		API MSG LOG Service
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param apiLog
	 */
	public StatusResDto insertApiLogPorcMsgLog(ApiLogReqDto apiLog) {
		StatusResDto rtnValue = new StatusResDto();
		loyRestApiMapper.insertApiLogPorcMsgLog(apiLog);
		rtnValue.setSuccess(true);

		return rtnValue;
	}
}
