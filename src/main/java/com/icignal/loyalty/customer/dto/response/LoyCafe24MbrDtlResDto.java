package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;


@PersonalData
@CommCode
public class LoyCafe24MbrDtlResDto extends GridPagingItemResDto{

	private String mall;
	
	
	@MarkName(groupCode = "CF24_MBR_MALL", codeField = "mall")
	private String mallNm;
	
	@Decrypted(masked = "none")
	private String name;
	@Decrypted(masked = "none")
	private String cellPh;
	@Decrypted(masked = "none")
	private String email;
	
	private String smsYn;
	private String emailYn;
	private String regDate;
	
	@Decrypted(masked = "none")
	private String userId;
	
	private String rid;
	
	
	public String getMallNm() {
		return mallNm;
	}
	public void setMallNm(String mallNm) {
		this.mallNm = mallNm;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCellPh() {
		return cellPh;
	}
	public void setCellPh(String cellPh) {
		this.cellPh = cellPh;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSmsYn() {
		return smsYn;
	}
	public void setSmsYn(String smsYn) {
		this.smsYn = smsYn;
	}
	public String getEmailYn() {
		return emailYn;
	}
	public void setEmailYn(String emailYn) {
		this.emailYn = emailYn;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMall() {
		return mall;
	}
	public void setMall(String mall) {
		this.mall = mall;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}

	
}
