/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyPurTxnHistListResDto.java
 * 2. Package	: com.icignal.loyalty.benefit.point.dto.response
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 11. 오후 7:57:50
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 11.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.benefit.point.dto.response;

import java.util.Calendar;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyPurTxnHistListResDto
 * 2. 파일명	: LoyPurTxnHistListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.benefit.point.dto.response
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
@PersonalData
public class LoyPurTxnHistListResDto extends GridPagingItemResDto{
	private String mbrNo;
	
	private String rid;
	private String sellDate;  
	
	private String intDomTypeCd;
	@MarkName(groupCode="INT_DOM_TYPE_CD",codeField="intDomTypeCd")
	private String intDomTypeCdNm;
	
	private String sellTypeCd;
	@MarkName(groupCode="SELL_TYPE_CD",codeField="sellTypeCd")
	private String sellTypeCdNm;
	
	private String dirPasTypeCd;
	@MarkName(groupCode="DIR_PAS_TYPE_CD",codeField="dirPasTypeCd")
	private String dirPasTypeCdNm;
	
	private String routeTypeCd;
	private String flightNo;
	private String onbrdDate;
	private String seatNo;
	private String sellAmt;
	private String tickNo;
	@Decrypted(masked = "custNm")
	private String custNm;
	@Decrypted(masked = "tel")
	private String hhp;
	@Decrypted(masked = "none")
	private String unMaskCustNm;
	@Decrypted(masked = "none")
	private String unMaskHhp;
	private String ridMbr;
	
	private String chnlNm;
	private String rcptNo;
	private String createDate;
	
	private String billNo;
	private String txnDesc;
	//회원유형을 위한 필드 custTypeCd 와 custTypeCdNm
	@MarkName(groupCode="LOY_CUST_TYPE_CD" , codeField="custTypeCd")
	private String custTypeCdNm;
	private String custTypeCd;

	@MarkName(groupCode="LOY_MBR_TYPE_CD" , codeField="mbrTypeCd")
	private String mbrTypeCdNm;
	private String mbrTypeCd;

	private String tierNm;
	private String birthDt;
	
	private String genCd;
	@MarkName(groupCode="LOY_GEN_CD" , codeField="genCd")
	private String genCdNm;

	private String discntAmt;
	private String settleAmt;

	private String ridCus;

	private String srcType;
	@MarkName(groupCode="SRC_TYPE" , codeField="srcType")
	private String srcTypeNm;

	private String custStatCd;
	@MarkName(groupCode="LOY_MBR_STAT_CD" , codeField="custStatCd")
	private String custStatCdNm;

	private String custNo;

	private String sbscDate;
	private String mbrStatCd;
	@MarkName(groupCode="LOY_MBR_STAT_CD" , codeField="mbrStatCd")
	private String mbrStatCdNm;
	private String srcIdx;
	private String goodNm;
	private String uPrice;
	private String saleQty;
	private String saleTot;
	private String prodId;
	private String mmZzItemCd;
	private String goodsCd;
	private String birthDate;
	private String ridOrd;
	
	private String shippingCost;
	
	private String offlineDC;
	private String mbrSale;
	private String eventSale;
	private String couponSale;
	private String pointAmt;
	private String salePoint;
	private String mmGroup;

	@MarkName(groupCode="LOY_CHNL_TYPE_CD" , codeField="bsalClsCd")
	private String bsalClsCdNm;
	private String bsalClsCd;	//영업구분코드

	private String brdNm;
	private String saleDate; //판매일자
	private String ordNo; //거래(주문)번호
	private String saleProdNm; //거래명

	@MarkName(groupCode="SELL_TYPE_CD" , codeField="slrtClsCd")
	private String slrtClsCdNm; //거래유형(판매,취소) sell_type_cd 공통코드
	private String slrtClsCd; //거래유형(판매,취소) sell_type_cd 공통코드
	private String totAmt; //정상가총액
	private String actAmt; //실결제금액
	private String discAmt;//할인금액
	private String dlvAmt; //배송비

	private String prodNm; //상품명
	private String colorCd; //컬러
	private String sizeCd; //사이즈
	private String csmPrc; //정상가
	private String milUseAmt; //사용적립금

	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_DST", codeField = "tierDST")
	private String tierDSTNm;
	private String tierDST;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_UMB", codeField = "tierUMB")
	private String tierUMBNm;
	private String tierUMB;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_LCS", codeField = "tierLCS")
	private String tierLCSNm;
	private String tierLCS;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_DSG", codeField = "tierDSG")
	private String tierDSGNm;
	private String tierDSG;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_LCG", codeField = "tierLCG")
	private String tierLCGNm;
	private String tierLCG;
	@MarkName(groupCode = "X_LOY_MBR_TIER_TYPE_CD_MSW", codeField = "tierMSW")
	private String tierMSWNm;
	private String tierMSW;

	public String getMmGroup() {
		return mmGroup;
	}
	public void setMmGroup(String mmGroup) {
		this.mmGroup = mmGroup;
	}
	public String getOfflineDC() {
		return offlineDC;
	}
	public void setOfflineDC(String offlineDC) {
		this.offlineDC = offlineDC;
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
	public String getPointAmt() {
		return pointAmt;
	}
	public void setPointAmt(String pointAmt) {
		this.pointAmt = pointAmt;
	}
	public String getSalePoint() {
		return salePoint;
	}
	public void setSalePoint(String salePoint) {
		this.salePoint = salePoint;
	}
	public String getShippingCost() {
		return shippingCost;
	}
	public void setShippingCost(String shippingCost) {
		this.shippingCost = shippingCost;
	}
	public String getRidOrd() {
		return ridOrd;
	}
	public void setRidOrd(String ridOrd) {
		this.ridOrd = ridOrd;
	}
	public String getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getMbrStatCdNm() {
		return mbrStatCdNm;
	}
	public void setMbrStatCdNm(String mbrStatCdNm) {
		this.mbrStatCdNm = mbrStatCdNm;
	}
	public String getSrcIdx() {
		return srcIdx;
	}
	public void setSrcIdx(String srcIdx) {
		this.srcIdx = srcIdx;
	}
	public String getGoodNm() {
		return goodNm;
	}
	public void setGoodNm(String goodNm) {
		this.goodNm = goodNm;
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
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getMmZzItemCd() {
		return mmZzItemCd;
	}
	public void setMmZzItemCd(String mmZzItemCd) {
		this.mmZzItemCd = mmZzItemCd;
	}
	public String getGoodsCd() {
		return goodsCd;
	}
	public void setGoodsCd(String goodsCd) {
		this.goodsCd = goodsCd;
	}
	public String getTxnDesc() {
		return txnDesc;
	}
	public void setTxnDesc(String txnDesc) {
		this.txnDesc = txnDesc;
	}
	public String getMbrTypeCd() {
		return mbrTypeCd;
	}
	public void setMbrTypeCd(String mbrTypeCd) {
		this.mbrTypeCd = mbrTypeCd;
	}
	public String getMbrTypeCdNm() {
		return mbrTypeCdNm;
	}
	public void setMbrTypeCdNm(String mbrTypeCdNm) {
		this.mbrTypeCdNm = mbrTypeCdNm;
	}
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	
	public String getBirthDt() {
		return birthDt;
	}
	public void setBirthDt(String birthDt) {
		if(birthDt!=null){
			String[] ages = birthDt.split("-");
			
			int birthYear = Integer.parseInt(ages[0]);
			int birthMonth = Integer.parseInt(ages[1]);
			int birthDay = Integer.parseInt(ages[2]);
			
			//나이 구하기
	        Calendar current = Calendar.getInstance();
	        int currentYear  = current.get(Calendar.YEAR);
	        int currentMonth = current.get(Calendar.MONTH) + 1;
	        int currentDay   = current.get(Calendar.DAY_OF_MONTH);
	       
	        int age = currentYear - birthYear;
	        // 생일 안 지난 경우 -1
	        if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
	            age--;
	        }
	        birthDt = Integer.toString(age);
			}
			this.birthDt = birthDt;
	}
	//	public String getBirthDt() {
//		return birthDt;
//	}
//	public void setBirthDt(String birthDt) {
//
//		String[] ages = birthDt.split("-");
//
//		int birthYear = Integer.parseInt(ages[0]);
//		int birthMonth = Integer.parseInt(ages[1]);
//		int birthDay = Integer.parseInt(ages[2]);
//
//		//나이 구하기
//        Calendar current = Calendar.getInstance();
//        int currentYear  = current.get(Calendar.YEAR);
//        int currentMonth = current.get(Calendar.MONTH) + 1;
//        int currentDay   = current.get(Calendar.DAY_OF_MONTH);
//
//        int age = currentYear - birthYear;
//        // 생일 안 지난 경우 -1
//        if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
//            age--;
//        }
//        birthDt = Integer.toString(age);
//
//        if(birthDt.equals("0")) {
//        	birthDt = null;
//        }
//
//		this.birthDt = birthDt;
//	}
	public String getGenCd() {
		return genCd;
	}
	public void setGenCd(String genCd) {
		this.genCd = genCd;
	}
	public String getGenCdNm() {
		return genCdNm;
	}
	public void setGenCdNm(String genCdNm) {
		this.genCdNm = genCdNm;
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
	public String getRidCus() {
		return ridCus;
	}
	public void setRidCus(String ridCus) {
		this.ridCus = ridCus;
	}
	public String getBillNo() {
		return billNo;
	}
	public void setBillNo(String billNo) {
		this.billNo = billNo;
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
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getUnMaskCustNm() {
		return unMaskCustNm;
	}
	public void setUnMaskCustNm(String unMaskCustNm) {
		this.unMaskCustNm = unMaskCustNm;
	}
	public String getUnMaskHhp() {
		return unMaskHhp;
	}
	public void setUnMaskHhp(String unMaskHhp) {
		this.unMaskHhp = unMaskHhp;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
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
	
	public String getCustTypeCd() {
		return custTypeCd;
	}
	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}
	
	public String getCustTypeCdNm() {
		return custTypeCdNm;
	}
	public void setCustTypeCdNm(String custTypeCdNm) {
		this.custTypeCdNm = custTypeCdNm;
	}
	
	public String getSrcType() {
		return srcType;
	}
	public void setSrcType(String srcType) {
		this.srcType = srcType;
	}
	public String getSrcTypeNm() {
		return srcTypeNm;
	}
	public void setSrcTypeNm(String srcTypeNm) {
		this.srcTypeNm = srcTypeNm;
	}

	public String getCustStatCd() {
		return custStatCd;
	}
	public void setCustStatCd(String custStatCd) {
		this.custStatCd = custStatCd;
	}
	public String getCustStatCdNm() {
		return custStatCdNm;
	}
	public void setCustStatCdNm(String custStatCdNm) {
		this.custStatCdNm = custStatCdNm;
	}
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getSbscDate() {
		return sbscDate;
	}
	public void setSbscDate(String sbscDate) {
		this.sbscDate = sbscDate;
	}

	public String getBsalClsCd() {
		return bsalClsCd;
	}

	public void setBsalClsCd(String bsalClsCd) {
		this.bsalClsCd = bsalClsCd;
	}

	public String getBrdNm() {
		return brdNm;
	}

	public void setBrdNm(String brdNm) {
		this.brdNm = brdNm;
	}

	public String getSaleDate() {
		return saleDate;
	}

	public void setSaleDate(String saleDate) {
		this.saleDate = saleDate;
	}

	public String getOrdNo() {
		return ordNo;
	}

	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}

	public String getSaleProdNm() {
		return saleProdNm;
	}

	public void setSaleProdNm(String saleProdNm) {
		this.saleProdNm = saleProdNm;
	}

	public String getSlrtClsCd() {
		return slrtClsCd;
	}

	public void setSlrtClsCd(String slrtClsCd) {
		this.slrtClsCd = slrtClsCd;
	}

	public String getTotAmt() {
		return totAmt;
	}

	public void setTotAmt(String totAmt) {
		this.totAmt = totAmt;
	}

	public String getActAmt() {
		return actAmt;
	}

	public void setActAmt(String actAmt) {
		this.actAmt = actAmt;
	}

	public String getDiscAmt() {
		return discAmt;
	}

	public void setDiscAmt(String discAmt) {
		this.discAmt = discAmt;
	}

	public String getDlvAmt() {
		return dlvAmt;
	}

	public void setDlvAmt(String dlvAmt) {
		this.dlvAmt = dlvAmt;
	}

	public String getBsalClsCdNm() {
		return bsalClsCdNm;
	}

	public void setBsalClsCdNm(String bsalClsCdNm) {
		this.bsalClsCdNm = bsalClsCdNm;
	}

	public String getSlrtClsCdNm() {
		return slrtClsCdNm;
	}

	public void setSlrtClsCdNm(String slrtClsCdNm) {
		this.slrtClsCdNm = slrtClsCdNm;
	}

	public String getProdNm() {
		return prodNm;
	}

	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}

	public String getColorCd() {
		return colorCd;
	}

	public void setColorCd(String colorCd) {
		this.colorCd = colorCd;
	}

	public String getSizeCd() {
		return sizeCd;
	}

	public void setSizeCd(String sizeCd) {
		this.sizeCd = sizeCd;
	}

	public String getCsmPrc() {
		return csmPrc;
	}

	public void setCsmPrc(String csmPrc) {
		this.csmPrc = csmPrc;
	}

	public String getMilUseAmt() {
		return milUseAmt;
	}

	public void setMilUseAmt(String milUseAmt) {
		this.milUseAmt = milUseAmt;
	}

	public String getTierDST() {
		return tierDST;
	}

	public void setTierDST(String tierDST) {
		this.tierDST = tierDST;
	}

	public String getTierUMB() {
		return tierUMB;
	}

	public void setTierUMB(String tierUMB) {
		this.tierUMB = tierUMB;
	}

	public String getTierLCS() {
		return tierLCS;
	}

	public void setTierLCS(String tierLCS) {
		this.tierLCS = tierLCS;
	}

	public String getTierDSG() {
		return tierDSG;
	}

	public void setTierDSG(String tierDSG) {
		this.tierDSG = tierDSG;
	}

	public String getTierLCG() {
		return tierLCG;
	}

	public void setTierLCG(String tierLCG) {
		this.tierLCG = tierLCG;
	}

	public String getTierMSW() {
		return tierMSW;
	}

	public void setTierMSW(String tierMSW) {
		this.tierMSW = tierMSW;
	}

	public String getTierDSTNm() {
		return tierDSTNm;
	}

	public void setTierDSTNm(String tierDSTNm) {
		this.tierDSTNm = tierDSTNm;
	}

	public String getTierUMBNm() {
		return tierUMBNm;
	}

	public void setTierUMBNm(String tierUMBNm) {
		this.tierUMBNm = tierUMBNm;
	}

	public String getTierLCSNm() {
		return tierLCSNm;
	}

	public void setTierLCSNm(String tierLCSNm) {
		this.tierLCSNm = tierLCSNm;
	}

	public String getTierDSGNm() {
		return tierDSGNm;
	}

	public void setTierDSGNm(String tierDSGNm) {
		this.tierDSGNm = tierDSGNm;
	}

	public String getTierLCGNm() {
		return tierLCGNm;
	}

	public void setTierLCGNm(String tierLCGNm) {
		this.tierLCGNm = tierLCGNm;
	}

	public String getTierMSWNm() {
		return tierMSWNm;
	}

	public void setTierMSWNm(String tierMSWNm) {
		this.tierMSWNm = tierMSWNm;
	}
}
