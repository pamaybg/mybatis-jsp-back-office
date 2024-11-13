package com.icignal.loyalty.benefit.point.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * @name : infavor.loyalty.trans.dto.response.LOYTransPromoListResponseDTO
 * @date : 2018. 1. 30.
 * @author : kimjunki
 * @description : 프로모션 항목 목록 조회
 */
@CommCode
public class LoyTransPromoListResDto extends GridPagingItemResDto {

    private String tabDispNo;
    private String camNm;
    private String offerNm;
    private String tabAcrlAmt;
    private String validEndDate;
    private String acrlDate;
    private String ofrNm;
    private String pntTxnType1Cd;
    private String pntTxnType1CdNm;
    private String pntTxnType2Cd;
    private String pntTxnType2CdNm;
    private String txnDate;
    private String createByNm;
    private String promYn;
    
    private String validDate;
    
	@MarkName(groupCode="PNT_TXN_TYPE", codeField="pntAccntBigTypeCdCd")
    private String pntAccntBigTypeCdNm;
    private String pntAccntBigTypeCdCd;
    
	@MarkName(groupCode="PNT_TXN_DTL_TYPE", codeField="pntAccntMidTypeCdCd")
    private String pntAccntMidTypeCdNm;
    private String pntAccntMidTypeCdCd;
    
	@MarkName(groupCode="DA_PNT_ACCNT_SML_TYPE", codeField="pntAccntSmlTypeCdCd")
    private String pntAccntSmlTypeCdNm;
    private String pntAccntSmlTypeCdCd;
    
	@MarkName(groupCode="DA_PNT_ACCNT_DETAIL_TYPE", codeField="pntAccntDetailTypeCdCd")
    private String pntAccntDetailTypeCdNm;
    private String pntAccntDetailTypeCdCd;
    private String acrlDesc;
    
    private String ofrNo;
    private String rdmAmt;
    private String mnsPntStatCd;	
	
	@MarkName(groupCode="MNS_PNT_STAT_CD", codeField="mnsPntStatCd")
	private String mnsPntStatNm;
	private String modifyBy;


    public String getModifyBy() {
        return modifyBy;
    }

    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }

    public String getOfrNo() {
		return ofrNo;
	}

	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}

	public String getRdmAmt() {
		return rdmAmt;
	}

	public void setRdmAmt(String rdmAmt) {
		this.rdmAmt = rdmAmt;
	}

	public String getOfrNm() {
		return ofrNm;
	}

	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}

	public String getAcrlDesc() {
		return acrlDesc;
	}

	public void setAcrlDesc(String acrlDesc) {
		this.acrlDesc = acrlDesc;
	}

	public String getPromYn() {
        return promYn;
    }

    public void setPromYn(String promYn) {
        this.promYn = promYn;
    }

    public String getPntTxnType1Cd() {
        return pntTxnType1Cd;
    }

    public void setPntTxnType1Cd(String pntTxnType1Cd) {
        this.pntTxnType1Cd = pntTxnType1Cd;
    }

    public String getPntTxnType1CdNm() {
        return pntTxnType1CdNm;
    }

    public void setPntTxnType1CdNm(String pntTxnType1CdNm) {
        this.pntTxnType1CdNm = pntTxnType1CdNm;
    }

    public String getPntTxnType2Cd() {
        return pntTxnType2Cd;
    }

    public void setPntTxnType2Cd(String pntTxnType2Cd) {
        this.pntTxnType2Cd = pntTxnType2Cd;
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

	public String getPntAccntBigTypeCdCd() {
		return pntAccntBigTypeCdCd;
	}

	public void setPntAccntBigTypeCdCd(String pntAccntBigTypeCdCd) {
		this.pntAccntBigTypeCdCd = pntAccntBigTypeCdCd;
	}

	public String getPntAccntMidTypeCdCd() {
		return pntAccntMidTypeCdCd;
	}

	public void setPntAccntMidTypeCdCd(String pntAccntMidTypeCdCd) {
		this.pntAccntMidTypeCdCd = pntAccntMidTypeCdCd;
	}

	public String getPntAccntSmlTypeCdCd() {
		return pntAccntSmlTypeCdCd;
	}

	public void setPntAccntSmlTypeCdCd(String pntAccntSmlTypeCdCd) {
		this.pntAccntSmlTypeCdCd = pntAccntSmlTypeCdCd;
	}

	public String getPntAccntDetailTypeCdCd() {
		return pntAccntDetailTypeCdCd;
	}

	public void setPntAccntDetailTypeCdCd(String pntAccntDetailTypeCdCd) {
		this.pntAccntDetailTypeCdCd = pntAccntDetailTypeCdCd;
	}

	public String getMnsPntStatCd() {
		return mnsPntStatCd;
	}

	public void setMnsPntStatCd(String mnsPntStatCd) {
		this.mnsPntStatCd = mnsPntStatCd;
	}

	public String getMnsPntStatNm() {
		return mnsPntStatNm;
	}

	public void setMnsPntStatNm(String mnsPntStatNm) {
		this.mnsPntStatNm = mnsPntStatNm;
	}
	
}
