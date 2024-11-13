package com.icignal.systemmanagement.log.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.exception.DataUnauthrizedException;
import com.icignal.systemmanagement.log.dto.request.SystemExcelDownloadLogReqDto;
import com.icignal.systemmanagement.log.dto.request.SystemLoginHistoryReqDto;
import com.icignal.systemmanagement.log.dto.request.SystemServiceReqLogReqDto;
import com.icignal.systemmanagement.log.dto.response.SystemAuthLogHistoryResDto;
import com.icignal.systemmanagement.log.dto.response.SystemCondLogHistoryResDto;
import com.icignal.systemmanagement.log.dto.response.SystemExcelDownloadLogResDto;
import com.icignal.systemmanagement.log.dto.response.SystemLoginHistoryResDto;
import com.icignal.systemmanagement.log.dto.response.SystemPiMaskDecListResDto;
import com.icignal.systemmanagement.log.mapper.SystemLogMapper;


/*
 * 1. 클래스명	: SystemLogSerivce
 * 2. 파일명	: SystemLogSerivce.java
 * 3. 패키지명	: com.icignal.systemmanagement.log.service
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *		개인정보 취급이력 Service
 * </PRE>
 */ 
@Service("SystemLogSerivce")
public class SystemLogSerivce {
	
	@Autowired
	private SystemLogMapper systemLogMapper;
	
	@Autowired
	LoggingHelper loggingHelper;

	/**
	 * @programId : 
	 * @name : addExcelDownloadLog
	 * @date : 2017. 6. 7.
	 * @author : "dg.ryu"
	 * @table : com.com_excel_downl_log
	 * @return : StatusResDto
	 * @description : 엑셀 다운로드 로그 등록
	 */
	public StatusResDto addExcelDownloadLog(HttpServletRequest request, SystemExcelDownloadLogReqDto param, EXCEL_DOWNLOAD_TYPE excelDownlType) {
		LogUtil.param(SystemLogSerivce.class, param);
		
		String id = CommonUtil.newRid();
		param.setId(id);
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
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
		
		param.setReqIp(reqIp);
		param.setReqUrl(reqUrl);
		param.setReqSessnId(reqSessnId);
		param.setReqLoginId(reqLoginId);
		param.setReqTypeCd(excelDownlType.toString());
		
		//엑셀 다운로드 로그 등록
		systemLogMapper.addExcelDownloadLog(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	 * @programId : 
	 * @name : getExcelDownloadLogList
	 * @date : 2017. 6. 7.
	 * @author : "dg.ryu"
	 * @table : com.com_excel_downl_log
	 * @return : GridPagingResDto
	 * @description : 엑셀 다운로드 로그 목록 조회
	 */
	public GridPagingResDto<SystemExcelDownloadLogResDto> getExcelDownloadLogList(SystemExcelDownloadLogReqDto param) {
		LogUtil.param(SystemLogSerivce.class, param);
		
		return new GridPagingResHelper<SystemExcelDownloadLogResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemLogMapper.getExcelDownloadLogList(param), AnnotationType.ALL);
	}
	
	/**
	 * @programId : 
	 * @name : getLoginHistoryList
	 * @date : 2017. 6. 7.
	 * @author : "dg.ryu"
	 * @table : com.login_history
	 * @return : GridPagingResDto
	 * @description : 로그인 이력 목록 조회
	 */
	public GridPagingResDto<SystemLoginHistoryResDto> getLoginHistoryList(SystemLoginHistoryReqDto param) {
		LogUtil.param(SystemLogSerivce.class, param);

		return new GridPagingResHelper<SystemLoginHistoryResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemLogMapper.getLoginHistoryList(param), AnnotationType.ALL);
	}
	
	 /*
	  * 1. 메소드명: excelDownLoginHistoryList
	  * 2. 클래스명: SystemLogSerivce
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		엑셀다운
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public GridPagingResDto<SystemLoginHistoryResDto> excelDownLoginHistoryList(SystemLoginHistoryReqDto param) {
		LogUtil.param(SystemLogSerivce.class, param);
		
		return new GridPagingResHelper<SystemLoginHistoryResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				systemLogMapper.excelDownLoginHistoryList(param),
				AnnotationType.PersonalData
		);
	}

	/**
	 * @programId : 
	 * @name : getCondLogHistoryList
	 * @date : 2019. 01. 28.
	 * @author : "dw.keum"
	 * @table : com.com_cond_log
	 * @return : GridPagingResDto
	 * @description : 공통조회조건 이력 조회
	 */
	public GridPagingResDto<SystemCondLogHistoryResDto> getCondLogHistoryList(SystemLoginHistoryReqDto param) {
		LogUtil.param(SystemLogSerivce.class, param);
		
		return new GridPagingResHelper<SystemCondLogHistoryResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemLogMapper.getCondLogHistoryList(param),  AnnotationType.PersonalData);
	}

	/**
	 * @programId : 
	 * @name : getCondLogHistoryList
	 * @date : 2019. 01. 28.
	 * @author : "dw.keum"
	 * @table : com.com_auth_log
	 * @return : GridPagingResDto
	 * @description : 권한 변경 이력 조회
	 */
	public GridPagingResDto<SystemAuthLogHistoryResDto> getAuthLogHistoryList(SystemLoginHistoryReqDto param) {
		LogUtil.param(SystemLogSerivce.class, param);

		return new GridPagingResHelper<SystemAuthLogHistoryResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemLogMapper.getAuthLogHistoryList(param), AnnotationType.CommCode);
	}
	
	/**
	 * @programId : 
	 * @name : addServiceReqLog
	 * @date : 2019. 7. 29.
	 * @author : "dg.ryu"
	 * @table : com.com_service_req_log
	 * @return : StatusResDto
	 * @description : 서비스 요청 로그 등록
	 */
	public StatusResDto addServiceReqLog(HttpServletRequest request, SystemServiceReqLogReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		LoginResDto loginInfo = null;
		
		HttpSession session = request.getSession(true);
		
		//세션 확인
		if (session != null && session.getAttribute(CommonUtil.USER_INFO_PROP) != null) {
			loginInfo = (LoginResDto) session.getAttribute(CommonUtil.USER_INFO_PROP);
			param.setLoginInfo(loginInfo);
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
			param.setReqParams(mapStr);
		}
		
		param.setReqIp(reqIp);
		param.setReqUrl(reqUrl);
		param.setReqSessnId(reqSessnId);
		param.setReqLoginId(reqLoginId);
		
		//엑셀 다운로드 로그 등록
		systemLogMapper.addServiceReqLog(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : getPiMaskDecList
	* @date : 2019. 11. 07.
	* @author : yj.choi
	* @table :
	* @return : GridPagingResDto
	* @description : 개인정보 마스킹 해지 이력 조회
	*/
	public GridPagingResDto<SystemPiMaskDecListResDto> getPiMaskDecList(SystemLoginHistoryReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<SystemPiMaskDecListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemLogMapper.getPiMaskDecList(param));
	}

	 /*
	  * 1. 메소드명: getPiMaskDecExcelDn
	  * 2. 클래스명: SystemLogSerivce
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 2. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		마스킹 해지 이력 엑셀 다운로드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public GridPagingResDto<SystemPiMaskDecListResDto> getPiMaskDecExcelDn(SystemLoginHistoryReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<SystemPiMaskDecListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemLogMapper.getPiMaskDecExcelDn(param));
	}
	
	
	 /*
	  * 1. 메소드명: getCondLogTestList
	  * 2. 클래스명: SystemLogSerivce
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		대용량 엑셀다운 테스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public GridPagingResDto<SystemCondLogHistoryResDto> getCondLogTestList(SystemLoginHistoryReqDto param) {
		LogUtil.param(SystemLogSerivce.class, param);
		
		return new GridPagingResHelper<SystemCondLogHistoryResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemLogMapper.selectCondLogTestList(param), AnnotationType.PersonalData);
	}

	 /*
	  * 1. 메소드명: clearMaskCondLogHistList
	  * 2. 클래스명: SystemLogSerivce
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		개인정보 조회이력 - 마스킹 해제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public SystemCondLogHistoryResDto clearMaskCondLogHistList(SystemLoginHistoryReqDto param) {
		LogUtil.param(this.getClass(), param); 
		loggingHelper.insertCustReleaLog(param, "com_condLogHist"); // 이력 저장
	    return new AnnotationHelper<SystemCondLogHistoryResDto>(AnnotationType.PersonalData, systemLogMapper.clearMaskCondLogHistList(param)).getItem();
	}


}
