 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.common.util;

import java.io.IOException;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 1. FileName	: MailUtils.java
 * 2. Package	: com.icignal.core.util
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 4. 13. 오전 10:53:14
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 4. 13.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: MailUtils
 * 2. 파일명	: MailUtils.java
 * 3. 패키지명	: com.icignal.core.util
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 4. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class MailUtils {
	
	

	
    /**
     * 발송 테스트 시 사용하세요.
     */
	public static void main(String[] args) {
		//MailUtils smtpUtil = new MailUtils();
		
		SendInfo sendInfo = new SendInfo();
		sendInfo.setSendTo("XXX@XXX.com");
		sendInfo.setSubject("subject");
		sendInfo.setContent("content");
		MailUtils.sendMailSmtp(sendInfo);
	}
	
	/**
	* @name : sendMailSmtp
	* @date : 2018. 10. 18.
	* @author : hy.jun
	* @return : StatusResponseDTO
	 * @throws AWSSecretsManagerConfigFailExecption 
	* @description : SMTP 메일발송
	*/
	public static StatusResDto sendMailSmtp(SendInfo sendInfo)   {
		StatusResDto rtnValue = new StatusResDto(true, "");
		
		try {
			JavaMailSender mailSender = getJavaMailSender();
			
			MimeMessage mimeMessage = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "utf-8");
			
			helper.setFrom(new InternetAddress("hr.noh@quintet.co.kr", "퀸텟시스템즈")); //발신메일주소, 발신명
			helper.setTo(sendInfo.getSendTo());
			helper.setSubject(sendInfo.getSubject());
			mimeMessage.setContent(sendInfo.getContent(), "text/html; charset=UTF-8");
			
			mailSender.send(mimeMessage);
			
		} catch (MessagingException | IOException e) {
			LogUtil.error(e);
			rtnValue.setSuccess(false);
			rtnValue.setMessage(e.getMessage());
			return rtnValue;
		}
		
		return rtnValue;
	}
	
	/**
	* @name : getJavaMailSender
	* @date : 2018. 10. 18.
	* @author : hy.jun
	* @return : JavaMailSender
	 * @throws IOException 
	 * @throws AWSSecretsManagerConfigFailExecption 
	 * @description : SMTP 메일발송객체 생성
	*/
	public static JavaMailSender getJavaMailSender() throws IOException {
		
	    JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
	    Properties props = mailSender.getJavaMailProperties();
	   
	    StandardPBEStringEncryptor encryptor = BeansUtil.getEncryptor();
	    mailSender.setHost(encryptor.decrypt( BeansUtil.getApplicationProperty("icignal.mail-connection-info.local.smtp.host")));
   		mailSender.setPort(Integer.parseInt(encryptor.decrypt(BeansUtil.getApplicationProperty("icignal.mail-connection-info.local.smtp.port"))));
   		mailSender.setUsername(encryptor.decrypt(BeansUtil.getApplicationProperty("icignal.mail-connection-info.local.smtp.username")));
   		mailSender.setPassword(encryptor.decrypt(BeansUtil.getApplicationProperty("icignal.mail-connection-info.local.smtp.password")));
	//	mailSender.setJavaMailProperties(props);
		
		props.put("mail.transport.protocol", "smtps");
		props.put("mail.smtps.auth", "true");
		props.put("mail.smtps.starttls.enable", "true");
		props.put("mail.debug", "true");
	    props.put("mail.smtps.ssl.enable", "true");
	    props.put("mail.smtps.ssl.checkserveridentity", "false");
	    props.put("mail.smtps.ssl.trust", "*");
	    
	    mailSender.setJavaMailProperties(props);
	    
	    return mailSender;
		
	}
    
    /**
    * @name : infavor.util.SendInfo
    * @date : 2018. 10. 18.
    * @author : hy.jun
    * @description : 발송정보
    */
    public static class SendInfo {
    	private String sendTo;
    	private String subject;
    	private String content;
    	
		public String getSendTo() {
			if(ObjectUtil.isEmpty(sendTo)) {
				throw new IllegalArgumentException("수신자 메일이 없습니다.");
			}
			return sendTo;
		}
		public void setSendTo(String sendTo) {
			this.sendTo = sendTo;
		}
		public String getSubject() {
			if(ObjectUtil.isEmpty(subject)) {
				throw new IllegalArgumentException("메일 제목이 없습니다.");
			}
			return subject;
		}
		public void setSubject(String subject) {
			this.subject = subject;
		}
		public String getContent() {
			if(ObjectUtil.isEmpty(content)) {
				throw new IllegalArgumentException("메일 내용이 없습니다.");
			}
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
    }

}

