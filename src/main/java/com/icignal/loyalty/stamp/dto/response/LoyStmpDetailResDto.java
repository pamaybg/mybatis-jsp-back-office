package com.icignal.loyalty.stamp.dto.response;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.response.MultiImage;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.ImageUtil;

/**
* @name : infavor.loyalty.stamp.dto.response.LOYStmpDetailResponseDTO
* @date : 2019. 3. 5.
* @author : hy.jun
* @description :
*/
public class LoyStmpDetailResDto extends StatusResDto {
	private String rid;
	private String stmpNo;
	private String stmpNm;
	private String stmpStartDt;
	private String stmpEndDt;
	private String stmpStartDtFullFmt;
	private String stmpEndDtFullFmt;
	private int stmpCnt;
	private String comment1;
	private String comment2;
	private String comment3;
	private String applyChnlCd;
	private String applyChnlCdNm;
	private int purCntMinAmt;
	private String stmpStatus;
	private String stmpStatusNm;
	private String regDt;
	private String calcTypeCd;
	private String calcTypeCdNm;
	private String calcTypeSubCd;
	private String calcTypeSubCdNm;
	private String mbrTgtYn;
	private String mbrNonTgtYn;
	private String stmpAreaCode;
	
	//스탬프 관련 이미지
	private String imageUrl;
	private MultiImage imageMUrl;
	private List<MultiImage> bgImg;
	private List<MultiImage> boardImg;
	private List<MultiImage> stmpImg1;
	private List<MultiImage> stmpImg2;
	private List<MultiImage> stmpImg3;
	private List<MultiImage> stmpImg4;
	private List<MultiImage> stmpImg1Sect;
	private List<MultiImage> stmpImg2Sect;
	private List<MultiImage> stmpImg3Sect;
	private List<MultiImage> stmpImg4Sect;
	private String oriName;
	
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
	public String getImageUrl() {
		if(this.imageUrl != null && this.imageUrl.length() > 0 && !this.imageUrl.contains(CommonUtil.getInstance().getImageServerUrl())){
			this.imageMUrl = new MultiImage();
			ImageUtil.setMultiImages(this.imageUrl, this.imageMUrl);
			this.imageUrl = CommonUtil.getInstance().getImageServerUrl() + "/" + this.imageUrl;
		}

		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public MultiImage getImageMUrl() {
		return imageMUrl;
	}
	public void setImageMUrl(MultiImage imageMUrl) {
		this.imageMUrl = imageMUrl;
	}
	public List<MultiImage> getBgImg() {
		if(this.bgImg == null) {
            this.bgImg = new ArrayList<>();
        } else {
            for (MultiImage multiImage : bgImg) {
                ImageUtil.setMultiImages(multiImage.getImgOrgUrl(), multiImage);
            }
        }
        return bgImg;
	}
	public void setBgImg(List<MultiImage> bgImg) {
		this.bgImg = bgImg;
	}
	public List<MultiImage> getBoardImg() {
		if(this.boardImg == null) {
            this.boardImg = new ArrayList<>();
        } else {
            for (MultiImage multiImage : boardImg) {
                ImageUtil.setMultiImages(multiImage.getImgOrgUrl(), multiImage);
            }
        }
        return boardImg;
	}
	public void setBoardImg(List<MultiImage> boardImg) {
		this.boardImg = boardImg;
	}
	public List<MultiImage> getStmpImg1() {
		if(this.stmpImg1 == null) {
            this.stmpImg1 = new ArrayList<>();
        } else {
            for (MultiImage multiImage : stmpImg1) {
                ImageUtil.setMultiImages(multiImage.getImgOrgUrl(), multiImage);
            }
        }
        return stmpImg1;
	}
	public void setStmpImg1(List<MultiImage> stmpImg1) {
		this.stmpImg1 = stmpImg1;
	}
	public List<MultiImage> getStmpImg2() {
     	if(this.stmpImg2 == null) {
            this.stmpImg2 = new ArrayList<>();
        } else {
            for (MultiImage multiImage : stmpImg2) {
                ImageUtil.setMultiImages(multiImage.getImgOrgUrl(), multiImage);
            }
        }
        return stmpImg2;
	}
	public void setStmpImg2(List<MultiImage> stmpImg2) {
		this.stmpImg2 = stmpImg2;
	}
	public List<MultiImage> getStmpImg3() {
     	if(this.stmpImg3 == null) {
            this.stmpImg3 = new ArrayList<>();
        } else {
            for (MultiImage multiImage : stmpImg3) {
                ImageUtil.setMultiImages(multiImage.getImgOrgUrl(), multiImage);
            }
        }
        return stmpImg3;
	}
	public void setStmpImg3(List<MultiImage> stmpImg3) {
		this.stmpImg3 = stmpImg3;
	}
	public List<MultiImage> getStmpImg4() {
     	if(this.stmpImg4 == null) {
            this.stmpImg4 = new ArrayList<>();
        } else {
            for (MultiImage multiImage : stmpImg4) {
                ImageUtil.setMultiImages(multiImage.getImgOrgUrl(), multiImage);
            }
        }
        return stmpImg4;
	}
	public void setStmpImg4(List<MultiImage> stmpImg4) {
		this.stmpImg4 = stmpImg4;
	}
	public String getOriName() {
		return oriName;
	}
	public void setOriName(String oriName) {
		this.oriName = oriName;
	}
	public String getApplyChnlCdNm() {
		return applyChnlCdNm;
	}
	public void setApplyChnlCdNm(String applyChnlCdNm) {
		this.applyChnlCdNm = applyChnlCdNm;
	}
	public String getStmpStatusNm() {
		return stmpStatusNm;
	}
	public void setStmpStatusNm(String stmpStatusNm) {
		this.stmpStatusNm = stmpStatusNm;
	}
	public String getCalcTypeCdNm() {
		return calcTypeCdNm;
	}
	public void setCalcTypeCdNm(String calcTypeCdNm) {
		this.calcTypeCdNm = calcTypeCdNm;
	}
	public String getCalcTypeSubCdNm() {
		return calcTypeSubCdNm;
	}
	public void setCalcTypeSubCdNm(String calcTypeSubCdNm) {
		this.calcTypeSubCdNm = calcTypeSubCdNm;
	}
	public String getStmpStartDtFullFmt() {
		return stmpStartDtFullFmt;
	}
	public void setStmpStartDtFullFmt(String stmpStartDtFullFmt) {
		this.stmpStartDtFullFmt = stmpStartDtFullFmt;
	}
	public String getStmpEndDtFullFmt() {
		return stmpEndDtFullFmt;
	}
	public void setStmpEndDtFullFmt(String stmpEndDtFullFmt) {
		this.stmpEndDtFullFmt = stmpEndDtFullFmt;
	}
	public List<MultiImage> getStmpImg1Sect() {
     	if(this.stmpImg1Sect == null) {
            this.stmpImg1Sect = new ArrayList<>();
        } else {
            for (MultiImage multiImage : stmpImg1Sect) {
                ImageUtil.setMultiImages(multiImage.getImgOrgUrl(), multiImage);
            }
        }
		return stmpImg1Sect;
	}
	public void setStmpImg1Sect(List<MultiImage> stmpImg1Sect) {
		this.stmpImg1Sect = stmpImg1Sect;
	}
	public List<MultiImage> getStmpImg2Sect() {
     	if(this.stmpImg2Sect == null) {
            this.stmpImg2Sect = new ArrayList<>();
        } else {
            for (MultiImage multiImage : stmpImg2Sect) {
                ImageUtil.setMultiImages(multiImage.getImgOrgUrl(), multiImage);
            }
        }
		return stmpImg2Sect;
	}
	public void setStmpImg2Sect(List<MultiImage> stmpImg2Sect) {
		this.stmpImg2Sect = stmpImg2Sect;
	}
	public List<MultiImage> getStmpImg3Sect() {
     	if(this.stmpImg3Sect == null) {
            this.stmpImg3Sect = new ArrayList<>();
        } else {
            for (MultiImage multiImage : stmpImg3Sect) {
                ImageUtil.setMultiImages(multiImage.getImgOrgUrl(), multiImage);
            }
        }
		return stmpImg3Sect;
	}
	public void setStmpImg3Sect(List<MultiImage> stmpImg3Sect) {
		this.stmpImg3Sect = stmpImg3Sect;
	}
	public List<MultiImage> getStmpImg4Sect() {
     	if(this.stmpImg4Sect == null) {
            this.stmpImg4Sect = new ArrayList<>();
        } else {
            for (MultiImage multiImage : stmpImg4Sect) {
                ImageUtil.setMultiImages(multiImage.getImgOrgUrl(), multiImage);
            }
        }
		return stmpImg4Sect;
	}
	public void setStmpImg4Sect(List<MultiImage> stmpImg4Sect) {
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
