package com.icignal.systemmanagement.storeReport.mapper;

import com.icignal.systemmanagement.storeReport.dto.request.StoreReportHistoryReqDto;
import com.icignal.systemmanagement.storeReport.dto.response.StoreReportHistoryResDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/*
 * 1. 클래스명	: StoreReportMapper
 * 2. 파일명	: StoreReportMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.storeReport.mapper
 * 4. 작성자명	: bg.yoon
 * 5. 작성일자	: 2022. 2. 28.
 */

/**
 * <PRE>
 * 1. 설명
 *		매장용 리포트 조회 이력 Mapper
 * </PRE>
 */ 
@Mapper
public interface StoreReportMapper {

	void addStoreReportLog(StoreReportHistoryReqDto param);

	List<StoreReportHistoryResDto> selectStoreReportHistoryList(StoreReportHistoryReqDto reqDto);

	List<StoreReportHistoryResDto> selectStoreReportHistoryListForExcel(StoreReportHistoryReqDto reqDto);
}
