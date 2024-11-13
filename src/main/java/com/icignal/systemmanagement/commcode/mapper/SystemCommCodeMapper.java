package com.icignal.systemmanagement.commcode.mapper;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCondListRequestDTO;
import com.icignal.systemmanagement.commcode.dto.request.SystemCommCodeExGridReqDto;
import com.icignal.systemmanagement.commcode.dto.request.SystemCommCodeExReqDto;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCondListResponseDTO;
import com.icignal.systemmanagement.commcode.dto.response.SystemCommCodeExCountryItemResDto;
import com.icignal.systemmanagement.commcode.dto.response.SystemCommCodeExGridResDto;


public interface SystemCommCodeMapper {

	List<MKTCommonCondListResponseDTO> selectCommCondList(MKTCommonCondListRequestDTO reqDto);

	List<MKTCommonCodeResponseDTO> getCommCodeGridList(MKTCommonCodeRequestDTO reqDto);

	List<MKTCommonCodeResponseDTO> getCommCodeList(MKTCommonCodeRequestDTO reqDto);

	List<SystemCommCodeExGridResDto> selectCommCodeExGroupList(SystemCommCodeExGridReqDto reqDto);

	List<SystemCommCodeExGridResDto> selectCommCodeExSubList(SystemCommCodeExGridReqDto reqDto);

	List<SystemCommCodeExGridResDto> selectCommCodeExParCodeList(SystemCommCodeExGridReqDto reqDto);

	Integer selectCommCodeExGroupCheck(SystemCommCodeExReqDto reqDto);

	void insertCommCodeExNewCode(SystemCommCodeExReqDto reqDto);

	Integer selectCommCodeExCodeNameCheck(SystemCommCodeExReqDto reqDto);

	Integer selectCommCodeExCodeNameCheckWithLang(SystemCommCodeExReqDto reqDto);

	void insertCommCodeExCodeExtend(SystemCommCodeExReqDto reqDto);

	List<SystemCommCodeExGridResDto> selectCommCodeExSubListNotGrid(SystemCommCodeExGridReqDto param);

	void updateCommCodeExGroupName(SystemCommCodeExReqDto reqDto);

	void updateCommCodeExCodeProperty(SystemCommCodeExReqDto reqDto);

	void updateCommCodeExCodeAttribProperty(SystemCommCodeExReqDto reqDto);

	void updateCommCodeExGroupCodeDel(SystemCommCodeExReqDto reqDto);

	void updateCommCodeExCodeNameDel(SystemCommCodeExReqDto reqDto);

	List<SystemCommCodeExCountryItemResDto> selectCommCodeExCountryCode(MKTBaseReqDto reqDto);
	
	public MKTCommonCodeResponseDTO selectCommCodeDetail(MKTCommonCodeRequestDTO reqDto);

	List<MKTCommonCodeResponseDTO> getParIdNullCodeList(MKTCommonCodeRequestDTO reqDto);

	List<SystemCommCodeExGridResDto> selectReportBrandList(MKTCommonCodeRequestDTO reqDto);

}
