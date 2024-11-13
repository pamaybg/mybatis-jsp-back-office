package com.icignal.external.thundermail.service;

import org.springframework.stereotype.Service;

import com.andwise.tm6.api.jars.automail.AutomailAPI;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.external.thundermail.dto.request.ThunderMailReqDto;


/**
 * @name : infavor.loyalty.webService.service.impl.LOYWebServiceService
 * @date : 2017. 10. 25.
 * @author : 이성원
 * @description :
 */
@Service
public class ThunderMailService  {


   
    /**
    * @programId :
    * @name : sendEmailAutoMail
    * @date : 2018. 12. 5.
    * @author : hy.jun
    * @table :
    * @return : 
    * @description : 썬더메일 자동메일api 발송
    */
    public StatusResDto sendEmailAutoMail(ThunderMailReqDto param) {
    	
    	StatusResDto rtnValue = new StatusResDto(false, "");
    	
		AutomailAPI automailAPI = new AutomailAPI();  
		
		automailAPI.setApiURL(CommonUtil.getInstance().getServletProp("thundermail.api-url"));
		automailAPI.setAutomailIDEncrypt(param.getAutomailID()); 
		automailAPI.setReceiverEmail(param.getEmailAddr()); 
		//메일 제목,내용,발신자는 썬더메일 관리자페이지 자동메일 템플릿에서 설정된 값을 사용한다.
//		automailAPI.setMailTitle(param.getEmailTitle());  
//		automailAPI.setMailContent(param.getComment());    //보내는 사람 이름 automailAPI.setSenderName("고객지원팀");
//		automailAPI.setSenderEmail (CommonUtil.getInstance().getServletProp("email.thundermail.sender"));
		automailAPI.setOnetooneInfo(param.getOnetooneInfo()); //썬더메일 자동메일api 치환값
		automailAPI.sendEmail(); 	
		
		LogUtil.debug("LOYWebServiceService.sendEmail() >>> auto code = " + automailAPI.getCode()); 
		LogUtil.debug("LOYWebServiceService.sendEmail() >>> auto msg = " + automailAPI.getMsg()); 
		
		/**
		 * <<자동메일api 결과코드 및 상세>>
		 * 
		 * 100 		데이터 연동 성공
		 * 200 		필수 파라미터 미입력, 데이터 값 오류
		 * 300 		서버 오류
		 * -400 	서버 통신 오류
		 * 500 		접근 IP 오류 
		 * 
		 */
		if(automailAPI.getCode().equals("100")) {
			rtnValue.setSuccess(true);
		}
		rtnValue.setMessage(automailAPI.getMsg());
		
		return rtnValue;
    }
    
	

    

}