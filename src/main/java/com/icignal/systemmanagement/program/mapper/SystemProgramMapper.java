 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.systemmanagement.program.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

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
import com.icignal.systemmanagement.program.dto.request.SystemUIObjectListReqDto;
import com.icignal.systemmanagement.program.dto.response.SystemAuthGroupListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemAuthListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemExcelDataMapResDto;
import com.icignal.systemmanagement.program.dto.response.SystemExcelDownloadListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemObjectListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemProgDetailResDto;
import com.icignal.systemmanagement.program.dto.response.SystemProgListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemUIObjectListResDto;


/**
 * 1. FileName	: LoyMbr.java
 * 2. Package	: com.icignal.loyalty.membership.mapper
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 6. 오후 3:34:03
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 6.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: LoyMbr
 * 2. 파일명	: LoyMbr.java
 * 3. 패키지명	: com.icignal.loyalty.membership.mapper
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface SystemProgramMapper {

	SystemExcelDownloadListResDto selectDtlExcel = null;

	public void deleteProgList(SystemProgListReqDto reqDto);

	public void insertProgramDetail(SystemInsertProgDetailReqDto reqDto);

	public SystemProgDetailResDto selectProgListDetail(SystemProgListReqDto reqDto);

	public void updateProgramDetail(SystemInsertProgDetailReqDto reqDto);

	public void deleteUIObjectList(SystemDeleteUIObjectListReqDto reqDto);

	public void insertUIObjectDetail(SystemInsertUIObjectDetailReqDto reqDto);

	public void insertAuthObjRelPopup(SystemInsertAuthObjRelReqDto reqDto);

	public void deleteProgRel(SystemProgListReqDto reqDto);

	public List<SystemProgListResDto> selectProgList(SystemProgListReqDto reqDto);

	public List<SystemUIObjectListResDto> selectUIObjectList(SystemUIObjectListReqDto reqDto);

	public List<SystemAuthGroupListResDto> selectObjAuthList(SystemAuthGroupListReqDto reqDto);

	public List<SystemObjectListResDto> selectObjectListNew(SystemObjectListReqDto reqDto);

	public List<SystemAuthListResDto> selectAuthListPop(SystemAuthListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectProgramAuthList
	  * 2. 클래스명: SystemProgramMapper
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
	
	public List<SystemProgListResDto> selectProgramAuthList(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectProgramList
	  * 2. 클래스명: SystemProgramMapper
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
	
	public List<SystemProgListResDto> selectProgramList(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: updateProgramDown
	  * 2. 클래스명: SystemProgramMapper
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
	 */
	
	public void updateProgramDown(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteProgramDown
	  * 2. 클래스명: SystemProgramMapper
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
	 */
	
	public void deleteProgramDown(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectprogramAuthCheck
	  * 2. 클래스명: SystemProgramMapper
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
	
	public SystemProgListResDto selectprogramAuthCheck(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteProgramAuth
	  * 2. 클래스명: SystemProgramMapper
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
	
	public void deleteProgramAuth(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectAuthProgramList
	  * 2. 클래스명: SystemProgramMapper
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
	
	public List<SystemAuthListResDto> selectAuthProgramList(SystemAuthListReqDto reqDto);

	 /*
	  * 1. 메소드명: insertAuthProgramRelPopup
	  * 2. 클래스명: SystemProgramMapper
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
	 */
	
	public void insertAuthProgramRelPopup(SystemInsertAuthObjRelReqDto reqDto);

	 /*
	  * 1. 메소드명: getLowProgramRel
	  * 2. 클래스명: SystemProgramMapper
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
	public List<SystemProgListResDto> selectLowProgramRel(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: updateParProgramDown
	  * 2. 클래스명: SystemProgramMapper
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
	 */
	public void updateParProgramDown(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteParProgramDown
	  * 2. 클래스명: SystemProgramMapper
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
	 */
	public void deleteParProgramDown(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectLowProgList
	  * 2. 클래스명: SystemProgramMapper
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
	public List<SystemProgListResDto> selectLowProgList(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: updateMainPgmId
	  * 2. 클래스명: SystemProgramMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 3. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 삭제시 MAIN_PGM_ID = NULL 처리
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	public void updateMainPgmId(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: updateParPgmId
	  * 2. 클래스명: SystemProgramMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 3. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램 삭제시 PAR_PGM_ID = NULL 처리
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	public void updateParPgmId(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: getDetailParProgList
	  * 2. 클래스명: SystemProgramMapper
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
	public List<SystemProgListResDto> selectDetailParProgList(SystemProgListReqDto reqDto);

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
	public List<SystemProgListResDto> selectDetailProgramList(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectProgRelList
	  * 2. 클래스명: SystemProgramMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 3.
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
	public List<SystemProgListResDto> selectProgRelList(SystemProgRelExcelDnReqDto reqDto);

	
	/*
	  * 1. 메소드명: selectExcelDownloadList
	  * 2. 클래스명: SystemProgramMapper
	  * 3. 작성자명: sm.lee
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		엑셀 다운로드 관리 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public List<SystemExcelDownloadListResDto> selectExcelDownloadList(SystemExcelDownloadListReqDto reqDto);

	/*
	  * 1. 메소드명: insertExcelDownloadList
	  * 2. 클래스명: SystemProgramMapper
	  * 3. 작성자명: sm.lee
	  * 4. 작성일자: 2020. 3. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		엑셀 파일 생성 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */

	public void insertProgramExcelFile(SystemExcelDownloadListReqDto reqDto);

	public void deleteExcelFile(SystemExcelDownloadListReqDto reqDto);

	public SystemExcelDownloadListResDto selectDtlExcel(SystemExcelDownloadListReqDto reqDto);

	public void updateExcelFile(SystemExcelDownloadListReqDto reqDto);

	public List<SystemExcelDataMapResDto> selectDataMapList(SystemExcelDataMapReqDto reqDto);

	public void insertExcelData(SystemExcelDataMapReqDto reqDto);

	public SystemExcelDataMapResDto selectDtlExcelData(SystemExcelDataMapReqDto reqDto);

	public void updateExcelData(SystemExcelDataMapReqDto reqDto);

	public void deleteDataMap(SystemExcelDataMapReqDto reqDto);

	public void deleteExcelFileDataMap(SystemExcelDataMapReqDto dataMapDto);
	
	public List<SystemProgListResDto> selectTemplateTestProgAllList(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectProgramChildTab
	  * 2. 클래스명: SystemProgramMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 23.
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
	
	public List<SystemProgListResDto> selectProgramChildTab(SystemProgListReqDto reqDto);

	 /*
	  * 1. 메소드명: insertAuthObjRelOne
	  * 2. 클래스명: SystemProgramMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오브젝트 등록시 권한 자동추가 (현재 권한)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	public void insertAuthObjRelOne(SystemInsertUIObjectDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: delAuthObjRelAll
	  * 2. 클래스명: SystemProgramMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오브젝트 삭제시 걸려있는 모든권한 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	public void delAuthObjRelAll(SystemDeleteUIObjectListReqDto reqDto);

}

