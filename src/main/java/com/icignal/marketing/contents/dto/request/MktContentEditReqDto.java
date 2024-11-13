package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : MKTContentResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 개인화 속성 조회
 */
public class MktContentEditReqDto extends MKTBaseReqDto{
	private String id;                 //id
	private String memId;			   //생성, 수정자 아이디
	private String contentsName;	   //콘텐츠 이름
	private String title;			   //제목
	private String txtMsgObject;	   //
	private String contents;
	private String html;
	private String description;
	private String textByteSize;
	private String contentsType;
	private String imgSize;
	private String imgCnt;
	private String imgId;
	private String barId;
	private String merId;
	private String bottom;
	private String extrlImgUrl;

	public String getExtrlImgUrl() {
        return extrlImgUrl;
    }
    public void setExtrlImgUrl(String extrlImgUrl) {
        this.extrlImgUrl = extrlImgUrl;
    }
    public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getContentsName() {
		return contentsName;
	}
	public void setContentsName(String contentsName) {
		this.contentsName = contentsName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTxtMsgObject() {
		return txtMsgObject;
	}
	public void setTxtMsgObject(String txtMsgObject) {
		this.txtMsgObject = txtMsgObject;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getHtml() {
		return html;
	}
	public void setHtml(String html) {
		this.html = html;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getTextByteSize() {
		return textByteSize;
	}
	public void setTextByteSize(String textByteSize) {
		this.textByteSize = textByteSize;
	}
	public String getContentsType() {
		return contentsType;
	}
	public void setContentsType(String contentsType) {
		this.contentsType = contentsType;
	}
	public String getImgSize() {
		return imgSize;
	}
	public void setImgSize(String imgSize) {
		this.imgSize = imgSize;
	}
	public String getImgCnt() {
		return imgCnt;
	}
	public void setImgCnt(String imgCnt) {
		this.imgCnt = imgCnt;
	}
	public String getImgId() {
		return imgId;
	}
	public void setImgId(String imgId) {
		this.imgId = imgId;
	}
	public String getBarId() {
		return barId;
	}
	public void setBarId(String barId) {
		this.barId = barId;
	}
	public String getMerId() {
		return merId;
	}
	public void setMerId(String merId) {
		this.merId = merId;
	}
	public String getBottom() {
		return bottom;
	}
	public void setBottom(String bottom) {
		this.bottom = bottom;
	}



}
