package com.icignal.auth.emailAuth.service;


import java.util.HashMap;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.auth.dto.request.LoginEmailAuthReqDto;
import com.icignal.auth.emailAuth.mapper.EmailAuthMapper;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.external.thundermail.dto.request.ThunderMailReqDto;
import com.icignal.external.thundermail.service.ThunderMailService;


@Service("EmailAuthService")
public class EmailAuthService   {
	@Autowired
	EmailAuthMapper emailAuthMapper;
	
	
	public StatusResDto authEmailConfirm(LoginEmailAuthReqDto param) {
		LogUtil.param(this.getClass(), param);
	
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		emailAuthMapper.updateEmailAuth(param);

		rtnValue.setSuccess(true);
		rtnValue.setMessage("인증에 성공하였습니다. 로그인 해주세요");
		return rtnValue;
		
		
	}
	
	 /*
	  * 1. 메소드명: insertEmailAuth
	  * 2. 클래스명: LoginService
	  * 3. 작성자명: sh.park
	  * 4. 작성일자: 2020. 2. 20.
	  */
	public StatusResDto insertEmailAuth(LoginEmailAuthReqDto param) {
		LogUtil.param(this.getClass(), param);

		StatusResDto rtnValue = new StatusResDto(false, "");
		int cnt = emailAuthMapper.insertEmailAuth(param);
		if(cnt > 0) {
			rtnValue.setSuccess(true);
		}

			return rtnValue;
	}
	
	
	public StatusResDto emailAuthCheck(LoginEmailAuthReqDto param) {

		StatusResDto rtnValue =  new StatusResDto();
		rtnValue.setSuccess(false);
		// email 인증 테이블 등록후
		param.setTokenId( CommonUtil.newRid());
		if(StringUtils.isBlank(param.getEmail())){
			rtnValue.setMessage("id를 입력해주세요.");
			return rtnValue;
		}
		param.setAuthLimitDt(BeansUtil.getApplicationProperty("icignal.login.double.email.auth-limit-time"));
		emailAuthMapper.insertEmailAuth(param);
			
		String api = BeansUtil.getApplicationProperty("icignal.login.double.email.api-method");
		
		// 선더메일 api 호출	
		if (StringUtil.compare("thundermail", api) ) {
			ThunderMailReqDto tmReqDto = new ThunderMailReqDto();
			tmReqDto.setAutomailID(CommonUtil.getInstance().getServletProp("loyalty.login.auth.email.automailId"));
			tmReqDto.setEmailAddr(param.getEmail());
			HashMap<String, String> onetooneInfoMap = new HashMap<String, String>();
			onetooneInfoMap.put("tokenId", param.getTokenId());
			onetooneInfoMap.put("authLimitDt", BeansUtil.getApplicationProperty("icignal.login.double.email.auth-limit-time"));
			onetooneInfoMap.put("authLoginLimitDt", BeansUtil.getApplicationProperty("loyalty.login.auth.email.authLoginLimitDt"));
			onetooneInfoMap.put("authLoginLimitDt", BeansUtil.getApplicationProperty("icignal.login.double.email.auth-login-limit-time"));
	
			tmReqDto.setOnetooneInfoMap(onetooneInfoMap);
			
			ThunderMailService tms = new ThunderMailService();
			rtnValue =  tms.sendEmailAutoMail(tmReqDto);
			if(rtnValue.getSuccess()){
				rtnValue.setMessage(param.getTokenId());
			}
		} else { // 썬더메일 이외의 경우 별도 구현 필요함.
			rtnValue.setMessage("이메일 인증 수단 API가 존재하지 않습니다.");
			return rtnValue;
		}
		
		return rtnValue;
	}

	
	public StatusResDto emailAuthLoginLimitDtCheck(LoginEmailAuthReqDto param) {
		StatusResDto rtnValue =  new StatusResDto();
		
		if(emailAuthMapper.emailAuthLoginIdCheck(param) == 0 ){
			rtnValue.setSuccess(false);
			rtnValue.setMessage("notEmailAuthId");
			return rtnValue;
		}
		
		if(emailAuthMapper.emailAuthDtCheck(param) ==  0 ){
			rtnValue.setSuccess(false);
			rtnValue.setMessage("notEmailAuth");
			return rtnValue;
		}
		
		if(emailAuthMapper.emailAuthSuccessChk(param.getTokenId()) ==  0 ){
			rtnValue.setSuccess(false);
			rtnValue.setMessage("emailAuthSuccessNotYn");
			return rtnValue;
		}
			
		rtnValue.setSuccess(true);
		return rtnValue;

	}
	
	

}
