package com.icignal.marketing.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : MktCampaignSurveyListResDto.java
 * @date : 2018. 4. 24.
 * @author : 이필수
 * @description : 캠페인 B2C이벤트 설문형 목록 ResDto
 */
public class MktCampaignSurveyListResDto extends StatusResDto {
	
	private String rid;						//응모형 RID
	private String questionSeq;				//질문순번
	private String duplicationFlg;			//중복답안여부
	private String questionDesc;			//질문
	private String answer1;					//답안1
	private String answer2;					//답안2
	private String answer3;					//답안3
	private String answer4;					//답안4
	private String answer5;					//답안5
	
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

}
