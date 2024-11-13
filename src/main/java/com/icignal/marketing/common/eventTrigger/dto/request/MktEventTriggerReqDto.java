package com.icignal.marketing.common.eventTrigger.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : ICNEventTriggerRequestDTO.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : 이벤트 트리거
 */
public class MktEventTriggerReqDto extends MKTBaseReqDto {

	private String rid;				//인터랩션 아이디
	private String ridIntactType;	//인터랩션 유형 아이디
	private String intactType1Cd;	//인터랙션 유형1 코드
	private String intactType2Cd;  //인터랙션 유형2 코드
	private String memId;			//회원 아이디
	
	private String campaignId;		//캠페인 아이디
	
	private String sourceNode;		//소스노드
	
	private String lgcCompId;		//로지컬 컴포넌트 아이디
	
	private String contentsId;		//콘텐츠 아이디
	
	private String camTgtHadId;		//타겟팅 아이디
   
	private String ridCamNode;		//캠페인 노드 아이디
	
	private String tgtGroupId;		//타겟그룹 아이디
	
	private String parTaskId;		//상위 테스크 아이디
	
	private String cnctrTypeCd;		//커넥터 유형 코드
	
	private String guid;
	private String trkNo;
	private String tgNo;
	private String trsDate;
	private String trsTime;
	private String evtType;
	private String evtDtlType;
	
	private String mbrNo;
	private String airline;
	private String date;
	private String origin;
	private String desti;
	private String classCd;
	private String flightNo;
	private String passenger;
	private int sellAmt;
	private int txnAmt;
	private String ticket;
	private int txnMile;
	private String orgnApprNo;
	
	
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }


	public String getRid() {
		return rid;
	}


	public void setRid(String rid) {
		this.rid = rid;
	}


	public String getIntactType1Cd() {
		return intactType1Cd;
	}


	public void setIntactType1Cd(String intactType1Cd) {
		this.intactType1Cd = intactType1Cd;
	}


	public String getIntactType2Cd() {
		return intactType2Cd;
	}


	public void setIntactType2Cd(String intactType2Cd) {
		this.intactType2Cd = intactType2Cd;
	}


	public String getMemId() {
		return memId;
	}


	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getRidIntactType() {
		return ridIntactType;
	}


	public void setRidIntactType(String ridIntactType) {
		this.ridIntactType = ridIntactType;
	}


	public String getCampaignId() {
		return campaignId;
	}


	public void setCampaignId(String campaignId) {
		this.campaignId = campaignId;
	}


	public String getSourceNode() {
		return sourceNode;
	}


	public void setSourceNode(String sourceNode) {
		this.sourceNode = sourceNode;
	}


	public String getLgcCompId() {
		return lgcCompId;
	}


	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}


	public String getContentsId() {
		return contentsId;
	}


	public void setContentsId(String contentsId) {
		this.contentsId = contentsId;
	}


	public String getCamTgtHadId() {
		return camTgtHadId;
	}


	public void setCamTgtHadId(String camTgtHadId) {
		this.camTgtHadId = camTgtHadId;
	}


	public String getRidCamNode() {
		return ridCamNode;
	}


	public void setRidCamNode(String ridCamNode) {
		this.ridCamNode = ridCamNode;
	}


	public String getTgtGroupId() {
		return tgtGroupId;
	}


	public void setTgtGroupId(String tgtGroupId) {
		this.tgtGroupId = tgtGroupId;
	}


	public String getCnctrTypeCd() {
		return cnctrTypeCd;
	}


	public void setCnctrTypeCd(String cnctrTypeCd) {
		this.cnctrTypeCd = cnctrTypeCd;
	}


	public String getParTaskId() {
		return parTaskId;
	}


	public void setParTaskId(String parTaskId) {
		this.parTaskId = parTaskId;
	}


	public String getTrkNo() {
		return trkNo;
	}


	public void setTrkNo(String trkNo) {
		this.trkNo = trkNo;
	}


	public String getTgNo() {
		return tgNo;
	}


	public void setTgNo(String tgNo) {
		this.tgNo = tgNo;
	}


	public String getTrsDate() {
		return trsDate;
	}


	public void setTrsDate(String trsDate) {
		this.trsDate = trsDate;
	}


	public String getTrsTime() {
		return trsTime;
	}


	public void setTrsTime(String trsTime) {
		this.trsTime = trsTime;
	}


	public String getEvtType() {
		return evtType;
	}


	public void setEvtType(String evtType) {
		this.evtType = evtType;
	}


	public String getEvtDtlType() {
		return evtDtlType;
	}


	public void setEvtDtlType(String evtDtlType) {
		this.evtDtlType = evtDtlType;
	}


	public String getMbrNo() {
		return mbrNo;
	}


	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}


	public String getAirline() {
		return airline;
	}


	public void setAirline(String airline) {
		this.airline = airline;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public String getOrigin() {
		return origin;
	}


	public void setOrigin(String origin) {
		this.origin = origin;
	}


	public String getDesti() {
		return desti;
	}


	public void setDesti(String desti) {
		this.desti = desti;
	}


	public String getClassCd() {
		return classCd;
	}


	public void setClassCd(String classCd) {
		this.classCd = classCd;
	}


	public String getFlightNo() {
		return flightNo;
	}


	public void setFlightNo(String flightNo) {
		this.flightNo = flightNo;
	}


	public String getPassenger() {
		return passenger;
	}


	public void setPassenger(String passenger) {
		this.passenger = passenger;
	}


	public String getGuid() {
		return guid;
	}


	public void setGuid(String guid) {
		this.guid = guid;
	}


	public int getSellAmt() {
		return sellAmt;
	}


	public void setSellAmt(int sellAmt) {
		this.sellAmt = sellAmt;
	}


	public String getTicket() {
		return ticket;
	}


	public void setTicket(String ticket) {
		this.ticket = ticket;
	}

	public int getTxnAmt() {
		return txnAmt;
	}

	public void setTxnAmt(int txnAmt) {
		this.txnAmt = txnAmt;
	}


	public int getTxnMile() {
		return txnMile;
	}


	public void setTxnMile(int txnMile) {
		this.txnMile = txnMile;
	}


	public String getOrgnApprNo() {
		return orgnApprNo;
	}


	public void setOrgnApprNo(String orgnApprNo) {
		this.orgnApprNo = orgnApprNo;
	}


}
