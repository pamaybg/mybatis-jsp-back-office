package com.icignal.systemmanagement.object.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.object.dto.request.SystemDeleteObjectListReqDto;
import com.icignal.systemmanagement.object.dto.request.SystemGetObjectDetailReqDto;
import com.icignal.systemmanagement.object.dto.request.SystemGetUIObjectDetailReqDto;
import com.icignal.systemmanagement.object.dto.request.SystemInsertObjectDetailReqDto;
import com.icignal.systemmanagement.object.dto.request.SystemUIObjectListReqDto;
import com.icignal.systemmanagement.object.dto.response.SystemGetObjectDetailResDTO;
import com.icignal.systemmanagement.object.dto.response.SystemGetUIObjectDetailResDto;
import com.icignal.systemmanagement.object.dto.response.SystemUIObjectListResDto;
import com.icignal.systemmanagement.program.dto.request.SystemDeleteUIObjectListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemInsertUIObjectDetailReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemObjectListReqDto;
import com.icignal.systemmanagement.program.dto.response.SystemObjectListResDto;

@Mapper
public interface SystemObjectMapper {

	public List<SystemObjectListResDto> getObjectList(SystemObjectListReqDto reqDto);

	public Integer isObjCdExist(SystemInsertObjectDetailReqDto reqDto);

	public void insertObjectDetail(SystemInsertObjectDetailReqDto reqDto);

	public SystemGetObjectDetailResDTO getObjectDetail(SystemGetObjectDetailReqDto reqDto);

	public void updateObjectDetail(SystemInsertObjectDetailReqDto reqDto);

	public void deleteObjectList(SystemDeleteObjectListReqDto reqDto);

	public void deleteUIObjectListByObjectList(SystemDeleteObjectListReqDto reqDto);

	public void insertUIObjectDetail(SystemInsertUIObjectDetailReqDto reqDto);

	public SystemGetUIObjectDetailResDto getUIObjectDetail(SystemGetUIObjectDetailReqDto reqDto);

	public void deleteUIObjectList(SystemDeleteUIObjectListReqDto reqDto);

	public void updateUIObjectDetail(SystemInsertUIObjectDetailReqDto reqDto);

	public List<SystemUIObjectListResDto> getUIObjectList(SystemUIObjectListReqDto reqDto);

	public List<SystemUIObjectListResDto> getObjectCode(SystemUIObjectListReqDto reqDto);

}
