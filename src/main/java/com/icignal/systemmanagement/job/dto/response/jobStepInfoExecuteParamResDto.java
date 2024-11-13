package com.icignal.systemmanagement.job.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class jobStepInfoExecuteParamResDto extends GridPagingItemResDto {
    private String executRid;
    private String argsType;
    @MarkName(groupCode = "ARGS_TYPE", codeField = "argsType")
    private String argsTypeNm;
    private String argsSeq;
    private String argsNm;
    private String argsVal;

    public String getArgsTypeNm() {
        return argsTypeNm;
    }

    public void setArgsTypeNm(String argsTypeNm) {
        this.argsTypeNm = argsTypeNm;
    }

    public String getExecutRid() {
        return executRid;
    }

    public void setExecutRid(String executRid) {
        this.executRid = executRid;
    }

    public String getArgsType() {
        return argsType;
    }

    public void setArgsType(String argsType) {
        this.argsType = argsType;
    }

    public String getArgsSeq() {
        return argsSeq;
    }

    public void setArgsSeq(String argsSeq) {
        this.argsSeq = argsSeq;
    }

    public String getArgsNm() {
        return argsNm;
    }

    public void setArgsNm(String argsNm) {
        this.argsNm = argsNm;
    }

    public String getArgsVal() {
        return argsVal;
    }

    public void setArgsVal(String argsVal) {
        this.argsVal = argsVal;
    }
}