/**
 *
 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
  * @fileName : LoyMbrRequestDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2016. 12. 28.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원 응답 DTO
  */
public class LoyMbrChangeHistListResDto  extends GridPagingItemResDto {

    private String rid;
    private String mbrRid;
    private String createDate;
    private String createBy;
    private String chgCol;
    private String bchngData;
    private String achngData;
    //@MarkName(groupCode="chgPstn", codeField="identiTypeCd")
    private String chgPstn;
    private String chgPstnCd;
    private String rmark;
    private String chgColNm;
    private String grpCode;
    private String codeName;
    private String rMark;
    private String modifyBy;
    private String modifyDate;
    
    
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getGrpCode() {
		return grpCode;
	}
	public void setGrpCode(String grpCode) {
		this.grpCode = grpCode;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getChgColNm() {
		return chgColNm;
	}
	public void setChgColNm(String chgColNm) {
		this.chgColNm = chgColNm;
	}
	public String getChgPstnCd() {
		return chgPstnCd;
	}
	public void setChgPstnCd(String chgPstnCd) {
		this.chgPstnCd = chgPstnCd;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMbrRid() {
		return mbrRid;
	}
	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
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
	public String getChgCol() {
		return chgCol;
	}
	public void setChgCol(String chgCol) {
		this.chgCol = chgCol;
	}
	public String getBchngData() {
		return bchngData;
	}
	public void setBchngData(String bchngData) {
		this.bchngData = bchngData;
	}
	public String getAchngData() {
		return achngData;
	}
	public void setAchngData(String achngData) {
		this.achngData = achngData;
	}
	public String getChgPstn() {
		return chgPstn;
	}
	public void setChgPstn(String chgPstn) {
		this.chgPstn = chgPstn;
	}
	public String getRmark() {
		return rmark;
	}
	public void setRmark(String rmark) {
		this.rmark = rmark;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getrMark() {
		return rMark;
	}
	public void setrMark(String rMark) {
		this.rMark = rMark;
	}
    






}
