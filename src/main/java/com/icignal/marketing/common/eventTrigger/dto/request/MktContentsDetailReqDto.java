package com.icignal.marketing.common.eventTrigger.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : ICNContentsDetailRequestDTO.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : 콘텐츠 상세
 */
public class MktContentsDetailReqDto extends MKTBaseReqDto {

	private String id;               //아이디
	private String contentsName;     //콘텐츠명
	private String contentsType;     //콘텐츠 유형
	private String contentsChannel;  //콘텐츠 채널
	private String contentsFlag;     //콘텐츠 종류
	private String title;            //제목
	private String txtMsgObject;     //TEXT 메세지 목적
	private String contents;         //내용
	private String html;             //HTML
	private int textByteSize;        //콘텐츠 용량
	private int imgSize;             //이미지 용량
	private int imgCnt;              //이미지 적용 건수
	private String modifyBy;         //수정자
	private String modifyDate;       //수정일
	private String memId;            //접속 ID
	private String filepath;         //파일 경로
	private String imagepath;        //이미지 경로
	private String fileName;         //파일 이름
	private String path;             //이동 경로
	private String realfileName;     //실제 파일 명
	private String barpath;          //바코드 파일 경로
	private String merpath;          //머지 이미지 경로
	private String merId;			 //머지 아이디
	private String barId;			 //바코드 아이디
	private String imgId;		     //이미지 아이디
	private String chnlId;           //채널 시스템 ID
	private boolean campaignCehck;   //캠페인 체크
	private String contentsTypeCode; //컨텐츠 타입 유형 코드
	private String bottom;           //발신자 번호
	private String contsPushTypeCode;        //콘텐츠 PUSH 유형코드
    private String contsPushTypeName;        //콘텐츠 PUSH 유형명
    private String contsPushSubTypeCode;        //콘텐츠 PUSH 업무 유형코드
    private String contsPushSubTypeVal;        //콘텐츠 PUSH 업무 유형 값
   
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

	public String getContentsName() {
		return contentsName;
	}

	public void setContentsName(String contentsName) {
		this.contentsName = contentsName;
	}

	public String getContentsType() {
		return contentsType;
	}

	public void setContentsType(String contentsType) {
		this.contentsType = contentsType;
	}

	public String getContentsChannel() {
		return contentsChannel;
	}

	public void setContentsChannel(String contentsChannel) {
		this.contentsChannel = contentsChannel;
	}

	public String getContentsFlag() {
		return contentsFlag;
	}

	public void setContentsFlag(String contentsFlag) {
		this.contentsFlag = contentsFlag;
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

	public int getTextByteSize() {
		return textByteSize;
	}

	public void setTextByteSize(int textByteSize) {
		this.textByteSize = textByteSize;
	}

	public int getImgSize() {
		return imgSize;
	}

	public void setImgSize(int imgSize) {
		this.imgSize = imgSize;
	}

	public int getImgCnt() {
		return imgCnt;
	}

	public void setImgCnt(int imgCnt) {
		this.imgCnt = imgCnt;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	public String getImagepath() {
		return imagepath;
	}

	public void setImagepath(String imagepath) {
		this.imagepath = imagepath;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getRealfileName() {
		return realfileName;
	}

	public void setRealfileName(String realfileName) {
		this.realfileName = realfileName;
	}

	public String getBarpath() {
		return barpath;
	}

	public void setBarpath(String barpath) {
		this.barpath = barpath;
	}

	public String getMerpath() {
		return merpath;
	}

	public void setMerpath(String merpath) {
		this.merpath = merpath;
	}

	public String getMerId() {
		return merId;
	}

	public void setMerId(String merId) {
		this.merId = merId;
	}

	public String getBarId() {
		return barId;
	}

	public void setBarId(String barId) {
		this.barId = barId;
	}

	public String getImgId() {
		return imgId;
	}

	public void setImgId(String imgId) {
		this.imgId = imgId;
	}

	public String getChnlId() {
		return chnlId;
	}

	public void setChnlId(String chnlId) {
		this.chnlId = chnlId;
	}

	public boolean isCampaignCehck() {
		return campaignCehck;
	}

	public void setCampaignCehck(boolean campaignCehck) {
		this.campaignCehck = campaignCehck;
	}

	public String getContentsTypeCode() {
		return contentsTypeCode;
	}

	public void setContentsTypeCode(String contentsTypeCode) {
		this.contentsTypeCode = contentsTypeCode;
	}

	public String getBottom() {
		return bottom;
	}

	public void setBottom(String bottom) {
		this.bottom = bottom;
	}

	public String getContsPushTypeCode() {
		return contsPushTypeCode;
	}

	public void setContsPushTypeCode(String contsPushTypeCode) {
		this.contsPushTypeCode = contsPushTypeCode;
	}

	public String getContsPushTypeName() {
		return contsPushTypeName;
	}

	public void setContsPushTypeName(String contsPushTypeName) {
		this.contsPushTypeName = contsPushTypeName;
	}

	public String getContsPushSubTypeCode() {
		return contsPushSubTypeCode;
	}

	public void setContsPushSubTypeCode(String contsPushSubTypeCode) {
		this.contsPushSubTypeCode = contsPushSubTypeCode;
	}

	public String getContsPushSubTypeVal() {
		return contsPushSubTypeVal;
	}

	public void setContsPushSubTypeVal(String contsPushSubTypeVal) {
		this.contsPushSubTypeVal = contsPushSubTypeVal;
	}

}
