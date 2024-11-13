package com.icignal.kepler.targetGroup.targetSql.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class KprTargetSqlDetailReqDto extends CommonDataAuthReqDto {

    private String targetGroupId;
    private int cnt;
    private String cafe24Yn;
    
    
    public String getTargetGroupId() {
        return targetGroupId;
    }

    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getCafe24Yn() {
		return cafe24Yn;
	}

	public void setCafe24Yn(String cafe24Yn) {
		this.cafe24Yn = cafe24Yn;
	}

}
