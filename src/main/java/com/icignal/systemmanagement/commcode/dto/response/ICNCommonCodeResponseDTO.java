package com.icignal.systemmanagement.commcode.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;


/**
 * @name : ICNCommonCodeResponseDTO.java
 * @date : 2015. 9. 22.
 * @author : 류동균
 * @description : 공통코드
 */
@CommCode
public class ICNCommonCodeResponseDTO extends GridPagingItemResDto {
	
    private String codeId;
	private String codeName;
	private String markName;
	private String parCodeId;
	
	private String attrib01;
	private String attrib02;
	private String attrib03;
	private String attrib04;
	private String attrib05;
	
	private String schemaNm;
	private String tblEngNm;
	private String groupCode;
	private String groupName;
	@MarkName(groupCode = "COM_CATEGORY_TYPE_CD", codeField = "type")
	private String typeMarkNm;
	private String type;
	private String seq;
	private String markCode;
	
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getMarkCode() {
		return markCode;
	}
	public void setMarkCode(String markCode) {
		this.markCode = markCode;
	}
	public String getTypeMarkNm() {
		return typeMarkNm;
	}
	public void setTypeMarkNm(String typeMarkNm) {
		this.typeMarkNm = typeMarkNm;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getGroupCode() {
		return groupCode;
	}
	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getCodeId() {
		return codeId;
	}
	public void setCodeId(String codeId) {
		this.codeId = codeId;
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
	public String getSchemaNm() {
		return schemaNm;
	}
	public void setSchemaNm(String schemaNm) {
		this.schemaNm = schemaNm;
	}
	public String getTblEngNm() {
		return tblEngNm;
	}
	public void setTblEngNm(String tblEngNm) {
		this.tblEngNm = tblEngNm;
	}
	public String getParCodeId() {
		return parCodeId;
	}
	public void setParCodeId(String parCodeId) {
		this.parCodeId = parCodeId;
	}
}
