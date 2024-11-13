package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;

public class LoyMbrAlterHistContsResDto extends GridPagingItemResDto {
	// 멤버필드
	private String id;                     
	private String contsType;              
	private String contsNo;                
	private String contsTypeCd;            
	private String contsNm;                
	private String exeChnlTypeCd;          
	private String contsDivCd;             
	private String contsPrpsCd;            
	private String contsSbst;              
	private String contsBottom;            
	private String contsHtmlC;             
	private String contsDesc;              
	private String contsVol;               
	private String imgSize;                
	private String subImgSize;             
	private String imgAplyCnt;             
	private String imgId;             
	private String subImgId;               
	private String bcodeImgId;             
	private String mergeImgId;             
	private String imgLinkUrl;             
	private String extrlImgUrl;            
	private String contsEmailTypeCd;       
	private String contsPushTypeCd;        
	private String contsPushSubTypeCd;     
	private String contsPushSubTypeVal;    
	private String contsPushAppTypeCd;     
	private String contsPushSendTypeCd;    
	private String contsPushParam;         
	private String deviceTypeCd;           
	private String snsInfo;                
	private String postId;                 
	private String reservePost;            
	private String openRange;              
	private String attType;                
	private String dpStartDt;              
	private String dpEndDt;                
	private String contsSeq;               
	private String contsLoadSeq;           
	private String contsAttenMtr;          
	private String inqrNo;                 
	private String newDpCloDt;             
	private String hpage;                  
	private String evNo;                   
	private String apctPosblNum;           
	private String pstngTypeCd;            
	private String contsTitle;             
	private String contsSubTitle;          
	private String modifyDate;             
	private String attrib01;               
	private String attrib02;               
	private String attrib03;               
	private String attrib04;               
	private String attrib05;        
	private String attrib06;          
	private String attrib07;          
	private String attrib08;          
	private String attrib09;          
	private String attrib10;          
	private String contsHtml;         
	private String contsHtmlCon;      
	private String sendContsTitle;    
	private String sendContsSbst;     
	private String ridOfr;            
	private String toCallbackNo;

	private String tagNm;   
	private String tagVal;  
	private String encYn; 
		
	
	
	
	// 게터세터
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContsType() {
		return contsType;
	}
	public void setContsType(String contsType) {
		this.contsType = contsType;
	}
	public String getContsNo() {
		return contsNo;
	}
	public void setContsNo(String contsNo) {
		this.contsNo = contsNo;
	}
	public String getContsTypeCd() {
		return contsTypeCd;
	}
	public void setContsTypeCd(String contsTypeCd) {
		this.contsTypeCd = contsTypeCd;
	}
	public String getContsNm() {
		return contsNm;
	}
	public void setContsNm(String contsNm) {
		this.contsNm = contsNm;
	}
	public String getExeChnlTypeCd() {
		return exeChnlTypeCd;
	}
	public void setExeChnlTypeCd(String exeChnlTypeCd) {
		this.exeChnlTypeCd = exeChnlTypeCd;
	}
	public String getContsDivCd() {
		return contsDivCd;
	}
	public void setContsDivCd(String contsDivCd) {
		this.contsDivCd = contsDivCd;
	}
	public String getContsPrpsCd() {
		return contsPrpsCd;
	}
	public void setContsPrpsCd(String contsPrpsCd) {
		this.contsPrpsCd = contsPrpsCd;
	}
	public String getContsSbst() {
		return contsSbst;
	}
	public void setContsSbst(String contsSbst) {
		this.contsSbst = contsSbst;
	}
	public String getContsBottom() {
		return contsBottom;
	}
	public void setContsBottom(String contsBottom) {
		this.contsBottom = contsBottom;
	}
	public String getContsHtmlC() {
		return contsHtmlC;
	}
	public void setContsHtmlC(String contsHtmlC) {
		this.contsHtmlC = contsHtmlC;
	}
	public String getContsDesc() {
		return contsDesc;
	}
	public void setContsDesc(String contsDesc) {
		this.contsDesc = contsDesc;
	}
	public String getContsVol() {
		return contsVol;
	}
	public void setContsVol(String contsVol) {
		this.contsVol = contsVol;
	}
	public String getImgSize() {
		return imgSize;
	}
	public void setImgSize(String imgSize) {
		this.imgSize = imgSize;
	}
	public String getSubImgSize() {
		return subImgSize;
	}
	public void setSubImgSize(String subImgSize) {
		this.subImgSize = subImgSize;
	}
	public String getImgAplyCnt() {
		return imgAplyCnt;
	}
	public void setImgAplyCnt(String imgAplyCnt) {
		this.imgAplyCnt = imgAplyCnt;
	}
	public String getImgId() {
		return imgId;
	}
	public void setImgId(String imgId) {
		this.imgId = imgId;
	}
	public String getSubImgId() {
		return subImgId;
	}
	public void setSubImgId(String subImgId) {
		this.subImgId = subImgId;
	}
	public String getBcodeImgId() {
		return bcodeImgId;
	}
	public void setBcodeImgId(String bcodeImgId) {
		this.bcodeImgId = bcodeImgId;
	}
	public String getMergeImgId() {
		return mergeImgId;
	}
	public void setMergeImgId(String mergeImgId) {
		this.mergeImgId = mergeImgId;
	}
	public String getImgLinkUrl() {
		return imgLinkUrl;
	}
	public void setImgLinkUrl(String imgLinkUrl) {
		this.imgLinkUrl = imgLinkUrl;
	}
	public String getExtrlImgUrl() {
		return extrlImgUrl;
	}
	public void setExtrlImgUrl(String extrlImgUrl) {
		this.extrlImgUrl = extrlImgUrl;
	}
	public String getContsEmailTypeCd() {
		return contsEmailTypeCd;
	}
	public void setContsEmailTypeCd(String contsEmailTypeCd) {
		this.contsEmailTypeCd = contsEmailTypeCd;
	}
	public String getContsPushTypeCd() {
		return contsPushTypeCd;
	}
	public void setContsPushTypeCd(String contsPushTypeCd) {
		this.contsPushTypeCd = contsPushTypeCd;
	}
	public String getContsPushSubTypeCd() {
		return contsPushSubTypeCd;
	}
	public void setContsPushSubTypeCd(String contsPushSubTypeCd) {
		this.contsPushSubTypeCd = contsPushSubTypeCd;
	}
	public String getContsPushSubTypeVal() {
		return contsPushSubTypeVal;
	}
	public void setContsPushSubTypeVal(String contsPushSubTypeVal) {
		this.contsPushSubTypeVal = contsPushSubTypeVal;
	}
	public String getContsPushAppTypeCd() {
		return contsPushAppTypeCd;
	}
	public void setContsPushAppTypeCd(String contsPushAppTypeCd) {
		this.contsPushAppTypeCd = contsPushAppTypeCd;
	}
	public String getContsPushSendTypeCd() {
		return contsPushSendTypeCd;
	}
	public void setContsPushSendTypeCd(String contsPushSendTypeCd) {
		this.contsPushSendTypeCd = contsPushSendTypeCd;
	}
	public String getContsPushParam() {
		return contsPushParam;
	}
	public void setContsPushParam(String contsPushParam) {
		this.contsPushParam = contsPushParam;
	}
	public String getDeviceTypeCd() {
		return deviceTypeCd;
	}
	public void setDeviceTypeCd(String deviceTypeCd) {
		this.deviceTypeCd = deviceTypeCd;
	}
	public String getSnsInfo() {
		return snsInfo;
	}
	public void setSnsInfo(String snsInfo) {
		this.snsInfo = snsInfo;
	}
	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getReservePost() {
		return reservePost;
	}
	public void setReservePost(String reservePost) {
		this.reservePost = reservePost;
	}
	public String getOpenRange() {
		return openRange;
	}
	public void setOpenRange(String openRange) {
		this.openRange = openRange;
	}
	public String getAttType() {
		return attType;
	}
	public void setAttType(String attType) {
		this.attType = attType;
	}
	public String getDpStartDt() {
		return dpStartDt;
	}
	public void setDpStartDt(String dpStartDt) {
		this.dpStartDt = dpStartDt;
	}
	public String getDpEndDt() {
		return dpEndDt;
	}
	public void setDpEndDt(String dpEndDt) {
		this.dpEndDt = dpEndDt;
	}
	public String getContsSeq() {
		return contsSeq;
	}
	public void setContsSeq(String contsSeq) {
		this.contsSeq = contsSeq;
	}
	public String getContsLoadSeq() {
		return contsLoadSeq;
	}
	public void setContsLoadSeq(String contsLoadSeq) {
		this.contsLoadSeq = contsLoadSeq;
	}
	public String getContsAttenMtr() {
		return contsAttenMtr;
	}
	public void setContsAttenMtr(String contsAttenMtr) {
		this.contsAttenMtr = contsAttenMtr;
	}
	public String getInqrNo() {
		return inqrNo;
	}
	public void setInqrNo(String inqrNo) {
		this.inqrNo = inqrNo;
	}
	public String getNewDpCloDt() {
		return newDpCloDt;
	}
	public void setNewDpCloDt(String newDpCloDt) {
		this.newDpCloDt = newDpCloDt;
	}
	public String getHpage() {
		return hpage;
	}
	public void setHpage(String hpage) {
		this.hpage = hpage;
	}
	public String getEvNo() {
		return evNo;
	}
	public void setEvNo(String evNo) {
		this.evNo = evNo;
	}
	public String getApctPosblNum() {
		return apctPosblNum;
	}
	public void setApctPosblNum(String apctPosblNum) {
		this.apctPosblNum = apctPosblNum;
	}
	public String getPstngTypeCd() {
		return pstngTypeCd;
	}
	public void setPstngTypeCd(String pstngTypeCd) {
		this.pstngTypeCd = pstngTypeCd;
	}
	public String getContsTitle() {
		return contsTitle;
	}
	public void setContsTitle(String contsTitle) {
		this.contsTitle = contsTitle;
	}
	public String getContsSubTitle() {
		return contsSubTitle;
	}
	public void setContsSubTitle(String contsSubTitle) {
		this.contsSubTitle = contsSubTitle;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
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
	public String getAttrib06() {
		return attrib06;
	}
	public void setAttrib06(String attrib06) {
		this.attrib06 = attrib06;
	}
	public String getAttrib07() {
		return attrib07;
	}
	public void setAttrib07(String attrib07) {
		this.attrib07 = attrib07;
	}
	public String getAttrib08() {
		return attrib08;
	}
	public void setAttrib08(String attrib08) {
		this.attrib08 = attrib08;
	}
	public String getAttrib09() {
		return attrib09;
	}
	public void setAttrib09(String attrib09) {
		this.attrib09 = attrib09;
	}
	public String getAttrib10() {
		return attrib10;
	}
	public void setAttrib10(String attrib10) {
		this.attrib10 = attrib10;
	}
	public String getContsHtml() {
		return contsHtml;
	}
	public void setContsHtml(String contsHtml) {
		this.contsHtml = contsHtml;
	}
	public String getContsHtmlCon() {
		return contsHtmlCon;
	}
	public void setContsHtmlCon(String contsHtmlCon) {
		this.contsHtmlCon = contsHtmlCon;
	}
	public String getSendContsTitle() {
		return sendContsTitle;
	}
	public void setSendContsTitle(String sendContsTitle) {
		this.sendContsTitle = sendContsTitle;
	}
	public String getSendContsSbst() {
		return sendContsSbst;
	}
	public void setSendContsSbst(String sendContsSbst) {
		this.sendContsSbst = sendContsSbst;
	}
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getToCallbackNo() {
		return toCallbackNo;
	}
	public void setToCallbackNo(String toCallbackNo) {
		this.toCallbackNo = toCallbackNo;
	}      
	
	public String getTagNm() {
		return tagNm;
	}
	public void setTagNm(String tagNm) {
		this.tagNm = tagNm;
	}
	public String getTagVal() {
		return tagVal;
	}
	public void setTagVal(String tagVal) {
		this.tagVal = tagVal;
	}
	public String getEncYn() {
		return encYn;
	}
	public void setEncYn(String encYn) {
		this.encYn = encYn;
	}
	
	
}
