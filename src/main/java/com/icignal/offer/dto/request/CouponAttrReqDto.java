package com.icignal.offer.dto.request;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class CouponAttrReqDto extends GridPagingItemResDto {
	

	private String rid;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;

	private String callApiUrl;
	private String callMethod;
	private String authKey;
	private String par1Name;
	private String par1ValType;
    @MarkName(groupCode = "LOY_CPN_API_PAR_TYPE", codeField = "par1ValType")
	private String par1ValTypeNm;
    
    private String par1Val;
    @MarkName(groupCode = "LOY_CPN_API_VAL_TYPE", codeField = "par1Val")
    private String par1ValNm;
	private String par2Name;
	private String par2ValType;
	@MarkName(groupCode = "LOY_CPN_API_PAR_TYPE", codeField = "par2ValType")
	private String par2ValTypeNm;

	private String par2Val;
	@MarkName(groupCode = "LOY_CPN_API_VAL_TYPE", codeField = "par2Val")
	private String par2ValNm;
	
	private String par3Name;
	private String par3ValType;
	@MarkName(groupCode = "LOY_CPN_API_PAR_TYPE", codeField = "par3ValType")
	private String par3ValTypeNm;
	private String par3Val;
	@MarkName(groupCode = "LOY_CPN_API_VAL_TYPE", codeField = "par3Val")
	private String par3ValNm;
	
	private String par4Name;
	private String par4ValType;
	@MarkName(groupCode = "LOY_CPN_API_PAR_TYPE", codeField = "par4ValType")
	private String par4ValTypeNm;
	private String par4Val;
	@MarkName(groupCode = "LOY_CPN_API_VAL_TYPE", codeField = "par4Val")	
	private String par4ValNm;
	
	private String par5Name;
	private String par5ValType;
	@MarkName(groupCode = "LOY_CPN_API_PAR_TYPE", codeField = "par5ValType")
	private String par5ValTypeNm;
	private String par5Val;
	@MarkName(groupCode = "LOY_CPN_API_VAL_TYPE", codeField = "par5Val")	
	private String par5ValNm;

	public String getPar3ValNm() {
		return par3ValNm;
	}
	public void setPar3ValNm(String par3ValNm) {
		this.par3ValNm = par3ValNm;
	}
	public String getPar4ValNm() {
		return par4ValNm;
	}
	public void setPar4ValNm(String par4ValNm) {
		this.par4ValNm = par4ValNm;
	}
	public String getPar5ValNm() {
		return par5ValNm;
	}
	public void setPar5ValNm(String par5ValNm) {
		this.par5ValNm = par5ValNm;
	}
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getCallApiUrl() {
		return callApiUrl;
	}
	public void setCallApiUrl(String callApiUrl) {
		this.callApiUrl = callApiUrl;
	}
	public String getCallMethod() {
		return callMethod;
	}
	public void setCallMethod(String callMethod) {
		this.callMethod = callMethod;
	}
	public String getAuthKey() {
		return authKey;
	}
	public void setAuthKey(String authKey) {
		this.authKey = authKey;
	}
	public String getPar1Name() {
		return par1Name;
	}
	public void setPar1Name(String par1Name) {
		this.par1Name = par1Name;
	}
	public String getPar1ValType() {
		return par1ValType;
	}
	public void setPar1ValType(String par1ValType) {
		this.par1ValType = par1ValType;
	}
	public String getPar1Val() {
		return par1Val;
	}
	public void setPar1Val(String par1Val) {
		this.par1Val = par1Val;
	}
	public String getPar2Name() {
		return par2Name;
	}
	public void setPar2Name(String par2Name) {
		this.par2Name = par2Name;
	}
	public String getPar2ValType() {
		return par2ValType;
	}
	public void setPar2ValType(String par2ValType) {
		this.par2ValType = par2ValType;
	}
	public String getPar2Val() {
		return par2Val;
	}
	public void setPar2Val(String par2Val) {
		this.par2Val = par2Val;
	}
	public String getPar3Name() {
		return par3Name;
	}
	public void setPar3Name(String par3Name) {
		this.par3Name = par3Name;
	}
	public String getPar3ValType() {
		return par3ValType;
	}
	public void setPar3ValType(String par3ValType) {
		this.par3ValType = par3ValType;
	}
	public String getPar3Val() {
		return par3Val;
	}
	public void setPar3Val(String par3Val) {
		this.par3Val = par3Val;
	}
	public String getPar4Name() {
		return par4Name;
	}
	public void setPar4Name(String par4Name) {
		this.par4Name = par4Name;
	}
	public String getPar4ValType() {
		return par4ValType;
	}
	public void setPar4ValType(String par4ValType) {
		this.par4ValType = par4ValType;
	}
	public String getPar4Val() {
		return par4Val;
	}
	public void setPar4Val(String par4Val) {
		this.par4Val = par4Val;
	}
	public String getPar5Name() {
		return par5Name;
	}
	public void setPar5Name(String par5Name) {
		this.par5Name = par5Name;
	}
	public String getPar5ValType() {
		return par5ValType;
	}
	public void setPar5ValType(String par5ValType) {
		this.par5ValType = par5ValType;
	}
	public String getPar5Val() {
		return par5Val;
	}
	public void setPar5Val(String par5Val) {
		this.par5Val = par5Val;
	}
	public String getPar1ValTypeNm() {
		return par1ValTypeNm;
	}
	public void setPar1ValTypeNm(String par1ValTypeNm) {
		this.par1ValTypeNm = par1ValTypeNm;
	}
	public String getPar1ValNm() {
		return par1ValNm;
	}
	public void setPar1ValNm(String par1ValNm) {
		this.par1ValNm = par1ValNm;
	}
	public String getPar2ValTypeNm() {
		return par2ValTypeNm;
	}
	public void setPar2ValTypeNm(String par2ValTypeNm) {
		this.par2ValTypeNm = par2ValTypeNm;
	}
	public String getPar2ValNm() {
		return par2ValNm;
	}
	public void setPar2ValNm(String par2ValNm) {
		this.par2ValNm = par2ValNm;
	}
	public String getPar3ValTypeNm() {
		return par3ValTypeNm;
	}
	public void setPar3ValTypeNm(String par3ValTypeNm) {
		this.par3ValTypeNm = par3ValTypeNm;
	}
	public String getPar4ValTypeNm() {
		return par4ValTypeNm;
	}
	public void setPar4ValTypeNm(String par4ValTypeNm) {
		this.par4ValTypeNm = par4ValTypeNm;
	}
	public String getPar5ValTypeNm() {
		return par5ValTypeNm;
	}
	public void setPar5ValTypeNm(String par5ValTypeNm) {
		this.par5ValTypeNm = par5ValTypeNm;
	}
	
	// 코드

     
}
