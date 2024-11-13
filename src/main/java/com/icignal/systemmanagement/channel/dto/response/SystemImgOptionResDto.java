package com.icignal.systemmanagement.channel.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;


/**
 * @name : MKTChannelResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 채널 정보 조회
 */
public class SystemImgOptionResDto extends StatusResDto{
	private String id;     		  //아이디
	private String mktChnlId;     //마케팅 채널 ID
	private String seq;     	  //순번
	private String maxVol;     	  //최대용량
	private String imgResolH;     //이미지 사이즈 최대 높이
	private String imgResolW;     //이미지 사이즈 최대 넓이
	private String upldEtsionCd;  //업로드 유형코드
	private String upldType;      //업로드 파일 유형
	private String type;          //타입
	private String createBy;      //등록자
	private String mDate;         //등록일자
	
	private String name;
	private int height;
	private int width;
	private String accntId;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMktChnlId() {
		return mktChnlId;
	}
	public void setMktChnlId(String mktChnlId) {
		this.mktChnlId = mktChnlId;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getMaxVol() {
		return maxVol;
	}
	public void setMaxVol(String maxVol) {
		this.maxVol = maxVol;
	}
	public String getImgResolH() {
		return imgResolH;
	}
	public void setImgResolH(String imgResolH) {
		this.imgResolH = imgResolH;
	}
	public String getImgResolW() {
		return imgResolW;
	}
	public void setImgResolW(String imgResolW) {
		this.imgResolW = imgResolW;
	}
	public String getUpldEtsionCd() {
		return upldEtsionCd;
	}
	public void setUpldEtsionCd(String upldEtsionCd) {
		this.upldEtsionCd = upldEtsionCd;
	}
	public String getUpldType() {
		return upldType;
	}
	public void setUpldType(String upldType) {
		this.upldType = upldType;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getmDate() {
		return mDate;
	}
	public void setmDate(String mDate) {
		this.mDate = mDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public int getWidth() {
		return width;
	}
	public void setWidth(int width) {
		this.width = width;
	}
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	
}
