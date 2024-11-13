package com.icignal.systemmanagement.program.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.dto.response.TempUploadResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.program.dto.request.SystemAuthGroupListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemAuthListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemDeleteUIObjectListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemExcelDataMapReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemExcelDownloadListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemInsertAuthObjRelReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemInsertProgDetailReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemInsertUIObjectDetailReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemObjectListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemProgListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemProgRelExcelDnReqDto;
import com.icignal.systemmanagement.program.dto.response.SystemAuthGroupListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemAuthListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemExcelDataMapResDto;
import com.icignal.systemmanagement.program.dto.response.SystemExcelDownloadListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemObjectListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemProgDetailResDto;
import com.icignal.systemmanagement.program.dto.response.SystemProgListResDto;
import com.icignal.systemmanagement.program.mapper.SystemProgramMapper;

/*
 * 1. 클래스명	: SystemProgramService
 * 2. 파일명	: SystemProgramService.java
 * 3. 패키지명	: com.icignal.systemmanagement.program.service
 * 4. 작성자명	: Quintet
 * 5. 작성일자	: 2017. 3. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템운영 프로그램 관리 Service
 * </PRE>
 */ 
@Service
public class SystemProgramService {
	
	@Autowired SystemProgramMapper systemProgramMapper;
	
	/*
	 * 1. 메소드명: getProgAllList
	 * 2. 클래스명: SystemProgramService
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2020. 2. 5.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 관리 목록
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<SystemProgListResDto> getProgAllList(SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("p");

		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectProgList(reqDto));
	}
	
	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.dao.impl.MKTAuthDAO.java
	 *  |_ deleteProgList()
	 * </pre>
	 * @OverrideMethod		: deleteProgList
	 * @OverrideMethod설명	: 프로그램 리스트 삭제
	 * @param MKTProgListRequestDTO
	 * @return StatusResponseDTO
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 3.			User01			신규 생성
	 * 2020. 3. 24.		hr.noh			updateMainPgmId, updateParPgmId 추가(하위프로그램과 권한관련 프로그램 목록 null처리)
	 * =================================================================================
	 *
	 * @SeeToOverriden		: @see infavor.beacon.enterprise.auth.dao.IMKTAuth#deleteProgList(infavor.beacon.enterprise.auth.dto.request.MKTProgListRequestDTO)
	 */
	public StatusResDto deleteProgList(SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
	
		systemProgramMapper.deleteProgRel(reqDto);
		systemProgramMapper.deleteProgList(reqDto);
		systemProgramMapper.updateMainPgmId(reqDto);
		systemProgramMapper.updateParPgmId(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.dao.impl.MKTAuthDAO.java
	 *  |_ insertProgramDetail()
	 * </pre>
	 * @OverrideMethod		: insertProgramDetail
	 * @OverrideMethod설명	: 프로그램 신규 등록
	 * @param SystemInsertProgDetailReqDto
	 * @return StatusResponseDTO
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 3.			User01			신규 생성
	 * =================================================================================
	 *
	 * @SeeToOverriden		: @see infavor.beacon.enterprise.auth.dao.IMKTAuth#insertProgramDetail(infavor.beacon.enterprise.auth.dto.request.MKTInsertProgDetailRequestDTO)
	 */
	public StatusResDto insertProgramDetail(SystemInsertProgDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();    
		rtnValue.setSuccess(false);
		reqDto.setId(CommonUtil.newRid());

		systemProgramMapper.insertProgramDetail(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.dao.impl.MKTAuthDAO.java
	 *  |_ progListDetail()
	 * </pre>
	 * @OverrideMethod		: progListDetail
	 * @OverrideMethod설명	: 프로그램 상세
	 * @param SystemProgListReqDto
	 * @return MKTProgDetailResponseDTO
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 3.			User01			신규 생성
	 * =================================================================================
	 *
	 * @SeeToOverriden		: @see infavor.beacon.enterprise.auth.dao.IMKTAuth#progListDetail(infavor.beacon.enterprise.auth.dto.request.MKTProgListRequestDTO)
	 */
	public SystemProgDetailResDto progListDetail(SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("p");

		return systemProgramMapper.selectProgListDetail(reqDto);
	}
	
	/**
	 * 
	 * <pre>
	 * infavor.beacon.enterprise.auth.dao.impl.MKTAuthDAO.java
	 *  |_ updateProgramDetail()
	 * </pre>
	 * @OverrideMethod		: updateProgramDetail
	 * @OverrideMethod설명	: 프로그램 상세 수정
	 * @param SystemInsertProgDetailReqDto
	 * @return StatusResponseDTO
	 * @history
	 * =================================================================================
	 * 변경일				작성자			변경내용
	 * =================================================================================
	 * 2017. 3. 3.			User01			신규 생성
	 * =================================================================================
	 *
	 * @SeeToOverriden		: @see infavor.beacon.enterprise.auth.dao.IMKTAuth#updateProgramDetail(infavor.beacon.enterprise.auth.dto.request.MKTInsertProgDetailRequestDTO)
	 */
	public StatusResDto updateProgramDetail(SystemInsertProgDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("");
		StatusResDto rtnValue = new StatusResDto();    
		rtnValue.setSuccess(false);
		systemProgramMapper.updateProgramDetail(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	/**

	 * @name : getObjAuthList
	 * @date : 2020.01.30
	 * @author : sh.park
	 * @return : GridPagingResponseDTO
	 * @description : obj 권한 리스트
	 */
	
	public GridPagingResDto<SystemAuthGroupListResDto> getObjAuthList(SystemAuthGroupListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<SystemAuthGroupListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectObjAuthList(reqDto));
	}
	
	/**
	 * @name : deleteUIObjectList
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : StatusResponseDTO
	 * @description : UI오브젝트 삭제 
	 */
	public StatusResDto deleteUIObjectList(SystemDeleteUIObjectListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		systemProgramMapper.deleteUIObjectList(reqDto);
		//오브젝트에 걸려있는 모든 권한 삭제
		systemProgramMapper.delAuthObjRelAll(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	/**
	 * @name : getObjectListNew
	 * @date : 2017. 3. 13.
	 * @author : sh.park
	 * @return : GridPagingResponseDTO
	 * @description : 오브젝트 리스트 조회 팝업(이미 프로그램 관리에 등록된 버튼 제외 리스트)
	 */
	public GridPagingResDto<SystemObjectListResDto> getObjectListNew(SystemObjectListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("o");
		return new GridPagingResHelper<SystemObjectListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectObjectListNew(reqDto));
	}
	
	/**
	 * @name : insertUIObjectDetail
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : StatusResponseDTO 
	 * @description : UI오브젝트 추가
	 */
	public StatusResDto insertUIObjectDetail(SystemInsertUIObjectDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false); 
		reqDto.setId(CommonUtil.newRid());
		systemProgramMapper.insertUIObjectDetail(reqDto);
		//추가된 오브젝트에 대하여 권한을 추가
		systemProgramMapper.insertAuthObjRelOne(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	/**
	* @name : getAuthListPop
	* @date : 2020. 1. 30.
	* @author : sh.park
	* @history :
	* @description : 프로그램 관리 오브젝트 권한 팝업 리스트
	* @param requ
	* @param response
	* @param reqDto
	* @return : StatusResponseDTO
	*/
	public GridPagingResDto<SystemAuthListResDto> getAuthListPop(SystemAuthListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("h");
		
		return new GridPagingResHelper<SystemAuthListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectAuthListPop(reqDto));
	}

	/**
	* @name : setAuthObjRelPopup
	* @date : 2020. 1. 30.
	* @author : sh.park
	* @history :
	* @description :  프로그램 관리 오브젝트 권한 팝업 등록 
	* @param requ
	* @param response
	* @param reqDto
	* @return : GridPagingResponseDTO
	*/
	public StatusResDto setAuthObjRelPopup(SystemInsertAuthObjRelReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		List<String> authList = reqDto.getAuthIdList();
		if(authList.size() > 0){
			reqDto.setId(CommonUtil.newRid());
			systemProgramMapper.insertAuthObjRelPopup(reqDto);
			rtnValue.setSuccess(true);
		}else {
			rtnValue.setSuccess(false);
		}

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getProgramAuthList
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public GridPagingResDto<SystemProgListResDto> getProgramAuthList(SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectProgramAuthList(reqDto));
	}

	 /*
	  * 1. 메소드명: getProgramListPop
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public GridPagingResDto<SystemProgListResDto> getProgramListPop(SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectProgramList(reqDto));
	}

	 /*
	  * 1. 메소드명: editProgramDown
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public StatusResDto editProgramDown(SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		systemProgramMapper.updateProgramDown(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeProgramDown
	  * 2. 클래스명: SystemProgramService
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
	 *   @param reqDto
	 *   @return	
	 */
	
	public StatusResDto removeProgramDown(SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		systemProgramMapper.deleteProgramDown(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: programAuthCheck
	  * 2. 클래스명: SystemProgramService
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
	 *   @param reqDto
	 *   @return	
	 */
	
	public SystemProgListResDto programAuthCheck(SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return systemProgramMapper.selectprogramAuthCheck(reqDto);
	}

	 /*
	  * 1. 메소드명: removeProgramAuth
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public StatusResDto removeProgramAuth(SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
	    systemProgramMapper.deleteProgramAuth(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getAuthProgramList
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public GridPagingResDto<SystemAuthListResDto> getAuthProgramList(SystemAuthListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("h");
		
		return new GridPagingResHelper<SystemAuthListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectAuthProgramList(reqDto));
	}

	 /*
	  * 1. 메소드명: setAuthProgramAddRel
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public StatusResDto setAuthProgramAddRel(SystemInsertAuthObjRelReqDto reqDto) {
		LogUtil.param(this.getClass(),reqDto);
		StatusResDto rtnValue = new StatusResDto();
		if(reqDto.getAuthIdList().size() > 0){
			reqDto.setId(CommonUtil.newRid());
			systemProgramMapper.insertAuthProgramRelPopup(reqDto);
			rtnValue.setSuccess(true);
		}else {
			rtnValue.setSuccess(false);
		}

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getLowProgramRel
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		하위프로그램 목록(프로그램간 상,하 관계(트리구조))
	 *		상위 프로그램 다음으로 속해있는 하위 프로그램 의 관계를 확인한다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<SystemProgListResDto> getLowProgramRel(SystemProgListReqDto reqDto) {
		
		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectLowProgramRel(reqDto));
	}

	 /*
	  * 1. 메소드명: editParProgramDown
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto editParProgramDown(SystemProgListReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		systemProgramMapper.updateParProgramDown(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeParProgramDown
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removeParProgramDown(SystemProgListReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		systemProgramMapper.deleteParProgramDown(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getLowProgList
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		하위 프로그램 목록에 추가할 프로그램 리스트 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<SystemProgListResDto> getLowProgListPop(SystemProgListReqDto reqDto) {
		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectLowProgList(reqDto));
	}

	 /*
	  * 1. 메소드명: getDetailParProgList
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 3. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로그램 목록 상세 상위프로그램 등록 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<SystemProgListResDto> getDetailParProgList(SystemProgListReqDto reqDto) {
		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectDetailParProgList(reqDto)
				, AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getDetailProgramList
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 3. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로그램 목록 상세 메인프로그램 등록 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<SystemProgListResDto> getDetailProgramList(SystemProgListReqDto reqDto) {
		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectDetailProgramList(reqDto)
				, AnnotationType.CommCode);
	}

	/**
	 * @name : getExcelDownloadList
	 * @date : 2020. 04. 02
	 * @author : sm.lee
	 * @return : GridPagingResDto<SystemExcelDownloadListResDto>
	 * @description : 프로그램 목록 엑셀 다운로드 목록 리스트 
	 */
	public GridPagingResDto<SystemExcelDownloadListResDto> getExcelDownloadList(SystemExcelDownloadListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("e");
		return new GridPagingResHelper<SystemExcelDownloadListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectExcelDownloadList(reqDto),AnnotationType.CommCode);
	}
	
	/**
	 * @name : deleteExcelFile
	 * @date : 2020. 04. 02
	 * @author : sm.lee
	 * @return : 
	 * @description : 엑셀 다운로드 관리 리스트 삭제
	 */
	public StatusResDto deleteExcelFile(SystemExcelDownloadListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		
		if(reqDto.getTemplateFile() != null) {
			File tempFile = new File(reqDto.getTemplateFile().replaceAll("/", Matcher.quoteReplacement(File.separator)));
			tempFile.delete();
		}
		SystemExcelDataMapReqDto dataMapDto = new SystemExcelDataMapReqDto();
		
		dataMapDto.setRidExcelH(reqDto.getRid());
		
		systemProgramMapper.deleteExcelFileDataMap(dataMapDto);		
		systemProgramMapper.deleteExcelFile(reqDto);
			
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	 * @name : setProgramExcelFile
	 * @date : 2020. 04. 02
	 * @author : sm.lee
	 * @return : StatusResDto
	 * @description : 엑셀 파일 생성 등록
	 */
	public StatusResDto setProgramExcelFile(SystemExcelDownloadListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		StatusResDto rtnValue = new StatusResDto();
		String rid = CommonUtil.newRid();
		reqDto.setRid(rid);
		
		if(reqDto.getTempName() != null) {
			String name = reqDto.getTempName();
			String fullPath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath")+"template/";
//			reqDto.setTemplateFile(fullPath.concat(name));
			reqDto.setTemplateFile(fullPath+name);
		}
		
		systemProgramMapper.insertProgramExcelFile(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	 * @name : excelTempUpload
	 * @date : 2020. 04. 02
	 * @author : sm.lee
	 * @return : 
	 * @description : 엑셀 템플릿 등록
	 */
	public List<TempUploadResDto> excelTempUpload(String filePath, MultipartFile file) {
		LogUtil.param(this.getClass(), null);
		
		List<TempUploadResDto> rtnValue = new ArrayList<TempUploadResDto>();

			try {
				String oriFileName = new String(file.getOriginalFilename());
				String fileName = oriFileName.replaceAll(" ", ""); // 파일명의 공백을 없애준다.
				//String tempPath = BeansUtil.getApplicationProperty("icignal.context.resource.file-upload-template-path");
				//파일명 변환
				fileName = UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf( '.' ), fileName.length());
				
				String tempFileFullPath = filePath +File.separator + "template/" + File.separator + fileName;
				String dir = filePath + File.separator + "template/";
				
				File Folder = new File(dir);
				//디렉토리 존재하지 않으면 생성
				if(!Folder.exists()) {
					Folder.mkdirs();
				}
				
				File tempFile = new File(tempFileFullPath);
				
				//파일을 지정한 path에 저장
				file.transferTo(tempFile);

				TempUploadResDto u = new TempUploadResDto(fileName, Long.valueOf(file.getSize()).intValue(), oriFileName); // 최종경로
				rtnValue.add(u);
			} catch (IllegalStateException | IOException e) {
			    LogUtil.error(e);
			}
		return rtnValue;
	}

	
	 /*
	  * 1. 메소드명: getDtlExcel
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: sm.lee
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		엑셀 파일 생성
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public SystemExcelDownloadListResDto getDtlExcel(SystemExcelDownloadListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
			
		SystemExcelDownloadListResDto rtnValue = systemProgramMapper.selectDtlExcel(reqDto);
		return new AnnotationHelper<SystemExcelDownloadListResDto>(AnnotationType.ALL, rtnValue).getItem();
	}
		
	 /*
	  * 1. 메소드명: getProgRelList
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 (상하)관계 엑셀 다운로드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<SystemProgListResDto> getProgRelList(SystemProgRelExcelDnReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectProgRelList(reqDto));
	}
	
	
	/**
	 * @name : editExcelFile
	 * @date : 2020. 04. 03
	 * @author : sm.lee
	 * @return : StatusResDto
	 * @description : 엑셀 파일 생성 수정
	 */
	public StatusResDto editExcelFile(SystemExcelDownloadListReqDto reqDto, String filePath) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();

		if (reqDto.getTemplateFile() != null) {

			String fullPath = filePath.concat(reqDto.getTemplateFile().replaceAll("/", Matcher.quoteReplacement(File.separator)));
			File tempFile = new File(fullPath);

			if (reqDto.getExcelCreateType().equals("G")) {

				tempFile.delete();
				reqDto.setTemplateFile(null);
				
			}else {
				if(reqDto.getTempName() != null) {
					tempFile.delete();
					String name = reqDto.getTempName();
					fullPath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath") +"template/";
					reqDto.setTemplateFile(fullPath.concat(name));
				}
				
			}

		}

		systemProgramMapper.updateExcelFile(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getDataMapList
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: sm.lee 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<SystemExcelDataMapResDto> getDataMapList(SystemExcelDataMapReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<SystemExcelDataMapResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectDataMapList(reqDto));
	
	}

	 /*
	  * 1. 메소드명: setExcelData
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: sm.lee 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto setExcelData(SystemExcelDataMapReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		StatusResDto rtnValue = new StatusResDto();
		
		String rid = CommonUtil.newRid();
		reqDto.setdRid(rid);
		
		systemProgramMapper.insertExcelData(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getDtlExcelData
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: sm.lee
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public SystemExcelDataMapResDto getDtlExcelData(SystemExcelDataMapReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return systemProgramMapper.selectDtlExcelData(reqDto);
	}

	 /*
	  * 1. 메소드명: editExcelData
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: sm.lee
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto editExcelData(SystemExcelDataMapReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		systemProgramMapper.updateExcelData(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: deleteDataMap
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: sm.lee 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto deleteDataMap(SystemExcelDataMapReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		systemProgramMapper.deleteDataMap(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: templateTestProgAllList
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<SystemProgListResDto> templateTestProgAllList(SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(reqDto.init(CommonUtil.getInstance().getDBType()), 
				systemProgramMapper.selectTemplateTestProgAllList(reqDto)); 
	}

	 /*
	  * 1. 메소드명: getProgramChildTab
	  * 2. 클래스명: SystemProgramService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	프로그램 하위 탭 조회	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public GridPagingResDto<SystemProgListResDto> getProgramChildTab(SystemProgListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<SystemProgListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemProgramMapper.selectProgramChildTab(reqDto));
	}


}
