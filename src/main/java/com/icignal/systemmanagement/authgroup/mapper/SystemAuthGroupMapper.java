package com.icignal.systemmanagement.authgroup.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.authgroup.dto.request.AuthAuthModalReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthGroupDeleteReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthGroupDetailReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthGroupEmployeeModalReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthGroupEmployeeReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthGroupInsertReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthGroupListReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthInsertAuthReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.AuthInsertEmployeeReqDto;
import com.icignal.systemmanagement.authgroup.dto.request.DeleteAuthGroupDetailReqDto;
import com.icignal.systemmanagement.authgroup.dto.response.AuthAuthModalResDto;
import com.icignal.systemmanagement.authgroup.dto.response.AuthGroupDetailResDto;
import com.icignal.systemmanagement.authgroup.dto.response.AuthGroupEmployeeModalResDto;
import com.icignal.systemmanagement.authgroup.dto.response.AuthGroupEmployeeResDto;
import com.icignal.systemmanagement.authgroup.dto.response.AuthGroupListResDto;

@Mapper
public interface SystemAuthGroupMapper {

	public void deleteGroupEmpList(AuthGroupDeleteReqDto reqDto);

	public void deleteGroupAuthAllList(AuthGroupDeleteReqDto reqDto);

	public void deleteAuthGroupList(AuthGroupDeleteReqDto reqDto);

	public String selectAuthGroupNm(String string);

	public void insertGroupDetail(AuthGroupInsertReqDto reqDto);

	public void updateGroupDetail(AuthGroupInsertReqDto reqDto);

	public String selectEmpNm(String string);

	public void deleteEmpList(DeleteAuthGroupDetailReqDto reqDto);

	public void deleteGroupAuthList(DeleteAuthGroupDetailReqDto reqDto);

	public AuthGroupDetailResDto getAuthGroupDetailNew(AuthGroupDetailReqDto reqDto);

	public String selectAuthNm(String string);

	public List<AuthGroupListResDto> getAuthGroupList(AuthGroupListReqDto reqDto);

	public List<AuthGroupEmployeeResDto> getAuthEmpList(AuthGroupEmployeeReqDto reqDto);

	public List<AuthAuthModalResDto> getAuthGroupAuthList(AuthAuthModalReqDto reqDto);

	public List<AuthAuthModalResDto> getAuthAddListModal(AuthAuthModalReqDto reqDto);

	public List<AuthGroupEmployeeModalResDto> getEmpAddListModal(AuthGroupEmployeeModalReqDto reqDto);

	public void addEmpList(AuthInsertEmployeeReqDto reqDto);

	public void addAuthList(AuthInsertAuthReqDto reqDto);

	
	
}
