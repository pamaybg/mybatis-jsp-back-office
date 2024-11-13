package com.icignal.systemmanagement.apispec.dto.vo;/**
 * 1. FileName	: descent-loyalty-marketing-bo
 * 2. Package	: com.icignal.systemmanagement.apispec.dto.vo
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-04-06 오전 10:11
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-04-06		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoyHistArrayVo
 * 2. 클래스명: LoyHistArrayVo
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-04-06
 */

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   MbrPushHistArray 서브 테이블	
 */
public class LoyHistArrayVo {
    private String subject;
    private String message;
    private String linkUrl;
    private String imgUrl;
    private String sentDt;

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getSentDt() {
        return sentDt;
    }

    public void setSentDt(String sentDt) {
        this.sentDt = sentDt;
    }
}
