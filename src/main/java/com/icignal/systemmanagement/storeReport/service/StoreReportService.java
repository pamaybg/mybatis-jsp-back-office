package com.icignal.systemmanagement.storeReport.service;


import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.systemmanagement.alert.dto.request.SystemAlertListReqDto;
import com.icignal.systemmanagement.alert.dto.response.SystemAlertListResDto;
import com.icignal.systemmanagement.storeReport.dto.request.StoreReportHistoryReqDto;
import com.icignal.systemmanagement.storeReport.dto.response.StoreReportHistoryResDto;
import com.icignal.systemmanagement.storeReport.mapper.StoreReportMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;


/*
 * 1. 클래스명	: StoreReportService
 * 2. 파일명	: StoreReportService.java
 * 3. 패키지명	: com.icignal.systemmanagement.storeReport.service
 * 4. 작성자명	: bg.yoon
 * 5. 작성일자	: 2020. 2. 28.
 */

/**
 * <PRE>
 * 1. 설명
 *		매장용 리포트 조회 이력 Service
 * </PRE>
 */ 
@Service("StoreReportSerivce")
public class StoreReportService {
	
	@Autowired
	private StoreReportMapper storeReportMapper;


	/*
	 * 1. 메소드명: addStoreReportHist
	 * 2. 클래스명: SystemLogSerivce
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 2. 28.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		매장용 리포트 메뉴 조회 이력 추가
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */
	public StatusResDto addStoreReportHist(StoreReportHistoryReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		if(param.getProgramNo() != null) {
			storeReportMapper.addStoreReportLog(param);
			rtnValue.setSuccess(true);
		}
		else{
			rtnValue.setSuccess(false);
		}

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getStoreReportHistList
	 * 2. 클래스명: SystemLogSerivce
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 2. 28.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		매장용 리포트 조회 이력 리스트
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */
	public GridPagingResDto<StoreReportHistoryResDto> getStoreReportHistList(StoreReportHistoryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<StoreReportHistoryResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), storeReportMapper.selectStoreReportHistoryList(reqDto), AnnotationHelper.AnnotationType.CommCode);
	}

	/*
	 * 1. 메소드명: getStoreReportHistListForExcel
	 * 2. 클래스명: SystemLogSerivce
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 3. 7.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		매장용 리포트 조회 이력 리스트 (엑셀)
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */
	public GridPagingResDto<StoreReportHistoryResDto> getStoreReportHistListForExcel(StoreReportHistoryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<StoreReportHistoryResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), storeReportMapper.selectStoreReportHistoryListForExcel(reqDto), AnnotationHelper.AnnotationType.CommCode);
	}


}
