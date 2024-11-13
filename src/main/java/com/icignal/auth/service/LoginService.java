 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.auth.service;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;

import com.icignal.auth.dto.request.InitPasswordReqDto;
import com.icignal.auth.mapper.LoginEshopMapper;
import com.icignal.common.tranChnl.mapper.TranChnlEshopMapper;
import com.icignal.common.tranChnl.model.TranChnlDto;
import com.icignal.common.util.*;
import com.icignal.loyalty.operationpolicymgt.dto.response.OperationPolicyDetailResDto;
import com.icignal.marketing.contents.dto.response.MktCondResDto;
import com.icignal.marketing.contents.dto.response.MktContentResDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.icignal.auth.dto.request.LoginCertSmsReqDto;
import com.icignal.auth.dto.request.LoginReqDto;
import com.icignal.auth.dto.request.UserIpInfoListReqDto;
import com.icignal.auth.dto.response.AuthCrmUserDto;
import com.icignal.auth.dto.response.DataAuthResDto;
import com.icignal.auth.dto.response.LoginCertSmsResDto;
import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.exception.LoginWrongUserInfoException;
import com.icignal.auth.mapper.LoginMapper;
import com.icignal.common.base.dto.request.MenuFrontReqDto;
import com.icignal.common.base.dto.request.SubAccountReqDto;
import com.icignal.common.base.dto.response.MenuFrontResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.AsyncService;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.external.thundermail.dto.request.ThunderMailReqDto;
import com.icignal.external.thundermail.service.ThunderMailService;
import org.springframework.transaction.annotation.Transactional;


/**
 * 1. FileName	: LoginService.java
 * 2. Package	: com.icignal.common.login.service
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 18. 오전 10:01:44
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 18.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: LoginService
 * 2. 파일명	: LoginService.java
 * 3. 패키지명	: com.icignal.common.login.service
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 18.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoginService {
	
	@Autowired LoginEshopMapper loginEshopMapper;
	@Autowired LoginMapper  loginMapper;
	@Autowired AsyncService  asyncService;
	@Autowired TranChnlEshopMapper tranChnlEshopMapper;
	

	
   
	public LoginResDto loginConfirm(LoginReqDto reqDto){
		LogUtil.param( this.getClass(), reqDto);
		
		reqDto.setSVCAlias("e");
//		LoginResDto rtnValue = (LoginResDto) this.queryForObject(LoginResDto.class, "MKTLogin.loginConfirm", reqDto, true);

		LoginResDto rtnValue;
		String email = reqDto.getEmail();
		if(email.endsWith("_admin")){
			reqDto.setEmail(email.substring(0,email.length()-6));
			reqDto.setPolicyInfo(true);
			rtnValue = loginMapper.loginConfirm(reqDto);

			if(rtnValue == null) {
				reqDto.setEmail(email);
				rtnValue = loginMapper.loginConfirm(reqDto);
			}
			else{
				reqDto.setLastLoginDate(loginMapper.checkLastLoginDate(reqDto));
				rtnValue.setFirstLoginFlag("0");
			}
		}
		else{
			rtnValue = loginMapper.loginConfirm(reqDto);
		}


		/*if(rtnValue == null) {
			throw new LoginWrongUserInfoException("Not Found User Info");
		}*/

		if(rtnValue != null) {
			rtnValue.setLastLoginDate(reqDto.getLastLoginDate());
			
			//로그인 시도 사용자의 ip 추출
			String host = "";
			try {
				host = InetAddress.getLocalHost().getHostAddress();
			} catch (UnknownHostException e) {
				LogUtil.error(e);
			}
			
			reqDto.setServer(host);
			
			//사용자 상태 확인
			String userStat = loginMapper.crmUserState(reqDto);
			if("INACTIVE".contentEquals(userStat)) {
				throw new LoginWrongUserInfoException("userStatInactive");
			}
			
			Boolean pwExpDtFlag = false;
			
			/*
			 * BAT KOREA 이중로그인으로인한 로그인잠금 해제
			 * 
			 * 
			 * if(rtnValue.getUserPwCnt() >= Integer.parseInt(Common.getInstance().getServletProp("loyalty.login.pwdTryLimit"))){
				
				//로그인 잠금 30분 제한시간 지난 경우
				if(ObjectUtil.isEmpty(rtnValue.getUserPwLockDate())) {
					//로그인 비밀번호 입력 5번 이상 실패했을 시
					throw new LoginWrongUserInfoException("overUserPwCnt");
				} 
				//로그인 잠금 30분 제한 풀리지 않은 경우
				else {
					if(rtnValue.getUserPwCnt() == 5) {
						//관리자 이메일 발송
						//sendLoginLockNoticeEmail(lr);
						
						//관리자 이메일 발송 이후 로그인시도 시 이메일 발송하지 않기 위해 로그인 실패 횟수 +1
						this.update("MKTLogin.updateLoginUserPwCnt", lr, true);
					}
					
					rtnValue.setSuccess(false);
					//로그인 30분 제한 풀림까지 남은시간 반환 (분)
					rtnValue.setMessage("remainingTime/"+rtnValue.getRemainingTime());
					return rtnValue;
				}
			}*/
			
			//사용자의 사용시작일,사용종료일(계정 사용기간)에 대한 확인
			Date excuteDateEqul = null;
			Date excuteDateStart= null;
			Date excuteDateEnd= null;
			try {
				String excuteDateDataStart = loginMapper.acesStartDate(reqDto);
				String excuteDateDataEnd = loginMapper.acesEndDate(reqDto);

				SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
				String format_time1 = format1.format (System.currentTimeMillis());


				if(StringUtil.isNotEmpty(format_time1)) {
					excuteDateEqul = format1.parse(format_time1);
				}
				if(StringUtil.isNotEmpty(excuteDateDataStart)) {
					excuteDateStart = format1.parse(excuteDateDataStart);
				}
				if(StringUtil.isNotEmpty(excuteDateDataEnd)) {
					excuteDateEnd = format1.parse(excuteDateDataEnd);
				}

			} catch (Exception e) {
				LogUtil.error(e);
			}
			//사용시작일
			if(StringUtil.isNotEmpty(excuteDateStart) && excuteDateEqul.compareTo(excuteDateStart) <= 0 ) {
				throw new LoginWrongUserInfoException("acesStartDateOver");
			}
			//사용종료일
			if(StringUtil.isNotEmpty(excuteDateEnd) && excuteDateEqul.compareTo(excuteDateEnd) >= 0 ) {
				throw new LoginWrongUserInfoException("acesEndDateOver");
			}
			
			//성공한 로그인 이력이 있는지 확인(신규회원이면 0)
			int cntLoginDate = loginMapper.cntLoginDate(reqDto);
			if(cntLoginDate > 0 && !checkLastLogin(reqDto.getLastLoginDate())) {
				//마지막으로 로그인한 날짜 확인
				//String LastLoginDate = loginMapper.checkLastLoginDate(reqDto);
				//HttpSession session = request.getSession(true);
				//session.setAttribute("LastLoginDate", LastLoginDate);
				
//				if(!checkLastLogin(reqDto.getLastLoginDate())) {
					//System.out.println("로그인한 날짜가 30일이 지났습니다. 관리자에게 문의하세요.");
					loginMapper.updateUserStat(reqDto);
					
					throw new LoginWrongUserInfoException("lastLoginDateOver");
//				}
			}
			
			
			if(rtnValue.getUserPwChangeExpDt() != null){
				long difTime = 0;
				
				try {
					difTime = calDifTime(rtnValue.getUserPwChangeExpDt());
				} catch (ParseException e1) {
					LogUtil.error(e1);
				}
				
				//로그인 패스워드 만료일 property
				int limitDay =  Integer.parseInt(BeansUtil.getApplicationProperty("icignal.login.password.limit-day"));
				//현재 날짜
				SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyy-MM-dd");
				String todayDate = dateFormat.format (System.currentTimeMillis());
				String dataCheck = rtnValue.getUserPwChangeExpDt();
				String[] dataCheckArray = dataCheck.split(" ");
			    String pwExpirDate = dataCheckArray[0].toString().trim();
				
				int loginPassChangeCheck = DateUtil.getDaysDiff(todayDate , pwExpirDate);
				//로그인 사용자 비밀번호 변경 만료일 확인 (1000 * 60 * 60 * 24 = 86400000 -> 1 day)
				//difTime/86400000
				if(loginPassChangeCheck >= limitDay){
					pwExpDtFlag = true;
				}
			}
			
			reqDto.setHistoryId(CommonUtil.newRid());
			reqDto.setMemId(rtnValue.getId());
			
			//로그인 사용자 IP접근제어
			rtnValue = chkUserHasIpAuth(rtnValue,host);
			if(!rtnValue.getSuccess()){
				throw new LoginWrongUserInfoException(rtnValue.getMessage());
			}
		
	//	    loginMapper.insertLoginHistory(reqDto);
		  
			// self-invocation 의 경우 async 처리
			asyncService.run( () -> loggingLoginHistoy(reqDto));
		
			
			//로그인 성공 시, com.crm_user의 USER_PW_CNT, USER_PW_LOCK_DATE 초기화
			loginMapper.updateUserPwCntReset(reqDto);
			//System.out.println("reqDto.getHistoryId(): " + reqDto.getHistoryId());
			
			rtnValue.setSuccess(true);
			rtnValue.setMessage(reqDto.getHistoryId());
			
			
			if(pwExpDtFlag)	rtnValue.setMessage(reqDto.getHistoryId()+",pwChangeExp");
			
			
			
		} else {
			
			Integer cnt = loginMapper.selectUserPwCnt(reqDto);
			cnt = Optional.ofNullable(cnt).orElse(0);
			
            int lockCnt = BeansUtil.getApplicationProperty("icignal.login.lock.cnt", Integer.class , -1);
          
			if(cnt == lockCnt){
						
				loginMapper.updateLoginUserPwCnt(reqDto);
				loginMapper.updateLoginUserPwLockDate(reqDto);
				//관리자 이메일 발송 (썬더메일용만 구현됨.)
				if ( StringUtil.compareLoozy("true",  BeansUtil.getApplicationProperty("icignal.login.lock.admin-alert.check")) &&
					 StringUtil.compareLoozy("thundermail",  BeansUtil.getApplicationProperty("icignal.login.lock.admin-alert.method"))) sendThunderMail(reqDto);
				
				throw new LoginWrongUserInfoException("overUserPwCnt");
				
			}else{
//				reqDto.setHistoryId(iMKTBase.getRowID());
				reqDto.setHistoryId(CommonUtil.newRid());
				
				//비밀번호 틀린 이력 남기기 com.login_history
				reqDto.setLoginSuccessYn("N");
				reqDto.setMemId("loginFailed");
				//this.insert("MKTLogin.insertLoginHistory", reqDto);
				
				loginMapper.insertLoginHistory(reqDto);
						
				//관리자 유무 체크
				int managerCheck = loginMapper.managerCheck(reqDto);
				//비밀번호 틀린 경우 cnt 수정 com.crm_user USER_PW_CNT
				//this.update("MKTLogin.updateLoginUserPwCnt", reqDto, true);
				//관리자의 경우 잠금 횟수 수정 금지
				if(managerCheck == 0) {
					loginMapper.updateLoginUserPwCnt(reqDto);
				}
				
				if(cnt >= lockCnt) {
					//로그인 비밀번호 입력 5번 이상 실패했을 시 30분 로그인 제한					
					//this.update("MKTLogin.updateLoginUserPwLockDate", reqDto, true);
					loginMapper.updateLoginUserPwLockDate(reqDto);
					throw new LoginWrongUserInfoException("overUserPwCnt");
				}
				
				
				throw new LoginWrongUserInfoException("idPwd");
			}
		}

			return rtnValue;
	}
	
	private boolean checkLastLogin(String lastLoginDate) {
		
		String lockDate = CommonUtil.getInstance().getServletProp("icignal.login.lock.date");
		
		SimpleDateFormat formDate = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		Calendar cal = Calendar.getInstance();
		Date loginDate;
		String value = null;
		String today = formDate.format(cal.getTime());

		try {
			loginDate = formDate.parse(lastLoginDate);
			cal.setTime(loginDate);
			cal.add(Calendar.DATE, Integer.parseInt(lockDate)); 
			value = formDate.format(cal.getTime());

		} catch (ParseException e) {
			LogUtil.error(e);
		}
		
		if(Integer.parseInt(value) < Integer.parseInt(today) ) {
			return false;
		}else {
			return true;
		}
		
		
		
	}
	
	
	public void loggingLoginHistoy(LoginReqDto reqDto) {
		loginMapper.insertLoginHistory(reqDto);
	}
	
	/**
	* @programId :
	* @name : sendLoginLockNoticeEmail
	* @date : 2018. 12. 6.
	* @author : hy.jun
	* @table :
	* @return : void
	* @description : 로그인 잠금 시 관리자에게 이메일 발송
	* 
	*/
	 /*
	  * 1. 메소드명: sendLoginLockNoticeEmail
	  * 2. 클래스명: LoginService
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	로그인 잠금 시 관리자에게 이메일 발송
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	private void sendThunderMail(LoginReqDto reqDto) {
		//관리자 이메일 발송
		ThunderMailReqDto lctr = new ThunderMailReqDto();
		lctr.setAutomailID(CommonUtil.getInstance().getServletProp("icignal.login.lock.admin-alert.mail.automail-id"));
		lctr.setEmailAddr(CommonUtil.getInstance().getServletProp("icignal.login.lock.admin-alert.mail.mail-addr"));
		
		//자동메일 템플릿 일대일치환값 세팅
		HashMap<String, String> onetooneInfoMap = new HashMap<String, String>(); 
		onetooneInfoMap.put("name", CommonUtil.getInstance().getServletProp("icignal.login.lock.admin-alert.mail.mail-name"));
		onetooneInfoMap.put("etc1", reqDto.getEmail()); //로그인 시도 아이디
		onetooneInfoMap.put("etc2", reqDto.getServer()); //로그인 시도 IP
		onetooneInfoMap.put("etc3", CommonUtil.getInstance().getServletProp("icignal.login.lock.cnt")); // 로그인 실패 횟수
		onetooneInfoMap.put("etc4", DateUtil.getToday("yyyy년 MM월 dd일 HH시 mm분"));
		
		lctr.setOnetooneInfoMap(onetooneInfoMap);
		// 썬더메일 발송
		ThunderMailService tms = new ThunderMailService();
		tms.sendEmailAutoMail(lctr);
		
	}
	
	/**
	 * @name : chkUserHasIpAuth
	 * @date : 2017. 11. 23.
	 * @author : jun.lee
	 * @return : LoginResDto
	 * @description : 로그인 사용자 IP접근제어 목록 조회
	 */
	public LoginResDto chkUserHasIpAuth(LoginResDto rtnValue, String host){
		UserIpInfoListReqDto ipReqDto = new UserIpInfoListReqDto();
		List<Map<String,String>> ipRtnValue = new ArrayList<>();
		
		ipReqDto.setRid(rtnValue.getId());		
		ipRtnValue = loginMapper.selectUserIpInfoList(ipReqDto);
		
		if(!ipRtnValue.isEmpty()){
			Boolean ipFlag = false;
			Boolean aclType1Flag = false;
			
			//aclType=1 인 경우
			for(int i=0; i<ipRtnValue.size(); i++){
				String aclType = ipRtnValue.get(i).toString().split(",")[0].replace("{","").replace("aclType=","");
				String accessIpAddr = ipRtnValue.get(i).toString().split(",")[1].trim().replace("}","").replace("accessIpAddr=","");
				
				if(aclType.equals("1")){
					aclType1Flag = true;
					
					if(accessIpAddr.equals(host)){
						ipFlag = true;
						break;
					}
				}
			}
			
			if(!aclType1Flag){
				//aclType=2 인 경우
				for(int i=0; i<ipRtnValue.size(); i++){
					String aclType = ipRtnValue.get(i).toString().split(",")[0].replace("{","").replace("aclType=","");
					String accessIpAddr = ipRtnValue.get(i).toString().split(",")[1].trim().replace("}","").replace("accessIpAddr=","");
					
					if(aclType.equals("2")){
						Boolean chkFlag = false;
						
						chkFlag = compareIpAddr(host,accessIpAddr);
						
						if(chkFlag){
							ipFlag = true;
							break;
						}
					}
				}
			}
			
			if(!ipFlag){
				rtnValue.setSuccess(false);
				rtnValue.setMessage("notIpAuth");
				
				return rtnValue;
			}
		}
		
		rtnValue.setSuccess(true);
		rtnValue.setMessage("");
		
		return rtnValue;
	}
    
	/**
	 * @name : compareIpAddr
	 * @date : 2017. 11. 23.
	 * @author : jun.lee
	 * @return : boolean
	 * @description : IP주소 비교
	 */
	private boolean compareIpAddr(String ipAddr1, String ipAddr2){
		
		int count = 0;
		int num = 0;
		String inIpAddr1 = ipAddr1;
		String inIpAddr2 = ipAddr2;
		
		count = countSubstring(inIpAddr2,"*");
		
		for(int i=0; i<(count); i++){
			num = inIpAddr2.lastIndexOf('.');
			inIpAddr2 = inIpAddr2.substring(0,num);
		}
		
		inIpAddr1 = inIpAddr1.substring(0,num);
		
		
		if(inIpAddr1.equals(inIpAddr2)){
			return true;
		}
		
		return false;
	}
	
	/**
	 * @name : countSubstring
	 * @date : 2017. 11. 23.
	 * @author : jun.lee
	 * @return : int
	 * @description : 문자수 세기
	 */
	private int countSubstring(String src, String sub) {
		int count = 0;
		int index = 0;
       if(src == null || sub == null) return 0;
       
       index = src.indexOf(sub, index);
		while( index > 0 ) {
			count++;
			index += sub.length();
		}

		return count;
	}
	
	/**
	 * @name : calDifTime
	 * @date : 2017. 11. 23.
	 * @author : jun.lee
	 * @return : long
	 * @throws ParseException 
	 * @description : 날짜 차이 계산
	 */
	public long calDifTime(String date) throws ParseException{
		Date curDate = new Date(); 
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
		
		curDate = dateFormat.parse(dateFormat.format(curDate));
		long curDateTime = curDate.getTime();
		
		Date reqDate = dateFormat.parse(date); 
		long reqDateTime = reqDate.getTime();
		
		long difTime = curDateTime - reqDateTime;
		
		return difTime;
	}
	
    /**
     * @name : getDataAuthorityList
     * @date : 2015. 12. 29.
     * @author : "류동균"
     * @description : DATA 권한
     */    
    public List<DataAuthResDto> getDataAuthorityList(LoginReqDto reqDto) {
        LogUtil.param(LoginResDto.class, reqDto);
        
        List<DataAuthResDto> rtnValue = new ArrayList<DataAuthResDto>();
        
      //  rtnValue = this.queryForList("MKTLogin.selectDataAuthorityList", reqDto);
        //  rtnValue = this.queryForList("MKTLogin.selectDataAuthorityList", reqDto);
        rtnValue = loginMapper.selectDataAuthorityList(reqDto);
        return rtnValue;
    }
    
    /**
     * @name : selectSubAccountList
     * @date : 2015. 12. 29.
     * @author : "류동균"
     * @description : 하위부서 조회
     */
    public List<String> selectSubAccountList(SubAccountReqDto reqDto) {
        
        List<String> rtnValue = new ArrayList<String>();
       // rtnValue = this.queryForList("MKTLogin.selectSubAccountList", accId);
        rtnValue = loginMapper.selectSubAccountList(reqDto);
        
        return rtnValue;
    }

	
	public List<MenuFrontResDto> getMenuFront(MenuFrontReqDto reqDto) {
		reqDto.setStrSVCType("");
	//	return this.queryForList("MKTLogin.getMenuFront", dto);
		return loginMapper.getMenuFront(reqDto);
	}

	/**
	* @programId :
	* @name : insertCertiCode
	* @date : 2019. 7. 19.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description : 인증번호 DB에 insert
	*/
	
	public StatusResDto insertCertiCode(LoginCertSmsReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		//this.update("MKTLogin.insertCertiCode", reqDto);
		loginMapper.insertCertiCode(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
		
	}

	/**
	* @programId :
	* @name : checkTransCetiSms
	* @date : 2019. 7. 19.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description : 인증확인
	*/
	
	public StatusResDto checkTransCertSms(LoginCertSmsReqDto param) {
		//LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		//3분 넘었는지 체크
	//	int checkCertiTime = (int) this.queryForObject(this.getClass(), "MKTLogin.validUserCertiTime", param, true);
		int checkCertiTime = loginMapper.validUserCertiTime(param);
		if(checkCertiTime > 0) {
			//인증비밀번호 5회이상 실패여부
			//int checkCertiCnt = (int) this.queryForObject(this.getClass(), "MKTLogin.validUserCertiPwdCnt", param, true);
			int checkCertiCnt = loginMapper.validUserCertiPwdCnt( param );
			
			if(checkCertiCnt <5) {
				//SMS 인증
//				int checkCerti = (int) this.queryForObject(this.getClass(), "MKTLogin.checkTransCetiSms", param, true);
				int checkCerti = loginMapper.checkTransCetiSms(param);
				
				if(checkCerti == 1) { //SMS 인증성공
					loginMapper.resetUserCertiPwdCnt(param); //비밀번호 틀린횟수 초기화
					rtnValue.setSuccess(true);
				}else { //SMS 인증 실패
					//실패횟수 증가
					loginMapper.updateCertiSmsFailCnt(param);
					rtnValue.setSuccess(false);
					rtnValue.setMessage("잘못된인증번호를 입력하셨습니다.");
				}
			}else {
				rtnValue.setMessage("인증비밀번호 5회 이상 실패하였습니다.\n관리자에게 문의하십시오.");
			}
		}else {
			rtnValue.setMessage("인증시간이 만료되었습니다.");
		}
		return rtnValue;
	}

	/**
	* @programId :
	* @name : validEmailPwd
	* @date : 2019. 7. 19.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	
	public StatusResDto validEmailPwd(LoginCertSmsReqDto br) {
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		//인증비밀번호 5회이상 초과인지 여부 판단
		int certiCnt = loginMapper.validUserCertiPwdCnt(br);
		
		if(certiCnt < 5) {
				//이메일비밀번호가 맞는치 여부판단
				int validCheck = loginMapper.validEmailPwd(br);
				if(validCheck == 0) {
					loginMapper.updateLoginUserPwCnt(br); //비밀번호 틀린횟수증가
					rtnValue.setSuccess(false);
					rtnValue.setMessage("이메일 또는 비밀번호가 틀렸습니다.");
				}else {
					rtnValue.setSuccess(true);
					
					Gson gson = new Gson();
					JsonObject object = new JsonObject();
					object.addProperty("authSmsYn", "true");
					
					rtnValue.setMessage(gson.toJson(object));
				}
		}else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("현재 SMS인증 로그인 시도 5회 실패하였습니다. \n관리자에게 문의하십시오.");
		}
		return rtnValue;
	}

	/**
	* @programId :
	* @name : getRecivePhoneNumber
	* @date : 2019. 7. 22.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	
	public LoginCertSmsResDto getRecivePhoneNumber(LoginCertSmsReqDto param) {
		return new AnnotationHelper<LoginCertSmsResDto>(AnnotationType.CommCode, loginMapper.getReciveMbrPhoneNumber(param)).getItem();
	}

	/**
	* @programId :
	* @name : checkTelNum
	* @date : 2019. 7. 23.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	
	public StatusResDto checkTelNum(LoginCertSmsReqDto param) {
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		int numberCheck = loginMapper.checkTelNum( param );
		if(numberCheck > 0) {
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}

	/**
	* @programId :
	* @name : getCallBackPhoneNumber
	* @date : 2019. 7. 23.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	
	public LoginCertSmsResDto getCallBackPhoneNumber() {
		LoginCertSmsResDto rtnValue = new LoginCertSmsResDto();
		rtnValue = loginMapper.getCallBackPhoneNumber();
		return rtnValue;
	}




	 /*
	  * 1. 메소드명: naverLoginConfirm
	  * 2. 클래스명: LoginService
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
	 *   @param lr
	 *   @return	
	 */
	
	public LoginResDto snsNaverLoginConfirm(LoginReqDto reqDto) {
		LogUtil.param( this.getClass(), reqDto);
		
		reqDto.setSVCAlias("e");
	
		LoginResDto rtnValue = loginMapper.snsNaverLoginConfirm(reqDto);
		
		String host = "";
		try{
			host = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			LogUtil.error(e);
		}
		
		reqDto.setServer(host);
		
		return rtnValue;
	}




	 /*
	  * 1. 메소드명: snsKakaoLoginConfirm
	  * 2. 클래스명: LoginService
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
	 *   @param lr
	 *   @return	
	 */
	
	public LoginResDto snsKakaoLoginConfirm(LoginReqDto reqDto) {
		LogUtil.param( this.getClass(), reqDto);
		
		reqDto.setSVCAlias("e");
	
		LoginResDto rtnValue = loginMapper.snsKakaoLoginConfirm(reqDto);
		
		String host = "";
		try{
			host = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			LogUtil.error(e);
		}
		
		reqDto.setServer(host);
		
		return rtnValue;
	}




	 /*
	  * 1. 메소드명: snsGoogleLoginConfirm
	  * 2. 클래스명: LoginService
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
	 *   @param lr
	 *   @return	
	 */
	
	public LoginResDto snsGoogleLoginConfirm(LoginReqDto reqDto) {
		LogUtil.param( this.getClass(), reqDto);
		
		reqDto.setSVCAlias("e");
	
		LoginResDto rtnValue = loginMapper.snsGoogleLoginConfirm(reqDto);
		
		String host = "";
		try{
			host = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			LogUtil.error(e);
		}
		
		reqDto.setServer(host);
		
		return rtnValue;
	}

	/**
	* @programId :
	* @name : getSmsCheckYn
	* @date : 2019. 8. 9.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	
/*	public LoginResDto getSmsCheckYn() {
		return  loginMapper.getSmsCheckYn();
	}
*/
	
	 /*
	  * 1. 메소드명: getLastLoginDate
	  * 2. 클래스명: LoginService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		마지막 로그인 날짜
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public String getLastLoginDate(LoginReqDto reqDto) {
		return loginMapper.checkLastLoginDate(reqDto);
	}

	 /*
	  * 1. 메소드명: getCrmUserIp
	  * 2. 클래스명: LoginService
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
	
	public AuthCrmUserDto getCrmUserIp(LoginCertSmsReqDto br) {
		return loginMapper.selectCrmUserIp(br);
	}

	/*
	 * 1. 메소드명: initPassword
	 * 2. 클래스명: LoginService
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 02. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 * 임시 비밀번호 발급
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param InitPasswordReqDto reqDto
	 *   @return StatusResDto rtnValue
	 */
	public StatusResDto initPassword(InitPasswordReqDto reqDto){

		StatusResDto rtnValue = new StatusResDto(false, "");

		// 사용자 아이디 유효성 검사
		StatusResDto valid = loginMapper.selectCrmUserId(reqDto);
		if(valid == null){
			// 존재하지 않는 아이디
			rtnValue.setErrorType(1);
			return rtnValue;
		}

		// 사용자 휴대전화번호 유효성 검사
		String empPhone = loginMapper.selectEmpMobileNum(reqDto);
		if(!reqDto.getReceiveMobileNo().equals(empPhone.replace("-",""))){
			// 일치하지 않는 휴대전화번호
			rtnValue.setErrorType(2);
			return rtnValue;
		}

		// 정책속성값(공통코드) 유무 검사
		List<OperationPolicyDetailResDto> operationPolicyDetailResDtoList = this.loginMapper.selectOperationPolicyDetailInitPw(reqDto);
		if(operationPolicyDetailResDtoList.size() == 0){
			// 정책속성값(공통코드)이 올바르지 않음
			rtnValue.setErrorType(3);
			return rtnValue;
		}

		// 임시 비밀번호 생성
		String RandomPwd = StringUtil.getRandomChar(10);
		reqDto.setPassword(SecurityUtil.encodePassword(RandomPwd));

		// 직원 정보 설정
		reqDto.setReceiveMobileNo(reqDto.getReceiveMobileNo().replace("-", ""));
		reqDto.setEmpName(loginMapper.selectEmpName(reqDto));

		for(OperationPolicyDetailResDto opd : operationPolicyDetailResDtoList){
			// 세부속성값(컨텐츠) 유무 검사
			valid = loginMapper.selectOperationPolicyDetailPropInitPwYn(opd);
			if (valid == null) {
				// 세부속성값(컨텐츠)이 올바르지 않음
				rtnValue.setErrorType(4);
				return rtnValue;
			}
			// 컨텐츠 내용 조회
			MktContentResDto content = loginMapper.selectContentForInitPw(opd);
			if(content == null){
				// 잘못된 세부속성 값
				rtnValue.setErrorType(5);
				return rtnValue;
			}

			// 발신자 번호 설정
			reqDto.setCallbackNo(content.getToCallbackNo());

			// 메세지 생성 및 설정
			String message = content.getContents();
			message = message.replace("{{사용자성명}}", reqDto.getEmpName());
			message = message.replace("{{사용자임시비밀번호}}", RandomPwd);
			reqDto.setMessage(message);
			reqDto.setSubject(content.getTitle());

			// SMS 전송
			if(opd.getDataVal().equals("SMS")){
				loginEshopMapper.insertSendSmsInitPassword(reqDto);
			}
		}

		// 암호화 임시 비밀번호로 변경
		loginMapper.updateTemporaryPassword(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}


	/*
	 * 1. 메소드명: checkOperationPolicy
	 * 2. 클래스명: LoginService
	 * 3. 작성자명: bg.yoon
	 * 4. 작성일자: 2022. 02. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 * 운영 정책 사용 여부 확인
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param InitPasswordReqDto reqDto
	 *   @return StatusResDto rtnValue
	 */
	public StatusResDto checkOperationPolicyInitPw(InitPasswordReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto(false, "");

		String useYn = loginMapper.selectOperationPolicyInitPwYn(reqDto);

		if(useYn.equals("Y")) rtnValue.setSuccess(true);
		else if(useYn.equals("N")) rtnValue.setSuccess(false);
		return rtnValue;
	}

}

