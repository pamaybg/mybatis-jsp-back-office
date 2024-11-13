package com.icignal.systemmanagement.program.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemProgListResDto extends GridPagingItemResDto {
	
	private String prog_crea;
	private String createDate;	
	private String progKey;
	private String pgmRid;		//권한관리 화면관리 프로그램 목록 programId
	private String menuId;
	private String authId;
	private String id;				//프로그램 관리 목록 progId
	private String menuChkYn;
	private String topPgmId;
	private String parPgmId;
	private String pgmNm;
	private String pgmNo;
	private String LEVEL;
	private String pgmPath;
	//신규
	@MarkName(groupCode = "ADMIN_PROG_TYPE", codeField = "pgmTypeCd")
	private String pgmType;
	private String pgmTypeCd;

	private String pgmTypeNm;
	private String progType;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getProgKey() {
		return progKey;
	}
	public void setProgKey(String progKey) {
		this.progKey = progKey;
	}
	public String getProg_crea() {
		return prog_crea;
	}
	public void setProg_crea(String prog_crea) {
		this.prog_crea = prog_crea;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getMenuChkYn() {
		return menuChkYn;
	}
	public void setMenuChkYn(String menuChkYn) {
		this.menuChkYn = menuChkYn;
	}
	public String getTopPgmId() {
		return topPgmId;
	}
	public void setTopPgmId(String topPgmId) {
		this.topPgmId = topPgmId;
	}
	public String getParPgmId() {
		return parPgmId;
	}
	public void setParPgmId(String parPgmId) {
		this.parPgmId = parPgmId;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getPgmNo() {
		return pgmNo;
	}
	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}
	public String getLEVEL() {
		return LEVEL;
	}
	public void setLEVEL(String lEVEL) {
		LEVEL = lEVEL;
	}
	public String getPgmPath() {
		return pgmPath;
	}
	public void setPgmPath(String pgmPath) {
		this.pgmPath = pgmPath;
	}
	public String getPgmType() {
		return pgmType;
	}
	public void setPgmType(String pgmType) {
		this.pgmType = pgmType;
	}
	public String getPgmTypeCd() {
		return pgmTypeCd;
	}
	public void setPgmTypeCd(String pgmTypeCd) {
		this.pgmTypeCd = pgmTypeCd;
	}

	public String getPgmTypeNm() {
		return pgmTypeNm;
	}

	public void setPgmTypeNm(String pgmTypeNm) {
		this.pgmTypeNm = pgmTypeNm;
	}

	public String getProgType() {
		return progType;
	}

	public void setProgType(String progType) {
		this.progType = progType;
	}
}
