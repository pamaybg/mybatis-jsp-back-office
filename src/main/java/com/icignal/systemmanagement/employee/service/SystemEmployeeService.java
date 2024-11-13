package com.icignal.systemmanagement.employee.service;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;

import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.auth.dto.response.GetUserPwdInfoResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthLogInsertReqDto;
import com.icignal.systemmanagement.auth.service.SystemAuthService;
import com.icignal.systemmanagement.authgroup.mapper.SystemAuthGroupMapper;
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
import com.icignal.systemmanagement.employee.mapper.SystemEmployeeMapper;

@Service
public class SystemEmployeeService {

	@Autowired
	SystemEmployeeMapper systemEmployeeMapper;

	@Autowired
	SystemAuthGroupMapper systemAuthGroupMapper;

	@Autowired
	SystemAuthService systemAuthService;

	@Autowired
	CommonService commonService;

	public StatusResDto deleteEmployee(SystemEmployeeDeleteReqDto edr) {
		LogUtil.param(this.getClass(), edr);

		StatusResDto rtnValue = new StatusResDto();

		systemEmployeeMapper.deleteEmployee(edr);
		systemEmployeeMapper.deleteUserByEmpId(edr);
		systemEmployeeMapper.deleteAuthUserDetailByEmpId(edr);

		rtnValue.setSuccess(true);

		return rtnValue;
	}

	public GridPagingResDto<SystemGetAuthGroupListByEIRUResDto> getAuthGroupListByEmpIdAndRidUser(
			SystemGetAuthGroupListByEIRUReqDto plr) {
		LogUtil.param(this.getClass(), plr);

		plr.setSVCAlias("aur");

		return new GridPagingResHelper<SystemGetAuthGroupListByEIRUResDto>().newGridPagingResDto(
				plr.init(CommonUtil.getInstance().getDBType()),
				systemEmployeeMapper.getAuthGroupListByEmpIdAndRidUser(plr));
	}

	public GridPagingResDto<SystemGetUserListByEIResDto> getUserListByEmpId(SystemGetUserListByEIRequestDto plr) {
		LogUtil.param(this.getClass(), plr);

		plr.setSVCAlias("cu");

		return new GridPagingResHelper<SystemGetUserListByEIResDto>().newGridPagingResDto(
				plr.init(CommonUtil.getInstance().getDBType()), systemEmployeeMapper.getUserListByEmpId(plr));
	}

	public GridPagingResDto<SystemEmployeeItemDto> selectEmployeeList(SystemEmployeeReqDto ber) {
		
		LogUtil.param(this.getClass(), ber);
		
		SystemEmployeeReqDto orgId = new SystemEmployeeReqDto();
		orgId.setRidDivision(ber.getStoreId());
		orgId.setComSchemas(ber.getComSchemas());
 
		//ber.setDivisionList(this.queryForList("MKTEmployee.selectSubDivList",orgId));this.update("MKTEmployee.selectSubDivList", orgId);
  
		ber.setSVCAlias("e");
  
		return new GridPagingResHelper<SystemEmployeeItemDto>().newGridPagingResDto(ber.init(CommonUtil.getInstance().getDBType()),
				systemEmployeeMapper.selectEmployeeList(ber),AnnotationType.CommCode); 
		}

	public GridPagingResDto<SystemGetIpAccessControlListResDto> getIpAccessControlList(SystemGetIpAccessControlListReqDto plr) {
		LogUtil.param(this.getClass(), plr);

		plr.setSVCAlias("a");

		return new GridPagingResHelper<SystemGetIpAccessControlListResDto>().newGridPagingResDto(
				plr.init(CommonUtil.getInstance().getDBType()), systemEmployeeMapper.selectIpAccessControlList(plr),AnnotationType.CommCode);
	}

	public StatusResDto removeIpAccessControl(SystemSetIpAccessControlReqDto plr) {
		LogUtil.param(this.getClass(), plr);

		// 현재 IP주소 세팅
		
		String host = ""; 
		try { host =
		InetAddress.getLocalHost().getHostAddress();
		}
		catch(UnknownHostException e)
		{
		LogUtil.error(e);
		}

		plr.setCreatorIpAddr(host);

		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);

		systemEmployeeMapper.insertIpAccessControlHist(plr);

		systemEmployeeMapper.deleteIpAccessControl(plr);

		rtnValue.setSuccess(true);

		return rtnValue;
	}

	//직원 관리 - 로그인 사용자 소유 권한 그룹 조회 삭제버튼
	public StatusResDto deleteAuthGroupByRid(SystemDeleteAuthGroupByRidReqDto darr) {
		LogUtil.param(this.getClass(), darr);

		StatusResDto rtnValue = new StatusResDto();

		//직원 관리 - 로그인 사용자 소유 권한 그룹 조회 삭제로그 쌓기
		SystemAuthLogInsertReqDto alir = new SystemAuthLogInsertReqDto();
		alir.setCreateBy(darr.getEmpId());
		alir.setAuthLogTypeCd(CommonUtil.COM_AUTH_LOG_TYPE_CD.AUTH.toString());
		alir.setLogTypeDtl(CommonUtil.LOG_TYPE_DTL.AUTH_GROUP_D.toString());
		alir.setObjRid(darr.getAutGroupId());
		alir.setObjNm(systemAuthGroupMapper.selectAuthGroupNm(darr.getAutGroupId()));
		systemAuthService.setAuthLog(alir);

		systemEmployeeMapper.deleteAuthGroupByRid(darr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}
	
	@Transactional
	public StatusResDto deleteUserDetail(SystemUserDetailReqDto bpdr) {
		LogUtil.param(this.getClass(), bpdr);
		/**
		 * 2019.01.24 hy.jun 사용자 변경이력 등록 - 사용자 / 삭제
		 */

		SystemAuthLogInsertReqDto alir = new SystemAuthLogInsertReqDto();
		alir.setCreateBy(bpdr.getCreateBy());
		alir.setAuthLogTypeCd(CommonUtil.COM_AUTH_LOG_TYPE_CD.USER.toString());
		alir.setLogTypeDtl(CommonUtil.LOG_TYPE_DTL.USER_D.toString());
		alir.setObjRid(bpdr.getRid());
		alir.setObjNm(systemAuthGroupMapper.selectEmpNm(bpdr.getRid()));
		systemAuthService.setAuthLog(alir);

		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);
		systemEmployeeMapper.deleteUserDetail(bpdr);
		systemEmployeeMapper.deleteAuthUserDetailByRid(bpdr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	public SystemEmployeeResDto selectEmployeeDetail(SystemEmployeeDetailReqDto ber) {
		LogUtil.param(this.getClass(), ber);

		ber.setSVCAlias("e");
		SystemEmployeeResDto resDto = systemEmployeeMapper.selectEmployeeDetail(ber);
		return new AnnotationHelper<SystemEmployeeResDto>(AnnotationType.PersonalData,resDto).getItem();
	}

	/*
	 * public MKTOrganizationDetailResponseDTO
	 * getOrganizationDetail(MKTOrganizationDetailRequestDTO dto) {
	 * LogUtil.param(this.getClass(), dto); return
	 * (MKTOrganizationDetailResponseDTO)
	 * systemEmployeeMapper.getOrganizationDetail(dto); }
	 */

	/**
	 * @name : insertEmployee
	 * @date : 2021. 12. 30.
	 * @author : quintet
	 * @return :
	 * @description : 직원관리 직원 생성
	 */
	public StatusResDto insertEmployee(SystemEmployeeInfoReqDto eir) {
		LogUtil.param(this.getClass(), eir);
  
		StatusResDto rtnValue = new StatusResDto();
  
		eir.setId(commonService.getRowID()); 
		Integer emailCompare = (Integer) systemEmployeeMapper.isEmpEmailExist(eir); 
		Integer empNoCompare = (Integer) systemEmployeeMapper.isEmpNoExist(eir); 
		
		if(emailCompare > 0){
			rtnValue.setSuccess(false); rtnValue.setMessage("MSG_1008"); } 
		else if(empNoCompare > 0) { 
			rtnValue.setSuccess(false);
			rtnValue.setMessage("MSG_3002"); } 
		else{ // String id = (String)/ this.insert("MKTEmployee.insertEmployee", eir); 
			//************ 김민준 수정************* 
			String id = eir.getId(); 
			eir.setEmployeeId(id);
			systemEmployeeMapper.insertEmployee(eir);
  
			rtnValue.setSuccess(true); } 
			
		return rtnValue; }

	/**
	 * @name : updateEmployee
	 * @date : 2021. 12. 30.
	 * @author : quintet
	 * @return :
	 * @description : 직원관리 직원상세 수정
	 */
	@Transactional
	public StatusResDto updateEmployee(SystemEmployeeInfoReqDto bur) {			
		LogUtil.param(this.getClass(), bur);
  
			StatusResDto rtnValue = new StatusResDto(); 
			//emailCompare -> DB에 이메일이 등록되있는지 확인, updateFlag -> 이메일을 수정하지 않았을 경우를 체크 
			Integer emailCompare = (Integer)systemEmployeeMapper.isEmpEmailExist(bur); 
			Integer empNoCompare = (Integer)systemEmployeeMapper.isEmpNoExist(bur); 
			//소속(부서)이 바뀔시 기존의 권한을 모두 해제한다.
			String devisionRid = systemEmployeeMapper.checkDivision(bur);
			
			if(emailCompare > 0){
				rtnValue.setSuccess(false); 
				rtnValue.setMessage("MSG_1008"); } 
			else if(empNoCompare > 0) { 
				rtnValue.setSuccess(false);
				rtnValue.setMessage("MSG_3002"); } 
			else if(!devisionRid.equals(bur.getRidDivision())) { 
				//List<String> authGroupList = systemEmployeeMapper.selectEmpAuthGroupList(bur);
				//직원이 속해있는 권한 그룹리스트
//				SystemEmployeeInfoReqDto authGroupList = new SystemEmployeeInfoReqDto();
//				GridPagingResDto<SystemEmployeeResDto> test; 
//						
//				test = new GridPagingResHelper<SystemEmployeeResDto>().newGridPagingResDto(
//								bur.init(CommonUtil.getInstance().getDBType()), systemEmployeeMapper.selectEmpAuthGroupList(bur));
				
//				new GridPagingResHelper<SystemGetIpAccessControlListResDto>().newGridPagingResDto(
//						plr.init(CommonUtil.getInstance().getDBType()), systemEmployeeMapper.selectIpAccessControlList(plr),AnnotationType.CommCode)
				//authGroupList.setEmpAuthGroupList();
				//직원이 속해있는 권한 그룹 해지
//				for(String a : authGroupList) {
//					String test = a;
//					test2.add(test);
//				}
//				List<SystemEmployeeInfoReqDto> agl = authGroupList;
//				for(int i=0 ; i<authGroupList.size(); i++) {
//					test2.add(authGroupList.get(i));
//				}
				
				//List<String> a = null;
//				for(int i=0; i<test.getRows().size(); i++) {
//					String T = test.getRows().get(i).getEmpAuthGroup();
//					bur.setEmpAuthGroup(T);
//					
//				}
				
				
				systemEmployeeMapper.deleteEmpAuthGroupList(bur);
				//게스트 권한 넣어주기
				systemEmployeeMapper.insertEmpGuestGroup(bur);
				rtnValue.setSuccess(true);
				rtnValue.setMessage("모든 권한이 해지되고 게스트 권한으로 변경되었습니다.");
				//권한 해제이력
//				SystemAuthLogInsertReqDto alir = new SystemAuthLogInsertReqDto();
//				alir.setCreateBy(bur.getCreateBy());
//				alir.setAuthLogTypeCd(CommonUtil.COM_AUTH_LOG_TYPE_CD.AUTH_GROUP.toString());
//				alir.setLogTypeDtl(CommonUtil.LOG_TYPE_DTL.USER_R.toString());
//				alir.setTargetRid(bur.getAuthGroupId());
//				alir.setTargetNm(systemAuthGroupMapper.selectAuthGroupNm(bur.getAuthGroupId()));
//				alir.setObjRid(bur.getRidCrmUserList());
//				alir.setObjNm(systemAuthGroupMapper.selectEmpNm(bur.getRidCrmUserList()));
//				systemAuthService.setAuthLog(alir);
				
				
				bur.setSVCAlias("e");
				systemEmployeeMapper.updateEmployee(bur); 
				rtnValue.setSuccess(true); 
				
			} else{ 
				
				bur.setSVCAlias("e");
			systemEmployeeMapper.updateEmployee(bur); 
			rtnValue.setSuccess(true); 
			
			}

			return rtnValue; 
			}

	public SystemGetIpAccessControlListResDto getIpAccessControlDetail(SystemSetIpAccessControlReqDto plr) {
		LogUtil.param(this.getClass(), plr);

		SystemGetIpAccessControlListResDto rtnValue = new SystemGetIpAccessControlListResDto();

		rtnValue = (SystemGetIpAccessControlListResDto) systemEmployeeMapper.selectIpAccessControlDetail(plr);

		return rtnValue;
	}

	public StatusResDto modifyIpAccessControl(SystemSetIpAccessControlReqDto plr) {
		LogUtil.param(this.getClass(), plr);

		// 현재 IP주소 세팅 
		String host = ""; 
		try { host = InetAddress.getLocalHost().getHostAddress();
		}
		catch(UnknownHostException e)
		{
		LogUtil.error(e);
		}
		
		plr.setCreatorIpAddr(host);
		
		StatusResDto rtnValue = new StatusResDto();
		
		rtnValue.setSuccess(false);
		
		systemEmployeeMapper.insertIpAccessControlHist(plr);
		systemEmployeeMapper.updateIpAccessControl(plr);
		
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	public StatusResDto setIpAccessControl(SystemSetIpAccessControlReqDto plr) {
		LogUtil.param(this.getClass(), plr);

		String host = "";
		try {
			host = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			LogUtil.error(e);
		}

		plr.setCreatorIpAddr(host);

		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);

		systemEmployeeMapper.insertIpAccessControlHist(plr);

		systemEmployeeMapper.insertIpAccessControl(plr);

		rtnValue.setSuccess(true);

		return rtnValue;
	}

	public GridPagingResDto<SystemGetIpAccessControlListResDto> getIpAccessControlHistList(SystemGetIpAccessControlListReqDto plr) {
		LogUtil.param(this.getClass(), plr);
		plr.setSVCAlias("a");
		return new GridPagingResHelper<SystemGetIpAccessControlListResDto>().newGridPagingResDto(
				plr.init(CommonUtil.getInstance().getDBType()), systemEmployeeMapper.selectIpAccessControlHistList(plr));

	}

	public GridPagingResDto<SystemGetAuthGroupListByEIRUResDto> getAuthGroupListByRidUser(SystemGetAuthGroupListByEIRUReqDto plr) {
		LogUtil.param(this.getClass(), plr);
		plr.setSVCAlias("ag");
		return new GridPagingResHelper<SystemGetAuthGroupListByEIRUResDto>().newGridPagingResDto(
				plr.init(CommonUtil.getInstance().getDBType()), systemEmployeeMapper.getAuthGroupListByRidUser(plr));
	}

	//직원 관리 - 로그인 사용자 소유 권한 그룹 신규 추가
	public StatusResDto insertAuthGroupAndEmpId(SystemInsertAuthGroupAndEmpIdReqDto bpdr) {
		LogUtil.param(this.getClass(), bpdr);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		//직원 관리 - 로그인 사용자 소유 권한 그룹 신규 로그 쌓기
		SystemAuthLogInsertReqDto alir = new SystemAuthLogInsertReqDto();
		alir.setCreateBy(bpdr.getCreateBy());
		alir.setAuthLogTypeCd(CommonUtil.COM_AUTH_LOG_TYPE_CD.AUTH.toString());
		alir.setLogTypeDtl(CommonUtil.LOG_TYPE_DTL.AUTH_GROUP_C.toString());
		alir.setObjRid(bpdr.getAutGroupId());
		alir.setObjNm(systemAuthGroupMapper.selectAuthGroupNm(bpdr.getAutGroupId()));
		systemAuthService.setAuthLog(alir);

		systemEmployeeMapper.insertAuthGroupAndEmpId(bpdr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	public SystemGetUserDetailResDto getUserDetail(SystemGetUserDetailRequestDto plr) {
		LogUtil.param(this.getClass(), plr);
		SystemGetUserDetailResDto rtnValue = new SystemGetUserDetailResDto();

		plr.setSVCAlias("o");
		rtnValue = (SystemGetUserDetailResDto) systemEmployeeMapper.getUserDetail(plr);

		return rtnValue;
	}

	/**
	 * @name : updateEmployee
	 * @date : 2021. 12. 30.
	 * @author : quintet
	 * @return :
	 * @description : 직원관리 로그인 사용자 신규등록
	 */
	@Transactional
	public StatusResDto insertUserDetail(SystemUserDetailReqDto bpdr) {
		LogUtil.param(this.getClass(), bpdr);
		
		StatusResDto rtnValue = new StatusResDto();
  
		//RID 채번 
		String rid = commonService.getRowID(); 
		bpdr.setRid(rid);
  //
		//변경할 비밀번호 유효성 검사(공통) 
		rtnValue = checkPwdPolicies(bpdr.getUserPw(),rtnValue); 
  
		if( rtnValue.getMessage() != null ){ return rtnValue; }
  
		if( bpdr.getUserPw().contains(bpdr.getUserId()) ){ 
			//변경할 비밀번호에 로그인 사용자 아이디가 포함된 경우 
			rtnValue.setMessage("3"); 
			rtnValue.setSuccess(false);
			return rtnValue; 
			}
		else if( bpdr.getUserPw().contains(bpdr.getEmpNo()) ){
			//직원일 경우, 변경할 비밀번호에 사번이 포함된 경우
			rtnValue.setMessage("4");
			rtnValue.setSuccess(false);
			
			return rtnValue;
		}
		
		//비밀번호 만료일자 설정 		
		bpdr.setPwdChangeTerm(BeansUtil.getApplicationProperty("icignal.login.password.limit-day"));
  
		try { bpdr.setUserPw(SecurityUtil.encodePassword(bpdr.getUserPw())); } 
		catch(IllegalArgumentException e) 
		{ LogUtil.error(e); }// 변수에 패스워드 값을 단방향 암호화하여 저장
		 
		Integer userId = (Integer)systemEmployeeMapper.isUserIdExist(bpdr); 
		if(userId <= 0){ 
			rtnValue.setMessage("1"); 
			systemEmployeeMapper.insertUserDetail(bpdr); 
			bpdr.setRidCrmuser(bpdr.getRid());
			bpdr.setRid(CommonUtil.newRid());
			systemEmployeeMapper.insertUserPwd(bpdr); 
			rtnValue.setSuccess(true); 
			}
		else{ rtnValue.setSuccess(true); 
		}
		
		/**
		 * 2019.01.24 hy.jun 사용자 변경이력 등록 - 사용자 / 삭제
		 */
		
		SystemAuthLogInsertReqDto alir = new SystemAuthLogInsertReqDto();
		alir.setCreateBy(bpdr.getCreateBy());
		alir.setAuthLogTypeCd(CommonUtil.COM_AUTH_LOG_TYPE_CD.USER.toString());
		alir.setLogTypeDtl(CommonUtil.LOG_TYPE_DTL.USER_C.toString());
		alir.setObjRid(rid); 
		alir.setObjNm(systemAuthGroupMapper.selectEmpNm(rid)); 
		
		return rtnValue; 
		
	}

	public StatusResDto updateUserDetail(SystemUserDetailReqDto bpdr) {
		LogUtil.param(this.getClass(), bpdr); 
		StatusResDto rtnValue = new StatusResDto();
		
		//변경할 비밀번호가 있을 때 
		if( bpdr.getUserPw() != null ){
			GetUserPwdInfoResDto rtnValue2 = new GetUserPwdInfoResDto();
			
			//변경할 비밀번호 유효성 검사(공통) 
			rtnValue = checkPwdPolicies(bpdr.getUserPw(),rtnValue);
			
			if( rtnValue.getMessage() != null ){ 
				return rtnValue; 
				}
			//로그인 사용자 아이디 정보로 비밀번호 정보 조회 
			rtnValue2 = systemEmployeeMapper.selectUserPwdInfo(bpdr);
			
			bpdr.setPwdCheckCnt((BeansUtil.getApplicationProperty("icignal.login.password.check-cnt")));
			List<String> rtnValue3 = systemEmployeeMapper.selectUserBePwd(bpdr);
			
			if( bpdr.getUserPw().contains(rtnValue2.getUserId()) ){
				//변경할 비밀번호에 로그인 사용자아이디가 포함된 경우 
				rtnValue.setMessage("3");
				rtnValue.setSuccess(false);
				return rtnValue; 
				}
			else if( bpdr.getUserPw().contains(rtnValue2.getEmpNo()) ){
				//직원일 경우, 변경할 비밀번호에 사번이 포함된 경우 
				rtnValue.setMessage("4");
				rtnValue.setSuccess(false);
				return rtnValue; 
				}
			//변수에 패스워드 값을 단방향 암호화하여 저장 
			
			try { bpdr.setUserPw(SecurityUtil.encodePassword(bpdr.getUserPw())); }
			catch(IllegalArgumentException e){
				LogUtil.error(e);
				rtnValue.setMessage("암호화 실패");
				rtnValue.setSuccess(false);
				
				return rtnValue;
			}
			
			// 로그인 사용자 비밀번호 비교 
			if( rtnValue2.getUserPw() != null && bpdr.getUserPw().equals(rtnValue2.getUserPw())){ 
				// 변경할 비밀번호가 현재 비밀번호와 같은 경우
				rtnValue.setMessage("2-1");
				rtnValue.setSuccess(false);
				return rtnValue;
			}

			for(String pwd : rtnValue3) {
				int idx=2;
				//변경할 비밀번호가 이전 비밀번호들과 같은 경우
				if( bpdr.getUserPw().equals(pwd)){
					rtnValue.setMessage("2-"+idx);
					rtnValue.setSuccess(false);
					return rtnValue;
				}
				idx++;
			}
			// 로그인 사용자 비밀번호 변경 세팅 
			if( rtnValue2.getUserPw() != null ){
				bpdr.setPreUserPw(rtnValue2.getUserPw());
				/*bpdr.setUserPwBef1(rtnValue2.getUserPw());*/
			}

			// 위의 조건 만족 시, 로그인 사용자 비밀번호 변경 
			
			bpdr.setByAdmin(true); //첫 로그인 설정 필요여부
			
			// 비밀번호 만료일자 설정 
			bpdr.setPwdChangeTerm(BeansUtil.getApplicationProperty("icignal.login.password.limit-day"));

			rtnValue.setSuccess(false);
			
			//관리자가 비밀번호 변경할 경우 첫 로그인 시 비밀번호 변경 필수
			if(bpdr.isByAdmin()) {
				bpdr.setFirstLoginFlg("1");
			} else {
				bpdr.setFirstLoginFlg("0");
			}
			systemEmployeeMapper.updateUserPwd(bpdr);
			bpdr.setRid(CommonUtil.newRid());
			systemEmployeeMapper.insertUserPwd(bpdr);
			rtnValue.setSuccess(true);

		}
		//hr.noh 사용자 정보 수정시 USER ID 중복 확인 로직 2022.02.08
		String crmUserId = systemEmployeeMapper.selectOneCrmUserId(bpdr.getRid());
		if(ObjectUtils.isNotEmpty(crmUserId) && crmUserId.equals(bpdr.getUserId())){

			rtnValue.setMessage("1");
			systemEmployeeMapper.updateUserDetail(bpdr);
			rtnValue.setSuccess(true);

		}else{
			Integer userId = (Integer) systemEmployeeMapper.isUserIdExist(bpdr);

			if(userId<=0){
				rtnValue.setMessage("1");
				systemEmployeeMapper.updateUserDetail(bpdr);
				rtnValue.setSuccess(true);
			}else{
				rtnValue.setSuccess(false);
			}
		}


		

		return rtnValue;
	}

	public GridPagingResDto<SystemEmployeePopUpResDto> selectEmployeePopUp(SystemEmployeeReqDto mer) {
		LogUtil.param(this.getClass(), mer);
		
		SystemEmployeeReqDto orgId = new SystemEmployeeReqDto();
		orgId.setRidDivision(mer.getStoreId());
		orgId.setComSchemas(mer.getComSchemas());
		
		mer.setSVCAlias("cd1");
		return new GridPagingResHelper<SystemEmployeePopUpResDto>().newGridPagingResDto(
				mer.init(CommonUtil.getInstance().getDBType()),systemEmployeeMapper.selectEmployeePopUp(mer)); 
		}

	/**
	 * @name : checkPwdPolicies
	 * @date : 2017. 11. 24.
	 * @author : jun.lee
	 * @return : StatusResponseDTO
	 * @description : 비밀번호 관련 정책(공통) 체크
	 */
	public StatusResDto checkPwdPolicies(String pwd, StatusResDto rtnValue){
//		if( !(pwd.length()>=10 && pwd.length()<=16) ){
//			//변경할 비밀번호는 10자리 이상 16자리 미만
//			rtnValue.setMessage("5-1");
//			rtnValue.setSuccess(false);
//			
//			return rtnValue;
		if( (pwd.matches("(?=.*\\d)(?=.*[a-zA-Z])") || pwd.matches("(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])")) && pwd.length()<10) {
			//대문자, 소문자, 숫자, 특수문자 중 2종류 이상 문자를 조합하여 최소 10자리 이상 입력
			rtnValue.setMessage("5-5");
			rtnValue.setSuccess(false);
			
			return rtnValue;
		}else if( !pwd.matches("(?=.*[a-zA-Z])(?=.*[~`!@#$%\\^&*()-]).{8,16}") ) {
			//대문자, 소문자, 숫자, 특수문자 중 3종류 이상 문자를 조합하여 최소 8자리 이상 입력
			rtnValue.setMessage("5-6");
			rtnValue.setSuccess(false);
			
			return rtnValue;
		}else if( pwd.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*") ) {
			//변경할 비밀번호에 한글이 포함된 경우
			rtnValue.setMessage("5-2");
			rtnValue.setSuccess(false);
			
			return rtnValue;
		}else if( spaceCheck(pwd) ) {
			//변경할 비밀번호에 공백이 포함된 경우
			rtnValue.setMessage("5-3");
			rtnValue.setSuccess(false);
			
			return rtnValue;
		}
		else if( !(pwd.matches("(?=.*\\d)(?=.*[a-zA-Z]).{8,16}")) //영문숫자 (8이상 16이하)
				&& !(pwd.matches("(?=.*\\d)(?=.*[~`!@#$%\\^&*()-]).{8,16}")) //특문숫자 (8이상 16이하)
				&& !(pwd.matches("(?=.*[a-zA-Z])(?=.*[~`!@#$%\\^&*()-]).{8,16}")) ) { //영문특문숫자 (8이상 16이하)
			//변경할 비밀번호에 영문, 특수문자, 숫자 중 두가지 이상 조합이 아닌 경우
			rtnValue.setMessage("5-4");
			rtnValue.setSuccess(false);
			
			return rtnValue;
		} else if( pwd.matches("([a-zA-Z0-9])\1\1\1") ) {
			//4자리 이상 연속된 문자나 숫자는 사용 불가함
			rtnValue.setMessage("5-7");
			rtnValue.setSuccess(false);
			
			return rtnValue;
		} else if( pwd.matches("([a-zA-Z0-9])\1\1\1") ) {
			//4자리 이상 반복 문자나 숫자는 사용 불가함
			rtnValue.setMessage("5-8");
			rtnValue.setSuccess(false);
			
			return rtnValue;
		}
		
		return rtnValue;
	}

	/**
	 * @name : spaceCheck
	 * @date : 2017. 11. 24.
	 * @author : jun.lee
	 * @return : boolean
	 * @description : 문자열 공백 체크
	 */
	public boolean spaceCheck(String spaceCheck) {
		for (int i = 0; i < spaceCheck.length(); i++) {
			if (spaceCheck.charAt(i) == ' ')
				return true;
		}
		return false;
	}

	 /*
	  * 1. 메소드명: setActiveUserLoginHist
	  * 2. 클래스명: SystemEmployeeService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		활성회원 COM.LOGIN_HISTORY -> MODIFY_DATE, LOGIN_SUCCESS_YN 새로 넣어주기
	 *		회원이 로그인 기준일보다 전에 로그인이 되있어야하고, 로그인 성공된 기록이 있어야 다시 로그인 할수 있음
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bpdr
	 *   @return	
	 */
	public StatusResDto setActiveUserLoginHist(SystemUserDetailReqDto bpdr) {
		LogUtil.param(this.getClass(), bpdr);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		//사용자의 ip 추출
		String host = "";
		try {
			host = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			LogUtil.error(e);
		}
		bpdr.setServer(host);
		
		systemEmployeeMapper.insertActiveUserLoginHist(bpdr);
		rtnValue.setMessage("사용자의 로그인이 가능합니다.");
		rtnValue.setSuccess(true);
		return rtnValue;
	}
}
