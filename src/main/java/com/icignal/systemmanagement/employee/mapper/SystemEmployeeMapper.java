package com.icignal.systemmanagement.employee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.auth.dto.response.GetUserPwdInfoResDto;
import com.icignal.systemmanagement.employee.dto.request.SystemDeleteAuthGroupByRidReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemEmployeeDeleteReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemEmployeeDetailReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemEmployeeInfoReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemEmployeeReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemGetAuthGroupListByEIRUReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemGetIpAccessControlListReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemGetUserDetailRequestDto;
import com.icignal.systemmanagement.employee.dto.request.SystemGetUserListByEIRequestDto;
import com.icignal.systemmanagement.employee.dto.request.SystemInsertAuthGroupAndEmpIdReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemSetIpAccessControlReqDto;
import com.icignal.systemmanagement.employee.dto.request.SystemUserDetailReqDto;
import com.icignal.systemmanagement.employee.dto.response.SystemEmployeeItemDto;
import com.icignal.systemmanagement.employee.dto.response.SystemEmployeePopUpResDto;
import com.icignal.systemmanagement.employee.dto.response.SystemEmployeeResDto;
import com.icignal.systemmanagement.employee.dto.response.SystemGetAuthGroupListByEIRUResDto;
import com.icignal.systemmanagement.employee.dto.response.SystemGetIpAccessControlListResDto;
import com.icignal.systemmanagement.employee.dto.response.SystemGetUserDetailResDto;
import com.icignal.systemmanagement.employee.dto.response.SystemGetUserListByEIResDto;

@Mapper
public interface SystemEmployeeMapper {

	public void deleteEmployee(SystemEmployeeDeleteReqDto edr);

	public void deleteEmpId(SystemEmployeeDeleteReqDto edr);

	public int deleteEmpAccRel(SystemEmployeeDeleteReqDto edr);

	public List<SystemGetAuthGroupListByEIRUResDto> getAuthGroupListByEmpIdAndRidUser(SystemGetAuthGroupListByEIRUReqDto plr);

	public List<SystemGetUserListByEIResDto> getUserListByEmpId(SystemGetUserListByEIRequestDto plr);

	public List<SystemEmployeeItemDto> selectEmployeeList(SystemEmployeeReqDto ber);

	public List<SystemGetIpAccessControlListResDto> selectIpAccessControlList(SystemGetIpAccessControlListReqDto plr);

	public void insertIpAccessControlHist(SystemSetIpAccessControlReqDto plr);

	public void deleteIpAccessControl(SystemSetIpAccessControlReqDto plr);

	public void deleteAuthGroupByRid(SystemDeleteAuthGroupByRidReqDto darr);

	public void deleteUserDetail(SystemUserDetailReqDto bpdr);

	public void deleteUserByEmpId(SystemEmployeeDeleteReqDto edr);

	public void deleteAuthUserDetailByRid(SystemUserDetailReqDto bpdr);

	public void deleteAuthUserDetailByEmpId(SystemEmployeeDeleteReqDto bpdr);

	public SystemEmployeeResDto selectEmployeeDetail(SystemEmployeeDetailReqDto ber);

	//public MKTOrganizationDetailResponseDTO getOrganizationDetail(MKTOrganizationDetailRequestDTO dto);

	public Integer isEmpEmailExist(SystemEmployeeInfoReqDto eir);

	public Integer isEmpNoExist(SystemEmployeeInfoReqDto eir);

	public void insertEmployee(SystemEmployeeInfoReqDto eir);

	public void insertEmpAccRel(SystemEmployeeInfoReqDto eir);

	public void updateEmployee(SystemEmployeeInfoReqDto bur);

	public SystemGetIpAccessControlListResDto selectIpAccessControlDetail(SystemSetIpAccessControlReqDto plr);

	public void updateIpAccessControl(SystemSetIpAccessControlReqDto plr);

	public List<SystemGetIpAccessControlListResDto> selectIpAccessControlHistList(SystemGetIpAccessControlListReqDto plr);

	public List<SystemGetAuthGroupListByEIRUResDto> getAuthGroupListByRidUser(SystemGetAuthGroupListByEIRUReqDto plr);

	public void insertAuthGroupAndEmpId(SystemInsertAuthGroupAndEmpIdReqDto bpdr);

	public SystemGetUserDetailResDto getUserDetail(SystemGetUserDetailRequestDto plr);

	public List<SystemEmployeePopUpResDto> selectEmployeePopUp(SystemEmployeeReqDto mer);


	public Integer isUserIdExist(SystemUserDetailReqDto bpdr);

	public GetUserPwdInfoResDto selectUserPwdInfo(SystemUserDetailReqDto bpdr);

	public void updateUserPwd(SystemUserDetailReqDto bpdr);

	public void updateUserDetail(SystemUserDetailReqDto bpdr);

	public void insertUserDetail(SystemUserDetailReqDto bpdr);

	public String checkDivision(SystemEmployeeInfoReqDto bur);

//	public List<SystemEmployeeResDto> selectEmpAuthGroupList(SystemEmployeeInfoReqDto bur);

	public void deleteEmpAuthGroupList(SystemEmployeeInfoReqDto bur);

	public void insertEmpGuestGroup(SystemEmployeeInfoReqDto bur);

	public void insertActiveUserLoginHist(SystemUserDetailReqDto bpdr);

	 /*
	  * 1. 메소드명: selectUserBePwd
	  * 2. 클래스명: SystemEmployeeMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 11. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bpdr
	 *   @return	
	 */
	
	public List<String> selectUserBePwd(SystemUserDetailReqDto bpdr);

	 /*
	  * 1. 메소드명: insertUserPwd
	  * 2. 클래스명: SystemEmployeeMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 11. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bpdr	
	 */
	
	public void insertUserPwd(SystemUserDetailReqDto bpdr);

	public void insertIpAccessControl(SystemSetIpAccessControlReqDto plr);


    String selectOneCrmUserId(String rid);

	List<SystemEmployeeItemDto> selectReportBrandStoreList(SystemEmployeeReqDto reqDto);

}
