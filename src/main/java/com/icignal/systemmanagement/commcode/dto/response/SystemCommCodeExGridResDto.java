package com.icignal.systemmanagement.commcode.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
@CommCode
public class SystemCommCodeExGridResDto extends GridPagingItemResDto {
	private String id;
	private String seq;
	private String codeName;
	private String markName;
	private String markCode;
	private String parCodeId;
	private String parCodeNm;
	private String lang;
	private String attrib01;
	private String attrib02;
	private String attrib03;
	private String attrib04;
	private String attrib05;
	private String createBy;
	private String modifyBy;
	private String createDate;
	private String modifyDate;
	private String groupName;
	private String groupCode;
	@MarkName(groupCode = "COM_CATEGORY_TYPE_CD", codeField = "type")
	private String typeMarkNm;
	private String type;
	
	private String parMarkNm; // 상위코드 표시명
	
	
	
	public String getParCodeNm() {
		return parCodeNm;
	}
	public void setParCodeNm(String parCodeNm) {
		this.parCodeNm = parCodeNm;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getMarkName() {
		return markName;
	}
	public void setMarkName(String markName) {
		this.markName = markName;
	}
	public String getMarkCode() {
		return markCode;
	}
	public void setMarkCode(String markCode) {
		this.markCode = markCode;
	}
	public String getParCodeId() {
		return parCodeId;
	}
	public void setParCodeId(String parCodeId) {
		this.parCodeId = parCodeId;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}

	public String getAttrib01() {
		return attrib01;
	}
	public void setAttrib01(String attrib01) {
		this.attrib01 = attrib01;
	}
	public String getAttrib02() {
		return attrib02;
	}
	public void setAttrib02(String attrib02) {
		this.attrib02 = attrib02;
	}
	public String getAttrib03() {
		return attrib03;
	}
	public void setAttrib03(String attrib03) {
		this.attrib03 = attrib03;
	}
	public String getAttrib04() {
		return attrib04;
	}
	public void setAttrib04(String attrib04) {
		this.attrib04 = attrib04;
	}
	public String getAttrib05() {
		return attrib05;
	}
	public void setAttrib05(String attrib05) {
		this.attrib05 = attrib05;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getGroupCode() {
		return groupCode;
	}
	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTypeMarkNm() {
		return typeMarkNm;
	}
	public void setTypeMarkNm(String typeMarkNm) {
		this.typeMarkNm = typeMarkNm;
	}

	public String getParMarkNm() {
		return parMarkNm;
	}
	public void setParMarkNm(String parMarkNm) {
		this.parMarkNm = parMarkNm;
	}
	
	
}
