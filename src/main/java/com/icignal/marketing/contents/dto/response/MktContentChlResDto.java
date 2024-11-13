package com.icignal.marketing.contents.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : MKTContentChlResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 콘텐츠 채널 정보 조회
 */
public class MktContentChlResDto extends GridPagingItemResDto{

	private String id;               //아이디
	private String type;             //유형
	private String mktChlId;         //캠페인채널 ID
	private String mktname;          //마케팅 명
	private String contentsType;     //콘텐츠 유형
	private String memId;            //접속 ID
	private String path;             //URL Path
	private String markName;         //마케팅 유형
	private String typeid;           //콘텐츠 ID
	private String typeCd;           //채널 명
	private String cost;             //채널 단가
	private String codeName;         //코드네임

	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getMktChlId() {
		return mktChlId;
	}
	public void setMktChlId(String mktChlId) {
		this.mktChlId = mktChlId;
	}
	public String getContentsType() {
		return contentsType;
	}
	public void setContentsType(String contentsType) {
		this.contentsType = contentsType;
	}
	public String getMktname() {
		return mktname;
	}
	public void setMktname(String mktname) {
		this.mktname = mktname;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getMarkName() {
		return markName;
	}
	public void setMarkName(String markName) {
		this.markName = markName;
	}
	public String getTypeid() {
		return typeid;
	}
	public void setTypeid(String typeid) {
		this.typeid = typeid;
	}
	public String getTypeCd() {
		return typeCd;
	}
	public void setTypeCd(String typeCd) {
		this.typeCd = typeCd;
	}
	public String getCost() {
		return cost;
	}
	public void setCost(String cost) {
		this.cost = cost;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	

	
}
