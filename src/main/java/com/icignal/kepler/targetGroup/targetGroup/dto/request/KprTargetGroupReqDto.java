package com.icignal.kepler.targetGroup.targetGroup.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 타겟그룹 ResponseDTO
 */
public class KprTargetGroupReqDto extends CommonDataAuthReqDto {
	
    private String targetGroupId;       //타겟그룹 아이디
    private int cnt;
    private String ridCust;
    private String userId;

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

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

    public String getRidCust() {return ridCust;}

    public void setRidCust(String ridCust) {this.ridCust = ridCust;}

    @Override
    public String getUserId() {
        return userId;
    }

    @Override
    public void setUserId(String userId) {
        this.userId = userId;
    }
}
