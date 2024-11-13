package com.icignal.onlineapproval.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * 승인레포트 : 캠페인 기본정보 Response DTO
 * 
 * @name : infavor.marketing.elapproval.dto.response.MKTApprovalReportCampaignResponseDTO
 * @date : 2018. 2. 28.
 * @author : jh.kim
 * @description : 
 */

@CommCode
public class AprvReportCampaignResDto extends CommonDataAuthReqDto{

    private String camNm;
    private String camStartDd;     //시작일
    private String camEndDd;       //종료일
    private String camTypeCd;      //캠페인유형명
    
    @MarkName(groupCode = "MKT_CAM_TYPE_CD", codeField = "camTypeCd")
    private String camTypeNm;      //캠페인유형코드
    private String camDesc;        //내용
    private String camScopeTypeCd; //조직코드 
    
    @MarkName(groupCode = "CAM_SCOPE_TYPE_CD", codeField = "camScopeTypeCd")
    private String camScopeTypeNm; //조직명
    private String promYn;         //프로모션여부
    private String fatiExceptYn;   //피로도미적용여부
    private String ridIntactType;  //트리거이벤트유형RID
    private String intactType1Cd;
    
    @MarkName(groupCode = "LOY_INTACT_TYPE", codeField = "intactType1Cd")
    private String intactType1Nm;
    private String intactType2Cd;
    
    
    @MarkName(groupCode = "LOY_INTACT_DTL_TYPE", codeField = "intactType2Cd")
    private String intactType2Nm;
    private String targetChnl;     //대상채널
    private String prmsExceptYn;   //퍼미션 미적용
    private String camPlner;	   //등록자
    
    private String oldAprStatCode;   //승인상태
    @MarkName(groupCode = "EL_APPROVAL_STATUS_CD", codeField = "intactType2Cd")
    private String oldAprStatCd;   //승인상태
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
    public String getTargetChnl() {
        return targetChnl;
    }

    public void setTargetChnl(String targetChnl) {
        this.targetChnl = targetChnl;
    }

    public String getCamNm() {
        return camNm;
    }
    public void setCamNm(String camNm) {
        this.camNm = camNm;
    }
    public String getCamStartDd() {
        return camStartDd;
    }
    public void setCamStartDd(String camStartDd) {
        this.camStartDd = camStartDd;
    }
    public String getCamEndDd() {
        return camEndDd;
    }
    public void setCamEndDd(String camEndDd) {
        this.camEndDd = camEndDd;
    }
    public String getCamTypeCd() {
        return camTypeCd;
    }
    public void setCamTypeCd(String camTypeCd) {
        this.camTypeCd = camTypeCd;
    }
    public String getCamTypeNm() {
        return camTypeNm;
    }
    public void setCamTypeNm(String camTypeNm) {
        this.camTypeNm = camTypeNm;
    }
    public String getCamDesc() {
        return camDesc;
    }
    public void setCamDesc(String camDesc) {
        this.camDesc = camDesc;
    }
    public String getCamScopeTypeCd() {
        return camScopeTypeCd;
    }
    public void setCamScopeTypeCd(String camScopeTypeCd) {
        this.camScopeTypeCd = camScopeTypeCd;
    }
    public String getCamScopeTypeNm() {
        return camScopeTypeNm;
    }
    public void setCamScopeTypeNm(String camScopeTypeNm) {
        this.camScopeTypeNm = camScopeTypeNm;
    }
    public String getPromYn() {
        return promYn;
    }
    public void setPromYn(String promYn) {
        this.promYn = promYn;
    }
    public String getFatiExceptYn() {
        return fatiExceptYn;
    }
    public void setFatiExceptYn(String fatiExceptYn) {
        this.fatiExceptYn = fatiExceptYn;
    }
    public String getRidIntactType() {
        return ridIntactType;
    }
    public void setRidIntactType(String ridIntactType) {
        this.ridIntactType = ridIntactType;
    }
    public String getIntactType1Cd() {
        return intactType1Cd;
    }
    public void setIntactType1Cd(String intactType1Cd) {
        this.intactType1Cd = intactType1Cd;
    }
    public String getIntactType1Nm() {
        return intactType1Nm;
    }
    public void setIntactType1Nm(String intactType1Nm) {
        this.intactType1Nm = intactType1Nm;
    }
    public String getIntactType2Cd() {
        return intactType2Cd;
    }
    public void setIntactType2Cd(String intactType2Cd) {
        this.intactType2Cd = intactType2Cd;
    }
    public String getIntactType2Nm() {
        return intactType2Nm;
    }
    public void setIntactType2Nm(String intactType2Nm) {
        this.intactType2Nm = intactType2Nm;
    }

	public String getPrmsExceptYn() {
		return prmsExceptYn;
	}

	public void setPrmsExceptYn(String prmsExceptYn) {
		this.prmsExceptYn = prmsExceptYn;
	}

	public String getCamPlner() {
		return camPlner;
	}

	public void setCamPlner(String camPlner) {
		this.camPlner = camPlner;
	}

	public String getOldAprStatCd() {
		return oldAprStatCd;
	}

	public void setOldAprStatCd(String oldAprStatCd) {
		this.oldAprStatCd = oldAprStatCd;
	}

	public String getOldAprStatCode() {
		return oldAprStatCode;
	}

	public void setOldAprStatCode(String oldAprStatCode) {
		this.oldAprStatCode = oldAprStatCode;
	}
}
