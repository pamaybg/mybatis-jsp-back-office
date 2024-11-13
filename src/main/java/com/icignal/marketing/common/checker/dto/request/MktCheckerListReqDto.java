package com.icignal.marketing.common.checker.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.marketing.common.checker.dto.response
 * @date : 2015. 11. 10.
 * @author : 류동균
 * @description : 
 */
public class MktCheckerListReqDto extends CommonDataAuthReqDto {
    
    private String tagetDtlId;    //대상자 상세 ID
    
    private String memberId;    //회원아이디
    
    private String exceptionYn;    //제외 여부
    
    private String duplicateDeleteYn;    //중복 삭제 여부
    
    private String permissionCheckDeleteYn;    //허가 점검 삭제 여부
    
    private String fatigueCheckDeleteYn;    //피로도 점검 삭제 여부
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getExceptionYn() {
        return exceptionYn;
    }

    public void setExceptionYn(String exceptionYn) {
        this.exceptionYn = exceptionYn;
    }

    public String getDuplicateDeleteYn() {
        return duplicateDeleteYn;
    }

    public void setDuplicateDeleteYn(String duplicateDeleteYn) {
        this.duplicateDeleteYn = duplicateDeleteYn;
    }

    public String getPermissionCheckDeleteYn() {
        return permissionCheckDeleteYn;
    }

    public void setPermissionCheckDeleteYn(String permissionCheckDeleteYn) {
        this.permissionCheckDeleteYn = permissionCheckDeleteYn;
    }

    public String getFatigueCheckDeleteYn() {
        return fatigueCheckDeleteYn;
    }

    public void setFatigueCheckDeleteYn(String fatigueCheckDeleteYn) {
        this.fatigueCheckDeleteYn = fatigueCheckDeleteYn;
    }

    public String getTagetDtlId() {
        return tagetDtlId;
    }

    public void setTagetDtlId(String tagetDtlId) {
        this.tagetDtlId = tagetDtlId;
    }    

 }
