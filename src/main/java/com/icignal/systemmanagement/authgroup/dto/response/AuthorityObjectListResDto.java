package com.icignal.systemmanagement.authgroup.dto.response;

import java.io.Serializable;

public class AuthorityObjectListResDto  implements Serializable {
	
	private static final long serialVersionUID = 7077013092586721807L;
	
	private String id;			//ui 오브젝트 아이디
	private String objTypeCd;	//오브젝트 유형 코드
	private String objTypeNm;	//오브젝트 유형명
	private String uiObjNm;		//ui오브젝트명
	private String uiObjDesc;	//ui오브젝트 설명
	private String objId;		//오브젝트 아이디
	private String objCd;		//오브젝트 코드
	private String objNm;		//오브젝트명
	private String objDesc;		//오브젝트 설명
	private String progId;		//프로그램 아이디
	private String progNum;		//프로그램 번호
	private String progName;	//프로그래명
	private String progTypeCd;	//프로그램 유형 코드
	private String progPath;	//프로그램 path
	private String applyType;	//유형
	private String uiViewCd;	//화면표시코드
	private String uiViewNm;	//화면표시명

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getObjTypeCd() {
		return objTypeCd;
	}

	public void setObjTypeCd(String objTypeCd) {
		this.objTypeCd = objTypeCd;
	}

	public String getObjTypeNm() {
		return objTypeNm;
	}

	public void setObjTypeNm(String objTypeNm) {
		this.objTypeNm = objTypeNm;
	}

	public String getUiObjNm() {
		return uiObjNm;
	}

	public void setUiObjNm(String uiObjNm) {
		this.uiObjNm = uiObjNm;
	}

	public String getUiObjDesc() {
		return uiObjDesc;
	}

	public void setUiObjDesc(String uiObjDesc) {
		this.uiObjDesc = uiObjDesc;
	}

	public String getObjId() {
		return objId;
	}

	public void setObjId(String objId) {
		this.objId = objId;
	}

	public String getObjCd() {
		return objCd;
	}

	public void setObjCd(String objCd) {
		this.objCd = objCd;
	}

	public String getObjNm() {
		return objNm;
	}

	public void setObjNm(String objNm) {
		this.objNm = objNm;
	}

	public String getObjDesc() {
		return objDesc;
	}

	public void setObjDesc(String objDesc) {
		this.objDesc = objDesc;
	}

	public String getProgId() {
		return progId;
	}

	public void setProgId(String progId) {
		this.progId = progId;
	}

	public String getProgNum() {
		return progNum;
	}

	public void setProgNum(String progNum) {
		this.progNum = progNum;
	}

	public String getProgName() {
		return progName;
	}

	public void setProgName(String progName) {
		this.progName = progName;
	}

	public String getProgTypeCd() {
		return progTypeCd;
	}

	public void setProgTypeCd(String progTypeCd) {
		this.progTypeCd = progTypeCd;
	}

	public String getProgPath() {
		return progPath;
	}

	public void setProgPath(String progPath) {
		this.progPath = progPath;
	}

	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	public String getUiViewCd() {
		return uiViewCd;
	}

	public void setUiViewCd(String uiViewCd) {
		this.uiViewCd = uiViewCd;
	}

	public String getUiViewNm() {
		return uiViewNm;
	}

	public void setUiViewNm(String uiViewNm) {
		this.uiViewNm = uiViewNm;
	}

	
	
	

}
