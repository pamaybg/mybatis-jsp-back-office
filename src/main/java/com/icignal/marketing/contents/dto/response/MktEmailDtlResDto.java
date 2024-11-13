package com.icignal.marketing.contents.dto.response;

/**
 * @name : MKTEmailDtlResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 이메일 상세 조회
 */
public class MktEmailDtlResDto {
	private String id;                 //아이디
	private String contentsName;
	private String contentsType;
	private String title;
	private String emailType;
	private String contents;
	private String html;
	private String textByteSize;
	private String fileName;
	private String filePath;
    private String ofrNm;
	private String contsTypeCd;
	private String ridOfr;
	private String txtMsgObject;
	private String surveyNm;
	private String ridSurv;
	
	
	public String getTxtMsgObject() {
		return txtMsgObject;
	}
	public void setTxtMsgObject(String txtMsgObject) {
		this.txtMsgObject = txtMsgObject;
	}
	public String getContsTypeCd() {
		return contsTypeCd;
	}
	public void setContsTypeCd(String contsTypeCd) {
		this.contsTypeCd = contsTypeCd;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContentsName() {
		return contentsName;
	}
	public void setContentsName(String contentsName) {
		this.contentsName = contentsName;
	}
	public String getContentsType() {
		return contentsType;
	}
	public void setContentsType(String contentsType) {
		this.contentsType = contentsType;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getHtml() {
		return html;
	}
	public void setHtml(String html) {
		this.html = html;
	}
	public String getTextByteSize() {
		return textByteSize;
	}
	public void setTextByteSize(String textByteSize) {
		this.textByteSize = textByteSize;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getEmailType() {
		return emailType;
	}
	public void setEmailType(String emailType) {
		this.emailType = emailType;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}

	public String getSurveyNm() {
		return surveyNm;
	}

	public void setSurveyNm(String surveyNm) {
		this.surveyNm = surveyNm;
	}

	public String getRidSurv() {
		return ridSurv;
	}

	public void setRidSurv(String ridSurv) {
		this.ridSurv = ridSurv;
	}
}
