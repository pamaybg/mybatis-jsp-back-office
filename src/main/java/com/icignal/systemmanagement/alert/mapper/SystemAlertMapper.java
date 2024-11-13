package com.icignal.systemmanagement.alert.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.alert.dto.request.SystemAlertListReqDto;
import com.icignal.systemmanagement.alert.dto.response.SystemAlertDetailResDto;
import com.icignal.systemmanagement.alert.dto.response.SystemAlertListResDto;

@Mapper
public interface SystemAlertMapper {

	List<SystemAlertListResDto> selectSystemAlertList(SystemAlertListReqDto reqDto);

	SystemAlertDetailResDto selectSystemAlertDetail(SystemAlertListReqDto reqDto);

}
