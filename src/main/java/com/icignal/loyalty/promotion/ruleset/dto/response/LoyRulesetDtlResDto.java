package com.icignal.loyalty.promotion.ruleset.dto.response;

/**
 * RuleSet 정보 Response DTO
 * 
 * @name : infavor.loyalty.ruleSet.dto.response.LOYRulesetDtlResponseDTO
 * @date : 2017. 11. 30.
 * @author : jh.kim
 * @description : 
 */
public class LoyRulesetDtlResDto {
    
    private String rid;                //RID
    private String ridMktCamMst;       //RID_캠페인마스터
    private String promTypeCd;         //프로모션유형코드
    private String allianceTypeCd;     //제휴사유형코드
    private String monthLmtPoint;      //월한도포인트
    private String promOccTmscntCd;    //프로모션발생횟수코드
    private String fstPrizeCnt;        //첫당첨충전횟수
    private String prizePeriod;        //당첨주기(충전횟수)
    private String cnclDt;             //취소일시
    private String stepAscAmt;         //단계별 증가분(포인트)
    private String prirtTypeCd;        //우선순위
    private String chitOtputSbst;      //전표출력내용
    private String rulesetDesc;        //비고
    
    private String promStartDt;        //프로모션 시작일시
    private String promEndDt;          //프로모션 종료일시
    private String promCyclTypeCd;		//반복주기 유형코드
    private String promCyclStartDd;		//반복주기 시작일
    private String promCyclEndDd;		//반복주기 종료일
    private String promTgtSendTypeCd;	//대상자전송유형코드
    private String newMemYn;			//신규멤버십회원 여부
    public String getPromStartDt() {
        return promStartDt;
    }
    public void setPromStartDt(String promStartDt) {
        this.promStartDt = promStartDt;
    }
    public String getPromEndDt() {
        return promEndDt;
    }
    public void setPromEndDt(String promEndDt) {
        this.promEndDt = promEndDt;
    }
    public String getPrirtTypeCd() {
        return prirtTypeCd;
    }
    public void setPrirtTypeCd(String prirtTypeCd) {
        this.prirtTypeCd = prirtTypeCd;
    }
    public String getRid() {
        return rid;
    }
    public void setRid(String rid) {
        this.rid = rid;
    }
    public String getRidMktCamMst() {
        return ridMktCamMst;
    }
    public void setRidMktCamMst(String ridMktCamMst) {
        this.ridMktCamMst = ridMktCamMst;
    }
    public String getPromTypeCd() {
        return promTypeCd;
    }
    public void setPromTypeCd(String promTypeCd) {
        this.promTypeCd = promTypeCd;
    }
    public String getAllianceTypeCd() {
        return allianceTypeCd;
    }
    public void setAllianceTypeCd(String allianceTypeCd) {
        this.allianceTypeCd = allianceTypeCd;
    }
    public String getMonthLmtPoint() {
        return monthLmtPoint;
    }
    public void setMonthLmtPoint(String monthLmtPoint) {
        this.monthLmtPoint = monthLmtPoint;
    }
    public String getPromOccTmscntCd() {
        return promOccTmscntCd;
    }
    public void setPromOccTmscntCd(String promOccTmscntCd) {
        this.promOccTmscntCd = promOccTmscntCd;
    }
    public String getFstPrizeCnt() {
        return fstPrizeCnt;
    }
    public void setFstPrizeCnt(String fstPrizeCnt) {
        this.fstPrizeCnt = fstPrizeCnt;
    }
    public String getPrizePeriod() {
        return prizePeriod;
    }
    public void setPrizePeriod(String prizePeriod) {
        this.prizePeriod = prizePeriod;
    }
    public String getCnclDt() {
        return cnclDt;
    }
    public void setCnclDt(String cnclDt) {
        this.cnclDt = cnclDt;
    }
    public String getStepAscAmt() {
        return stepAscAmt;
    }
    public void setStepAscAmt(String stepAscAmt) {
        this.stepAscAmt = stepAscAmt;
    }
    public String getChitOtputSbst() {
        return chitOtputSbst;
    }
    public void setChitOtputSbst(String chitOtputSbst) {
        this.chitOtputSbst = chitOtputSbst;
    }
    public String getRulesetDesc() {
        return rulesetDesc;
    }
    public void setRulesetDesc(String rulesetDesc) {
        this.rulesetDesc = rulesetDesc;
    }
	public String getPromCyclTypeCd() {
		return promCyclTypeCd;
	}
	public void setPromCyclTypeCd(String promCyclTypeCd) {
		this.promCyclTypeCd = promCyclTypeCd;
	}
	public String getPromCyclStartDd() {
		return promCyclStartDd;
	}
	public void setPromCyclStartDd(String promCyclStartDd) {
		this.promCyclStartDd = promCyclStartDd;
	}
	public String getPromCyclEndDd() {
		return promCyclEndDd;
	}
	public void setPromCyclEndDd(String promCyclEndDd) {
		this.promCyclEndDd = promCyclEndDd;
	}
	public String getPromTgtSendTypeCd() {
		return promTgtSendTypeCd;
	}
	public void setPromTgtSendTypeCd(String promTgtSendTypeCd) {
		this.promTgtSendTypeCd = promTgtSendTypeCd;
	}
	public String getNewMemYn() {
		return newMemYn;
	}
	public void setNewMemYn(String newMemYn) {
		this.newMemYn = newMemYn;
	}
    
}
