/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyMbrTxnHistListResDto.java
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 11. 오후 5:50:13
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 11.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyMbrTxnHistListResDto
 * 2. 파일명	: LoyMbrTxnHistListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.membership.dto.response
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 11.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@CommCode
public class LoyMbrTxnHistListResDto extends GridPagingItemResDto{
	private String rid;
	private String sellDate;
	
	private String intDomTypeCd;
	@MarkName(groupCode="INT_DOM_TYPE_CD",codeField="intDomTypeCd")
	private String intDomTypeCdNm;
	
	
	@MarkName(groupCode="SELL_TYPE_CD",codeField="sellTypeCd")
	private String sellTypeCd;
	private String sellTypeCdNm;
	
	private String dirPasTypeCd;
	@MarkName(groupCode="DIR_PAS_TYPE_CD",codeField="dirPasTypeCd")
	private String dirPasTypeCdNm;
	
	private String routeTypeCd;
	private String flightNo;
	private String onbrdDate;
	private String seatNo;
	private String sellAmt;
	private String sellAmtSum;
	private String discntAmtSum;
	private String settleAmtSum;
	private String settleDeliSum;
	private String settleDeliCnt;
	private String tickNo;
	
	//추가(기본용)
	private String chnlRid;
	private String chnlNm;
	private String rcptNo;
	private String createDate;
	
	
	private String purHeadRid;
	
	private String srcType;
    
	//@MarkName(groupCode="SRC_TYPE",codeField="srcType")
	private String srcTypeNm;
	
	private String chnlNo;
	private String posNo;
	private String billNo;
	private String discntAmt;
	private String settleAmt;

	private String desc1;
	private String mmZzItemCd;
	
	private String posId;
	private String mallId;
	
	private String prodId;
	private String prodNm;
	private String txnDesc;
	
	private String txnAmtSum;
	private String pntAmtSum;
	
	private String rceptNo; //영수증
	private String txnDate;
	private String txnTypeNm;
	private String txnSubTypeNm;
	private String txnAmt;
	private String pntAmt;
	private String txnNum;
	private String apprNo;
	private String apprDate;
	
	private String txnDt;
	private String pntValidEndDt;
	
	private String lineNo;
	private String uPrice;
	private String saleQty;
	private String saleTot;
	private String dcAmt;
	private String saleAmt;
	private String goodsCd;

	private String cancleDate; //취소일자
	private String rdmPoint; //포인트 사용액
	private String arclPoint; //포인트 적립액
	
	private String salePoint;   //포인트 사용액
	private String pointAmt; // 포인트 적립액
	
	private String goodNm;
	private String mbrSale;
	private String eventSale;
	private String couponSale;
	private String srcIdx;
	private String acrlPoint;
	private String shippingCost;
	private String mbrIntCode;
	private String ridRepMbr;

	private String saleDate;

	private String offlineDC;
	private String cancelYn;
	private String mbrNo;

	@MarkName(groupCode="LOY_CHNL_TYPE_CD",codeField="bsalClsCd")
	private String bsalClsCd;

	private String saleProdNm;
	private String dlvAmt;

	private String brdNm;
	private String ordNo;
	private String actAmt;

	private String colorCd;
	private String sizeCd;
	private String csmPrc;

	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getSettleDeliSum() {
		return settleDeliSum;
	}
	public void setSettleDeliSum(String settleDeliSum) {
		this.settleDeliSum = settleDeliSum;
	}
	public String getSettleDeliCnt() {
		return settleDeliCnt;
	}
	public void setSettleDeliCnt(String settleDeliCnt) {
		this.settleDeliCnt = settleDeliCnt;
	}
	public String getOfflineDC() {
		return offlineDC;
	}
	public void setOfflineDC(String offlineDC) {
		this.offlineDC = offlineDC;
	}
	public String getCancelYn() {
		return cancelYn;
	}
	public void setCancelYn(String cancelYn) {
		this.cancelYn = cancelYn;
	}
	public String getRidRepMbr() {
		return ridRepMbr;
	}
	public void setRidRepMbr(String ridRepMbr) {
		this.ridRepMbr = ridRepMbr;
	}
	public String getMbrIntCode() {
		return mbrIntCode;
	}
	public void setMbrIntCode(String mbrIntCode) {
		this.mbrIntCode = mbrIntCode;
	}
	public String getGoodNm() {
		return goodNm;
	}
	public void setGoodNm(String goodNm) {
		this.goodNm = goodNm;
	}
	public String getMbrSale() {
		return mbrSale;
	}
	public void setMbrSale(String mbrSale) {
		this.mbrSale = mbrSale;
	}
	public String getEventSale() {
		return eventSale;
	}
	public void setEventSale(String eventSale) {
		this.eventSale = eventSale;
	}
	public String getCouponSale() {
		return couponSale;
	}
	public void setCouponSale(String couponSale) {
		this.couponSale = couponSale;
	}
	public String getCancleDate() {
		return cancleDate;
	}
	public void setCancleDate(String cancleDate) {
		this.cancleDate = cancleDate;
	}
	public String getRdmPoint() {
		return rdmPoint;
	}
	public void setRdmPoint(String rdmPoint) {
		this.rdmPoint = rdmPoint;
	}
	public String getArclPoint() {
		return arclPoint;
	}
	public void setArclPoint(String arclPoint) {
		this.arclPoint = arclPoint;
	}
	public String getLineNo() {
		return lineNo;
	}
	public void setLineNo(String lineNo) {
		this.lineNo = lineNo;
	}
	public String getuPrice() {
		return uPrice;
	}
	public void setuPrice(String uPrice) {
		this.uPrice = uPrice;
	}
	public String getSaleQty() {
		return saleQty;
	}
	public void setSaleQty(String saleQty) {
		this.saleQty = saleQty;
	}
	public String getSaleTot() {
		return saleTot;
	}
	public void setSaleTot(String saleTot) {
		this.saleTot = saleTot;
	}
	public String getDcAmt() {
		return dcAmt;
	}
	public void setDcAmt(String dcAmt) {
		this.dcAmt = dcAmt;
	}
	public String getSaleAmt() {
		return saleAmt;
	}
	public void setSaleAmt(String saleAmt) {
		this.saleAmt = saleAmt;
	}
	public String getGoodsCd() {
		return goodsCd;
	}
	public void setGoodsCd(String goodsCd) {
		this.goodsCd = goodsCd;
	}
	public String getTxnDate() {
		return txnDate;
	}
	public void setTxnDate(String txnDate) {
		this.txnDate = txnDate;
	}
	public String getTxnTypeNm() {
		return txnTypeNm;
	}
	public void setTxnTypeNm(String txnTypeNm) {
		this.txnTypeNm = txnTypeNm;
	}
	public String getTxnSubTypeNm() {
		return txnSubTypeNm;
	}
	public void setTxnSubTypeNm(String txnSubTypeNm) {
		this.txnSubTypeNm = txnSubTypeNm;
	}
	public String getTxnDesc() {
		return txnDesc;
	}
	public void setTxnDesc(String txnDesc) {
		this.txnDesc = txnDesc;
	}
	public String getPosId() {
		return posId;
	}
	public void setPosId(String posId) {
		this.posId = posId;
	}
	public String getMallId() {
		return mallId;
	}
	public void setMallId(String mallId) {
		this.mallId = mallId;
	}
	public String getDesc1() {
		return desc1;
	}
	public void setDesc1(String desc1) {
		this.desc1 = desc1;
	}
	public String getMmZzItemCd() {
		return mmZzItemCd;
	}
	public void setMmZzItemCd(String mmZzItemCd) {
		this.mmZzItemCd = mmZzItemCd;
	}
	public String getSrcType() {
		return srcType;
	}
	public void setSrcType(String srcType) {
		this.srcType = srcType;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getPosNo() {
		return posNo;
	}
	public void setPosNo(String posNo) {
		this.posNo = posNo;
	}
	public String getBillNo() {
		return billNo;
	}
	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}
	public String getDiscntAmt() {
		return discntAmt;
	}
	public void setDiscntAmt(String discntAmt) {
		this.discntAmt = discntAmt;
	}
	public String getSettleAmt() {
		return settleAmt;
	}
	public void setSettleAmt(String settleAmt) {
		this.settleAmt = settleAmt;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSellDate() {
		return sellDate;
	}
	public void setSellDate(String sellDate) {
		this.sellDate = sellDate;
	}
	public String getIntDomTypeCd() {
		return intDomTypeCd;
	}
	public void setIntDomTypeCd(String intDomTypeCd) {
		this.intDomTypeCd = intDomTypeCd;
	}
	public String getIntDomTypeCdNm() {
		return intDomTypeCdNm;
	}
	public void setIntDomTypeCdNm(String intDomTypeCdNm) {
		this.intDomTypeCdNm = intDomTypeCdNm;
	}
	public String getSellTypeCd() {
		return sellTypeCd;
	}
	public void setSellTypeCd(String sellTypeCd) {
		this.sellTypeCd = sellTypeCd;
	}
	public String getSellTypeCdNm() {
		return sellTypeCdNm;
	}
	public void setSellTypeCdNm(String sellTypeCdNm) {
		this.sellTypeCdNm = sellTypeCdNm;
	}
	public String getDirPasTypeCd() {
		return dirPasTypeCd;
	}
	public void setDirPasTypeCd(String dirPasTypeCd) {
		this.dirPasTypeCd = dirPasTypeCd;
	}
	public String getDirPasTypeCdNm() {
		return dirPasTypeCdNm;
	}
	public void setDirPasTypeCdNm(String dirPasTypeCdNm) {
		this.dirPasTypeCdNm = dirPasTypeCdNm;
	}
	public String getRouteTypeCd() {
		return routeTypeCd;
	}
	public void setRouteTypeCd(String routeTypeCd) {
		this.routeTypeCd = routeTypeCd;
	}
	public String getFlightNo() {
		return flightNo;
	}
	public void setFlightNo(String flightNo) {
		this.flightNo = flightNo;
	}
	public String getOnbrdDate() {
		return onbrdDate;
	}
	public void setOnbrdDate(String onbrdDate) {
		this.onbrdDate = onbrdDate;
	}
	public String getSeatNo() {
		return seatNo;
	}
	public void setSeatNo(String seatNo) {
		this.seatNo = seatNo;
	}
	public String getSellAmt() {
		return sellAmt;
	}
	public void setSellAmt(String sellAmt) {
		this.sellAmt = sellAmt;
	}
	public String getTickNo() {
		return tickNo;
	}
	public void setTickNo(String tickNo) {
		this.tickNo = tickNo;
	}
	public String getChnlRid() {
		return chnlRid;
	}
	public void setChnlRid(String chnlRid) {
		this.chnlRid = chnlRid;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getRcptNo() {
		return rcptNo;
	}
	public void setRcptNo(String rcptNo) {
		this.rcptNo = rcptNo;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getPurHeadRid() {
		return purHeadRid;
	}
	public void setPurHeadRid(String purHeadRid) {
		this.purHeadRid = purHeadRid;
	}
	
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	
	public String getSrcTypeNm() {
		return srcTypeNm;
	}
	public void setSrcTypeNm(String srcTypeNm) {
		this.srcTypeNm = srcTypeNm;
	}
	public String getSellAmtSum() {
		return sellAmtSum;
	}
	public void setSellAmtSum(String sellAmtSum) {
		this.sellAmtSum = sellAmtSum;
	}
	public String getDiscntAmtSum() {
		return discntAmtSum;
	}
	public void setDiscntAmtSum(String discntAmtSum) {
		this.discntAmtSum = discntAmtSum;
	}
	public String getSettleAmtSum() {
		return settleAmtSum;
	}
	public void setSettleAmtSum(String settleAmtSum) {
		this.settleAmtSum = settleAmtSum;
	}
	public String getTxnAmtSum() {
		return txnAmtSum;
	}
	public void setTxnAmtSum(String txnAmtSum) {
		this.txnAmtSum = txnAmtSum;
	}
	public String getPntAmtSum() {
		return pntAmtSum;
	}
	public void setPntAmtSum(String pntAmtSum) {
		this.pntAmtSum = pntAmtSum;
	}
	public String getRceptNo() {
		return rceptNo;
	}
	public void setRceptNo(String rceptNo) {
		this.rceptNo = rceptNo;
	}
	public String getTxnAmt() {
		return txnAmt;
	}
	public void setTxnAmt(String txnAmt) {
		this.txnAmt = txnAmt;
	}
	public String getPntAmt() {
		return pntAmt;
	}
	public void setPntAmt(String pntAmt) {
		this.pntAmt = pntAmt;
	}
	public String getTxnNum() {
		return txnNum;
	}
	public void setTxnNum(String txnNum) {
		this.txnNum = txnNum;
	}
	public String getApprNo() {
		return apprNo;
	}
	public void setApprNo(String apprNo) {
		this.apprNo = apprNo;
	}
	public String getApprDate() {
		return apprDate;
	}
	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}
	public String getTxnDt() {
		return txnDt;
	}
	public void setTxnDt(String txnDt) {
		this.txnDt = txnDt;
	}
	public String getPntValidEndDt() {
		return pntValidEndDt;
	}
	public void setPntValidEndDt(String pntValidEndDt) {
		this.pntValidEndDt = pntValidEndDt;
	}
	public String getSalePoint() {
		return salePoint;
	}
	public void setSalePoint(String salePoint) {
		this.salePoint = salePoint;
	}
	public String getPointAmt() {
		return pointAmt;
	}
	public void setPointAmt(String pointAmt) {
		this.pointAmt = pointAmt;
	}
	public String getSrcIdx() {
		return srcIdx;
	}
	public void setSrcIdx(String srcIdx) {
		this.srcIdx = srcIdx;
	}
	public String getAcrlPoint() {
		return acrlPoint;
	}
	public void setAcrlPoint(String acrlPoint) {
		this.acrlPoint = acrlPoint;
	}
	public String getShippingCost() {
		return shippingCost;
	}
	public void setShippingCost(String shippingCost) {
		this.shippingCost = shippingCost;
	}
	public String getBsalClsCd() {return bsalClsCd;}
	public void setBsalClsCd(String bsalClsCd) {this.bsalClsCd = bsalClsCd;}
	public String getSaleProdNm() {return saleProdNm;}
	public void setSaleProdNm(String saleProdNm) {this.saleProdNm = saleProdNm;}
	public String getDlvAmt() {return dlvAmt;}
	public void setDlvAmt(String dlvAmt) {this.dlvAmt = dlvAmt;}
	public String getBrdNm() {return brdNm;}
	public void setBrdNm(String brdNm) {this.brdNm = brdNm;}
	public String getSaleDate() {return saleDate;}
	public void setSaleDate(String saleDate) {this.saleDate = saleDate;}
	public String getOrdNo() {return ordNo;}
	public void setOrdNo(String ordNo) {this.ordNo = ordNo;}
	public String getActAmt() {return actAmt;}
	public void setActAmt(String actAmt) {this.actAmt = actAmt;}
	public String getColorCd() {return colorCd;}
	public void setColorCd(String colorCd) {this.colorCd = colorCd;}
	public String getSizeCd() {return sizeCd;}
	public void setSizeCd(String sizeCd) {this.sizeCd = sizeCd;}
	public String getCsmPrc() {return csmPrc;}
	public void setCsmPrc(String csmPrc) {this.csmPrc = csmPrc;}
}
