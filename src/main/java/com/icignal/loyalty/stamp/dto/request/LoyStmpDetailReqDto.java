package com.icignal.loyalty.stamp.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.common.base.dto.request.MultiUploadReqDto;


/**
* @name : infavor.loyalty.stamp.dto.request.LOYStmpDetailRequestDTO
* @date : 2019. 3. 5.
* @author : hy.jun
* @description :
*/
public class LoyStmpDetailReqDto extends MKTBaseReqDto {
	private String rid;
	private String stmpNo;
	private String stmpNm;
	private String stmpStartDt;
	private String stmpEndDt;
	private int stmpCnt;
	private String comment1;
	private String comment2;
	private String comment3;
	private String applyChnlCd;
	private int purCntMinAmt;
	private String stmpStatus;
	private String regDt;
	private String calcTypeCd;
	private String calcTypeSubCd;
	private String mbrTgtYn;
	private String mbrNonTgtYn;
	private String stmpAreaCode;
	
	//스탬프 관련 이미지
	private List<MultiUploadReqDto> bgImg;
	private List<MultiUploadReqDto> boardImg;
	private List<MultiUploadReqDto> stmpImg1;
	private List<MultiUploadReqDto> stmpImg2;
	private List<MultiUploadReqDto> stmpImg3;
	private List<MultiUploadReqDto> stmpImg4;
	private List<MultiUploadReqDto> stmpImg1Sect;
	private List<MultiUploadReqDto> stmpImg2Sect;
	private List<MultiUploadReqDto> stmpImg3Sect;
	private List<MultiUploadReqDto> stmpImg4Sect;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getStmpNo() {
		return stmpNo;
	}
	public void setStmpNo(String stmpNo) {
		this.stmpNo = stmpNo;
	}
	public String getStmpNm() {
		return stmpNm;
	}
	public void setStmpNm(String stmpNm) {
		this.stmpNm = stmpNm;
	}
	public String getStmpStartDt() {
		return stmpStartDt;
	}
	public void setStmpStartDt(String stmpStartDt) {
		this.stmpStartDt = stmpStartDt;
	}
	public String getStmpEndDt() {
		return stmpEndDt;
	}
	public void setStmpEndDt(String stmpEndDt) {
		this.stmpEndDt = stmpEndDt;
	}
	public int getStmpCnt() {
		return stmpCnt;
	}
	public void setStmpCnt(int stmpCnt) {
		this.stmpCnt = stmpCnt;
	}
	public String getComment1() {
		return comment1;
	}
	public void setComment1(String comment1) {
		this.comment1 = comment1;
	}
	public String getComment2() {
		return comment2;
	}
	public void setComment2(String comment2) {
		this.comment2 = comment2;
	}
	public String getApplyChnlCd() {
		return applyChnlCd;
	}
	public void setApplyChnlCd(String applyChnlCd) {
		this.applyChnlCd = applyChnlCd;
	}
	public int getPurCntMinAmt() {
		return purCntMinAmt;
	}
	public void setPurCntMinAmt(int purCntMinAmt) {
		this.purCntMinAmt = purCntMinAmt;
	}
	public String getStmpStatus() {
		return stmpStatus;
	}
	public void setStmpStatus(String stmpStatus) {
		this.stmpStatus = stmpStatus;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getCalcTypeCd() {
		return calcTypeCd;
	}
	public void setCalcTypeCd(String calcTypeCd) {
		this.calcTypeCd = calcTypeCd;
	}
	public String getCalcTypeSubCd() {
		return calcTypeSubCd;
	}
	public void setCalcTypeSubCd(String calcTypeSubCd) {
		this.calcTypeSubCd = calcTypeSubCd;
	}
	public String getComment3() {
		return comment3;
	}
	public void setComment3(String comment3) {
		this.comment3 = comment3;
	}
	public List<MultiUploadReqDto> getBgImg() {
		return bgImg;
	}
	public void setBgImg(List<MultiUploadReqDto> bgImg) {
		this.bgImg = bgImg;
	}
	public List<MultiUploadReqDto> getBoardImg() {
		return boardImg;
	}
	public void setBoardImg(List<MultiUploadReqDto> boardImg) {
		this.boardImg = boardImg;
	}
	public List<MultiUploadReqDto> getStmpImg1() {
		return stmpImg1;
	}
	public void setStmpImg1(List<MultiUploadReqDto> stmpImg1) {
		this.stmpImg1 = stmpImg1;
	}
	public List<MultiUploadReqDto> getStmpImg2() {
		return stmpImg2;
	}
	public void setStmpImg2(List<MultiUploadReqDto> stmpImg2) {
		this.stmpImg2 = stmpImg2;
	}
	public List<MultiUploadReqDto> getStmpImg3() {
		return stmpImg3;
	}
	public void setStmpImg3(List<MultiUploadReqDto> stmpImg3) {
		this.stmpImg3 = stmpImg3;
	}
	public List<MultiUploadReqDto> getStmpImg4() {
		return stmpImg4;
	}
	public void setStmpImg4(List<MultiUploadReqDto> stmpImg4) {
		this.stmpImg4 = stmpImg4;
	}
	public List<MultiUploadReqDto> getStmpImg1Sect() {
		return stmpImg1Sect;
	}
	public void setStmpImg1Sect(List<MultiUploadReqDto> stmpImg1Sect) {
		this.stmpImg1Sect = stmpImg1Sect;
	}
	public List<MultiUploadReqDto> getStmpImg2Sect() {
		return stmpImg2Sect;
	}
	public void setStmpImg2Sect(List<MultiUploadReqDto> stmpImg2Sect) {
		this.stmpImg2Sect = stmpImg2Sect;
	}
	public List<MultiUploadReqDto> getStmpImg3Sect() {
		return stmpImg3Sect;
	}
	public void setStmpImg3Sect(List<MultiUploadReqDto> stmpImg3Sect) {
		this.stmpImg3Sect = stmpImg3Sect;
	}
	public List<MultiUploadReqDto> getStmpImg4Sect() {
		return stmpImg4Sect;
	}
	public void setStmpImg4Sect(List<MultiUploadReqDto> stmpImg4Sect) {
		this.stmpImg4Sect = stmpImg4Sect;
	}
	public String getMbrTgtYn() {
		return mbrTgtYn;
	}
	public void setMbrTgtYn(String mbrTgtYn) {
		this.mbrTgtYn = mbrTgtYn;
	}
	public String getMbrNonTgtYn() {
		return mbrNonTgtYn;
	}
	public void setMbrNonTgtYn(String mbrNonTgtYn) {
		this.mbrNonTgtYn = mbrNonTgtYn;
	}
	public String getStmpAreaCode() {
		return stmpAreaCode;
	}
	public void setStmpAreaCode(String stmpAreaCode) {
		this.stmpAreaCode = stmpAreaCode;
	}
	
}
