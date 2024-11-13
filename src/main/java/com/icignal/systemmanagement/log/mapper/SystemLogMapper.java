package com.icignal.systemmanagement.log.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.log.dto.request.SystemExcelDownloadLogReqDto;
import com.icignal.systemmanagement.log.dto.request.SystemLoginHistoryReqDto;
import com.icignal.systemmanagement.log.dto.request.SystemServiceReqLogReqDto;
import com.icignal.systemmanagement.log.dto.response.SystemAuthLogHistoryResDto;
import com.icignal.systemmanagement.log.dto.response.SystemCondLogHistoryResDto;
import com.icignal.systemmanagement.log.dto.response.SystemExcelDownloadLogResDto;
import com.icignal.systemmanagement.log.dto.response.SystemLoginHistoryResDto;
import com.icignal.systemmanagement.log.dto.response.SystemPiMaskDecListResDto;

/*
 * 1. 클래스명	: SystemLogMapper
 * 2. 파일명	: SystemLogMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.log.mapper
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *		개인정보 취급이력 Mapper
 * </PRE>
 */ 
@Mapper
public interface SystemLogMapper {

	void addExcelDownloadLog(SystemExcelDownloadLogReqDto edlr);

	List<SystemExcelDownloadLogResDto> getExcelDownloadLogList(SystemExcelDownloadLogReqDto edlr);

	List<SystemLoginHistoryResDto> getLoginHistoryList(SystemLoginHistoryReqDto lhr);

	List<SystemCondLogHistoryResDto> getCondLogHistoryList(SystemLoginHistoryReqDto clhr);

	List<SystemAuthLogHistoryResDto> getAuthLogHistoryList(SystemLoginHistoryReqDto param);

	void addServiceReqLog(SystemServiceReqLogReqDto param);

	List<SystemPiMaskDecListResDto> getPiMaskDecList(SystemLoginHistoryReqDto param);

	List<SystemPiMaskDecListResDto> getPiMaskDecExcelDn(SystemLoginHistoryReqDto param);

	List<SystemCondLogHistoryResDto> selectCondLogTestList(SystemLoginHistoryReqDto param);

	SystemCondLogHistoryResDto clearMaskCondLogHistList(SystemLoginHistoryReqDto param);

	List<SystemLoginHistoryResDto> excelDownLoginHistoryList(SystemLoginHistoryReqDto param);

}
