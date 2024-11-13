package com.icignal.systemmanagement.storeReport.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class StoreReportHistoryReqDto extends CommonDataAuthReqDto {
    private String programNo;

    public String getProgramNo() {return programNo;}
    public void setProgramNo(String programNo) {this.programNo = programNo;}
}
