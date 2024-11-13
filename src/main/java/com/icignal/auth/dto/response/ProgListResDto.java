package com.icignal.auth.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class ProgListResDto extends GridPagingItemResDto {

	private String progId;
	private String progName;
	private String progType;
	private String progPath;
	private String prog_crea;
	private String createDate;	
	private String progKey;
	private String pgmRid;		//권한관리 화면관리 프로그램 목록 programId
	private String menuId;
	private String authId;
	private String id;				//프로그램 관리 목록 progId
	
	
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
	public String getProgId() {
		return progId;
	}
	public void setProgId(String progId) {
		this.progId = progId;
	}
	public String getProgName() {
		return progName;
	}
	public void setProgName(String progName) {
		this.progName = progName;
	}
	public String getProgType() {
		return progType;
	}
	public void setProgType(String progType) {
		this.progType = progType;
	}
	public String getProgPath() {
		return progPath;
	}
	public void setProgPath(String progPath) {
		this.progPath = progPath;
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
}
