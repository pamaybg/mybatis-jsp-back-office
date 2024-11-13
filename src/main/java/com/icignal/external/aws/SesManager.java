package com.icignal.external.aws;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

/*
 * 1. 클래스명	: SesManager
 * 2. 파일명	: SesManager.java
 * 3. 패키지명	: com.icignal.external.aws
 * 4. 작성자명	: dwKeum
 * 5. 작성일자	: 2020. 08. 27
 */

import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.services.simpleemail.AmazonSimpleEmailService;
import com.amazonaws.services.simpleemail.AmazonSimpleEmailServiceClientBuilder;
import com.amazonaws.services.simpleemail.model.Body;
import com.amazonaws.services.simpleemail.model.BulkEmailDestination;
import com.amazonaws.services.simpleemail.model.BulkEmailDestinationStatus;
import com.amazonaws.services.simpleemail.model.Content;
import com.amazonaws.services.simpleemail.model.CreateTemplateRequest;
import com.amazonaws.services.simpleemail.model.DeleteTemplateRequest;
import com.amazonaws.services.simpleemail.model.Destination;
import com.amazonaws.services.simpleemail.model.Message;
import com.amazonaws.services.simpleemail.model.MessageTag;
import com.amazonaws.services.simpleemail.model.SendBulkTemplatedEmailRequest;
import com.amazonaws.services.simpleemail.model.SendBulkTemplatedEmailResult;
import com.amazonaws.services.simpleemail.model.SendEmailRequest;
import com.amazonaws.services.simpleemail.model.Template;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.external.aws.dto.request.AwsSesManagerReqDto;


/**
 * <PRE>
 * 1. 설명 : AWS SES 서비스 관리 객체
 *
 * 2. 사용법:
 *
 *
 * </PRE>
 */
public class SesManager {
    private Credentials credentials;

    private String region;

    private AWSCredentialsProvider credentialsProvider;

    private AmazonSimpleEmailService amazonSimpleEmailService;

    /*
     * 1. 메소드명: SesManager
     * 2. 클래스명: SesManager
     * 3. 작성자명: dw.keum
     * 4. 작성일자: 2020. 8. 28.
     */

    /**
     * <PRE>
     * 1. 설명
     * sesManger 객체생성시 자격증명,지역
     * 2. 사용법
     *
     * </PRE>
     *
     * @param
     * @return
     */
    public SesManager() {
        this.credentials = BeansUtil.getAWSCredentials();
        this.region = BeansUtil.getAwsRegion();
        amazonSimpleEmailService();
    }

    private AmazonSimpleEmailService amazonSimpleEmailService() {
        credentialsProvider = new AWSStaticCredentialsProvider(credentials.getBasicAWSCredentials());

        amazonSimpleEmailService = AmazonSimpleEmailServiceClientBuilder.standard()
                .withCredentials(credentialsProvider)
                .withRegion(region) //ap-northeast-2
                .build();
        return amazonSimpleEmailService;
    }

    /*
     * 1. 메소드명: sendAsyncSDK
     * 2. 클래스명: SesManager
     * 3. 작성자명: dw.keum
     * 4. 작성일자: 2020. 8. 28.
     */

    /**
     * <PRE>
     * 1. 설명
     * ses SDK 전송
     * 2. 사용법
     *
     * </PRE>
     *
     * @param AwsSesManagerReqDto
     * @return StatusResDto
     */
    public StatusResDto sendAsyncSDK(AwsSesManagerReqDto reqDto) {
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        SendEmailRequest request = new SendEmailRequest();
            request.withDestination(new Destination().withToAddresses(reqDto.getReceivers()))               //수신자 단건,다건
                    .withMessage(new Message().withBody(
                            new Body()
                                    .withText(new Content("UTF-8").withData(reqDto.getTextHtml()))    //html
                                    .withText(new Content("UTF-8").withData(reqDto.getText()))        //text
                    ).withSubject(
                            new Content().withCharset("UTF-8").withData(reqDto.getSubject())               //제목
                    )).withSource(reqDto.getSender());                                                     //전송자

            amazonSimpleEmailService.sendEmail(request);    //이메일 전송
            rtnValue.setSuccess(true);
        

        return rtnValue;
    }

    /*
     * 1. 메소드명: sendSMTP
     * 2. 클래스명: SesManager
     * 3. 작성자명: dw.keum
     * 4. 작성일자: 2020. 8. 28.
     */

    /**
     * <PRE>
     * 1. 설명
     * ses SMTP 단건 전송
     * 2. 사용법
     *
     * </PRE>
     *
     * @param AwsSesManagerReqDto
     * @return StatusResDto
     */
    public StatusResDto sendSMTP(AwsSesManagerReqDto reqDto) {
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        String host = CommonUtil.getInstance().getServletProp("aws.ses.smtp.host");
        String port = CommonUtil.getInstance().getServletProp("aws.ses.smtp.port");
        String smtpUserName = CommonUtil.getInstance().getServletProp("aws.ses.smtp.username");
        String smtpPassword = CommonUtil.getInstance().getServletProp("aws.ses.smtp.smtpPwd");
        String configSet = CommonUtil.getInstance().getServletProp("aws.ses.smtp.configSet");  //SES Config Set Name : 설정안할시 header 삭제

        Properties props = System.getProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");

        Session session = Session.getDefaultInstance(props);

        MimeMessage msg = new MimeMessage(session);
        Transport transport = null;

        try {
            msg.setFrom(new InternetAddress(reqDto.getSender(), reqDto.getSenderName()));
            msg.setRecipient(javax.mail.Message.RecipientType.TO, new InternetAddress(reqDto.getReceiver()));   //수신자 한명
            msg.setSubject(reqDto.getSubject());
            msg.setContent(reqDto.getTextHtml(), "text/html; charset=utf-8");
            msg.setHeader("X-SES-CONFIGURATION-SET", configSet);

            transport = session.getTransport();
            transport.connect(host, smtpUserName, smtpPassword);
            transport.sendMessage(msg, msg.getAllRecipients());
            
            rtnValue.setSuccess(true);
        } catch (AddressException e) {
            LogUtil.error(e);
        } catch (UnsupportedEncodingException e) {
            LogUtil.error(e);
        } catch (MessagingException e) {
            LogUtil.error(e);
        } finally {
            if (ObjectUtil.isNotEmpty(transport)) {
                try {
                    transport.close();
                } catch (MessagingException e) {
                    LogUtil.error(e);
                }
            }
        }

        return rtnValue;
    }

    /*
     * 1. 메소드명: personalSendEmail
     * 2. 클래스명: SesManager
     * 3. 작성자명: LEE GYEONG YOUNG
     * 4. 작성일자: 2020. 12. 14.
     */
    /**
     * <PRE>
     * 1. 설명
     *      ses 개인화 이메일 발송
     * 2. 사용법
     *      개인화 이메일 전송
     *      템플릿생성시  $key$ -> {{key}} 로변경 personalData에 JSON형식으로 사용
     *      ex) { "key" : "value" , "key" : "value"}
     * </PRE>
     *
     * @param AwsSesManagerReqDto
     * @return StatusResDto
     */
    public StatusResDto personalSendEmail (AwsSesManagerReqDto reqDto){
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        try {
			        List<BulkEmailDestination> listBulkEmailDestination = new ArrayList<>();
			      String configSetName = BeansUtil.getApplicationProperty("aws.ses.mkt.sesWatch.configSet");
			//      String configSetName = BeansUtil.getApplicationProperty("aws.ses.loy.sesWatch.configSet");
			      SendBulkTemplatedEmailRequest sendBulkTemplatedEmailRequest = null;
			      SendBulkTemplatedEmailResult res = null;
			      //보내야할 총 인원 수
			      Integer peoples = reqDto.getPersonalData().size();
			      //개인화 데이터셋팅
			      for(AwsSesManagerReqDto perInfo : reqDto.getPersonalData()){
			          BulkEmailDestination bulkEmailDestination = new BulkEmailDestination();
			          bulkEmailDestination.setDestination(new Destination(Collections.singletonList(perInfo.getReceiver())));
			          bulkEmailDestination.setReplacementTemplateData(perInfo.getReplaceData());  //개인화정보 JSON
			          listBulkEmailDestination.add(bulkEmailDestination);
				            //sendBulkTemplatedEmail -> 50명 단위로 잘라서 보내야만 함.
				       sendBulkTemplatedEmailRequest = new SendBulkTemplatedEmailRequest().withConfigurationSetName(configSetName);
				       sendBulkTemplatedEmailRequest.setSource(reqDto.getSender());
				       sendBulkTemplatedEmailRequest.setTemplate(reqDto.getTempNm());
				       sendBulkTemplatedEmailRequest.setDefaultTemplateData(reqDto.getDefaultData());   //개인화실패시 default Template
				       sendBulkTemplatedEmailRequest.setDestinations(listBulkEmailDestination);
				       sendBulkTemplatedEmailRequest.withDefaultTags(new MessageTag().withName("X-SES-CONFIGURATION-SET").withValue(configSetName)); //수신자 메일확인시
				       if(listBulkEmailDestination.size() ==50) {
						       //이메일 전송
						       res = amazonSimpleEmailService.sendBulkTemplatedEmail(sendBulkTemplatedEmailRequest);
						       for(BulkEmailDestinationStatus status : res.getStatus()){
						    	     System.out.println(status.getStatus());
						    	     System.out.println(status.getError());
						    	     System.out.println(status.getMessageId());
						       }
						       listBulkEmailDestination.removeAll(listBulkEmailDestination);
						       peoples --;
						       Thread.sleep(2000);
				       } else {
				    	   //대상자가 50명 미만
				    	   if(reqDto.getPersonalData().size() < 50) {
				    		   if(peoples == 1) {
							       res = amazonSimpleEmailService.sendBulkTemplatedEmail(sendBulkTemplatedEmailRequest);
							       for(BulkEmailDestinationStatus status : res.getStatus()){
							    	     System.out.println(status.getStatus());
							    	     System.out.println(status.getError());
							    	     System.out.println(status.getMessageId());
							       }
							       listBulkEmailDestination.removeAll(listBulkEmailDestination);
							       Thread.sleep(2000);
				    		   } else {
				    			   peoples--;
				    		   }
				    		//대상자가 50명 이상
				    	   }else {
				    		   if(peoples < 50) {
				    			   if(peoples == 1) {
								       res = amazonSimpleEmailService.sendBulkTemplatedEmail(sendBulkTemplatedEmailRequest);
								       for(BulkEmailDestinationStatus status : res.getStatus()){
								    	     System.out.println(status.getStatus());
								    	     System.out.println(status.getError());
								    	     System.out.println(status.getMessageId());
								       }
								       listBulkEmailDestination.removeAll(listBulkEmailDestination);
								       Thread.sleep(2000);
				    			   } else {
				    				   peoples--;
				    			   }
				    		   } else {
				    			   peoples--;
				    		   }
				    	   }
				       }
			      }
			      
			        deleteTemplate(reqDto);
			        rtnValue.setSuccess(true);
        }catch (Exception e) {
	        rtnValue.setSuccess(false);
		}
        return rtnValue;
    }
    
    /*
     * 1. 메소드명: encodeNameWithAddress
     * 2. 클래스명: SesManager
     * 3. 작성자명: LEE GYEONG YOUNG
     * 4. 작성일자: 2020. 12. 07.
     */

    /**
     * <PRE>
     * 1. 설명
     * ses 발신자 주소 만들기
     * 2. 사용법
     *
     * </PRE>
     *
     * @param 
     * @return String
     */
    
public String encodeNameWithAddress(AwsSesManagerReqDto reqData){
		String returnStr = reqData.getSenderAddr();
		try {
			String encoded = MimeUtility.encodeText(reqData.getSenderAddrName(), "utf-8", "Q");
			returnStr = encoded + "<"+reqData.getSenderAddr()+">";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return returnStr;
	}

    /*
     * 1. 메소드명: createEmailTemplate
     * 2. 클래스명: SesManager
     * 3. 작성자명: dw.keum
     * 4. 작성일자: 2020. 8. 28.
     */
    /**
     * <PRE>
     * 1. 설명
     *      ses 이메일 템플릿 생성
     * 2. 사용법
     *      개인화발송시 템플릿 생성후 처리
     *      템플릿 생성시 개인화는 {{value}} 값으로 셋팅해야함
     * </PRE>
     *
     * @param AwsSesManagerReqDto
     * @return String tempNm : 템플릿명
     */
    public StatusResDto createEmailTemplate (AwsSesManagerReqDto reqDto){
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        Template template = new Template();
        template.setTemplateName(reqDto.getTempNm());       //tempName 중복X
        template.setHtmlPart(reqDto.getTextHtml());         // 개인화 {{value}}
        template.setSubjectPart(reqDto.getSubject());       // 개인화 {{value}}
        template.setTextPart(reqDto.getText());             // 개인화 {{value}}

        CreateTemplateRequest createTemplateRequest = new CreateTemplateRequest();
        createTemplateRequest.setTemplate(template);

        amazonSimpleEmailService.createTemplate(createTemplateRequest); //템플릿 생성
        rtnValue.setSuccess(true);
        return rtnValue;
    }

    /*
     * 1. 메소드명: deleteTemplate
     * 2. 클래스명: SesManager
     * 3. 작성자명: dw.keum
     * 4. 작성일자: 2020. 9. 3.
     */
    /**
     * <PRE>
     * 1. 설명
     *      ses template 삭제
     * 2. 사용법
     *      template 이름으로 삭제함.
     * </PRE>
     *
     * @param AwsSesManagerReqDto
     * @return StatusResDto
     */
    public StatusResDto deleteTemplate(AwsSesManagerReqDto reqDto){
        StatusResDto rtnValue = new StatusResDto();

        DeleteTemplateRequest delteTempalte = new DeleteTemplateRequest();
        delteTempalte.setTemplateName(reqDto.getTempNm());
        amazonSimpleEmailService.deleteTemplate(delteTempalte);

        rtnValue.setSuccess(true);
        return rtnValue;
    }

	public Credentials getCredentials() {
		return credentials;
	}

	public void setCredentials(Credentials credentials) {
		this.credentials = credentials;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public AWSCredentialsProvider getCredentialsProvider() {
		return credentialsProvider;
	}

	public void setCredentialsProvider(AWSCredentialsProvider credentialsProvider) {
		this.credentialsProvider = credentialsProvider;
	}

	public AmazonSimpleEmailService getAmazonSimpleEmailService() {
		return amazonSimpleEmailService;
	}

	public void setAmazonSimpleEmailService(AmazonSimpleEmailService amazonSimpleEmailService) {
		this.amazonSimpleEmailService = amazonSimpleEmailService;
	}
    
    
}
