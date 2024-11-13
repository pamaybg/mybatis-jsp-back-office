package com.icignal.marketing.contents.dto.request;


import com.icignal.common.base.dto.request.MKTGridPagingReqDto;



/**
 * @name : MKTContentChlRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 콘텐츠 채널 정보 조회
 */
public class MktContentChlReqDto extends MKTGridPagingReqDto {
	
	private String id;               //아이디
	private String type;             //유형
	private String mktChlId;         //캠페인채널 ID
	private String contentsType;     //콘텐츠 유형
	private String memId;            //접속 ID
	private String accntId;          //어카운트 Id

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
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	
	
}
