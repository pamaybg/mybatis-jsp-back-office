package com.icignal.offer.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class OfferJoinChnlItemReqDto extends MKTBaseReqDto {

	private String targetOfferId;       //타겟오퍼 아이디
    private String chnlId;
    private String attrib01;
    private String attrib02;
    private String attrib03;
    private String attrib04;
    private String attrib05;
    
    private String ridProdM;
    
    private String fileName;
    private String uploadValidCheck;
    private String prodUseType;
    
    private List<OfferJoinChnlItemReqDto> itemList;

	public String getTargetOfferId() {
		return targetOfferId;
	}

	public void setTargetOfferId(String targetOfferId) {
		this.targetOfferId = targetOfferId;
	}

	public String getChnlId() {
		return chnlId;
	}

	public void setChnlId(String chnlId) {
		this.chnlId = chnlId;
	}

	public String getAttrib01() {
		return attrib01;
	}

	public void setAttrib01(String attrib01) {
		this.attrib01 = attrib01;
	}

	public String getAttrib02() {
		return attrib02;
	}

	public void setAttrib02(String attrib02) {
		this.attrib02 = attrib02;
	}

	public String getAttrib03() {
		return attrib03;
	}

	public void setAttrib03(String attrib03) {
		this.attrib03 = attrib03;
	}

	public String getAttrib04() {
		return attrib04;
	}

	public void setAttrib04(String attrib04) {
		this.attrib04 = attrib04;
	}

	public String getAttrib05() {
		return attrib05;
	}

	public void setAttrib05(String attrib05) {
		this.attrib05 = attrib05;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getUploadValidCheck() {
		return uploadValidCheck;
	}

	public void setUploadValidCheck(String uploadValidCheck) {
		this.uploadValidCheck = uploadValidCheck;
	}

	public List<OfferJoinChnlItemReqDto> getItemList() {
		return itemList;
	}

	public void setItemList(List<OfferJoinChnlItemReqDto> itemList) {
		this.itemList = itemList;
	}

	public String getRidProdM() {
		return ridProdM;
	}

	public void setRidProdM(String ridProdM) {
		this.ridProdM = ridProdM;
	}

	public String getProdUseType() {
		return prodUseType;
	}

	public void setProdUseType(String prodUseType) {
		this.prodUseType = prodUseType;
	} 
}
