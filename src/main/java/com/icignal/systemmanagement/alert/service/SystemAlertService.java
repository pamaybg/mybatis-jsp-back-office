package com.icignal.systemmanagement.alert.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.alert.dto.request.SystemAlertListReqDto;
import com.icignal.systemmanagement.alert.dto.response.SystemAlertDetailResDto;
import com.icignal.systemmanagement.alert.dto.response.SystemAlertListResDto;
import com.icignal.systemmanagement.alert.mapper.SystemAlertMapper;

@Service
public class SystemAlertService {

	@Autowired
	private SystemAlertMapper systemAlertMapper;

	public GridPagingResDto<SystemAlertListResDto> getSystemAlertList(SystemAlertListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<SystemAlertListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemAlertMapper.selectSystemAlertList(reqDto), AnnotationType.CommCode);
	}
	
	public SystemAlertDetailResDto getSystemAlertDetail(SystemAlertListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
	    return new AnnotationHelper<SystemAlertDetailResDto>(AnnotationType.ALL, systemAlertMapper.selectSystemAlertDetail(reqDto)).getItem();
	}
	
}
