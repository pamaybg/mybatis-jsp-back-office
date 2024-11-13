package com.icignal.loyalty.qna.service;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.qna.dto.request.LoyQnaReqDto;
import com.icignal.loyalty.qna.dto.response.LoyQnaResDto;
import com.icignal.loyalty.qna.mapper.LoyQnaMapper;

@Service
public class LoyQnaService {
	
	@Autowired LoyQnaMapper loyQnaMapper;
	
	@Autowired LoggingHelper loggingHelper;
	
	/**
	* @programId :
	* @name : getSrList
	* @date : 2019. 7. 5.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	
	public GridPagingResDto<LoyQnaResDto> getQnaList(LoyQnaReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("vsr");
		
		return new GridPagingResHelper<LoyQnaResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyQnaMapper.getQnaList(reqDto)
				, AnnotationType.ALL);

	}

	/**
	* @programId :
	* @name : getQnaDetail
	* @date : 2019. 7. 5.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	
	public LoyQnaResDto getQnaDetail(LoyQnaReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyQnaResDto res =      loyQnaMapper.getQnaDetail(reqDto);
	    return new AnnotationHelper<LoyQnaResDto>(AnnotationType.PersonalData, res).getItem();
	}

	/**
	* @programId :
	* @name : updateQnaDetail
	* @date : 2019. 7. 5.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	
	public StatusResDto updateQnaDetail(LoyQnaReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		reqDto.setSrStatus("Closed");
		
		//접수상태가 완료일경우 이메일 발송
		Properties props = new Properties();
		
		final String email = "batglo";
		final String pwd = "batkorea1";
		
		props.put("mail.smtp.host", "smtp.daum.net");
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", "smtp.daum.net");
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(email, pwd);
			} 
		});
		
		try {
		  
		  MimeMessage message = new MimeMessage(session);
		  
		  message.setFrom(new InternetAddress("info@discoverglo.co.kr","glolive","UTF-8"));
		  
		  message.addRecipient(Message.RecipientType.TO , new InternetAddress(reqDto.getSrEmail())); //수신자이메일
		  
		  //message.addRecipient(Message.RecipientType.BCC , new InternetAddress("dw.keum@quintet.co.kr")); //숨은참조
		  
		  message.setSubject(MimeUtility.encodeText("gloLiVE_상담문의/답변", "UTF-8", "B")); //제목 인코딩
		  
		  message.setHeader("Content-Type", "text/html; charset=UTF-8");
		  
		  message.setContent("접수내용<br>" + 
				  			 "<blockquote>" + "<p>" + reqDto.getSmtpReqTxt() + "</p>" + "</blockquote><br>" +
				  			 "답변내용<br>" + 
				  			 "<blockquote>" + "<p>" + reqDto.getSmtpAnsTxt() + "</p>" + "</blockquote>",
				  			 "text/html;charset=UTF-8");    //답변내용
		  
		  Transport.send(message);
		  		  
			rtnValue.setSuccess(false);
			loyQnaMapper.updateQnaDetail(reqDto);
			rtnValue.setSuccess(true);
			return rtnValue;
		  
		} catch (Exception e) {
		  LogUtil.error(e);
		}
			
		return rtnValue;
	}

	/**
	* @programId :
	* @name : qnaClearMaskMbr
	* @date : 2019. 7. 11.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description :
	*/
	
	public LoyQnaResDto qnaClearMaskMbr(LoyQnaReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto,"LOY_QNA");
		return new AnnotationHelper<LoyQnaResDto>(AnnotationType.ALL,(LoyQnaResDto)loyQnaMapper.getQnaClearMaskMbr(reqDto)).getItem() ;
	}

}
