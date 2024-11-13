package com.icignal.systemmanagement.organization.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.organization.dto.request.SystemModifyOrganizationReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemOrganizationDetailReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemOrganizationInfoListReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemOrganizationListReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemOrganziationNodeListReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemSetOrganizationReqDto;
import com.icignal.systemmanagement.organization.dto.response.SystemOrganizationDetailResDto;
import com.icignal.systemmanagement.organization.dto.response.SystemOrganizationInfoListResDto;
import com.icignal.systemmanagement.organization.dto.response.SystemOrganizationListResDto;
import com.icignal.systemmanagement.organization.dto.response.SystemOrganizationLvlResDto;
import com.icignal.systemmanagement.organization.dto.response.SystemOrganizationNodeListResDto;

@Mapper
public interface SystemOrganizationMapper {

	List<SystemOrganizationListResDto> getOrganizationList(SystemOrganizationListReqDto dto);

	SystemOrganizationDetailResDto getOrganizationDetail(SystemOrganizationDetailReqDto dto);

	String getDivLvlByRidParDiv(String ridParDiv);

	SystemOrganizationLvlResDto getRidLvlByRidParDiv(String ridParDiv);

	void insertOrganization(SystemSetOrganizationReqDto dto);

	void updateOrganization(SystemModifyOrganizationReqDto dto);

	List<SystemOrganizationInfoListResDto> getOrganizationInfoList(SystemOrganizationInfoListReqDto dto);
	
	List<SystemOrganizationNodeListResDto> selectNodeList(SystemOrganziationNodeListReqDto nlr);



}
