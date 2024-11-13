package com.icignal.kepler.targetGroup.targetGroup.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.targetGroup.dto.request
 * @date : 2016. 7. 21.
 * @author : 류동균
 * @description : 타겟그룹 아이템 목록 RequestDTO
 */
public class KprTargetGroupItemListReqDto extends CommonDataAuthReqDto {

    private String targetGroupId;       //타겟그룹 아이디

    private Boolean excelFlag = false;
    
    private String memId;
    
    
    public String getTargetGroupId() {
        return targetGroupId;
    }

    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }

	public Boolean getExcelFlag() {
		return excelFlag;
	}

	public void setExcelFlag(Boolean excelFlag) {
		this.excelFlag = excelFlag;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}
}
