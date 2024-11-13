package com.icignal.auth.emailAuth.controller;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.request.LoginEmailAuthReqDto;
import com.icignal.auth.emailAuth.service.EmailAuthService;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.MailUtils;
import com.icignal.common.util.ObjectUtil;




@Controller
@RequestMapping("/auth/email")
public class EmailAuthController {
	
	@Autowired
	EmailAuthService emailAuthservice;
	
	static final Logger logger = LoggerFactory.getLogger(EmailAuthController.class);

	@RequestMapping(value = "/authEmailConfirm", method = RequestMethod.POST)
	public @ResponseBody StatusResDto authEmailConfirm(HttpServletRequest request, HttpServletResponse response,
			@RequestBody LoginEmailAuthReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		return emailAuthservice.authEmailConfirm(param);
	}
	

    @RequestMapping(value="/sendMailSmtp.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto sendMailSmtp(HttpServletRequest request, HttpServletResponse response, @RequestBody JSONObject param) {
    	LogUtil.param(this.getClass(), param);

    	MailUtils.SendInfo sendInfo = new MailUtils.SendInfo();
    	sendInfo.setContent("이메일 인증");
    	try {
			sendInfo.setSendTo(param.get("sendTo").toString());
		} catch (JSONException e) {
			logger.error(e.getMessage(), e);
		}
    	sendInfo.setSubject("이메일 인증");

    	return MailUtils.sendMailSmtp(sendInfo);
    }

    
    /**
    * @programId :
    * @name : sendMailSmtp2
    * @date : 2020. 01. 20.(사용시 username password 변수 변경 필요 /mailUrl properties 관리 필요)
    * @author : sh.park
    * @table :
    * @return : sendMailSmtp2
    * @description : smtp 이메일 전송
    */
    @RequestMapping(value="/sendMailSmtp2.do", method = RequestMethod.POST)
    public @ResponseBody StatusResDto sendMailSmtp2(HttpServletRequest request, HttpServletResponse response, @RequestBody LoginEmailAuthReqDto param) throws AddressException, MessagingException {
    	StatusResDto rtnValue =new StatusResDto();
    	
    	param.setTokenId(CommonUtil.newRid());
    	param.setRid(CommonUtil.newRid());
    	
		if(ObjectUtil.isEmpty(param.getEmail())){
			rtnValue.setMessage("id를 입력해주세요.");
			return rtnValue;
		}
		
		param.setAuthLimitDt(CommonUtil.getInstance().getServletProp("loyalty.login.auth.email.authLimitDt"));  //properties 주석처리 되있습니다.
		emailAuthservice.insertEmailAuth(param);

    	/*보내는 사람 username/ password*/ 
    	String host = "smtp.gmail.com";  
    	//BeansUtil.getApplicationProperties(key);
    	final String username = "0830thgus"; 
    	final String password = ""; 
    	int port=465; //포트번호  
 
    	
    	String recipient = param.getEmail(); //받는 사람의 메일주소를 입력해주세요.  
    	String subject = "로그인 메일 인증입니다."; 
     	//주석 해제
    	String mailUrl="http://localhost:8080/common/email/emailAuth?tokenId="+param.getTokenId();
    	String body = mailUrl; //메일 내용 입력해주세요.  
 	 
    	Properties props = System.getProperties();  

    	// 정보를 담기 위한 객체 생성  
    	// SMTP 서버 정보 설정  
    	props.put("mail.smtp.host", host);  
    	props.put("mail.smtp.port", port);  
    	props.put("mail.smtp.auth", "true");  
    	props.put("mail.smtp.ssl.enable", "true");  
    	props.put("mail.smtp.ssl.trust", host);  

    	//Session 생성  
    	Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {  
    	String un=username;  
    	String pw=password;  
    	@Override
		protected javax.mail.PasswordAuthentication getPasswordAuthentication() {  
    	return new javax.mail.PasswordAuthentication(un, pw);  
    	}  
   	});  

    	session.setDebug(true); //for debug  
    	Message mimeMessage = new MimeMessage(session); 
    	mimeMessage.setFrom(new InternetAddress("0830thgus@naver.com")); 
    	mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); 
    	mimeMessage.setSubject(subject); 
    	mimeMessage.setText(body); 
    	Transport.send(mimeMessage); 
    	
    	rtnValue.setSuccess(true);
    	rtnValue.setMessage(param.getTokenId());
  		
    	return rtnValue;
    }
	
}

