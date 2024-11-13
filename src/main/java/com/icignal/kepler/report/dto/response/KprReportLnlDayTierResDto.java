package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class KprReportLnlDayTierResDto extends GridPagingItemResDto{
	
	private String yyyymmdd;  
	private String chnlNm;    
	
	private String mUnitPrice;
	private long allMbrCnt            ;
	private long allSalAmt            ;
	private long allMbrAmt            ;
	private long mbrAmtRate           ;
	private long allOrdCnt            ;
	private long allSellAmt           ;
	private long allDiscntAmt         ;
	private long allSettleAmt         ;
	private long allAvgSettleAmt      ;
	private long allSkuQty            ;
	private long allSalQty            ;
	private long allAvgSalQty         ;
	private long allAvgUnitPrice        ;
	private long mOrdCnt              ;
	private long mSellAmt             ;
	private long mDiscntAmt           ;
	private long mSettleAmt           ;
	private long mAvgSettleAmt        ;
	private long mSkuQty              ;
	private long mSalQty              ;
	private long mAvgSalQty           ;
	private long mAvgUnitPrice        ;
	private long bOrdCnt              ;
	private long bSellAmt             ;
	private long bDiscntAmt           ;
	private long bSettleAmt           ;
	private long bAvgSettleAmt        ;
	private long bSkuQty              ;
	private long bSalQty              ;
	private long bAvgSalQty           ;
	private long bAvgUnitPrice        ;
	private long lMbrCnt	          ;
	private long lOrdCnt		      ;
	private long lSellAmt		      ;
	private long lDiscntAmt	          ;
	private long lSettleAmt	          ;
	private long lAvgSettleAmt        ;
	private long lUnitPrice	          ;
	private long lSkuQty		      ;
	private long lSalQty		      ;
	private long lAvgSalQty	          ;
	private long lAvgUnitPrice        ;
	private long vMbrCnt	          ;
	private long vOrdCnt		      ;
	private long vSellAmt		      ;
	private long vDiscntAmt	          ;
	private long vSettleAmt	          ;
	private long vAvgSettleAmt        ;
	private long vUnitPrice	          ;
	private long vSkuQty		      ;
	private long vSalQty		      ;
	private long vAvgSalQty	          ;
	private long vAvgUnitPrice        ;
	private long wMbrCnt	          ;
	private long wOrdCnt		      ;
	private long wSellAmt		      ;
	private long wDiscntAmt	          ;
	private long wSettleAmt	          ;
	private long wAvgSettleAmt        ;
	private long wUnitPrice	          ;
	private long wSkuQty		      ;
	private long wSalQty		      ;
	private long wAvgSalQty	          ;
	private long wAvgUnitPrice		  ;
	
	private long pMbrCnt	;
	private long pOrdCnt	;
	private long pSellAmt;
	private long pDiscntAmt;
	private long pSettleAmt;
	private long pAvgSettleAmt;
	private long pUnitPrice;
	private long pSkuQty;
	private long pSalQty;
	private long pAvgSalQty;
	private long pAvgUnitPrice;
	
	private long webMbrCnt	;
	private long webOrdCnt	;
	private long webSellAmt;
	private long webDiscntAmt;
	private long webSettleAmt;
	private long webAvgSettleAmt;
	private long webUnitPrice;
	private long webSkuQty;
	private long webSalQty;
	private long webAvgSalQty;
	private long webAvgUnitPrice;
	
	private long aMbrCnt;
	private long aOrdCnt;
	private long aSellAmt;
	private long aDiscntAmt;
	private long aSettleAmt;
	private long aAvgSettleAmt;
	private long aUnitPrice;
	private long aSkuQty;
	private long aSalQty;
	public long getpMbrCnt() {
		return pMbrCnt;
	}
	public void setpMbrCnt(long pMbrCnt) {
		this.pMbrCnt = pMbrCnt;
	}
	public long getpOrdCnt() {
		return pOrdCnt;
	}
	public void setpOrdCnt(long pOrdCnt) {
		this.pOrdCnt = pOrdCnt;
	}
	public long getpSellAmt() {
		return pSellAmt;
	}
	public void setpSellAmt(long pSellAmt) {
		this.pSellAmt = pSellAmt;
	}
	public long getpDiscntAmt() {
		return pDiscntAmt;
	}
	public void setpDiscntAmt(long pDiscntAmt) {
		this.pDiscntAmt = pDiscntAmt;
	}
	public long getpSettleAmt() {
		return pSettleAmt;
	}
	public void setpSettleAmt(long pSettleAmt) {
		this.pSettleAmt = pSettleAmt;
	}
	public long getpAvgSettleAmt() {
		return pAvgSettleAmt;
	}
	public void setpAvgSettleAmt(long pAvgSettleAmt) {
		this.pAvgSettleAmt = pAvgSettleAmt;
	}
	public long getpUnitPrice() {
		return pUnitPrice;
	}
	public void setpUnitPrice(long pUnitPrice) {
		this.pUnitPrice = pUnitPrice;
	}
	public long getpSkuQty() {
		return pSkuQty;
	}
	public void setpSkuQty(long pSkuQty) {
		this.pSkuQty = pSkuQty;
	}
	public long getpSalQty() {
		return pSalQty;
	}
	public void setpSalQty(long pSalQty) {
		this.pSalQty = pSalQty;
	}
	public long getpAvgSalQty() {
		return pAvgSalQty;
	}
	public void setpAvgSalQty(long pAvgSalQty) {
		this.pAvgSalQty = pAvgSalQty;
	}
	public long getpAvgUnitPrice() {
		return pAvgUnitPrice;
	}
	public void setpAvgUnitPrice(long pAvgUnitPrice) {
		this.pAvgUnitPrice = pAvgUnitPrice;
	}
	public long getWebMbrCnt() {
		return webMbrCnt;
	}
	public void setWebMbrCnt(long webMbrCnt) {
		this.webMbrCnt = webMbrCnt;
	}
	

	public long getWebDiscntAmt() {
		return webDiscntAmt;
	}
	public void setWebDiscntAmt(long webDiscntAmt) {
		this.webDiscntAmt = webDiscntAmt;
	}
	public long getWebSettleAmt() {
		return webSettleAmt;
	}
	public void setWebSettleAmt(long webSettleAmt) {
		this.webSettleAmt = webSettleAmt;
	}
	public long getWebAvgSettleAmt() {
		return webAvgSettleAmt;
	}
	public void setWebAvgSettleAmt(long webAvgSettleAmt) {
		this.webAvgSettleAmt = webAvgSettleAmt;
	}
	public long getWebUnitPrice() {
		return webUnitPrice;
	}
	public void setWebUnitPrice(long webUnitPrice) {
		this.webUnitPrice = webUnitPrice;
	}
	public long getWebSkuQty() {
		return webSkuQty;
	}
	public void setWebSkuQty(long webSkuQty) {
		this.webSkuQty = webSkuQty;
	}
	public long getWebSalQty() {
		return webSalQty;
	}
	public void setWebSalQty(long webSalQty) {
		this.webSalQty = webSalQty;
	}
	public long getWebAvgSalQty() {
		return webAvgSalQty;
	}
	public void setWebAvgSalQty(long webAvgSalQty) {
		this.webAvgSalQty = webAvgSalQty;
	}
	public long getWebAvgUnitPrice() {
		return webAvgUnitPrice;
	}
	public void setWebAvgUnitPrice(long webAvgUnitPrice) {
		this.webAvgUnitPrice = webAvgUnitPrice;
	}
	public long getaMbrCnt() {
		return aMbrCnt;
	}
	public void setaMbrCnt(long aMbrCnt) {
		this.aMbrCnt = aMbrCnt;
	}
	public long getaOrdCnt() {
		return aOrdCnt;
	}
	public void setaOrdCnt(long aOrdCnt) {
		this.aOrdCnt = aOrdCnt;
	}
	public long getaSellAmt() {
		return aSellAmt;
	}
	public void setaSellAmt(long aSellAmt) {
		this.aSellAmt = aSellAmt;
	}
	public long getaDiscntAmt() {
		return aDiscntAmt;
	}
	public void setaDiscntAmt(long aDiscntAmt) {
		this.aDiscntAmt = aDiscntAmt;
	}
	public long getaSettleAmt() {
		return aSettleAmt;
	}
	public void setaSettleAmt(long aSettleAmt) {
		this.aSettleAmt = aSettleAmt;
	}
	public long getaAvgSettleAmt() {
		return aAvgSettleAmt;
	}
	public void setaAvgSettleAmt(long aAvgSettleAmt) {
		this.aAvgSettleAmt = aAvgSettleAmt;
	}
	public long getaUnitPrice() {
		return aUnitPrice;
	}
	public void setaUnitPrice(long aUnitPrice) {
		this.aUnitPrice = aUnitPrice;
	}
	public long getaSkuQty() {
		return aSkuQty;
	}
	public void setaSkuQty(long aSkuQty) {
		this.aSkuQty = aSkuQty;
	}
	public long getaSalQty() {
		return aSalQty;
	}
	public void setaSalQty(long aSalQty) {
		this.aSalQty = aSalQty;
	}
	public long getaAvgSalQty() {
		return aAvgSalQty;
	}
	public void setaAvgSalQty(long aAvgSalQty) {
		this.aAvgSalQty = aAvgSalQty;
	}
	public long getaAvgUnitPrice() {
		return aAvgUnitPrice;
	}
	public void setaAvgUnitPrice(long aAvgUnitPrice) {
		this.aAvgUnitPrice = aAvgUnitPrice;
	}
	private long aAvgSalQty;
	private long aAvgUnitPrice;
	
	private long mmSellAmt;
	private long mmDiscntAmt;
	private long mmSettleAmt;
	private long mmbrAmtRate;
	
	
	private long purMbrCnt; 
	
	public long getMmSellAmt() {
		return mmSellAmt;
	}
	public void setMmSellAmt(long mmSellAmt) {
		this.mmSellAmt = mmSellAmt;
	}
	public long getMmDiscntAmt() {
		return mmDiscntAmt;
	}
	public void setMmDiscntAmt(long mmDiscntAmt) {
		this.mmDiscntAmt = mmDiscntAmt;
	}
	public long getMmSettleAmt() {
		return mmSettleAmt;
	}
	public void setMmSettleAmt(long mmSettleAmt) {
		this.mmSettleAmt = mmSettleAmt;
	}
	public long getMmbrAmtRate() {
		return mmbrAmtRate;
	}
	public void setMmbrAmtRate(long mmbrAmtRate) {
		this.mmbrAmtRate = mmbrAmtRate;
	}
	public String getYyyymmdd() {
		return yyyymmdd;
	}
	public void setYyyymmdd(String yyyymmdd) {
		this.yyyymmdd = yyyymmdd;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public long getAllMbrCnt() {
		return allMbrCnt;
	}
	public void setAllMbrCnt(long allMbrCnt) {
		this.allMbrCnt = allMbrCnt;
	}
	public long getAllSalAmt() {
		return allSalAmt;
	}
	public void setAllSalAmt(long allSalAmt) {
		this.allSalAmt = allSalAmt;
	}
	public long getAllMbrAmt() {
		return allMbrAmt;
	}
	public void setAllMbrAmt(long allMbrAmt) {
		this.allMbrAmt = allMbrAmt;
	}
	public long getMbrAmtRate() {
		return mbrAmtRate;
	}
	public void setMbrAmtRate(long mbrAmtRate) {
		this.mbrAmtRate = mbrAmtRate;
	}
	public long getAllOrdCnt() {
		return allOrdCnt;
	}
	public void setAllOrdCnt(long allOrdCnt) {
		this.allOrdCnt = allOrdCnt;
	}
	public long getAllSellAmt() {
		return allSellAmt;
	}
	public void setAllSellAmt(long allSellAmt) {
		this.allSellAmt = allSellAmt;
	}
	public long getAllDiscntAmt() {
		return allDiscntAmt;
	}
	public void setAllDiscntAmt(long allDiscntAmt) {
		this.allDiscntAmt = allDiscntAmt;
	}
	public long getAllSettleAmt() {
		return allSettleAmt;
	}
	public void setAllSettleAmt(long allSettleAmt) {
		this.allSettleAmt = allSettleAmt;
	}
	public long getAllSkuQty() {
		return allSkuQty;
	}
	public void setAllSkuQty(long allSkuQty) {
		this.allSkuQty = allSkuQty;
	}
	public long getAllSalQty() {
		return allSalQty;
	}
	public void setAllSalQty(long allSalQty) {
		this.allSalQty = allSalQty;
	}
	public long getAllAvgSalQty() {
		return allAvgSalQty;
	}
	public void setAllAvgSalQty(long allAvgSalQty) {
		this.allAvgSalQty = allAvgSalQty;
	}
	public long getmOrdCnt() {
		return mOrdCnt;
	}
	public void setmOrdCnt(long mOrdCnt) {
		this.mOrdCnt = mOrdCnt;
	}
	public long getmSellAmt() {
		return mSellAmt;
	}
	public void setmSellAmt(long mSellAmt) {
		this.mSellAmt = mSellAmt;
	}
	public long getmDiscntAmt() {
		return mDiscntAmt;
	}
	public void setmDiscntAmt(long mDiscntAmt) {
		this.mDiscntAmt = mDiscntAmt;
	}
	public long getmSettleAmt() {
		return mSettleAmt;
	}
	public void setmSettleAmt(long mSettleAmt) {
		this.mSettleAmt = mSettleAmt;
	}
	public long getmAvgSettleAmt() {
		return mAvgSettleAmt;
	}
	public void setmAvgSettleAmt(long mAvgSettleAmt) {
		this.mAvgSettleAmt = mAvgSettleAmt;
	}
	public long getmSkuQty() {
		return mSkuQty;
	}
	public void setmSkuQty(long mSkuQty) {
		this.mSkuQty = mSkuQty;
	}
	public long getmSalQty() {
		return mSalQty;
	}
	public void setmSalQty(long mSalQty) {
		this.mSalQty = mSalQty;
	}
	public long getmAvgSalQty() {
		return mAvgSalQty;
	}
	public void setmAvgSalQty(long mAvgSalQty) {
		this.mAvgSalQty = mAvgSalQty;
	}
	public long getmAvgUnitPrice() {
		return mAvgUnitPrice;
	}
	public void setmAvgUnitPrice(long mAvgUnitPrice) {
		this.mAvgUnitPrice = mAvgUnitPrice;
	}
	public long getbOrdCnt() {
		return bOrdCnt;
	}
	public void setbOrdCnt(long bOrdCnt) {
		this.bOrdCnt = bOrdCnt;
	}
	public long getbSellAmt() {
		return bSellAmt;
	}
	public void setbSellAmt(long bSellAmt) {
		this.bSellAmt = bSellAmt;
	}
	public long getbDiscntAmt() {
		return bDiscntAmt;
	}
	public void setbDiscntAmt(long bDiscntAmt) {
		this.bDiscntAmt = bDiscntAmt;
	}
	public long getbSettleAmt() {
		return bSettleAmt;
	}
	public void setbSettleAmt(long bSettleAmt) {
		this.bSettleAmt = bSettleAmt;
	}
	public long getbAvgSettleAmt() {
		return bAvgSettleAmt;
	}
	public void setbAvgSettleAmt(long bAvgSettleAmt) {
		this.bAvgSettleAmt = bAvgSettleAmt;
	}
	public long getbSkuQty() {
		return bSkuQty;
	}
	public void setbSkuQty(long bSkuQty) {
		this.bSkuQty = bSkuQty;
	}
	public long getbSalQty() {
		return bSalQty;
	}
	public void setbSalQty(long bSalQty) {
		this.bSalQty = bSalQty;
	}
	public long getbAvgSalQty() {
		return bAvgSalQty;
	}
	public void setbAvgSalQty(long bAvgSalQty) {
		this.bAvgSalQty = bAvgSalQty;
	}
	public long getbAvgUnitPrice() {
		return bAvgUnitPrice;
	}
	public void setbAvgUnitPrice(long bAvgUnitPrice) {
		this.bAvgUnitPrice = bAvgUnitPrice;
	}
	public long getlMbrCnt() {
		return lMbrCnt;
	}
	public void setlMbrCnt(long lMbrCnt) {
		this.lMbrCnt = lMbrCnt;
	}
	public long getlOrdCnt() {
		return lOrdCnt;
	}
	public void setlOrdCnt(long lOrdCnt) {
		this.lOrdCnt = lOrdCnt;
	}
	public long getlSellAmt() {
		return lSellAmt;
	}
	public void setlSellAmt(long lSellAmt) {
		this.lSellAmt = lSellAmt;
	}
	public long getlDiscntAmt() {
		return lDiscntAmt;
	}
	public void setlDiscntAmt(long lDiscntAmt) {
		this.lDiscntAmt = lDiscntAmt;
	}
	public long getlSettleAmt() {
		return lSettleAmt;
	}
	public void setlSettleAmt(long lSettleAmt) {
		this.lSettleAmt = lSettleAmt;
	}
	public long getlAvgSettleAmt() {
		return lAvgSettleAmt;
	}
	public void setlAvgSettleAmt(long lAvgSettleAmt) {
		this.lAvgSettleAmt = lAvgSettleAmt;
	}
	public long getlUnitPrice() {
		return lUnitPrice;
	}
	public void setlUnitPrice(long lUnitPrice) {
		this.lUnitPrice = lUnitPrice;
	}
	public long getlSkuQty() {
		return lSkuQty;
	}
	public void setlSkuQty(long lSkuQty) {
		this.lSkuQty = lSkuQty;
	}
	public long getlSalQty() {
		return lSalQty;
	}
	public void setlSalQty(long lSalQty) {
		this.lSalQty = lSalQty;
	}
	public long getlAvgSalQty() {
		return lAvgSalQty;
	}
	public void setlAvgSalQty(long lAvgSalQty) {
		this.lAvgSalQty = lAvgSalQty;
	}
	public long getlAvgUnitPrice() {
		return lAvgUnitPrice;
	}
	public void setlAvgUnitPrice(long lAvgUnitPrice) {
		this.lAvgUnitPrice = lAvgUnitPrice;
	}
	public long getvMbrCnt() {
		return vMbrCnt;
	}
	public void setvMbrCnt(long vMbrCnt) {
		this.vMbrCnt = vMbrCnt;
	}
	public long getvOrdCnt() {
		return vOrdCnt;
	}
	public void setvOrdCnt(long vOrdCnt) {
		this.vOrdCnt = vOrdCnt;
	}
	public long getvSellAmt() {
		return vSellAmt;
	}
	public void setvSellAmt(long vSellAmt) {
		this.vSellAmt = vSellAmt;
	}
	public long getvDiscntAmt() {
		return vDiscntAmt;
	}
	public void setvDiscntAmt(long vDiscntAmt) {
		this.vDiscntAmt = vDiscntAmt;
	}
	public long getvSettleAmt() {
		return vSettleAmt;
	}
	public void setvSettleAmt(long vSettleAmt) {
		this.vSettleAmt = vSettleAmt;
	}
	public long getvAvgSettleAmt() {
		return vAvgSettleAmt;
	}
	public void setvAvgSettleAmt(long vAvgSettleAmt) {
		this.vAvgSettleAmt = vAvgSettleAmt;
	}
	public long getvUnitPrice() {
		return vUnitPrice;
	}
	public void setvUnitPrice(long vUnitPrice) {
		this.vUnitPrice = vUnitPrice;
	}
	public long getvSkuQty() {
		return vSkuQty;
	}
	public void setvSkuQty(long vSkuQty) {
		this.vSkuQty = vSkuQty;
	}
	public long getvSalQty() {
		return vSalQty;
	}
	public void setvSalQty(long vSalQty) {
		this.vSalQty = vSalQty;
	}
	public long getvAvgSalQty() {
		return vAvgSalQty;
	}
	public void setvAvgSalQty(long vAvgSalQty) {
		this.vAvgSalQty = vAvgSalQty;
	}
	public long getvAvgUnitPrice() {
		return vAvgUnitPrice;
	}
	public void setvAvgUnitPrice(long vAvgUnitPrice) {
		this.vAvgUnitPrice = vAvgUnitPrice;
	}
	public long getwMbrCnt() {
		return wMbrCnt;
	}
	public void setwMbrCnt(long wMbrCnt) {
		this.wMbrCnt = wMbrCnt;
	}
	public long getwOrdCnt() {
		return wOrdCnt;
	}
	public void setwOrdCnt(long wOrdCnt) {
		this.wOrdCnt = wOrdCnt;
	}
	public long getwSellAmt() {
		return wSellAmt;
	}
	public void setwSellAmt(long wSellAmt) {
		this.wSellAmt = wSellAmt;
	}
	public long getwDiscntAmt() {
		return wDiscntAmt;
	}
	public void setwDiscntAmt(long wDiscntAmt) {
		this.wDiscntAmt = wDiscntAmt;
	}
	public long getwSettleAmt() {
		return wSettleAmt;
	}
	public void setwSettleAmt(long wSettleAmt) {
		this.wSettleAmt = wSettleAmt;
	}
	public long getwAvgSettleAmt() {
		return wAvgSettleAmt;
	}
	public void setwAvgSettleAmt(long wAvgSettleAmt) {
		this.wAvgSettleAmt = wAvgSettleAmt;
	}
	public long getwUnitPrice() {
		return wUnitPrice;
	}
	public void setwUnitPrice(long wUnitPrice) {
		this.wUnitPrice = wUnitPrice;
	}
	public long getwSkuQty() {
		return wSkuQty;
	}
	public void setwSkuQty(long wSkuQty) {
		this.wSkuQty = wSkuQty;
	}
	public long getwSalQty() {
		return wSalQty;
	}
	public void setwSalQty(long wSalQty) {
		this.wSalQty = wSalQty;
	}
	public long getwAvgSalQty() {
		return wAvgSalQty;
	}
	public void setwAvgSalQty(long wAvgSalQty) {
		this.wAvgSalQty = wAvgSalQty;
	}
	public long getwAvgUnitPrice() {
		return wAvgUnitPrice;
	}
	public void setwAvgUnitPrice(long wAvgUnitPrice) {
		this.wAvgUnitPrice = wAvgUnitPrice;
	}
	public long getAllAvgSettleAmt() {
		return allAvgSettleAmt;
	}
	public void setAllAvgSettleAmt(long allAvgSettleAmt) {
		this.allAvgSettleAmt = allAvgSettleAmt;
	}
	public long getAllAvgUnitPrice() {
		return allAvgUnitPrice;
	}
	public void setAllAvgUnitPrice(long allAvgUnitPrice) {
		this.allAvgUnitPrice = allAvgUnitPrice;
	}
	public long getPurMbrCnt() {
		return purMbrCnt;
	}
	public void setPurMbrCnt(long purMbrCnt) {
		this.purMbrCnt = purMbrCnt;
	}
	public long getWebSellAmt() {
		return webSellAmt;
	}
	public void setWebSellAmt(long webSellAmt) {
		this.webSellAmt = webSellAmt;
	}
	public long getWebOrdCnt() {
		return webOrdCnt;
	}
	public void setWebOrdCnt(long webOrdCnt) {
		this.webOrdCnt = webOrdCnt;
	}
	public String getmUnitPrice() {
		return mUnitPrice;
	}
	public void setmUnitPrice(String mUnitPrice) {
		this.mUnitPrice = mUnitPrice;
	}
	
	

}
