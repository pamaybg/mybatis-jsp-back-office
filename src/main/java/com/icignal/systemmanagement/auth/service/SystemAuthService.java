package com.icignal.systemmanagement.auth.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.auth.dto.request.UserDetailReqDto;
import com.icignal.auth.dto.response.GetUserPwdInfoResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthCallProcReqDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthDetailReqDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthGroupEmployeeModalReqDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthLogInsertReqDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthMenuListRequestDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthObjectListPopReqDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthObjectListReqDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthProgramAccessReqDto;
import com.icignal.systemmanagement.auth.dto.request.SystemDeleteAuthObjRelReqDto;
import com.icignal.systemmanagement.auth.dto.request.SystemInsertVIewAuthListReqDto;
import com.icignal.systemmanagement.auth.dto.response.SystemAuthDetailResDto;
import com.icignal.systemmanagement.auth.dto.response.SystemAuthGroupEmployeeModalResDto;
import com.icignal.systemmanagement.auth.dto.response.SystemAuthMenuListResDto;
import com.icignal.systemmanagement.auth.dto.response.SystemAuthObjectListPopResDto;
import com.icignal.systemmanagement.auth.dto.response.SystemAuthObjectListResDto;
import com.icignal.systemmanagement.auth.dto.response.SystemAuthProgramAccessResDto;
import com.icignal.systemmanagement.auth.mapper.SystemAuthMapper;
import com.icignal.systemmanagement.authgroup.dto.request.InsertAuthDetailReqDto;
import com.icignal.systemmanagement.menu.dto.request.SystemAuthMenuNameLangReqDto;
import com.icignal.systemmanagement.menu.dto.response.SystemAuthMenuNameLangResDto;
import com.icignal.systemmanagement.program.dto.request.SystemAuthGroupListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemAuthListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemProgListReqDto;
import com.icignal.systemmanagement.program.dto.response.SystemAuthListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemProgListResDto;

/*
 * 1. 클래스명	: SystemAuthService
 * 2. 파일명	: SystemAuthService.java
 * 3. 패키지명	: com.icignal.systemmanagement.auth.service
 * 4. 작성자명	: Quintet
 * 5. 작성일자	: 2020. 4. 21.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - 권한관리 Service
 * </PRE>
 */
@Service
public class SystemAuthService {

 @Autowired SystemAuthMapper systemAuthMapper;

 /**
	 *
	 * <pre>
	 * com.icignal.systemmanagement.auth.service.SystemAuthService.java
	 *  |_ getAuthList()
	 * </pre>
	 * Method		: getAuthList
	 * Method설명	: 권한 관리 리스트
	 * @param SystemAuthListReqDto
	 * @return GridPagingResDto MKTAuthListResponseDTO
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 3.			User01			신규 생성
	 * =================================================================================
	 *
	 * @SeeToOverriden		: @see com.icignal.systemmanagement.auth.service.SystemAuthService(SystemAuthListReqDto)
	 */

	public GridPagingResDto<SystemAuthListResDto> getAuthList(SystemAuthListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setSVCAlias("h");

		return new GridPagingResHelper<SystemAuthListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemAuthMapper.getAuthList(reqDto));
	}

	/**
	 *
	 * <pre>
	 * com.icignal.systemmanagement.auth.service.SystemAuthService.java
	 *  |_ getAuthMenuList()
	 * </pre>
	 * Method		: getAuthMenuList
	 * Method설명	: 계정이 갖고 있는 권한 정보에 따른 메뉴 권한을 불러오는 함수
	 * @param SystemAuthMenuListRequestDto
	 * @return List<MKTAuthMenuListResponseDTO>
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 3.			User01			신규 생성
	 * =================================================================================
	 *
	 * @SeeToOverriden		: @see com.icignal.systemmanagement.auth.service.SystemAuthService(SystemAuthMenuListRequestDto)
	 */

	public List<SystemAuthMenuListResDto> getAuthMenuList(SystemAuthMenuListRequestDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		List<SystemAuthMenuListResDto> rtnValue = new ArrayList<SystemAuthMenuListResDto>();
		reqDto.setSVCAlias("amr");

		rtnValue = systemAuthMapper.getAuthMenuList(reqDto);

		return rtnValue;
	}

	/**
	 *
	 * <pre>
	 * com.icignal.systemmanagement.auth.service.SystemAuthService.java
	 *  |_ getProgList()
	 * </pre>
	 * Method		: getProgList
	 * Method설명	: 권한관리 오브젝트 관리 프로그램 목록
	 * @param SystemProgListReqDto
	 * @return GridPagingResDto MKTProgListResponseDTO
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 3.			User01			신규 생성
	 * 2020. 02. 05		노형래			권한관리 오브젝트 관리 프로그램 목록
	 * =================================================================================
	 *
	 * @SeeToOverriden		: @see infavor.beacon.enterprise.auth.service.IMKTAuthService#getProgList(infavor.beacon.enterprise.auth.dto.request.MKTProgListRequestDTO)
	 */

	public GridPagingResDto<SystemProgListResDto> getProgList(SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setSVCAlias("p");

		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemAuthMapper.getProgList(reqDto), AnnotationType.CommCode);
	}

	/**
	 *
	 * <pre>
	 * com.icignal.systemmanagement.auth.service.SystemAuthService.java
	 *  |_ authDetail()
	 * </pre>
	 * @Method이름	: authDetail
	 * @Method설명	: 권한 상세
	 * @param SystemAuthDetailReqDto
	 * @return MKTAuthDetailResponseDTO
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 3.			표민종			신규 생성
	 * =================================================================================
	 * 2017. 3. 9.			장용			권한 통합에 따른 소스변경 - 권한 마스터 테이블에서 조회되도록 변경
	 * =================================================================================
	 */

	public SystemAuthDetailResDto authDetail(SystemAuthDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		SystemAuthDetailResDto rtnValue = new SystemAuthDetailResDto();

		reqDto.setSVCAlias("a");
		rtnValue = (SystemAuthDetailResDto)systemAuthMapper.authDetail(reqDto);

		return rtnValue;
	}


	public GridPagingResDto<SystemAuthMenuNameLangResDto> getMenuNameLang(SystemAuthMenuNameLangReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<SystemAuthMenuNameLangResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemAuthMapper.getMenuNameLang(reqDto));
	}

	/*
	 * 1. 메소드명: getProgramAccessList
	 * 2. 클래스명: MKTAuthService
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2020. 1. 31.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		권한 프로그램 목록 리스트
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */

	public GridPagingResDto<SystemAuthProgramAccessResDto> getProgramAccessList(SystemAuthProgramAccessReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setSVCAlias("reqDto");

		return new GridPagingResHelper<SystemAuthProgramAccessResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemAuthMapper.getProgramAccessList(reqDto), AnnotationType.CommCode);
	}

	/**
	 * <pre>
	 * com.icignal.systemmanagement.auth.service.SystemAuthService.java
	 *  |_ setViewAuthList()
	 * </pre>
	 * @Method이름	: setViewAuthList
	 * @Method설명	: 화면 권한 설정
	 * @param SystemInsertVIewAuthListReqDto
	 * @return StatusResDto
	 * @history
	 * =================================================================================
	 * 변경일					작성자				변경내용
	 * =================================================================================
	 * 2017. 3. 9.		yongjang			신규 생성
	 * =================================================================================
	 */

	public StatusResDto setViewAuthList(SystemInsertVIewAuthListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();

		if(reqDto.getMenuIdList().size() > 0){
			//메뉴 삭제 후 인서트
			systemAuthMapper.updateViewAuthList(reqDto);
			systemAuthMapper.setViewAuthList(reqDto);
			rtnValue.setSuccess(true);
		}else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("1개 이상의 화면권한을 넣어주어야 합니다.");
		}



		return rtnValue;
	}
	/**
	 * com.icignal.systemmanagement.auth.service.SystemAuthService.java
	 * getAuthObjectList()
	 * @Method이름	: getAuthObjectList
	 * @Method설명	: 권한 오브젝트 목록 조회
	 * @param SystemAuthObjectListReqDto
	 * @return GridPagingResDto
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 13.		장용			신규 생성
	 * =================================================================================
	 */

	public GridPagingResDto<SystemAuthObjectListResDto> getAuthObjectList(SystemAuthObjectListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		GridPagingResDto<SystemAuthObjectListResDto> rtnValue = new GridPagingResDto<SystemAuthObjectListResDto>();

		if(reqDto.getAuthId() != null && reqDto.getPgmId() != null){
			rtnValue.setSuccess(false);
			reqDto.setSVCAlias("aor");
			rtnValue = new GridPagingResHelper<SystemAuthObjectListResDto>().newGridPagingResDto(
					reqDto.init(CommonUtil.getInstance().getDBType()), systemAuthMapper.getAuthObjectList(reqDto), AnnotationType.CommCode);
		}

		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * com.icignal.systemmanagement.auth.service.SystemAuthService.java
	 * getAuthObjectListPop()
	 * @Method이름	: getAuthObjectListPop
	 * @Method설명	: 권한 오브젝트 팝업 목록 조회
	 * @param SystemAuthObjectListPopReqDto
	 * @return GridPagingResDto
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 13.		장용			신규 생성
	 * =================================================================================
	 */

	public GridPagingResDto<SystemAuthObjectListPopResDto> getAuthObjectListPop(SystemAuthObjectListPopReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		GridPagingResDto<SystemAuthObjectListPopResDto> rtnValue = new GridPagingResDto<SystemAuthObjectListPopResDto>();

		if(reqDto.getAuthId() != null && reqDto.getPgmId() != null){
			rtnValue.setSuccess(false);
			reqDto.setSVCAlias("uo");
			rtnValue = new GridPagingResHelper<SystemAuthObjectListPopResDto>().newGridPagingResDto(
					reqDto.init(CommonUtil.getInstance().getDBType()), systemAuthMapper.getAuthObjectListPop(reqDto));
		}

		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * com.icignal.systemmanagement.auth.service.SystemAuthService.java
	 * deleteAuthObjRel()
	 * @Method이름	: deleteAuthObjRel
	 * @Method설명	: 권한 오브젝트 관계 삭제
	 * @param SystemDeleteAuthObjRelReqDto
	 * @return StatusResDto
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 13.		장용			신규 생성
	 * =================================================================================
	 */

	public StatusResDto deleteAuthObjRel(SystemDeleteAuthObjRelReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();

		if(reqDto.getObjRelIdList() != null && reqDto.getObjRelIdList().size() > 0){
			reqDto.setSVCAlias("");
			systemAuthMapper.deleteAuthObjRel(reqDto);
		}
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 *
	 * <pre>
	 * SystemAuthService.java
	 *  |_ deleteAuthList()
	 * </pre>
	 * Method		: deleteAuthList
	 * Method설명	: 권한 리스트 삭제
	 * @param SystemAuthMenuListRequestDto
	 * @return StatusResDto
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 3.			User01			신규 생성
	 * 2020. 4. 21.			hr.noh			deleteAuthProgramRel, deleteAuthObjectRelList 추가
	 * =================================================================================
	 *
	 * @SeeToOverriden		: @see com.icignal.systemmanagement.auth.service.SystemAuthService(SystemAuthMenuListRequestDto)
	 */
	public StatusResDto deleteAuthList(SystemAuthMenuListRequestDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		/**
		 * 2019.01.24 hy.jun
		 * 권한 변경이력 등록
		 * - 권한 / 삭제
		 */
		for(String authId : reqDto.getAuthIds()) {
			SystemAuthLogInsertReqDto alir = new SystemAuthLogInsertReqDto();
			alir.setCreateBy(reqDto.getCreateBy());
			alir.setAuthLogTypeCd(CommonUtil.COM_AUTH_LOG_TYPE_CD.AUTH.toString());
			alir.setLogTypeDtl(CommonUtil.LOG_TYPE_DTL.AUTH_D.toString());
			alir.setObjRid(authId);
			alir.setObjNm(systemAuthMapper.selectAuthNm(authId));
			this.setAuthLog(alir);
		}

		StatusResDto rtnValue = new StatusResDto();
		systemAuthMapper.deleteAuthList(reqDto);
		systemAuthMapper.deleteAuthRelList(reqDto);
		systemAuthMapper.deleteAuthProgramRel(reqDto);
		systemAuthMapper.deleteAuthObjectRelList(reqDto);

		rtnValue.setSuccess(true);

		return rtnValue;
	}


	/**
	* @name : getAuthListPop
	* @date : 2020. 2. 6.
	* @author : sh.park
	* @history :
	* @description : 권한복사 팝업 권한 리스트(선택한 권한 제외 GRID)
	* @param requ
	* @param response
	* @param reqDto
	* @return : GridPagingResDto
	*/

	public GridPagingResDto<SystemAuthListResDto> getAuthCopyList(SystemAuthListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setSVCAlias("h");
		return new GridPagingResHelper<SystemAuthListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemAuthMapper.getAuthCopyList(reqDto));
	}

	/**
	* @name : callAuthCopyProc
	* @date : 2020. 2. 6.
	* @author : sh.park
	* @history :
	* @description : 권한복사 프로시져 호출
	* @param
	* @param reqDto
	* @return : StatusResDto
	*/

	public StatusResDto callAuthCopyProc(SystemAuthCallProcReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		 StatusResDto rtnValue = new StatusResDto();

		  systemAuthMapper.callAuthCopyProc(reqDto);
		  rtnValue.setSuccess(true);

		 return rtnValue;
	}

	/**
	* @programId :
	* @name : setAuthLog
	* @date : 2019. 1. 24.
	* @author : hy.jun
	* @table :
	* @return :
	* @description :
	*/
	public StatusResDto setAuthLog(SystemAuthLogInsertReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto(false, "");
		int cnt = (int) systemAuthMapper.insertAuthLog(reqDto);
		if(cnt > 0) {
			rtnValue.setSuccess(true);
		}

		return rtnValue;
	}

	/**
	 *
	 * <pre>
	 * infavor.beacon.enterprise.auth.service.impl.MKTAuthService.java
	 *  |_ insertAuthDetail()
	 * </pre>
	 * @OverrideMethod		: insertAuthDetail
	 * @OverrideMethod설명	: 권한 상세 저장
	 * @param MKTInsertAuthDetailRequestDTO
	 * @return StatusResponseDTO
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 3.			User01			신규 생성
	 * =================================================================================
	 *
	 * @SeeToOverriden		: @see infavor.beacon.enterprise.auth.service.IMKTAuthService#insertAuthDetail(infavor.beacon.enterprise.auth.dto.request.MKTInsertAuthDetailRequestDTO)
	 */
	public StatusResDto insertAuthDetail(InsertAuthDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();

		//authId 생성
		String authId = CommonUtil.newRid();
		reqDto.setAuthId(authId);

		/**
		 * 2019.01.24 hy.jun
		 * 권한 변경이력 등록
		 * - 권한 / 생성
		 */
		SystemAuthLogInsertReqDto alir = new SystemAuthLogInsertReqDto();
		alir.setCreateBy(reqDto.getCreateBy());
		alir.setAuthLogTypeCd(CommonUtil.COM_AUTH_LOG_TYPE_CD.AUTH.toString());
		alir.setLogTypeDtl(CommonUtil.LOG_TYPE_DTL.AUTH_C.toString());
		alir.setObjRid(authId);
		alir.setObjNm(reqDto.getAuthName());
		this.setAuthLog(alir);

		rtnValue.setSuccess(false);
		systemAuthMapper.insertAuthDetail(reqDto);
		rtnValue.setSuccess(true);
		rtnValue.setMessage(authId);

		return rtnValue;
	}

	/**
	 *
	 * <pre>
	 * infavor.beacon.enterprise.auth.dao.impl.MKTAuthDAO.java
	 *  |_ updateAuthDetail()
	 * </pre>
	 * @OverrideMethod		: updateAuthDetail
	 * @OverrideMethod설명	: 권한 상세 수정
	 * @param MKTInsertAuthDetailRequestDTO
	 * @return StatusResponseDTO
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 3.			User01			신규 생성
	 * =================================================================================
	 *
	 * @SeeToOverriden		: @see infavor.beacon.enterprise.auth.dao.IMKTAuth#updateAuthDetail(infavor.beacon.enterprise.auth.dto.request.MKTInsertAuthDetailRequestDTO)
	 */
	public StatusResDto updateAuthDetail(InsertAuthDetailReqDto biad) {
		LogUtil.param(this.getClass(), biad);

		StatusResDto rtnValue = new StatusResDto();

		systemAuthMapper.updateAuthDetail(biad);
		rtnValue.setSuccess(true);

		return rtnValue;

	}

	 /*
	  * 1. 메소드명: getProgramListPop
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */

	public GridPagingResDto<SystemProgListResDto> getAuthProgramListPop(SystemProgListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("t1");
		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(
				 param.init(CommonUtil.getInstance().getDBType()),
				 systemAuthMapper.getAuthProgramListPop(param), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getProgAuthList
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */

	public GridPagingResDto<SystemProgListResDto> getProgAuthList(SystemProgListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("t1");
		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(
				 param.init(CommonUtil.getInstance().getDBType()),
				 systemAuthMapper.selectProgAuthList(param));
	}

	 /*
	  * 1. 메소드명: addProgramAuth
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */

	public StatusResDto addProgramAuth(SystemProgListReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		List<String> progId = systemAuthMapper.selectProgId(param);

		param.setProgId(progId);
		param.setRid(CommonUtil.newRid());

		systemAuthMapper.insertProgramParentAuth(param);
		if(param.getProgId().size()!=0) {
			systemAuthMapper.insertProgramchildAuth(param);
		}

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getAuthProgram
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */
	public GridPagingResDto<SystemProgListResDto> getAuthProgram(SystemProgListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("apr");
		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(
				 param.init(CommonUtil.getInstance().getDBType()),
				 systemAuthMapper.selectAuthProgram(param), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: removeProgramPrarent
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */

	public StatusResDto removeProgramPrarentAuth(SystemProgListReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		List<String> progId = systemAuthMapper.selectProgId(param);

		param.setProgId(progId);

		systemAuthMapper.deleteProgramAuth(param);
		if(param.getProgId().size()!=0) {
			systemAuthMapper.deleteProgramchildAuth(param);
		}

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeProgramChildAuth
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */

	public StatusResDto removeProgramChildAuth(SystemProgListReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();

		systemAuthMapper.deleteProgramAuth(param);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyUserPwd
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param plr
	 *   @return
	 */

	public StatusResDto modifyUserPwd(UserDetailReqDto plr) {
		LogUtil.param(this.getClass(), plr);

		StatusResDto rtnValue = new StatusResDto();
		GetUserPwdInfoResDto rtnValue2 = new GetUserPwdInfoResDto();

		rtnValue.setSuccess(false);

		//변경할 비밀번호 유효성 검사(공통)
		rtnValue = checkPwdPolicies(plr.getUserPw(), rtnValue);
		if( rtnValue.getMessage() != null ){
			return rtnValue;
		}

		//로그인 사용자 아이디 정보로 비밀번호 정보 조회
		rtnValue2 = systemAuthMapper.selectUserPwdInfo(plr);
		plr.setPwdCheckCnt((BeansUtil.getApplicationProperty("icignal.login.password.check-cnt")));
		List<String> rtnValue3 = systemAuthMapper.selectUserBePwd(plr);
		if( plr.getUserPw().contains(rtnValue2.getUserId()) ){
			//변경할 비밀번호에 로그인 사용자 아이디가 포함된 경우
			rtnValue.setMessage("3");
			rtnValue.setSuccess(false);

			return rtnValue;
		}else if( plr.getUserPw().contains(rtnValue2.getEmpNo()) ){
			//직원일 경우, 변경할 비밀번호에 사번이 포함된 경우
			rtnValue.setMessage("4");
			rtnValue.setSuccess(false);

			return rtnValue;
		}

		//변수에 패스워드 값을 단방향 암호화하여 저장
		try {
			plr.setPreUserPw(SecurityUtil.encodePassword(plr.getPreUserPw()));
			plr.setUserPw(SecurityUtil.encodePassword(plr.getUserPw()));
		} catch (Exception e) {
			LogUtil.error(e);
			rtnValue.setSuccess(false);
			rtnValue.setMessage("암호화 실패");
			return rtnValue;
		}

		//로그인 사용자 비밀번호 비교
		if( rtnValue2.getUserPw() != null && !plr.getPreUserPw().equals(rtnValue2.getUserPw())){
			//입력한 현재 비밀번호가 기존의 현재 비밀번호와 일치하지 않는 경우
			rtnValue.setMessage("1");
			rtnValue.setSuccess(false);

			return rtnValue;
		}

		if( rtnValue2.getUserPw() != null && plr.getUserPw().equals(rtnValue2.getUserPw())){
			//변경할 비밀번호가 현재 비밀번호와 같은 경우
			rtnValue.setMessage("2-1");
			rtnValue.setSuccess(false);

			return rtnValue;
		}

		for(String pwd : rtnValue3) {
			int idx=2;
			//변경할 비밀번호가 이전 비밀번호들과 같은 경우
			if( plr.getUserPw().equals(pwd)){
				rtnValue.setMessage("2-"+idx);
				rtnValue.setSuccess(false);
				return rtnValue;
			}
			idx++;
		}

		//로그인 사용자 비밀번호 변경 세팅
		if( rtnValue2.getUserPw() != null ){
			plr.setUserPwBef1(rtnValue2.getUserPw());
		}


		//비밀번호 만료일자 설정
		plr.setPwdChangeTerm(CommonUtil.getInstance().getServletProp("loyalty.login.pwdChangeTerm"));
		//위의 조건 만족 시, 로그인 사용자 비밀번호 변경
		//관리자가 비밀번호 변경할 경우 첫 로그인 시 비밀번호 변경 필수
				if(plr.isByAdmin()) {
					plr.setFirstLoginFlg("1");
				} else {
					plr.setFirstLoginFlg("0");
				}
				plr.setUserStat("ACTIVE");
				systemAuthMapper.updateUserPwd(plr);
//				plr.setRidCrmuser(plr.getRid());
				plr.setRid(CommonUtil.newRid());
				systemAuthMapper.insertUserPwd(plr);
				rtnValue.setSuccess(true);

		return rtnValue;
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
		/*if( (pwd.matches("(?=.*\\d)(?=.*[a-zA-Z])") || pwd.matches("(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])")) && pwd.length()<10) {
			//대문자, 소문자, 숫자, 특수문자 중 2종류 이상 문자를 조합하여 최소 10자리 이상 입력
			rtnValue.setMessage("5-5");
			rtnValue.setSuccess(false);
			
			return rtnValue;
		}*/
		if( !pwd.matches("(?=.*[a-zA-Z])(?=.*[~`!@#$%\\^&*()-]).{8,16}") ) {
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
		else if( !(pwd.matches("(?=.*\\d)(?=.*[a-zA-Z]).{8,16}")) //영문숫자 (8~16자리)
				&& !(pwd.matches("(?=.*\\d)(?=.*[~`!@#$%\\^&*()-]).{8,16}")) //특문숫자 (8~16자리)
				&& !(pwd.matches("(?=.*[a-zA-Z])(?=.*[~`!@#$%\\^&*()-]).{8,16}")) ) { //영문특문숫자 (8~16자리)
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
	public boolean spaceCheck(String spaceCheck)
	{
	    for(int i = 0 ; i < spaceCheck.length() ; i++)
	    {
	        if(spaceCheck.charAt(i) == ' ')
	            return true;
	    }
	    return false;
	}

	 /*
	  * 1. 메소드명: getAuthProgramLChildistPop
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */

	public GridPagingResDto<SystemProgListResDto> getAuthProgramLChildistPop(SystemProgListReqDto param) {
		param.setSVCAlias("t1");
		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(
				 param.init(CommonUtil.getInstance().getDBType()),
				 systemAuthMapper.selectAuthProgramLChildistPop(param), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: addProgramChildAuth
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */

	public StatusResDto addProgramChildAuth(SystemProgListReqDto param) {
		LogUtil.param(this.getClass(),param);
		StatusResDto rtnValue = new StatusResDto();
		systemAuthMapper.insertProgramChildAuth(param);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	* @name : delAuthObjRel
	* @date : 2020. 1. 30.
	* @author : sh.park
	* @history :
	* @description :  프로그램 관리 오브젝트 권한 팝업 삭제
	* @param requ
	* @param response
	* @param reqDto
	* @return : StatusResponseDTO
	*/
	public StatusResDto delAuthObjRel(SystemAuthGroupListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		systemAuthMapper.delAuthObjRel(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyNaverToken
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 4. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param oauthToken
	 */

	public StatusResDto modifyNaverToken(String id,String userId) {
		LogUtil.param(this.getClass(),id);
		StatusResDto rtnValue = new StatusResDto();
		HashMap<String, String> mapData = new HashMap<String, String>();
		mapData.put("loginRid",userId);
		mapData.put("id",id);
		systemAuthMapper.updateNaverToken(mapData);
		rtnValue.setSuccess(true);

		return rtnValue;

	}

	 /*
	  * 1. 메소드명: modifyKaKaoToken
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 4. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param access_Token
	 *   @param userId
	 */

	public StatusResDto modifyKaKaoToken(String id, String userId) {
		LogUtil.param(this.getClass(),id);
		StatusResDto rtnValue = new StatusResDto();
		HashMap<String, String> mapData = new HashMap<String, String>();
		mapData.put("loginRid",userId);
		mapData.put("id",id);
		systemAuthMapper.updateKakaoToken(mapData);
		rtnValue.setSuccess(true);

		return rtnValue;

	}

	 /*
	  * 1. 메소드명: modifyGogleToken
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 4. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param access_Token
	 *   @param userId
	 */

	public StatusResDto modifyGogleToken(String id, String userId) {
		LogUtil.param(this.getClass(),id);
		StatusResDto rtnValue = new StatusResDto();
		HashMap<String, String> mapData = new HashMap<String, String>();
		mapData.put("loginRid",userId);
		mapData.put("id",id);
		systemAuthMapper.updateGogleToken(mapData);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyFacebookToken
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 4. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param access_Token
	 *   @param userId
	 */

	public StatusResDto modifyFacebookToken(String id, String userId) {
		LogUtil.param(this.getClass(),id);
		StatusResDto rtnValue = new StatusResDto();
		HashMap<String, String> mapData = new HashMap<String, String>();
		mapData.put("loginRid",userId);
		mapData.put("id",id);
		systemAuthMapper.updateFackbookToken(mapData);
		rtnValue.setSuccess(true);

		return rtnValue;

	}

	 /*
	  * 1. 메소드명: getCheckToken
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param accessToken
	 *   @return
	 */

	public StatusResDto getCheckNaverToken(String id) {

		LogUtil.param(this.getClass(),id);
		StatusResDto rtnValue = new StatusResDto();

		Integer cnt = (Integer) systemAuthMapper.selectrCheckNaverToken(id);

		if (cnt == 0)
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getCheckKakaoToken
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param access_Token
	 *   @return
	 */

	public StatusResDto getCheckKakaoToken(String id) {
		LogUtil.param(this.getClass(),id);
		StatusResDto rtnValue = new StatusResDto();

		Integer cnt = (Integer) systemAuthMapper.selectrCheckKakaoToken(id);

		if (cnt == 0)
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getCheckGoogleToken
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param access_Token
	 *   @return
	 */

	public StatusResDto getCheckGoogleToken(String id) {
		LogUtil.param(this.getClass(),id);
		StatusResDto rtnValue = new StatusResDto();

		Integer cnt = (Integer) systemAuthMapper.selectrCheckGoogleToken(id);

		if (cnt == 0)
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyUserFirstLoginFlg
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: hy.jun
	  * 4. 작성일자: 2018. 03. 08.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로그인 사용자 최초 로그인 플래그 변경
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param plr
	 *   @return
	 */
	public StatusResDto modifyUserFirstLoginFlg(UserDetailReqDto plr) {
		LogUtil.param(SystemAuthService.class, plr);
		StatusResDto rtnValue = new StatusResDto(false, "");
		systemAuthMapper.modifyUserFirstLoginFlg(plr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getEmpAddListModalForCallCenter
	  * 2. 클래스명: SystemAuthService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param bagem
	 *   @return
	 */

	public GridPagingResDto<SystemAuthGroupEmployeeModalResDto> getEmpAddListModalForCallCenter(
			SystemAuthGroupEmployeeModalReqDto bagem) {
		return new GridPagingResHelper<SystemAuthGroupEmployeeModalResDto>().newGridPagingResDto(
				bagem.init(CommonUtil.getInstance().getDBType()),
				 systemAuthMapper.selectEmpAddListModalForCallCenter(bagem), AnnotationType.PersonalData);
	}

}
