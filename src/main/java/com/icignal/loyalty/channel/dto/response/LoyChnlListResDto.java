package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyChnlListResDto
 * 2. 파일명	: LoyChnlListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: 이성원
 * 5. 작성일자	: 2017. 10. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@CommCode
public class LoyChnlListResDto extends GridPagingItemResDto {

    private String rid;
    private String ouTypeCd;
    private String chnlNo;
    private String chnlNm;
    private String mbrbsCdadd;
    private String stnMgmtDiv;
    private String stnDiv;
    private String stnPoint_OprtYn;
    private String stnTkcgr;
    private String parMbrbsYn;
    private String parChnlNo;
    private String parChnlNm;
    private String adjRuleCd;
    private String adjRuleDesc;
    private String acrlRuleCd;
    private String acrlRuleDesc;
    private String pointContType;
    private String mbrbsStatusCd;
    private String trmnYn;
    private String acrlPsblYn;      // 포인트적립가능여부
    private String roadNmAdr;
    private String telNo;
    private String pgmNm;
    private String chnlTypeNm;
    private String topChnlNm;
    private String topChnlYn;

    private String isMapCoord;      // 위경도유무 Y/N
    
    @MarkName(groupCode="LOY_CHNL_TYPE_CD" , codeField="chnlTypeCd")
    private String chnlTypeCdNm;
    private String chnlTypeCd;      // 채널유형
  
    @MarkName(groupCode="LOY_CHNL_SUB_TYPE_CD" , codeField="chnlTypeSubCd")
    private String chnlTypeSubCdNm;
    private String chnlTypeSubCd;
  
    @MarkName(groupCode="LOY_CHNL_STAT_CD" , codeField="chnlStatCd")
    private String chnlStatCdNm;
    private String chnlStatCd;      // 상태 (A,I)
    
    @MarkName(groupCode="LOY_CHNL_ACT_TYPE_CD" , codeField="chnlActStatCd")
    private String chnlActStatCdNm; // 폐점여부 
    private String chnlActStatCd; 

    private String usePsblYn;       // 포인트사용가능여부
    private String mbrJoinPsblYn;   // 회원가입가능여부
    private String createDate;
    private String ctg;             // 유통구분


    private	String chnlNamestickerYn;    // 네임스티커 유무
    private	String chnlPhotocardYn;	     // 포토교통카드 유무
    private	String chnlPtstkYn;	         // 포토스티커 유무
    private String chnlParkingYn;		// 주차 가능 유무

    public String getCtg() {
        return ctg;
    }

    public void setCtg(String ctg) {
        this.ctg = ctg;
    }

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getChnlTypeSubCd() {
        return chnlTypeSubCd;
    }

    public void setChnlTypeSubCd(String chnlTypeSubCd) {
        this.chnlTypeSubCd = chnlTypeSubCd;
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

    public String getMbrbsCdadd() {
        return mbrbsCdadd;
    }

    public void setMbrbsCdadd(String mbrbsCdadd) {
        this.mbrbsCdadd = mbrbsCdadd;
    }

    public String getStnMgmtDiv() {
        return stnMgmtDiv;
    }

    public void setStnMgmtDiv(String stnMgmtDiv) {
        this.stnMgmtDiv = stnMgmtDiv;
    }

    public String getStnDiv() {
        return stnDiv;
    }

    public void setStnDiv(String stnDiv) {
        this.stnDiv = stnDiv;
    }

    public String getStnPoint_OprtYn() {
        return stnPoint_OprtYn;
    }

    public void setStnPoint_OprtYn(String stnPoint_OprtYn) {
        this.stnPoint_OprtYn = stnPoint_OprtYn;
    }

    public String getStnTkcgr() {
        return stnTkcgr;
    }

    public void setStnTkcgr(String stnTkcgr) {
        this.stnTkcgr = stnTkcgr;
    }

    public String getParMbrbsYn() {
        return parMbrbsYn;
    }

    public void setParMbrbsYn(String parMbrbsYn) {
        this.parMbrbsYn = parMbrbsYn;
    }

    public String getParChnlNo() {
        return parChnlNo;
    }

    public void setParChnlNo(String parChnlNo) {
        this.parChnlNo = parChnlNo;
    }

    public String getParChnlNm() {
        return parChnlNm;
    }

    public void setParChnlNm(String parChnlNm) {
        this.parChnlNm = parChnlNm;
    }

    public String getAdjRuleCd() {
        return adjRuleCd;
    }

    public void setAdjRuleCd(String adjRuleCd) {
        this.adjRuleCd = adjRuleCd;
    }

    public String getAdjRuleDesc() {
        return adjRuleDesc;
    }

    public void setAdjRuleDesc(String adjRuleDesc) {
        this.adjRuleDesc = adjRuleDesc;
    }

    public String getAcrlRuleCd() {
        return acrlRuleCd;
    }

    public void setAcrlRuleCd(String acrlRuleCd) {
        this.acrlRuleCd = acrlRuleCd;
    }

    public String getAcrlRuleDesc() {
        return acrlRuleDesc;
    }

    public void setAcrlRuleDesc(String acrlRuleDesc) {
        this.acrlRuleDesc = acrlRuleDesc;
    }

    public String getPointContType() {
        return pointContType;
    }

    public void setPointContType(String pointContType) {
        this.pointContType = pointContType;
    }

    public String getMbrbsStatusCd() {
        return mbrbsStatusCd;
    }

    public void setMbrbsStatusCd(String mbrbsStatusCd) {
        this.mbrbsStatusCd = mbrbsStatusCd;
    }

    public String getTrmnYn() {
        return trmnYn;
    }

    public void setTmnYn(String trmnYn) {
        this.trmnYn = trmnYn;
    }

    public String getAcrlPsblYn() {
        return acrlPsblYn;
    }

    public void setAcrlPsblYn(String acrlPsblYn) {
        this.acrlPsblYn = acrlPsblYn;
    }

    public String getOuTypeCd() {
        return ouTypeCd;
    }

    public void setOuTypeCd(String ouTypeCd) {
        this.ouTypeCd = ouTypeCd;
    }

    /**
     * @return the roadNmAdr
     */
    public String getRoadNmAdr() {
        return roadNmAdr;
    }

    /**
     * @param roadNmAdr
     *            the roadNmAdr to set
     */
    public void setRoadNmAdr(String roadNmAdr) {
        this.roadNmAdr = roadNmAdr;
    }

    /**
     * @return the telNo
     */
    public String getTelNo() {
        return telNo;
    }

    /**
     * @param telNo
     *            the telNo to set
     */
    public void setTelNo(String telNo) {
        this.telNo = telNo;
    }

    public String getIsMapCoord() {
        return isMapCoord;
    }

    public void setIsMapCoord(String isMapCoord) {
        this.isMapCoord = isMapCoord;
    }

    public void setTrmnYn(String trmnYn) {
        this.trmnYn = trmnYn;
    }

    public String getChnlTypeCdNm() {
        return chnlTypeCdNm;
    }

    public void setChnlTypeCdNm(String chnlTypeCdNm) {
        this.chnlTypeCdNm = chnlTypeCdNm;
    }

    public String getChnlTypeSubCdNm() {
        return chnlTypeSubCdNm;
    }

    public void setChnlTypeSubCdNm(String chnlTypeSubCdNm) {
        this.chnlTypeSubCdNm = chnlTypeSubCdNm;
    }

    public String getChnlStatCdNm() {
        return chnlStatCdNm;
    }

    public void setChnlStatCdNm(String chnlStatCdNm) {
        this.chnlStatCdNm = chnlStatCdNm;
    }

    public String getChnlActStatCdNm() {
        return chnlActStatCdNm;
    }

    public void setChnlActStatCdNm(String chnlActStatCdNm) {
        this.chnlActStatCdNm = chnlActStatCdNm;
    }

    public String getChnlTypeCd() {
        return chnlTypeCd;
    }

    public void setChnlTypeCd(String chnlTypeCd) {
        this.chnlTypeCd = chnlTypeCd;
    }

    public String getChnlStatCd() {
        return chnlStatCd;
    }

    public void setChnlStatCd(String chnlStatCd) {
        this.chnlStatCd = chnlStatCd;
    }

    public String getUsePsblYn() {
        return usePsblYn;
    }

    public void setUsePsblYn(String usePsblYn) {
        this.usePsblYn = usePsblYn;
    }

    public String getMbrJoinPsblYn() {
        return mbrJoinPsblYn;
    }

    public void setMbrJoinPsblYn(String mbrJoinPsblYn) {
        this.mbrJoinPsblYn = mbrJoinPsblYn;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

	public String getChnlNamestickerYn() {
		return chnlNamestickerYn;
	}

	public void setChnlNamestickerYn(String chnlNamestickerYn) {
		this.chnlNamestickerYn = chnlNamestickerYn;
	}

	public String getChnlPhotocardYn() {
		return chnlPhotocardYn;
	}

	public void setChnlPhotocardYn(String chnlPhotocardYn) {
		this.chnlPhotocardYn = chnlPhotocardYn;
	}

	public String getChnlPtstkYn() {
		return chnlPtstkYn;
	}

	public void setChnlPtstkYn(String chnlPtstkYn) {
		this.chnlPtstkYn = chnlPtstkYn;
	}

	public String getChnlParkingYn() {
		return chnlParkingYn;
	}

	public void setChnlParkingYn(String chnlParkingYn) {
		this.chnlParkingYn = chnlParkingYn;
	}

	public String getPgmNm() {
		return pgmNm;
	}

	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}

	public String getChnlTypeNm() {
		return chnlTypeNm;
	}

	public void setChnlTypeNm(String chnlTypeNm) {
		this.chnlTypeNm = chnlTypeNm;
	}

	public String getTopChnlNm() {
		return topChnlNm;
	}

	public void setTopChnlNm(String topChnlNm) {
		this.topChnlNm = topChnlNm;
	}

	public String getTopChnlYn() {
		return topChnlYn;
	}

	public void setTopChnlYn(String topChnlYn) {
		this.topChnlYn = topChnlYn;
	}

	public String getChnlActStatCd() {
		return chnlActStatCd;
	}

	public void setChnlActStatCd(String chnlActStatCd) {
		this.chnlActStatCd = chnlActStatCd;
	}


}
