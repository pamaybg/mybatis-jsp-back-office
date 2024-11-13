
package com.icignal.loyalty.event.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyEventPlanExcutionReqDto extends CommonDataAuthReqDto{
	private String eventNm;
	private String eventType;
	private String eventCategory;
	private String voteStartDate;
	private String voteEndDate;
	private String eventNo;
	private String oneEventVoteTicketCnt;
	private String maxVoteCnt;
	private String oneMaxCnt;	//일 제한 횟수
	private String promotion;
	private String eventDate;
	private String eventTime;
	private String eventWiningDate;
	private String eventPlace;
	private String downFilecheck;
	private String downURL;
	private String downFile;
	private String thumImg;
	private String mainImg;
	private String detailImg1;
	private String detailImg2;
	private String detailImg3;
	private String notice;
	private String promotionRid;
	private String rid;
	private String radioCheck;
	private String downFileNm;
	private String eventSeq;
	private String addrRegYn;
	private String camTypeCd;
	private String videoTime;	//동영상 최소 재생시간
	private String smlTypeCd; 
	private String devRegYn;	//기기등록 여부
	private String fileNm;		//이미지 이름
	private String tierLimitYn;	//등급제한 여부
	private String usePntAmt;
	private String ofrUseRid;
	private String useOfrAmt;
	private String evtWinTypeCd;
	private String winMbrCnt;
	private String winRate;
	private String noteText;
	private String maxApplyCnt;
	private String totLimitCnt;
	private String bnftOfrRid;
	private String bnftOfrAmt;
	private String ticketOfrNm;
	private String bnftOfrNm;
	private String effStrtDayCnt;
	
	
	public String getBnftOfrRid() {
		return bnftOfrRid;
	}
	public void setBnftOfrRid(String bnftOfrRid) {
		this.bnftOfrRid = bnftOfrRid;
	}
	public String getBnftOfrAmt() {
		return bnftOfrAmt;
	}
	public void setBnftOfrAmt(String bnftOfrAmt) {
		this.bnftOfrAmt = bnftOfrAmt;
	}
	public String getTicketOfrNm() {
		return ticketOfrNm;
	}
	public void setTicketOfrNm(String ticketOfrNm) {
		this.ticketOfrNm = ticketOfrNm;
	}
	public String getBnftOfrNm() {
		return bnftOfrNm;
	}
	public void setBnftOfrNm(String bnftOfrNm) {
		this.bnftOfrNm = bnftOfrNm;
	}
	public String getEffStrtDayCnt() {
		return effStrtDayCnt;
	}
	public void setEffStrtDayCnt(String effStrtDayCnt) {
		this.effStrtDayCnt = effStrtDayCnt;
	}
	public String getTotLimitCnt() {
		return totLimitCnt;
	}
	public void setTotLimitCnt(String totLimitCnt) {
		this.totLimitCnt = totLimitCnt;
	}
	public String getMaxApplyCnt() {
		return maxApplyCnt;
	}
	public void setMaxApplyCnt(String maxApplyCnt) {
		this.maxApplyCnt = maxApplyCnt;
	}
	public String getUsePntAmt() {
		return usePntAmt;
	}
	public void setUsePntAmt(String usePntAmt) {
		this.usePntAmt = usePntAmt;
	}
	public String getOfrUseRid() {
		return ofrUseRid;
	}
	public void setOfrUseRid(String ofrUseRid) {
		this.ofrUseRid = ofrUseRid;
	}
	public String getUseOfrAmt() {
		return useOfrAmt;
	}
	public void setUseOfrAmt(String useOfrAmt) {
		this.useOfrAmt = useOfrAmt;
	}
	public String getEvtWinTypeCd() {
		return evtWinTypeCd;
	}
	public void setEvtWinTypeCd(String evtWinTypeCd) {
		this.evtWinTypeCd = evtWinTypeCd;
	}
	public String getWinMbrCnt() {
		return winMbrCnt;
	}
	public void setWinMbrCnt(String winMbrCnt) {
		this.winMbrCnt = winMbrCnt;
	}
	public String getWinRate() {
		return winRate;
	}
	public void setWinRate(String winRate) {
		this.winRate = winRate;
	}
	public String getNoteText() {
		return noteText;
	}
	public void setNoteText(String noteText) {
		this.noteText = noteText;
	}
	public String getSmlTypeCd() {
		return smlTypeCd;
	}
	public void setSmlTypeCd(String smlTypeCd) {
		this.smlTypeCd = smlTypeCd;
	}
	public String getEventNm() {
		return eventNm;
	}
	public void setEventNm(String eventNm) {
		this.eventNm = eventNm;
	}
	public String getEventType() {
		return eventType;
	}
	public void setEventType(String eventType) {
		this.eventType = eventType;
	}
	public String getEventCategory() {
		return eventCategory;
	}
	public void setEventCategory(String eventCategory) {
		this.eventCategory = eventCategory;
	}
	public String getVoteStartDate() {
		return voteStartDate;
	}
	public void setVoteStartDate(String voteStartDate) {
		this.voteStartDate = voteStartDate;
	}
	public String getVoteEndDate() {
		return voteEndDate;
	}
	public void setVoteEndDate(String voteEndDate) {
		this.voteEndDate = voteEndDate;
	}
	public String getEventNo() {
		return eventNo;
	}
	public void setEventNo(String eventNo) {
		this.eventNo = eventNo;
	}
	public String getOneEventVoteTicketCnt() {
		return oneEventVoteTicketCnt;
	}
	public void setOneEventVoteTicketCnt(String oneEventVoteTicketCnt) {
		this.oneEventVoteTicketCnt = oneEventVoteTicketCnt;
	}
	public String getMaxVoteCnt() {
		return maxVoteCnt;
	}
	public void setMaxVoteCnt(String maxVoteCnt) {
		this.maxVoteCnt = maxVoteCnt;
	}
	public String getPromotion() {
		return promotion;
	}
	public void setPromotion(String promotion) {
		this.promotion = promotion;
	}
	public String getEventDate() {
		return eventDate;
	}
	public void setEventDate(String eventDate) {
		this.eventDate = eventDate;
	}
	public String getEventTime() {
		return eventTime;
	}
	public void setEventTime(String eventTime) {
		this.eventTime = eventTime;
	}
	public String getEventWiningDate() {
		return eventWiningDate;
	}
	public void setEventWiningDate(String eventWiningDate) {
		this.eventWiningDate = eventWiningDate;
	}
	public String getEventPlace() {
		return eventPlace;
	}
	public void setEventPlace(String eventPlace) {
		this.eventPlace = eventPlace;
	}
	public String getDownFilecheck() {
		return downFilecheck;
	}
	public void setDownFilecheck(String downFilecheck) {
		this.downFilecheck = downFilecheck;
	}
	public String getDownURL() {
		return downURL;
	}
	public void setDownURL(String downURL) {
		this.downURL = downURL;
	}
	public String getDownFile() {
		return downFile;
	}
	public void setDownFile(String downFile) {
		this.downFile = downFile;
	}
	public String getThumImg() {
		return thumImg;
	}
	public void setThumImg(String thumImg) {
		this.thumImg = thumImg;
	}
	public String getMainImg() {
		return mainImg;
	}
	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}
	public String getDetailImg1() {
		return detailImg1;
	}
	public void setDetailImg1(String detailImg1) {
		this.detailImg1 = detailImg1;
	}
	public String getDetailImg2() {
		return detailImg2;
	}
	public void setDetailImg2(String detailImg2) {
		this.detailImg2 = detailImg2;
	}
	public String getDetailImg3() {
		return detailImg3;
	}
	public void setDetailImg3(String detailImg3) {
		this.detailImg3 = detailImg3;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public String getPromotionRid() {
		return promotionRid;
	}
	public void setPromotionRid(String promotionRid) {
		this.promotionRid = promotionRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRadioCheck() {
		return radioCheck;
	}
	public void setRadioCheck(String radioCheck) {
		this.radioCheck = radioCheck;
	}
	public String getDownFileNm() {
		return downFileNm;
	}
	public void setDownFileNm(String downFileNm) {
		this.downFileNm = downFileNm;
	}
	public String getEventSeq() {
		return eventSeq;
	}
	public void setEventSeq(String eventSeq) {
		this.eventSeq = eventSeq;
	}
	public String getAddrRegYn() {
		return addrRegYn;
	}
	public void setAddrRegYn(String addrRegYn) {
		this.addrRegYn = addrRegYn;
	}
	public String getOneMaxCnt() {
		return oneMaxCnt;
	}
	public void setOneMaxCnt(String oneMaxCnt) {
		this.oneMaxCnt = oneMaxCnt;
	}
	public String getCamTypeCd() {
		return camTypeCd;
	}
	public void setCamTypeCd(String camTypeCd) {
		this.camTypeCd = camTypeCd;
	}
	public String getVideoTime() {
		return videoTime;
	}
	public void setVideoTime(String videoTime) {
		this.videoTime = videoTime;
	}
	public String getDevRegYn() {
		return devRegYn;
	}
	public void setDevRegYn(String devRegYn) {
		this.devRegYn = devRegYn;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	public String getTierLimitYn() {
		return tierLimitYn;
	}
	public void setTierLimitYn(String tierLimitYn) {
		this.tierLimitYn = tierLimitYn;
	}
}