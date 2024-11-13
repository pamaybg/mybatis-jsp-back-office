package com.icignal.loyalty.membership.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : infavor.Loyalty.member.mbr.dto.request.LoyMbrPasswordRequestDTO
 * @date : 2017. 7. 18.
 * @author : jh.kim
 * @description : 로얄티 프로그램 회원 비밀번호 관리 Request DTO
 */
public class LoyMbrPasswordReqDto extends MKTBaseReqDto {

    private String rid;
    private String pntUsePw;
    private String mbrNo;
    private String rmark;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getPntUsePw() {
        return pntUsePw;
    }

    public void setPntUsePw(String pntUsePw) {
        this.pntUsePw = pntUsePw;
    }


    public String getMbrNo() {
		return mbrNo;
	}

	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}


	public String getRmark() {
		return rmark;
	}

	public void setRmark(String rmark) {
		this.rmark = rmark;
	}

	@Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

}
