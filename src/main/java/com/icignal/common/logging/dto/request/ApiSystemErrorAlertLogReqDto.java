package com.icignal.common.logging.dto.request;/**
 * 1. FileName	: descent-loyalty-marketing-bo
 * 2. Package	: com.icignal.common.logging.dto.request
 * 3. Comments	:
 * 4. Author	: bg.yoon
 * 5. DateTime	: 2022-03-10 오전 10:56
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-03-10		 | bg.yoon			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: ApiSystemErrorAlertLogReqDto
 * 2. 클래스명: ApiSystemErrorAlertLogReqDto
 * 3. 작성자명: bg.yoon
 * 4. 작성일자: 2022-03-10
 */


/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   API 시스템 에러 알림 Dto
 */
public class ApiSystemErrorAlertLogReqDto {

    private String apiNo;
    private String content;
    private String programNo;
    private String subject;
    private String createBy;
    private String sendStatCd;
    private String toEmail;

    public String getApiNo() {return apiNo;}
    public void setApiNo(String apiNo) {this.apiNo = apiNo;}
    public String getContent() {return content;}
    public void setContent(String content) {this.content = content;}
    public String getProgramNo() {return programNo;}
    public void setProgramNo(String programNo) {this.programNo = programNo;}
    public String getSubject() {return subject;}
    public void setSubject(String subject) {this.subject = subject;}
    public String getCreateBy() {return createBy;}
    public void setCreateBy(String createBy) {this.createBy = createBy;}
    public String getSendStatCd() {return sendStatCd;}
    public void setSendStatCd(String sendStatCd) {this.sendStatCd = sendStatCd;}
    public String getToEmail() {return toEmail;}
    public void setToEmail(String toEmail) {this.toEmail = toEmail;}

}
