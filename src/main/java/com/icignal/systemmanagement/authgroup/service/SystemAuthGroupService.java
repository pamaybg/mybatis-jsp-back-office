package com.icignal.systemmanagement.authgroup.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthLogInsertReqDto;
import com.icignal.systemmanagement.auth.service.SystemAuthService;
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
import com.icignal.systemmanagement.authgroup.dto.response.AuthGroupInsertResDto;
import com.icignal.systemmanagement.authgroup.dto.response.AuthGroupListResDto;
import com.icignal.systemmanagement.authgroup.mapper.SystemAuthGroupMapper;

@Service
public class SystemAuthGroupService {
	
	@Autowired SystemAuthGroupMapper systemAuthGroupMapper;
	
	@Autowired SystemAuthService systemAuthService;
	
	@Autowired CommonService commonService;
	
	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.dao.impl.MKTAuthDAO.java
	 *  |_ getAuthGroupList()
	 * </pre>
	 * @OverrideMethod		: getAuthGroupList
	 * @OverrideMethod설명	: 권한 그룹 리스트 출력
	 * @param MKTAuthGroupListRequestDTO
	 * @return GridPagingResponseDTO MKTAuthGroupListResponse
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 3.			User01			신규 생성
	 * =================================================================================
	 *
	 * @SeeToOverriden		: @see infavor.beacon.enterprise.auth.dao.IMKTAuth#getAuthGroupList(infavor.beacon.enterprise.auth.dto.request.MKTAuthGroupListRequestDTO)
	 */	
	public GridPagingResDto<AuthGroupListResDto> getAuthGroupList(AuthGroupListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("ag");
		
		return new GridPagingResHelper<AuthGroupListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemAuthGroupMapper.getAuthGroupList(reqDto));
	}
	
	@Transactional
	public StatusResDto deleteAuthGroupList(AuthGroupDeleteReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		StatusResDto rtnValue = new StatusResDto();
		
		for(int i=0; i<reqDto.getGroupId().size(); i++) {
			SystemAuthLogInsertReqDto alir = new SystemAuthLogInsertReqDto();
			alir.setCreateBy(reqDto.getCreateBy());
			alir.setAuthLogTypeCd(CommonUtil.COM_AUTH_LOG_TYPE_CD.AUTH_GROUP.toString());
			alir.setLogTypeDtl(CommonUtil.LOG_TYPE_DTL.AUTH_GROUP_D.toString());
			alir.setObjRid(reqDto.getGroupId().get(i));
			alir.setObjNm(systemAuthGroupMapper.selectAuthGroupNm(reqDto.getGroupId().get(i)));
			systemAuthService.setAuthLog(alir);
		}
		
		systemAuthGroupMapper.deleteGroupEmpList(reqDto);
		systemAuthGroupMapper.deleteGroupAuthAllList(reqDto);
		systemAuthGroupMapper.deleteAuthGroupList(reqDto);
		
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.service.impl.MKTAuthService.java
	 *  |_ insertGroupDetail()
	 * </pre>
	 * @OverrideMethod		: insertGroupDetail
	 * @OverrideMethod설명	: 권한 그룹 상세 등록
	 * @param MKTAuthGroupInsertRequestDTO
	 * @return MKTAuthGroupInsertResponseDTO
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 6.			표민종			신규 생성
	 * =================================================================================
	 *
	 * @SeeToOverriden		: @see infavor.beacon.enterprise.auth.service.IMKTAuthService#insertGroupDetail(infavor.beacon.enterprise.auth.dto.request.MKTAuthGroupInsertRequestDTO)
	 */
	@Transactional
	public AuthGroupInsertResDto insertGroupDetail(AuthGroupInsertReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		//id 채번
				String groupId = commonService.getRowID();
				reqDto.setGroupId(groupId);
				
				/**
				 * 2019.01.24 hy.jun
				 * 권한 변경이력 등록
				 * - 권한그룹 / 생성
				 */
				SystemAuthLogInsertReqDto alir = new SystemAuthLogInsertReqDto();
				alir.setCreateBy(reqDto.getCreateBy());
				alir.setAuthLogTypeCd(CommonUtil.COM_AUTH_LOG_TYPE_CD.AUTH_GROUP.toString());
				alir.setLogTypeDtl(CommonUtil.LOG_TYPE_DTL.AUTH_GROUP_C.toString());
				alir.setObjRid(groupId);
				alir.setObjNm(reqDto.getGroupName());
				systemAuthService.setAuthLog(alir);
								
				AuthGroupInsertResDto rtnValue = new AuthGroupInsertResDto();
			//	SystemMenuListReqDto mlr = new SystemMenuListReqDto();
				
				rtnValue.setSuccess(false);
				
				systemAuthGroupMapper.insertGroupDetail(reqDto);
				rtnValue.setSuccess(true);
				
				return rtnValue;
	}
	
	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.dao.impl.MKTAuthDAO.java
	 *  |_ updateGroupDetail()
	 * </pre>
	 * @OverrideMethod		: updateGroupDetail
	 * @OverrideMethod설명	: 권한 그룹 상세 수정
	 * @param MKTAuthGroupInsertRequestDTO
	 * @return StatusResponseDTO
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 3.			User01			신규 생성
	 * =================================================================================
	 *
	 * @SeeToOverriden		: @see infavor.beacon.enterprise.auth.dao.IMKTAuth#updateGroupDetail(infavor.beacon.enterprise.auth.dto.request.MKTAuthGroupInsertRequestDTO)
	 */
	public AuthGroupInsertResDto updateGroupDetail(AuthGroupInsertReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		AuthGroupInsertResDto rtnValue = new AuthGroupInsertResDto();
		rtnValue.setSuccess(false);
		
		systemAuthGroupMapper.updateGroupDetail(reqDto);
		rtnValue.setGroupId(reqDto.getGroupId());
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.dao.impl.MKTAuthDAO.java
	 *  |_ getAuthEmpList()
	 * </pre>
	 * @OverrideMethod		: getAuthEmpList
	 * @OverrideMethod설명	: 권한그룹에 등록된 직원 목록
	 * @param  MKTAuthGroupEmployeeRequestDTO
	 * @return GridPagingResponseDTO MKTAuthGroupEmployeeResponseDTO
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 6.			User01			신규 생성
	 * =================================================================================
	 *
	 * @SeeToOverriden		: @see infavor.beacon.enterprise.auth.dao.IMKTAuth#getAuthEmpList(infavor.beacon.enterprise.auth.dto.request.MKTAuthGroupEmployeeRequestDTO)
	 */
	public GridPagingResDto<AuthGroupEmployeeResDto> getAuthEmpList(AuthGroupEmployeeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("aur");
		
		return new GridPagingResHelper<AuthGroupEmployeeResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemAuthGroupMapper.getAuthEmpList(reqDto), AnnotationType.CommCode);
	}

	@Transactional
	public StatusResDto deleteEmpList(DeleteAuthGroupDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		StatusResDto rtnValue = new StatusResDto(false , "");
		
		/**
		 * 2019.01.24 hy.jun
		 * 권한 변경이력 등록
		 * - 권한그룹 / 제거
		 */
		for(int i=0; i<reqDto.getDelIdList().size(); i++) {
			SystemAuthLogInsertReqDto alir = new SystemAuthLogInsertReqDto();
			alir.setCreateBy(reqDto.getCreateBy());
			alir.setAuthLogTypeCd(CommonUtil.COM_AUTH_LOG_TYPE_CD.AUTH_GROUP.toString());
			alir.setLogTypeDtl(CommonUtil.LOG_TYPE_DTL.USER_R.toString());
			alir.setTargetRid(reqDto.getAuthGroupId());
			alir.setTargetNm(systemAuthGroupMapper.selectAuthGroupNm(reqDto.getAuthGroupId()));
			alir.setObjRid(reqDto.getRidCrmUserList().get(i));
			alir.setObjNm(systemAuthGroupMapper.selectEmpNm(reqDto.getRidCrmUserList().get(i)));
			systemAuthService.setAuthLog(alir);
		}
		//권한그룹의 직원 삭제
		
		rtnValue.setSuccess(false);
		systemAuthGroupMapper.deleteEmpList(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	public GridPagingResDto<AuthAuthModalResDto> getAuthGroupAuthList(AuthAuthModalReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("at");
		
		return new GridPagingResHelper<AuthAuthModalResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemAuthGroupMapper.getAuthGroupAuthList(reqDto));
	}
	
	@Transactional
	public StatusResDto deleteGroupAuthList(DeleteAuthGroupDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		/**
		 * 2019.01.24 hy.jun
		 * 권한그룹 변경이력 등록
		 * - 권한그룹 / 제거
		 */
		for(int i=0; i<reqDto.getAuthIdList().size(); i++) {
			SystemAuthLogInsertReqDto alir = new SystemAuthLogInsertReqDto();
			alir.setCreateBy(reqDto.getCreateBy());
			alir.setAuthLogTypeCd(CommonUtil.COM_AUTH_LOG_TYPE_CD.AUTH_GROUP.toString());
			alir.setLogTypeDtl(CommonUtil.LOG_TYPE_DTL.AUTH_R.toString());
			alir.setTargetRid(reqDto.getAuthGroupId());
			alir.setTargetNm(systemAuthGroupMapper.selectAuthGroupNm(reqDto.getAuthGroupId()));
			alir.setObjRid(reqDto.getAuthIdList().get(i));
			alir.setObjNm(systemAuthGroupMapper.selectAuthNm(reqDto.getAuthIdList().get(i)));
			systemAuthService.setAuthLog(alir);
		}
			
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		systemAuthGroupMapper.deleteGroupAuthList(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	public AuthGroupDetailResDto getAuthGroupDetailNew(AuthGroupDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		AuthGroupDetailResDto rtnValue = new AuthGroupDetailResDto();
		LogUtil.info("!!"+reqDto.getGroupId()+"here");
		
		reqDto.setSVCAlias("ag");
		rtnValue = systemAuthGroupMapper.getAuthGroupDetailNew(reqDto);
		
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}


	public GridPagingResDto<AuthAuthModalResDto> getAuthAddListModal(AuthAuthModalReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("h");
		
		return new GridPagingResHelper<AuthAuthModalResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemAuthGroupMapper.getAuthAddListModal(reqDto));
	}


	public GridPagingResDto<AuthGroupEmployeeModalResDto> getEmpAddListModal(AuthGroupEmployeeModalReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("e");

		return new GridPagingResHelper<AuthGroupEmployeeModalResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemAuthGroupMapper.getEmpAddListModal(reqDto),AnnotationType.ALL);
		
	}

	@Transactional
	public StatusResDto addEmpList(AuthInsertEmployeeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		StatusResDto rtnValue = new StatusResDto(false, "");
		
		/**
		 * 2019.01.25 hy.jun
		 * 권한 변경이력 등록
		 * - 권한그룹 / 추가
		 */
		for(int i=0; i<reqDto.getUserSelectList().size(); i++) {
			SystemAuthLogInsertReqDto alir = new SystemAuthLogInsertReqDto();
			alir.setCreateBy(reqDto.getCreateBy());
			alir.setAuthLogTypeCd(CommonUtil.COM_AUTH_LOG_TYPE_CD.AUTH_GROUP.toString());
			alir.setLogTypeDtl(CommonUtil.LOG_TYPE_DTL.USER_A.toString());
			alir.setTargetRid(reqDto.getAuthGroupId());
			alir.setTargetNm(systemAuthGroupMapper.selectAuthGroupNm(reqDto.getAuthGroupId()));
			alir.setObjRid(reqDto.getUserSelectList().get(i));
			alir.setObjNm(systemAuthGroupMapper.selectEmpNm(reqDto.getUserSelectList().get(i)));
			systemAuthService.setAuthLog(alir);
		}
		
		rtnValue.setSuccess(false);		
		systemAuthGroupMapper.addEmpList(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	@Transactional
	public StatusResDto addAuthList(AuthInsertAuthReqDto reqDto) {
		/**
		 * 2019.01.24 hy.jun
		 * 권한 변경이력 등록
		 * - 권한그룹 / 추가
		 */
		for(int i=0; i<reqDto.getAuthSelectList().size(); i++) {
			SystemAuthLogInsertReqDto alir = new SystemAuthLogInsertReqDto();
			alir.setCreateBy(reqDto.getCreateBy());
			alir.setAuthLogTypeCd(CommonUtil.COM_AUTH_LOG_TYPE_CD.AUTH_GROUP.toString());
			alir.setLogTypeDtl(CommonUtil.LOG_TYPE_DTL.AUTH_A.toString());
			alir.setTargetRid(reqDto.getAuthGroupId());
			alir.setTargetNm(systemAuthGroupMapper.selectAuthGroupNm(reqDto.getAuthGroupId()));
			alir.setObjRid(reqDto.getAuthSelectList().get(i));
			alir.setObjNm(systemAuthGroupMapper.selectAuthNm(reqDto.getAuthSelectList().get(i)));
			systemAuthService.setAuthLog(alir);
		}
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		systemAuthGroupMapper.addAuthList(reqDto);
		rtnValue.setSuccess(true);
		
		
		return null;
	}
	
}
