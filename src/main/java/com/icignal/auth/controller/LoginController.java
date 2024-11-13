
package com.icignal.auth.controller;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.request.InitPasswordReqDto;
import com.icignal.auth.dto.request.LoginCertSmsReqDto;
import com.icignal.auth.dto.request.LoginEmailAuthReqDto;
import com.icignal.auth.dto.request.LoginReqDto;
import com.icignal.auth.dto.response.AuthCrmUserDto;
import com.icignal.auth.emailAuth.service.EmailAuthService;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.auth.service.LoginService;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.request.BaseReqDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.DateUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.external.naverservice.service.NaverService;




/**
 * @name : MKTLoginController.java
 * @date : 2015. 9. 18.
 * @author : 류동균
 * @description : 로그인
 */
@Controller
@RequestMapping("/login")
public class LoginController extends BaseController {  

	@Autowired AuthHelper authHelper;
	@Autowired EmailAuthService emailAuthService;
	@Autowired LoginService loginService;
	@Autowired NaverService naverService;


	@RequestMapping
    public String login(Device device, HttpServletRequest request, HttpServletResponse response) {
		String deviceInfo = null;
		String retunUrl = null;
		//최초 접근시 디바이스 정보
		if (device.isMobile()) {
			deviceInfo = "mobile";
			retunUrl = "base/login/mlogin.mobileFull-tiles";
		} else if (device.isTablet()) {
			deviceInfo = "mobile";
			retunUrl = "base/login/mlogin.mobileFull-tiles";
		} else {
			deviceInfo = "web";
			retunUrl = "base/login/login.defaultFull-tiles";
		}
		
		//모바일 로그인 페이지 개발시 삭제
		//retunUrl = "base/login/login.defaultFull-tiles";

		HttpSession session = request.getSession();
		session.setAttribute("deviceInfo", deviceInfo);

        // 세션 정보가 없을 경우 로그인 페이지로 이동
        return authHelper.checkUserInfo(request, response, retunUrl);
    }
    
	@Override
	@RequestMapping(value = "/{name:.+}", method = RequestMethod.GET)
	public String NavigateMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		
		//기기별 로그인페이지 호출
		String rtnValue = "base/login/login.defaultFull-tiles";
		HttpSession session = request.getSession(true);
		String deviceInfo = session.getAttribute("deviceInfo").toString();
		if(deviceInfo.equals("mobile") || deviceInfo.equals("tablet")){
			rtnValue = "base/login/" + name + ".mobileFull-tiles";
		} else {
			rtnValue = "base/login/" + name + ".defaultFull-tiles";
		}

		return authHelper.checkUserInfo(request, response,rtnValue);
	}
    
    @Override
	@RequestMapping(value = "/npopup/{name:.+}", method = RequestMethod.GET)
	public String NavigateNPopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
    	return "base/login/npopup/" + name;
	}
	

    @Override
	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		return authHelper.checkUserInfoInclude(request, response, "base/login/popup/" + name);
	}
    
	@RequestMapping(value="/loginPageConfirm.do", method=RequestMethod.POST)
    public @ResponseBody   StatusResDto loginPageConfirm(HttpServletRequest request, HttpServletResponse response,Model model) {
	    StatusResDto rtnValue = new StatusResDto();
	    return rtnValue;
	}

	@RequestMapping(value="/loginConfirm.do", method=RequestMethod.POST)
	public @ResponseBody
	StatusResDto loginConfirm(HttpServletRequest request, HttpServletResponse response, @RequestBody BaseReqDto br) {
		
		StatusResDto rtnValue = new StatusResDto();

		LoginReqDto lr = new LoginReqDto();
		lr.setEmail(request.getHeader("email"));
		lr.setPassword(request.getHeader("password"));
		lr.setPreSessionAbortYn(Boolean.valueOf(request.getHeader("preSessionAbortYn")));

		lr.setLang(request.getHeader("lang"));
		lr.setIp(CommonUtil.getClientIP(request));
		

		//향후 값 받아오는 것으로 변경할 예정(app_service_id, lang, country)
        if(lr.getLang() == null){
            lr.setLang(CommonUtil.DEFAULT_LANG);
        }

        if(StringUtils.isNotBlank(lr.getPassword())) {
			String appServiceId = DateUtil.getToday("yyyyMMdd") + BeansUtil.getApplicationProperty("icignal.context.server.appServiceId");
			
			String desPassword = SecurityUtil.decodePBKDF2WithHmacSHA1(lr.getPassword(), appServiceId,	appServiceId, appServiceId, 1000);
			String 	password = SecurityUtil.encodePassword(desPassword);
			
			lr.setPassword(password); // 객체에 암호화한 비밀번호를 저장
		}

		String loginAuthType = BeansUtil.getApplicationProperty("icignal.login.auth-type");		
		if(StringUtils.equals("single", loginAuthType)) {			
			rtnValue = authHelper.loginConfirm(lr, request, response);
			return rtnValue;
		}
		
		if(StringUtils.equals("double", loginAuthType)) {
			
			boolean isAuthPassUser = false;
			String authPassUser = BeansUtil.getApplicationProperty("icignal.login.double.auth-pass-users");
			
			if (StringUtils.isNotBlank( authPassUser) ){				
				isAuthPassUser = Arrays.asList( StringUtils.split(authPassUser, ',')).stream().anyMatch(o -> o.equals(lr.getEmail()));				
				if(isAuthPassUser) {
					lr.setDoubleAuthCheckPassUser(true);
					rtnValue = authHelper.loginConfirm(lr, request, response);
					
					return rtnValue;
				}
			}
			
			
			String doubleAuthMethod = BeansUtil.getApplicationProperty("icignal.login.double.auth-method");
				
			 if( "email".equals(doubleAuthMethod)){				 
				 String tokenId =  request.getHeader("tokenId");
				if(StringUtils.isBlank(tokenId)){
					rtnValue.setSuccess(false);
					rtnValue.setMessage("notEmailAuth");
					return rtnValue;
				}
				
				LoginEmailAuthReqDto emailAuthDto =  new LoginEmailAuthReqDto();
				emailAuthDto.setTokenId(tokenId);
				emailAuthDto.setEmail(lr.getEmail());
				rtnValue =  emailAuthService.emailAuthLoginLimitDtCheck(emailAuthDto);
				if(rtnValue.getSuccess()) rtnValue = authHelper.loginConfirm(lr, request, response);                   
				return rtnValue;
		    }
			 
		   if("sms".equals(doubleAuthMethod)) {
					LoginCertSmsReqDto req = new LoginCertSmsReqDto();
					req.setSystemColumn(lr.getSystemColumn());
					req.setEmail(lr.getEmail());
					req.setPassword(lr.getPassword());
					rtnValue = loginService.validEmailPwd(req);
					
			}
		}  // double end
	
		return rtnValue;  
	}

	/**
	* @programId :
	* @name : transCertiSms
	* @date : 2019. 7. 19.
	* @author : dw.keum
	* @table :
	* @return : StatusResDto
	* @description : 이중로그인 SMS 
	*/
	@RequestMapping(value="/transCertiSms.do", method=RequestMethod.POST)
	public @ResponseBody StatusResDto transCertiSms(HttpServletRequest request, HttpServletResponse response, @RequestBody LoginCertSmsReqDto param) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loginService.checkTransCertSms(param);
		
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : checkTelNum
	* @date : 2019. 7. 23.
	* @author : dw.keum
	* @table :
	* @return : StatusResDto
	* @description :
	*/
	@RequestMapping(value="/checkTelNum.do", method=RequestMethod.POST)
	public @ResponseBody
	StatusResDto checkTelNum(HttpServletRequest request, HttpServletResponse response, @RequestBody LoginCertSmsReqDto param) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue = loginService.checkTelNum(param);
		
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : checkTransCetiSms
	* @date : 2019. 7. 19.
	* @author : dw.keum
	* @table :
	* @return : StatusResDto
	* @description :
	*/
	@RequestMapping(value="/checkTransCetiSms.do", method=RequestMethod.POST)
	public @ResponseBody
	StatusResDto checkTransCertSms(HttpServletRequest request, HttpServletResponse response, @RequestBody LoginCertSmsReqDto param) {
		
		StatusResDto rtnValue = new StatusResDto();
		
		// 인증번호 확인
		rtnValue = loginService.checkTransCertSms(param);
		
		// 인증 성공했을경우 로그인 세션 생성
		if (rtnValue.getSuccess()) {
			
			HttpSession session = request.getSession(true);
			
			LoginReqDto lr = new LoginReqDto();
			lr.setEmail(request.getHeader("email"));
			lr.setPassword(request.getHeader("password"));
			lr.setPreSessionAbortYn(Boolean.valueOf(request.getHeader("preSessionAbortYn")));

			lr.setLang(request.getHeader("lang"));
			lr.setIp(CommonUtil.getClientIP(request));
			
			 if(StringUtils.isNotBlank(lr.getPassword())) {
//				String appServiceId = DateUtil.getToday("yyyyMMdd") + CommonUtil.getInstance().getLanguages("appServiceId");
				String appServiceId = DateUtil.getToday("yyyyMMdd") + "13e28abc1cf39fdb62b00005";
				String desPassword = SecurityUtil.decodePBKDF2WithHmacSHA1(lr.getPassword(), appServiceId, appServiceId, appServiceId, 1000);
				String password =  SecurityUtil.encodePassword(desPassword);
				lr.setPassword(password); // 객체에 암호화한 비밀번호를 저장
			}
			
			rtnValue = authHelper.loginConfirm(lr, request, response);
		}
		
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : validEmailPwd
	* @date : 2019. 7. 19.
	* @author : dw.keum
	* @table :
	* @return : StatusResDto
	* @description : 로그인시 이메일 패스워드 채크
	*/
	@RequestMapping(value="/MKTvalidEmailPwd.do", method=RequestMethod.POST)
	public @ResponseBody
	StatusResDto validEmailPwd(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoginCertSmsReqDto br) {
		
		br.setEmail(request.getHeader("email"));
		br.setPassword(request.getHeader("password"));
		
		 if(StringUtils.isNotBlank(br.getPassword())) {
			String appServiceId = DateUtil.getToday("yyyyMMdd") + "13e28abc1cf39fdb62b00005";
			String desPassword = SecurityUtil.decodePBKDF2WithHmacSHA1(br.getPassword(), appServiceId, appServiceId, appServiceId, 1000);
			String password =  SecurityUtil.encodePassword(desPassword);
			br.setPassword(password); // 객체에 암호화한 비밀번호를 저장
		}
		return loginService.validEmailPwd(br);
	}
	
	@RequestMapping(value="/getCrmUserIp.do", method=RequestMethod.POST)
	public @ResponseBody
	AuthCrmUserDto getCrmUserIp(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoginCertSmsReqDto br) {
		
		if(StringUtils.isNotEmpty(br.getUserId())){
			if(br.getUserId().contains("_admin")){
				br.setUserId(br.getUserId().replace("_admin",""));
			}
		}

		return loginService.getCrmUserIp(br);
	}

	/**
	 * @programId :
	 * @name : initPassword
	 * @date : 2022. 2. 18.
	 * @author : bg.yoon
	 * @table :  
	 * @return : StatusResDto
	 * @description : 사용자 ID로 비밀번호 초기화(임시 비밀번호) 후 SMS 전송
	 */
	@RequestMapping(value="/initPassword.do", method=RequestMethod.POST)
	public @ResponseBody
	StatusResDto initPassword(HttpServletRequest request, HttpServletResponse response,
								@RequestBody InitPasswordReqDto reqDto) {
		return loginService.initPassword(reqDto);
	}

	/**
	 * @programId :
	 * @name : checkOperationPolicy
	 * @date : 2022. 2. 21.
	 * @author : bg.yoon
	 * @table :
	 * @return : StatusResDto
	 * @description : 비밀번호 초기화 운영정책 사용여부 확인
	 */
	@RequestMapping(value="/checkOperationPolicyInitPw.do", method=RequestMethod.POST)
	public @ResponseBody
	StatusResDto checkOperationPolicy(HttpServletRequest request, HttpServletResponse response,
							  @RequestBody InitPasswordReqDto reqDto) {
		return loginService.checkOperationPolicyInitPw(reqDto);
	}
	

}
