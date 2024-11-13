package com.icignal.loyalty.promotion.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyOfferProductDtlReqDto extends CommonDataAuthReqDto {

    private String ridMktOfferMst;   // 오퍼 마스터 rid
    
    private String rid;
    
    private String ridProd;
    private String prodId;
    private String prodNm;
    
    private String posProdCnt;
    private String posProdCd;
    private String posBcodeNo;
    private String posChnlCd;			//POS공급업체코드
    private String posProdAmt;			//POS원가

    private String dataStatus;
    
    public String getDataStatus() {
        return dataStatus;
    }
    public void setDataStatus(String dataStatus) {
        this.dataStatus = dataStatus;
    }
    public String getRidMktOfferMst() {
        return ridMktOfferMst;
    }
    public void setRidMktOfferMst(String ridMktOfferMst) {
        this.ridMktOfferMst = ridMktOfferMst;
    }
    public String getRid() {
        return rid;
    }
    public void setRid(String rid) {
        this.rid = rid;
    }
    public String getRidProd() {
        return ridProd;
    }
    public void setRidProd(String ridProd) {
        this.ridProd = ridProd;
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
    public String getPosProdCnt() {
        return posProdCnt;
    }
    public void setPosProdCnt(String posProdCnt) {
        this.posProdCnt = posProdCnt;
    }
    public String getPosProdCd() {
        return posProdCd;
    }
    public void setPosProdCd(String posProdCd) {
        this.posProdCd = posProdCd;
    }
    public String getPosBcodeNo() {
        return posBcodeNo;
    }
    public void setPosBcodeNo(String posBcodeNo) {
        this.posBcodeNo = posBcodeNo;
    }
	public String getPosChnlCd() {
		return posChnlCd;
	}
	public void setPosChnlCd(String posChnlCd) {
		this.posChnlCd = posChnlCd;
	}
	public String getPosProdAmt() {
		return posProdAmt;
	}
	public void setPosProdAmt(String posProdAmt) {
		this.posProdAmt = posProdAmt;
	}
    
}
