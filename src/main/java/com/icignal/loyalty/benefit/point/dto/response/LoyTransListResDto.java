package com.icignal.loyalty.benefit.point.dto.response;

import java.util.Calendar;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@CommCode
@PersonalData
public class LoyTransListResDto  extends GridPagingItemResDto{

	
	private String txnUniqNo;
	private String apprDate;
	private String pntTxnType1Cd;
	private String pntTxnType2Cd;
	private String mbrNo;
	private String ecommMbrNo;
	@Decrypted(masked = "custNm")
	private String custNm;
	private String mbrStatCd;
	private String memDiv;
	private String txnDesc;
	private String memDivCd;
	private String memGrade;
	private String pntAmt;
	private String usePnt;
	private String giftPnt;
	private String prodNm;
	private String txnAmt;
	private String chnlNo;
	private String chnlNm;
	private String groupPnt;
	private String rid;
	
	@Decrypted(masked = "cardNum")
	private String cardNoDecoding;
	private String cardNo;
	private String ridMbr;
	private String promoCnt;
	private String ridMbrCard;
	private String ridProd;
	private String cardTypeCd;
	private String cprtCardCd;
	private String cardTypeCdCode;
	private String cprtCardCdName;
	private String ridChnl;
	private String txnDt;
	private String cardKndNm;
	private String rcptno;
	private String txnStatNm;
	private String orgnApprNo;
	private String orgnApprDate;
	private String apprNo;
	private String webId;
	private String txnStatCd;
	private String apprDateYYYYMMDD;
	private String pntTxnType1code;
	private String pntTxnType2code;
	private String dtlApprDate;
	private String dtlApprNo;
	private String dtlPntTxnType2Cd;
	private String dtlMbrNo;
	private String dtlCustNm;
	private String dtlMemDiv;
	private String dtlRidTierCur;
	private String dtlPntAmt;
	private String dtlUsePnt;
	private String dtlChnlNo;
	private String dtlChnlNm;
	private String dtlBizno;
	private String dtlTotalPntAvl;
	private String dtlGiftPnt;
	private String dtlMemGrade;
	private String dtlCardNum;
	private String dtlPntTxnType1Cd;
	private String dtlCprtCardCd;
	private String dtlCardTypeCd;
	private String tabSndDate;
	private String tabTxnUniqNo;
	private String tabTerminalCd;
	private String tabTxnDate;
	private String tabRefNo;
	private String tabReqTypeCd;
	private String tabAmtTypeCd;
	private String tabPaymentCd;
	private String tabProdId;
	private String tabProdNm;
	private String tabProdUnitCost;
	private String tabProdQty;
	private String tabTxnAmt;
	private String tabChnlNo;
	private String tabChnlNm;
	private String tabGroupPnt;
	private String tabRidMbrTransfer;
	private String tabCustNm;
	private String tabCardDrctDdctPnt;
	private String tabAutoDeductYn;
	private String tabCnclYn;
	private String tabCnclDt;
	private String tabOrgnApprDate;
	private String tabOrgnApprNo;
	private String tabExpireMonths;
	private String tabCouponNo;
	private String tabTicketNum;
	private String tabCnclTypeCd;
    private String tabDispNo;
    private String camNm;
    private String offerNm;
    private String tabAcrlAmt;
    private String validEndDate;
    private String acrlDate;
    private String pntTxnType1CdNm;
    private String pntTxnType2CdNm;
    private String txnDate;
    private String createByNm;
    private String promYn;
    private String validDate;
    private String pntAccntBigTypeCdNm;
    private String pntAccntMidTypeCdNm;
    private String pntAccntSmlTypeCdNm;
    private String pntAccntDetailTypeCdNm;
    private String acrlDesc;
    @Decrypted(masked = "tel")
	private String hhp;
    @Decrypted(masked = "none")
    private String unMaskCustNm;
    @Decrypted(masked = "none")
    private String unMaskHhp;
	
	
	private String birthDt;
	
	private String tierNm;
	
	private String genCd;
	@MarkName(groupCode="LOY_GEN_CD" , codeField="genCd")
	private String genCdNm;
	
	private String custTypeCd;
	@MarkName(groupCode="LOY_CUST_TYPE_CD" , codeField="custTypeCd")
	private String custTypeCdNm;
	private String salesAmt;
		
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
	public String getUnMaskHhp() {
		return unMaskHhp;
	}
	public void setUnMaskHhp(String unMaskHhp) {
		this.unMaskHhp = unMaskHhp;
	}
	public String getUnMaskCustNm() {
		return unMaskCustNm;
	}
	public void setUnMaskCustNm(String unMaskCustNm) {
		this.unMaskCustNm = unMaskCustNm;
	}
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getTabDispNo() {
		return tabDispNo;
	}
	public void setTabDispNo(String tabDispNo) {
		this.tabDispNo = tabDispNo;
	}
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getOfferNm() {
		return offerNm;
	}
	public void setOfferNm(String offerNm) {
		this.offerNm = offerNm;
	}
	public String getTabAcrlAmt() {
		return tabAcrlAmt;
	}
	public void setTabAcrlAmt(String tabAcrlAmt) {
		this.tabAcrlAmt = tabAcrlAmt;
	}
	public String getValidEndDate() {
		return validEndDate;
	}
	public void setValidEndDate(String validEndDate) {
		this.validEndDate = validEndDate;
	}
	public String getAcrlDate() {
		return acrlDate;
	}
	public void setAcrlDate(String acrlDate) {
		this.acrlDate = acrlDate;
	}
	public String getPntTxnType1CdNm() {
		return pntTxnType1CdNm;
	}
	public void setPntTxnType1CdNm(String pntTxnType1CdNm) {
		this.pntTxnType1CdNm = pntTxnType1CdNm;
	}
	public String getPntTxnType2CdNm() {
		return pntTxnType2CdNm;
	}
	public void setPntTxnType2CdNm(String pntTxnType2CdNm) {
		this.pntTxnType2CdNm = pntTxnType2CdNm;
	}
	public String getTxnDate() {
		return txnDate;
	}
	public void setTxnDate(String txnDate) {
		this.txnDate = txnDate;
	}
	public String getCreateByNm() {
		return createByNm;
	}
	public void setCreateByNm(String createByNm) {
		this.createByNm = createByNm;
	}
	public String getPromYn() {
		return promYn;
	}
	public void setPromYn(String promYn) {
		this.promYn = promYn;
	}
	public String getValidDate() {
		return validDate;
	}
	public void setValidDate(String validDate) {
		this.validDate = validDate;
	}
	public String getPntAccntBigTypeCdNm() {
		return pntAccntBigTypeCdNm;
	}
	public void setPntAccntBigTypeCdNm(String pntAccntBigTypeCdNm) {
		this.pntAccntBigTypeCdNm = pntAccntBigTypeCdNm;
	}
	public String getPntAccntMidTypeCdNm() {
		return pntAccntMidTypeCdNm;
	}
	public void setPntAccntMidTypeCdNm(String pntAccntMidTypeCdNm) {
		this.pntAccntMidTypeCdNm = pntAccntMidTypeCdNm;
	}
	public String getPntAccntSmlTypeCdNm() {
		return pntAccntSmlTypeCdNm;
	}
	public void setPntAccntSmlTypeCdNm(String pntAccntSmlTypeCdNm) {
		this.pntAccntSmlTypeCdNm = pntAccntSmlTypeCdNm;
	}
	public String getPntAccntDetailTypeCdNm() {
		return pntAccntDetailTypeCdNm;
	}
	public void setPntAccntDetailTypeCdNm(String pntAccntDetailTypeCdNm) {
		this.pntAccntDetailTypeCdNm = pntAccntDetailTypeCdNm;
	}
	public String getAcrlDesc() {
		return acrlDesc;
	}
	public void setAcrlDesc(String acrlDesc) {
		this.acrlDesc = acrlDesc;
	}
	public String getTabSndDate() {
		return tabSndDate;
	}
	public void setTabSndDate(String tabSndDate) {
		this.tabSndDate = tabSndDate;
	}
	public String getTabTxnUniqNo() {
		return tabTxnUniqNo;
	}
	public void setTabTxnUniqNo(String tabTxnUniqNo) {
		this.tabTxnUniqNo = tabTxnUniqNo;
	}
	public String getTabTerminalCd() {
		return tabTerminalCd;
	}
	public void setTabTerminalCd(String tabTerminalCd) {
		this.tabTerminalCd = tabTerminalCd;
	}
	public String getTabTxnDate() {
		return tabTxnDate;
	}
	public void setTabTxnDate(String tabTxnDate) {
		this.tabTxnDate = tabTxnDate;
	}
	public String getTabRefNo() {
		return tabRefNo;
	}
	public void setTabRefNo(String tabRefNo) {
		this.tabRefNo = tabRefNo;
	}
	public String getTabReqTypeCd() {
		return tabReqTypeCd;
	}
	public void setTabReqTypeCd(String tabReqTypeCd) {
		this.tabReqTypeCd = tabReqTypeCd;
	}
	public String getTabAmtTypeCd() {
		return tabAmtTypeCd;
	}
	public void setTabAmtTypeCd(String tabAmtTypeCd) {
		this.tabAmtTypeCd = tabAmtTypeCd;
	}
	public String getTabPaymentCd() {
		return tabPaymentCd;
	}
	public void setTabPaymentCd(String tabPaymentCd) {
		this.tabPaymentCd = tabPaymentCd;
	}
	public String getTabProdId() {
		return tabProdId;
	}
	public void setTabProdId(String tabProdId) {
		this.tabProdId = tabProdId;
	}
	public String getTabProdNm() {
		return tabProdNm;
	}
	public void setTabProdNm(String tabProdNm) {
		this.tabProdNm = tabProdNm;
	}
	public String getTabProdUnitCost() {
		return tabProdUnitCost;
	}
	public void setTabProdUnitCost(String tabProdUnitCost) {
		this.tabProdUnitCost = tabProdUnitCost;
	}
	public String getTabProdQty() {
		return tabProdQty;
	}
	public void setTabProdQty(String tabProdQty) {
		this.tabProdQty = tabProdQty;
	}
	public String getTabTxnAmt() {
		return tabTxnAmt;
	}
	public void setTabTxnAmt(String tabTxnAmt) {
		this.tabTxnAmt = tabTxnAmt;
	}
	public String getTabChnlNo() {
		return tabChnlNo;
	}
	public void setTabChnlNo(String tabChnlNo) {
		this.tabChnlNo = tabChnlNo;
	}
	public String getTabChnlNm() {
		return tabChnlNm;
	}
	public void setTabChnlNm(String tabChnlNm) {
		this.tabChnlNm = tabChnlNm;
	}
	public String getTabGroupPnt() {
		return tabGroupPnt;
	}
	public void setTabGroupPnt(String tabGroupPnt) {
		this.tabGroupPnt = tabGroupPnt;
	}
	public String getTabRidMbrTransfer() {
		return tabRidMbrTransfer;
	}
	public void setTabRidMbrTransfer(String tabRidMbrTransfer) {
		this.tabRidMbrTransfer = tabRidMbrTransfer;
	}
	public String getTabCustNm() {
		return tabCustNm;
	}
	public void setTabCustNm(String tabCustNm) {
		this.tabCustNm = tabCustNm;
	}
	public String getTabCardDrctDdctPnt() {
		return tabCardDrctDdctPnt;
	}
	public void setTabCardDrctDdctPnt(String tabCardDrctDdctPnt) {
		this.tabCardDrctDdctPnt = tabCardDrctDdctPnt;
	}
	public String getTabAutoDeductYn() {
		return tabAutoDeductYn;
	}
	public void setTabAutoDeductYn(String tabAutoDeductYn) {
		this.tabAutoDeductYn = tabAutoDeductYn;
	}
	public String getTabCnclYn() {
		return tabCnclYn;
	}
	public void setTabCnclYn(String tabCnclYn) {
		this.tabCnclYn = tabCnclYn;
	}
	public String getTabCnclDt() {
		return tabCnclDt;
	}
	public void setTabCnclDt(String tabCnclDt) {
		this.tabCnclDt = tabCnclDt;
	}
	public String getTabOrgnApprDate() {
		return tabOrgnApprDate;
	}
	public void setTabOrgnApprDate(String tabOrgnApprDate) {
		this.tabOrgnApprDate = tabOrgnApprDate;
	}
	public String getTabOrgnApprNo() {
		return tabOrgnApprNo;
	}
	public void setTabOrgnApprNo(String tabOrgnApprNo) {
		this.tabOrgnApprNo = tabOrgnApprNo;
	}
	public String getTabExpireMonths() {
		return tabExpireMonths;
	}
	public void setTabExpireMonths(String tabExpireMonths) {
		this.tabExpireMonths = tabExpireMonths;
	}
	public String getTabCouponNo() {
		return tabCouponNo;
	}
	public void setTabCouponNo(String tabCouponNo) {
		this.tabCouponNo = tabCouponNo;
	}
	public String getTabTicketNum() {
		return tabTicketNum;
	}
	public void setTabTicketNum(String tabTicketNum) {
		this.tabTicketNum = tabTicketNum;
	}
	public String getTabCnclTypeCd() {
		return tabCnclTypeCd;
	}
	public void setTabCnclTypeCd(String tabCnclTypeCd) {
		this.tabCnclTypeCd = tabCnclTypeCd;
	}
	public String getDtlApprDate() {
		return dtlApprDate;
	}
	public void setDtlApprDate(String dtlApprDate) {
		this.dtlApprDate = dtlApprDate;
	}
	public String getDtlApprNo() {
		return dtlApprNo;
	}
	public void setDtlApprNo(String dtlApprNo) {
		this.dtlApprNo = dtlApprNo;
	}
	public String getDtlPntTxnType2Cd() {
		return dtlPntTxnType2Cd;
	}
	public void setDtlPntTxnType2Cd(String dtlPntTxnType2Cd) {
		this.dtlPntTxnType2Cd = dtlPntTxnType2Cd;
	}
	public String getDtlMbrNo() {
		return dtlMbrNo;
	}
	public void setDtlMbrNo(String dtlMbrNo) {
		this.dtlMbrNo = dtlMbrNo;
	}
	public String getDtlCustNm() {
		return dtlCustNm;
	}
	public void setDtlCustNm(String dtlCustNm) {
		this.dtlCustNm = dtlCustNm;
	}
	public String getDtlMemDiv() {
		return dtlMemDiv;
	}
	public void setDtlMemDiv(String dtlMemDiv) {
		this.dtlMemDiv = dtlMemDiv;
	}
	public String getDtlRidTierCur() {
		return dtlRidTierCur;
	}
	public void setDtlRidTierCur(String dtlRidTierCur) {
		this.dtlRidTierCur = dtlRidTierCur;
	}
	public String getDtlPntAmt() {
		return dtlPntAmt;
	}
	public void setDtlPntAmt(String dtlPntAmt) {
		this.dtlPntAmt = dtlPntAmt;
	}
	public String getDtlUsePnt() {
		return dtlUsePnt;
	}
	public void setDtlUsePnt(String dtlUsePnt) {
		this.dtlUsePnt = dtlUsePnt;
	}
	public String getDtlChnlNo() {
		return dtlChnlNo;
	}
	public void setDtlChnlNo(String dtlChnlNo) {
		this.dtlChnlNo = dtlChnlNo;
	}
	public String getDtlChnlNm() {
		return dtlChnlNm;
	}
	public void setDtlChnlNm(String dtlChnlNm) {
		this.dtlChnlNm = dtlChnlNm;
	}
	public String getDtlBizno() {
		return dtlBizno;
	}
	public void setDtlBizno(String dtlBizno) {
		this.dtlBizno = dtlBizno;
	}
	public String getDtlTotalPntAvl() {
		return dtlTotalPntAvl;
	}
	public void setDtlTotalPntAvl(String dtlTotalPntAvl) {
		this.dtlTotalPntAvl = dtlTotalPntAvl;
	}
	public String getDtlGiftPnt() {
		return dtlGiftPnt;
	}
	public void setDtlGiftPnt(String dtlGiftPnt) {
		this.dtlGiftPnt = dtlGiftPnt;
	}
	public String getDtlMemGrade() {
		return dtlMemGrade;
	}
	public void setDtlMemGrade(String dtlMemGrade) {
		this.dtlMemGrade = dtlMemGrade;
	}
	public String getDtlCardNum() {
		return dtlCardNum;
	}
	public void setDtlCardNum(String dtlCardNum) {
		this.dtlCardNum = dtlCardNum;
	}
	public String getDtlPntTxnType1Cd() {
		return dtlPntTxnType1Cd;
	}
	public void setDtlPntTxnType1Cd(String dtlPntTxnType1Cd) {
		this.dtlPntTxnType1Cd = dtlPntTxnType1Cd;
	}
	public String getDtlCprtCardCd() {
		return dtlCprtCardCd;
	}
	public void setDtlCprtCardCd(String dtlCprtCardCd) {
		this.dtlCprtCardCd = dtlCprtCardCd;
	}
	public String getDtlCardTypeCd() {
		return dtlCardTypeCd;
	}
	public void setDtlCardTypeCd(String dtlCardTypeCd) {
		this.dtlCardTypeCd = dtlCardTypeCd;
	}
	public String getTxnUniqNo() {
		return txnUniqNo;
	}
	public void setTxnUniqNo(String txnUniqNo) {
		this.txnUniqNo = txnUniqNo;
	}
	public String getApprDate() {
		return apprDate;
	}
	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}
	public String getPntTxnType1Cd() {
		return pntTxnType1Cd;
	}
	public void setPntTxnType1Cd(String pntTxnType1Cd) {
		this.pntTxnType1Cd = pntTxnType1Cd;
	}
	public String getPntTxnType2Cd() {
		return pntTxnType2Cd;
	}
	public void setPntTxnType2Cd(String pntTxnType2Cd) {
		this.pntTxnType2Cd = pntTxnType2Cd;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getEcommMbrNo() {
		return ecommMbrNo;
	}
	public void setEcommMbrNo(String ecommMbrNo) {
		this.ecommMbrNo = ecommMbrNo;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getMemDiv() {
		return memDiv;
	}
	public void setMemDiv(String memDiv) {
		this.memDiv = memDiv;
	}
	public String getMemDivCd() {
		return memDivCd;
	}
	public void setMemDivCd(String memDivCd) {
		this.memDivCd = memDivCd;
	}
	public String getMemGrade() {
		return memGrade;
	}
	public void setMemGrade(String memGrade) {
		this.memGrade = memGrade;
	}
	public String getPntAmt() {
		return pntAmt;
	}
	public void setPntAmt(String pntAmt) {
		this.pntAmt = pntAmt;
	}
	public String getUsePnt() {
		return usePnt;
	}
	public void setUsePnt(String usePnt) {
		this.usePnt = usePnt;
	}
	public String getGiftPnt() {
		return giftPnt;
	}
	public void setGiftPnt(String giftPnt) {
		this.giftPnt = giftPnt;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getTxnAmt() {
		return txnAmt;
	}
	public void setTxnAmt(String txnAmt) {
		this.txnAmt = txnAmt;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getGroupPnt() {
		return groupPnt;
	}
	public void setGroupPnt(String groupPnt) {
		this.groupPnt = groupPnt;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCardNoDecoding() {
		return cardNoDecoding;
	}
	public void setCardNoDecoding(String cardNoDecoding) {
		this.cardNoDecoding = cardNoDecoding;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getPromoCnt() {
		return promoCnt;
	}
	public void setPromoCnt(String promoCnt) {
		this.promoCnt = promoCnt;
	}
	public String getRidMbrCard() {
		return ridMbrCard;
	}
	public void setRidMbrCard(String ridMbrCard) {
		this.ridMbrCard = ridMbrCard;
	}
	public String getRidProd() {
		return ridProd;
	}
	public void setRidProd(String ridProd) {
		this.ridProd = ridProd;
	}
	public String getCardTypeCd() {
		return cardTypeCd;
	}
	public void setCardTypeCd(String cardTypeCd) {
		this.cardTypeCd = cardTypeCd;
	}
	public String getCprtCardCd() {
		return cprtCardCd;
	}
	public void setCprtCardCd(String cprtCardCd) {
		this.cprtCardCd = cprtCardCd;
	}
	public String getCardTypeCdCode() {
		return cardTypeCdCode;
	}
	public void setCardTypeCdCode(String cardTypeCdCode) {
		this.cardTypeCdCode = cardTypeCdCode;
	}
	public String getCprtCardCdName() {
		return cprtCardCdName;
	}
	public void setCprtCardCdName(String cprtCardCdName) {
		this.cprtCardCdName = cprtCardCdName;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	public String getTxnDt() {
		return txnDt;
	}
	public void setTxnDt(String txnDt) {
		this.txnDt = txnDt;
	}
	public String getCardKndNm() {
		return cardKndNm;
	}
	public void setCardKndNm(String cardKndNm) {
		this.cardKndNm = cardKndNm;
	}
	public String getRcptno() {
		return rcptno;
	}
	public void setRcptno(String rcptno) {
		this.rcptno = rcptno;
	}
	public String getTxnStatNm() {
		return txnStatNm;
	}
	public void setTxnStatNm(String txnStatNm) {
		this.txnStatNm = txnStatNm;
	}
	public String getOrgnApprNo() {
		return orgnApprNo;
	}
	public void setOrgnApprNo(String orgnApprNo) {
		this.orgnApprNo = orgnApprNo;
	}
	public String getOrgnApprDate() {
		return orgnApprDate;
	}
	public void setOrgnApprDate(String orgnApprDate) {
		this.orgnApprDate = orgnApprDate;
	}
	public String getApprNo() {
		return apprNo;
	}
	public void setApprNo(String apprNo) {
		this.apprNo = apprNo;
	}
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getTxnStatCd() {
		return txnStatCd;
	}
	public void setTxnStatCd(String txnStatCd) {
		this.txnStatCd = txnStatCd;
	}
	public String getApprDateYYYYMMDD() {
		return apprDateYYYYMMDD;
	}
	public void setApprDateYYYYMMDD(String apprDateYYYYMMDD) {
		this.apprDateYYYYMMDD = apprDateYYYYMMDD;
	}
	public String getPntTxnType1code() {
		return pntTxnType1code;
	}
	public void setPntTxnType1code(String pntTxnType1code) {
		this.pntTxnType1code = pntTxnType1code;
	}
	public String getPntTxnType2code() {
		return pntTxnType2code;
	}
	public void setPntTxnType2code(String pntTxnType2code) {
		this.pntTxnType2code = pntTxnType2code;
	}
	public String getTxnDesc() {
		return txnDesc;
	}
	public void setTxnDesc(String txnDesc) {
		this.txnDesc = txnDesc;
	}
	public String getSalesAmt() {
		return salesAmt;
	}
	public void setSalesAmt(String salesAmt) {
		this.salesAmt = salesAmt;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}

	
}
