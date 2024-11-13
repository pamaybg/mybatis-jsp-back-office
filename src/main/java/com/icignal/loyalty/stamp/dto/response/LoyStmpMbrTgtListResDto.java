package com.icignal.loyalty.stamp.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
* @name : infavor.loyalty.stamp.dto.response.LOYStmpMbrTgtListResponseDTO
* @date : 2019. 4. 22.
* @author : hy.jun
* @description :
*/
@CommCode
@PersonalData
public class LoyStmpMbrTgtListResDto extends GridPagingItemResDto {
	
	private static final long serialVersionUID = 4200358617224588586L;
	
	@Decrypted(masked = "custNm")
	private String custNm;
	private String mbrNo;
	private String mbrStatCd;
	@MarkName(groupCode="LOY_MBR_STAT_CD", codeField="mbrStatCd")
	private String mbrStatCdNm;
	private String mbrLockYn;
	private String createDate;
	private String name; //생성자
	private String rid;
	
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getMbrStatCdNm() {
		return mbrStatCdNm;
	}
	public void setMbrStatCdNm(String mbrStatCdNm) {
		this.mbrStatCdNm = mbrStatCdNm;
	}
	public String getMbrLockYn() {
		return mbrLockYn;
	}
	public void setMbrLockYn(String mbrLockYn) {
		this.mbrLockYn = mbrLockYn;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
}
