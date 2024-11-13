package com.icignal.onlineapproval.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * 승인레포트 : 쿠폰 정보 Response DTO
 * 
 * @name : infavor.marketing.elapproval.dto.response.MKTApprovalReportCoupnResponseDTO
 * @date : 2018. 2. 28.
 * @author : jh.kim
 * @description :
 */
public class AprvReportCoupnResDto {

    private String coupnNm;
    private String useStartDt;
    private String useEndDt;
    private String coupnDesc;
    private String coupnUseGdnc1;
    private String coupnUseGdnc2;
    private String coupnUseGdnc3;
    private String coupnUseGdnc4;
    private String coupnUseGdnc5;
    private String coupnUseGdnc6;
    private String coupnUseGdnc7;
    private String coupnUseGdnc8;
    private String coupnUseGdnc9;
    private String coupnUseGdnc10;

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
    public String getCoupnNm() {
        return coupnNm;
    }

    public void setCoupnNm(String coupnNm) {
        this.coupnNm = coupnNm;
    }

    public String getUseStartDt() {
        return useStartDt;
    }

    public void setUseStartDt(String useStartDt) {
        this.useStartDt = useStartDt;
    }

    public String getUseEndDt() {
        return useEndDt;
    }

    public void setUseEndDt(String useEndDt) {
        this.useEndDt = useEndDt;
    }

    public String getCoupnDesc() {
        return coupnDesc;
    }

    public void setCoupnDesc(String coupnDesc) {
        this.coupnDesc = coupnDesc;
    }

    public String getCoupnUseGdnc1() {
        return coupnUseGdnc1;
    }

    public void setCoupnUseGdnc1(String coupnUseGdnc1) {
        this.coupnUseGdnc1 = coupnUseGdnc1;
    }

    public String getCoupnUseGdnc2() {
        return coupnUseGdnc2;
    }

    public void setCoupnUseGdnc2(String coupnUseGdnc2) {
        this.coupnUseGdnc2 = coupnUseGdnc2;
    }

    public String getCoupnUseGdnc3() {
        return coupnUseGdnc3;
    }

    public void setCoupnUseGdnc3(String coupnUseGdnc3) {
        this.coupnUseGdnc3 = coupnUseGdnc3;
    }

    public String getCoupnUseGdnc4() {
        return coupnUseGdnc4;
    }

    public void setCoupnUseGdnc4(String coupnUseGdnc4) {
        this.coupnUseGdnc4 = coupnUseGdnc4;
    }

    public String getCoupnUseGdnc5() {
        return coupnUseGdnc5;
    }

    public void setCoupnUseGdnc5(String coupnUseGdnc5) {
        this.coupnUseGdnc5 = coupnUseGdnc5;
    }

    public String getCoupnUseGdnc6() {
        return coupnUseGdnc6;
    }

    public void setCoupnUseGdnc6(String coupnUseGdnc6) {
        this.coupnUseGdnc6 = coupnUseGdnc6;
    }

    public String getCoupnUseGdnc7() {
        return coupnUseGdnc7;
    }

    public void setCoupnUseGdnc7(String coupnUseGdnc7) {
        this.coupnUseGdnc7 = coupnUseGdnc7;
    }

    public String getCoupnUseGdnc8() {
        return coupnUseGdnc8;
    }

    public void setCoupnUseGdnc8(String coupnUseGdnc8) {
        this.coupnUseGdnc8 = coupnUseGdnc8;
    }

    public String getCoupnUseGdnc9() {
        return coupnUseGdnc9;
    }

    public void setCoupnUseGdnc9(String coupnUseGdnc9) {
        this.coupnUseGdnc9 = coupnUseGdnc9;
    }

    public String getCoupnUseGdnc10() {
        return coupnUseGdnc10;
    }

    public void setCoupnUseGdnc10(String coupnUseGdnc10) {
        this.coupnUseGdnc10 = coupnUseGdnc10;
    }

}
