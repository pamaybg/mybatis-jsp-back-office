package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name infavor.loyalty.member.mbr.dto.request.LoyVocPntTxnRequestDTO
 * @date 2018. 10. 25.
 * @author jh.kim
 * @description VOC 포인트 등록
 */
public class LoyVocPntTxnReqDto extends MKTBaseReqDto {

    private String rid;
    private String ridMbr;
    private String mbrNo;
    private String pntAmt;
    private String pntTxnType_1Cd;
    private String pntTxnType_2Cd;
    private String type;

    private String ridMktCamMst;
    private String offerId;
    private String offerNo;
    private String offerType;
    private String chnlNo; //적립처

    private String vocDesc; //처리사유
    private String pgmRid;
    private String pgmNo;
    private String pntTxnType;
    private String pntTxnDtlType;
    


	public String getPntTxnType() {
		return pntTxnType;
	}

	public void setPntTxnType(String pntTxnType) {
		this.pntTxnType = pntTxnType;
	}

	

	public String getPntTxnDtlType() {
		return pntTxnDtlType;
	}

	public void setPntTxnDtlType(String pntTxnDtlType) {
		this.pntTxnDtlType = pntTxnDtlType;
	}

	public String getPgmNo() {
		return pgmNo;
	}

	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}

	public String getPgmRid() {
		return pgmRid;
	}

	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}

	public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getRidMbr() {
        return ridMbr;
    }

    public void setRidMbr(String ridMbr) {
        this.ridMbr = ridMbr;
    }

    public String getPntAmt() {
        return pntAmt;
    }

    public void setPntAmt(String pntAmt) {
        this.pntAmt = pntAmt;
    }

    public String getPntTxnType_1Cd() {
        return pntTxnType_1Cd;
    }

    public void setPntTxnType_1Cd(String pntTxnType_1Cd) {
        this.pntTxnType_1Cd = pntTxnType_1Cd;
    }

    public String getPntTxnType_2Cd() {
        return pntTxnType_2Cd;
    }

    public void setPntTxnType_2Cd(String pntTxnType_2Cd) {
        this.pntTxnType_2Cd = pntTxnType_2Cd;
    }

	public String getRidMktCamMst() {
		return ridMktCamMst;
	}

	public void setRidMktCamMst(String ridMktCamMst) {
		this.ridMktCamMst = ridMktCamMst;
	}

	public String getOfferId() {
		return offerId;
	}

	public void setOfferId(String offerId) {
		this.offerId = offerId;
	}

	public String getOfferNo() {
		return offerNo;
	}

	public void setOfferNo(String offerNo) {
		this.offerNo = offerNo;
	}

	public String getOfferType() {
		return offerType;
	}

	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}

	public String getChnlNo() {
		return chnlNo;
	}

	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}

	public String getVocDesc() {
		return vocDesc;
	}

	public void setVocDesc(String vocDesc) {
		this.vocDesc = vocDesc;
	}

	public String getMbrNo() {
		return mbrNo;
	}

	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}

}
