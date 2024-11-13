 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.auth.mapper;

import java.util.List;
import java.util.Map;

import com.icignal.auth.dto.request.InitPasswordReqDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.loyalty.operationpolicymgt.dto.response.OperationPolicyDetailResDto;
import com.icignal.marketing.contents.dto.response.MktContentResDto;
import org.apache.ibatis.annotations.Mapper;

import com.icignal.auth.dto.request.LoginCertSmsReqDto;
import com.icignal.auth.dto.request.LoginReqDto;
import com.icignal.auth.dto.request.UserIpInfoListReqDto;
import com.icignal.auth.dto.response.AuthCrmUserDto;
import com.icignal.auth.dto.response.DataAuthResDto;
import com.icignal.auth.dto.response.LoginCertSmsResDto;
import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.dto.request.MenuFrontReqDto;
import com.icignal.common.base.dto.request.SubAccountReqDto;
import com.icignal.common.base.dto.response.MenuFrontResDto;

/**
 * 1. FileName	: LoginMapper.java
 * 2. Package	: com.icignal.auth.mapper
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 18. 오후 2:45:12
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 18.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: LoginMapper
 * 2. 파일명	: LoginMapper.java
 * 3. 패키지명	: com.icignal.auth.mapper
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 18.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoginMapper {
	public LoginResDto loginConfirm(LoginReqDto reqDto);
	//public StatusResDto insertLoginHistory(LoginReqDto reqDto);
	
	
	public void insertLoginHistory(LoginReqDto reqDto);
	
	public void updateUserPwCntReset(LoginReqDto reqDto);
	public Integer selectUserPwCnt(LoginReqDto reqDto);
	public void updateLoginUserPwCnt(LoginReqDto reqDto);
	public void updateLoginUserPwLockDate(LoginReqDto reqDto);
	
	public List<Map<String, String>> selectUserIpInfoList(UserIpInfoListReqDto reqDto);
	public List<DataAuthResDto> selectDataAuthorityList(LoginReqDto reqDto);
	public List<String> selectSubAccountList(SubAccountReqDto reqDto);
	public List<MenuFrontResDto> getMenuFront(MenuFrontReqDto reqDto);
	public void insertCertiCode(LoginCertSmsReqDto reqDto);
	public Integer validUserCertiTime(LoginCertSmsReqDto reqDto);
	public Integer validUserCertiPwdCnt(LoginCertSmsReqDto reqDto);
	public Integer checkTransCetiSms(LoginCertSmsReqDto reqDto);
	public void resetUserCertiPwdCnt(LoginCertSmsReqDto reqDto);
	public void updateCertiSmsFailCnt(LoginCertSmsReqDto reqDto);
	public Integer validEmailPwd(LoginCertSmsReqDto reqDto);
	public void updateLoginUserPwCnt(LoginCertSmsReqDto reqDto);
	public LoginCertSmsResDto getReciveMbrPhoneNumber(LoginCertSmsReqDto reqDto);
	public Integer checkTelNum(LoginCertSmsReqDto reqDto);
	public LoginCertSmsResDto getCallBackPhoneNumber();
	public LoginResDto getSmsCheckYn();
	
	
	public void insertTestTran();
	public void insertTestTranSub();


	 /*
	  * 1. 메소드명: naverLoginConfirm
	  * 2. 클래스명: LoginMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 7.
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
	
	public LoginResDto snsNaverLoginConfirm(LoginReqDto reqDto);


	 /*
	  * 1. 메소드명: snsKakaoLoginConfirm
	  * 2. 클래스명: LoginMapper
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
	 *   @param reqDto
	 *   @return	
	 */
	
	public LoginResDto snsKakaoLoginConfirm(LoginReqDto reqDto);


	 /*
	  * 1. 메소드명: snsGoogleLoginConfirm
	  * 2. 클래스명: LoginMapper
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
	 *   @param reqDto
	 *   @return	
	 */
	
	public LoginResDto snsGoogleLoginConfirm(LoginReqDto reqDto);


	 /*
	  * 1. 메소드명: checkLastLoginDate
	  * 2. 클래스명: LoginMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		마지막 로그인 날짜 확인 (30일이 넘으면 해제시킴)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public Integer cntLoginDate(LoginReqDto reqDto);
	public String checkLastLoginDate(LoginReqDto reqDto);


	 /*
	  * 1. 메소드명: updateUserStat
	  * 2. 클래스명: LoginMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로그인 기준일 이후 로그인한 직원의 USER_STAT = 'INACTIVE'(비활성)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	public void updateUserStat(LoginReqDto reqDto);


	 /*
	  * 1. 메소드명: crmUserState
	  * 2. 클래스명: LoginMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로그인하는 사용자의 상태 확인 - USER_STAT (ACTIVE : 활성, INACTIVE : 비활성, HOLDING: 보류)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public String crmUserState(LoginReqDto reqDto);


	 /*
	  * 1. 메소드명: selectCrmUserIp
	  * 2. 클래스명: LoginMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 11. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param br
	 *   @return	
	 */
	
	public AuthCrmUserDto selectCrmUserIp(LoginCertSmsReqDto br);


	public int managerCheck(LoginReqDto param);
	
	public String acesStartDate(LoginReqDto reqDto);

	public String acesEndDate(LoginReqDto reqDto);

	/*
	 * 1. 메소드명: updateTemporaryPassword
	 * 2. 클래스명: LoginMapper
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 02. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		임시 비밀번호로 변경
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public void updateTemporaryPassword(InitPasswordReqDto reqDto);

	/*
	 * 1. 메소드명: selectEmpMobileNum
	 * 2. 클래스명: LoginMapper
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 02. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		직원 휴대폰 전화번호 검색
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public String selectEmpMobileNum(InitPasswordReqDto reqDto);

	/*
	 * 1. 메소드명: selectEmpName
	 * 2. 클래스명: LoginMapper
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 02. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		직원 이름 검색
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public String selectEmpName(InitPasswordReqDto reqDto);

	/*
	 * 1. 메소드명: selectCrmUserId
	 * 2. 클래스명: LoginMapper
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 02. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사용자 아이디 유효성 검사
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto selectCrmUserId(InitPasswordReqDto reqDto);

	/*
	 * 1. 메소드명: selectOperationPolicyInitPwYn
	 * 2. 클래스명: LoginMapper
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 02. 24.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		운영정책: BO 임시 비밀번호 발급 사용여부 확인
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public String selectOperationPolicyInitPwYn(InitPasswordReqDto reqDto);

	/*
	 * 1. 메소드명: selectOperationPolicyDetailInitPw
	 * 2. 클래스명: LoginMapper
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 02. 24.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		운영정책: BO 임시 비밀번호 발급 정책속성값(공통코드) 사용여부 확인
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public List<OperationPolicyDetailResDto> selectOperationPolicyDetailInitPw(InitPasswordReqDto reqDto);

	/*
	 * 1. 메소드명: selectOperationPolicyDetailPropInitPwYn
	 * 2. 클래스명: LoginMapper
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 02. 24.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		운영정책: BO 임시 비밀번호 발급 세부속성(컨텐츠) 사용여부 확인
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */
	public LoginResDto selectOperationPolicyDetailPropInitPwYn(OperationPolicyDetailResDto param);

	/*
	 * 1. 메소드명: selectContentForInitPw
	 * 2. 클래스명: LoginMapper
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 02. 24.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		운영정책: BO 임시 비밀번호 발급 컨텐츠 내용 검색
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */
	public MktContentResDto selectContentForInitPw(OperationPolicyDetailResDto param);
}

