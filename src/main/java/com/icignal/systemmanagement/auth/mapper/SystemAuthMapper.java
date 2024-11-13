package com.icignal.systemmanagement.auth.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.auth.dto.request.UserDetailReqDto;
import com.icignal.auth.dto.response.GetUserPwdInfoResDto;
import com.icignal.common.base.dto.response.StatusResDto;
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
import com.icignal.systemmanagement.authgroup.dto.request.InsertAuthDetailReqDto;
import com.icignal.systemmanagement.menu.dto.request.SystemAuthMenuNameLangReqDto;
import com.icignal.systemmanagement.menu.dto.response.SystemAuthMenuNameLangResDto;
import com.icignal.systemmanagement.program.dto.request.SystemAuthGroupListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemAuthListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemProgListReqDto;
import com.icignal.systemmanagement.program.dto.response.SystemAuthListResDto;
import com.icignal.systemmanagement.program.dto.response.SystemProgListResDto;

/*
 * 1. 클래스명	: SystemAuthMapper
 * 2. 파일명	: SystemAuthMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.auth.mapper
 * 4. 작성자명	: Quintet
 * 5. 작성일자	: 2020. 4. 21.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 -  권한 관리 Mapper
 * </PRE>
 */ 
@Mapper
public interface SystemAuthMapper {

	public List<SystemAuthListResDto> getAuthList(SystemAuthListReqDto reqDto);

	public List<SystemAuthMenuListResDto> getAuthMenuList(SystemAuthMenuListRequestDto reqDto);

	public List<SystemProgListResDto> getProgList(SystemProgListReqDto reqDto);

	public SystemAuthDetailResDto authDetail(SystemAuthDetailReqDto reqDto);

	public List<SystemAuthMenuNameLangResDto> getMenuNameLang(SystemAuthMenuNameLangReqDto reqDto);

	public List<SystemAuthProgramAccessResDto> getProgramAccessList(SystemAuthProgramAccessReqDto reqDto);

	public void updateProgNoAccessList(SystemAuthProgramAccessReqDto reqDto);

	public void setProgNoAccessList(SystemAuthProgramAccessReqDto reqDto);

	public void updateViewAuthList(SystemInsertVIewAuthListReqDto reqDto);

	public void setViewAuthList(SystemInsertVIewAuthListReqDto reqDto);

	public List<SystemAuthObjectListResDto> getAuthObjectList(SystemAuthObjectListReqDto reqDto);

	public List<SystemAuthObjectListPopResDto> getAuthObjectListPop(SystemAuthObjectListPopReqDto reqDto);

	public void deleteAuthObjRel(SystemDeleteAuthObjRelReqDto reqDto);

	public void callAuthCopyProc(SystemAuthCallProcReqDto reqDto);

	public List<SystemAuthListResDto> getAuthCopyList(SystemAuthListReqDto reqDto);

	/**
	* @programId :
	* @name : getAuthNm
	* @date : 2019. 1. 25.
	* @author : hy.jun
	* @table :
	* @return : String
	* @description :
	*/
	public String getAuthNm(String param);

	public StatusResDto setAuthLog(SystemAuthLogInsertReqDto reqDto);

	public void deleteAuthList(SystemAuthMenuListRequestDto reqDto);

	public void deleteAuthRelList(SystemAuthMenuListRequestDto reqDto);

	public int insertAuthLog(SystemAuthLogInsertReqDto reqDto);

	public void insertAuthDetail(InsertAuthDetailReqDto reqDto);

	public void updateAuthDetail(InsertAuthDetailReqDto biad);

	public String selectAuthNm(String authId);
	

	 /*
	  * 1. 메소드명: selectProgAuthList
	  * 2. 클래스명: SystemAuthMapper
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
	
	public List<SystemProgListResDto> selectProgAuthList(SystemProgListReqDto param);

	 /*
	  * 1. 메소드명: getAuthProgramListPop
	  * 2. 클래스명: SystemAuthMapper
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
	
	public List<SystemProgListResDto> getAuthProgramListPop(SystemProgListReqDto param);

	 /*
	  * 1. 메소드명: insertProgramParentAuth
	  * 2. 클래스명: SystemAuthMapper
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
	 */
	
	public void insertProgramParentAuth(SystemProgListReqDto param);

	 /*
	  * 1. 메소드명: selectProgId
	  * 2. 클래스명: SystemAuthMapper
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
	
	public List<String> selectProgId(SystemProgListReqDto param);

	 /*
	  * 1. 메소드명: insertProgramchildAuth
	  * 2. 클래스명: SystemAuthMapper
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
	 */
	
	public void insertProgramchildAuth(SystemProgListReqDto param);

	 /*
	  * 1. 메소드명: selectAuthProgram
	  * 2. 클래스명: SystemAuthMapper
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
	
	public List<SystemProgListResDto> selectAuthProgram(SystemProgListReqDto param);

	 /*
	  * 1. 메소드명: deleteProgramParentAuth
	  * 2. 클래스명: SystemAuthMapper
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
	 */
	
	public void deleteProgramAuth(SystemProgListReqDto param);

	 /*
	  * 1. 메소드명: deleteProgramchildAuth
	  * 2. 클래스명: SystemAuthMapper
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
	 */
	
	public void deleteProgramchildAuth(SystemProgListReqDto param);

	 /*
	  * 1. 메소드명: selectUserPwdInfo
	  * 2. 클래스명: SystemAuthMapper
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
	
	public GetUserPwdInfoResDto selectUserPwdInfo(UserDetailReqDto plr);


	 /*
	  * 1. 메소드명: updateUserPwd
	  * 2. 클래스명: SystemAuthMapper
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
	 *   @param plr	
	 */
	
	public void updateUserPwd(UserDetailReqDto plr);

	 /*
	  * 1. 메소드명: selectAuthProgramLChildistPop
	  * 2. 클래스명: SystemAuthMapper
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
	
	public List<SystemProgListResDto> selectAuthProgramLChildistPop(SystemProgListReqDto param);

	 /*
	  * 1. 메소드명: insertProgramChildAuth
	  * 2. 클래스명: SystemAuthMapper
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
	 */
	
	public void insertProgramChildAuth(SystemProgListReqDto param);

	 /*
	  * 1. 메소드명: updateNaverToken
	  * 2. 클래스명: SystemAuthMapper
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
	 *   @param mapData	
	 */
	
	public void updateNaverToken(HashMap<String, String> mapData);

	/*
	* 1. 메소드명: deleteAuthObjRel
	  * 2. 클래스명: SystemAuthMapper
	  * 3. 작성자명: Quintet 
	  * 4. 작성일자: 2020. 3. 31.
	  */
	 /**
	 * <PRE>
	 * 1. 설명
	 * 프로그램 관리 오브젝트 권한 팝업 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public void delAuthObjRel(SystemAuthGroupListReqDto reqDto);

	 /*
	  * 1. 메소드명: updateKakaoToken
	  * 2. 클래스명: SystemAuthMapper
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
	 *   @param mapData	
	 */
	
	public void updateKakaoToken(HashMap<String, String> mapData);

	 /*
	  * 1. 메소드명: updateGogleToken
	  * 2. 클래스명: SystemAuthMapper
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
	 *   @param mapData	
	 */
	
	public void updateGogleToken(HashMap<String, String> mapData);
	
	 /*
	  * 1. 메소드명: updateFackbookToken
	  * 2. 클래스명: SystemAuthMapper
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
	 *   @param mapData	
	 */
	
	public void updateFackbookToken(HashMap<String, String> mapData);

	 /*
	  * 1. 메소드명: selectCheckToken
	  * 2. 클래스명: SystemAuthMapper
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
	
	public Integer selectrCheckNaverToken(String accessToken);

	 /*
	  * 1. 메소드명: selectrCheckKakaoToken
	  * 2. 클래스명: SystemAuthMapper
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
	
	public Integer selectrCheckKakaoToken(String accessToken);

	 /*
	  * 1. 메소드명: selectrCheckGoogleToken
	  * 2. 클래스명: SystemAuthMapper
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
	
	public Integer selectrCheckGoogleToken(String accessToken);

	 /*
	  * 1. 메소드명: deleteAuthProgramRel
	  * 2. 클래스명: SystemAuthMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		권한 삭제시 프로그램 권한 관계 테이블 flag = 0
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	public void deleteAuthProgramRel(SystemAuthMenuListRequestDto reqDto);

	 /*
	  * 1. 메소드명: deleteAuthObjectRelList
	  * 2. 클래스명: SystemAuthMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		권한 삭제시 오브젝트 권한 관계 테이블 flag = 0
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	public void deleteAuthObjectRelList(SystemAuthMenuListRequestDto reqDto);

	 /*
	  * 1. 메소드명: modifyUserFirstLoginFlg
	  * 2. 클래스명: SystemAuthMapper
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
	 */
	public void modifyUserFirstLoginFlg(UserDetailReqDto plr);

	 /*
	  * 1. 메소드명: selectEmpAddListModalForCallCenter
	  * 2. 클래스명: SystemAuthMapper
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
	
	public List<SystemAuthGroupEmployeeModalResDto> selectEmpAddListModalForCallCenter(
			SystemAuthGroupEmployeeModalReqDto bagem);

	 /*
	  * 1. 메소드명: insertUserPwd
	  * 2. 클래스명: SystemAuthMapper
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
	 *   @param plr	
	 */
	
	public void insertUserPwd(UserDetailReqDto plr);

	 /*
	  * 1. 메소드명: selectUserBePwd
	  * 2. 클래스명: SystemAuthMapper
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
	 *   @param plr
	 *   @return	
	 */
	
	public List<String> selectUserBePwd(UserDetailReqDto plr);

}
