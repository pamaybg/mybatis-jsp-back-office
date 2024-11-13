package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;
/**
 * @name : MktCampaignEntryInfoReqDto.java
 * @date : 2018. 04. 19.
 * @author : 이필수
 * @description : B2C 이벤트 캠페인 응모형  ReqDto
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class MktCampaignSurveyListReqDto extends MKTBaseReqDto {
    
	private String createDate;				//생성일시
	private String modifyDate;				//수정일시
	
	private String ridCam;					//캠페인 RID
	private String ridEventMst;				//이벤트 RID
	private String rid;						//응모형 RID
	private String questionSeq;				//질문순번
	private String duplicationFlg;			//중복답안여부
	private String questionDesc;			//질문
	private String answer1;					//답안1
	private String answer2;					//답안2
	private String answer3;					//답안3
	private String answer4;					//답안4
	private String answer5;					//답안5
	
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getQuestionSeq() {
		return questionSeq;
	}

	public void setQuestionSeq(String questionSeq) {
		this.questionSeq = questionSeq;
	}

	public String getDuplicationFlg() {
		return duplicationFlg;
	}

	public void setDuplicationFlg(String duplicationFlg) {
		this.duplicationFlg = duplicationFlg;
	}

	public String getQuestionDesc() {
		return questionDesc;
	}

	public void setQuestionDesc(String questionDesc) {
		this.questionDesc = questionDesc;
	}

	public String getAnswer1() {
		return answer1;
	}

	public void setAnswer1(String answer1) {
		this.answer1 = answer1;
	}

	public String getAnswer2() {
		return answer2;
	}

	public void setAnswer2(String answer2) {
		this.answer2 = answer2;
	}

	public String getAnswer3() {
		return answer3;
	}

	public void setAnswer3(String answer3) {
		this.answer3 = answer3;
	}

	public String getAnswer4() {
		return answer4;
	}

	public void setAnswer4(String answer4) {
		this.answer4 = answer4;
	}

	public String getAnswer5() {
		return answer5;
	}

	public void setAnswer5(String answer5) {
		this.answer5 = answer5;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getRidCam() {
		return ridCam;
	}

	public void setRidCam(String ridCam) {
		this.ridCam = ridCam;
	}

	public String getRidEventMst() {
		return ridEventMst;
	}

	public void setRidEventMst(String ridEventMst) {
		this.ridEventMst = ridEventMst;
	}


}
