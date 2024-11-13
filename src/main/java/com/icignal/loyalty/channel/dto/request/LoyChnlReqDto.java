package com.icignal.loyalty.channel.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.loyalty.event.dto.request.LOYProdRequestDTO;

import java.util.List;

/*
 * 1. 클래스명	: LoyChnlReqDto
 * 2. 파일명	: LoyChnlReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 2. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class LoyChnlReqDto extends CommonDataAuthReqDto {

	/** RID */
	private String rid;

	/** 채널 번호 */
	private String chnlNo;
	/** 채널 명 */
	private String chnlNm;

	/** 채널 상태 코드 */
	private String chnlStatCd;

	/** 채널 유형 코드 */
	private String chnlTypeCd;

	/** 채널 유형 서브 코드 */
	private String chnlTypeSubCd;

	/** 채널레벌번호 */
	private String chnlLvlNo;

	/** 상위채널RID */
	private String parRid;

	/** 가입약관 RID */
	private String ridTerms;


	/** PAR_RID_TOP */
	private String parRidTop;

	/** RID_PGM */
	private String ridPgm;

	/** RID_고객 주요 */
	private String ridCustPr;

	/** 적립 가능 여부 */
	private String acrlPsblYn;

	/** 사용 가능 여부 */
	private String usePsblYn;

	/** 회원 가입 가능 여부 */
	private String mbrJoinPsblYn;
	
	/** 상위채널 seq */
	private String parKeySeq;
	
	/** 최상위채널 seq */
	private String parKeySeqTop;
	
	private String chnlRid;
	
	private String seqNo;
	private String img1;
	private String img2;
	private String comments;
	private String mainImg;
	private String dupSeqNo;
	private String imgPathId;
	private String descChnlImg;

	private String uploadValidCheck;
	private String fileName;		 //파일명

	private List<LoyChnlReqDto> array;
	private boolean message;
	private String empNo;

	public String getSeqNo() {
		return seqNo;
	}

	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}

	public String getImg1() {
		return img1;
	}

	public void setImg1(String img1) {
		this.img1 = img1;
	}

	public String getImg2() {
		return img2;
	}

	public void setImg2(String img2) {
		this.img2 = img2;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	/**
	 * @return the parKeySeq
	 */
	public String getParKeySeq() {
		return parKeySeq;
	}

	/**
	 * @param parKeySeq the parKeySeq to set
	 */
	public void setParKeySeq(String parKeySeq) {
		this.parKeySeq = parKeySeq;
	}

	/**
	 * @return the parKeySeqTop
	 */
	public String getParKeySeqTop() {
		return parKeySeqTop;
	}

	/**
	 * @param parKeySeqTop the parKeySeqTop to set
	 */
	public void setParKeySeqTop(String parKeySeqTop) {
		this.parKeySeqTop = parKeySeqTop;
	}

	/**
	 * @return the rid
	 */
	public String getRid() {
		return rid;
	}

	/**
	 * @param rid the rid to set
	 */
	public void setRid(String rid) {
		this.rid = rid;
	}

	/**
	 * @return the chnlNo
	 */
	public String getChnlNo() {
		return chnlNo;
	}

	/**
	 * @param chnlNo the chnlNo to set
	 */
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}

	/**
	 * @return the chnlNm
	 */
	public String getChnlNm() {
		return chnlNm;
	}

	/**
	 * @param chnlNm the chnlNm to set
	 */
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}

	/**
	 * @return the chnlStatCd
	 */
	public String getChnlStatCd() {
		return chnlStatCd;
	}

	/**
	 * @param chnlStatCd the chnlStatCd to set
	 */
	public void setChnlStatCd(String chnlStatCd) {
		this.chnlStatCd = chnlStatCd;
	}

	/**
	 * @return the chnlTypeCd
	 */
	public String getChnlTypeCd() {
		return chnlTypeCd;
	}

	/**
	 * @param chnlTypeCd the chnlTypeCd to set
	 */
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}

	/**
	 * @return the chnlTypeSubCd
	 */
	public String getChnlTypeSubCd() {
		return chnlTypeSubCd;
	}

	/**
	 * @param chnlTypeSubCd the chnlTypeSubCd to set
	 */
	public void setChnlTypeSubCd(String chnlTypeSubCd) {
		this.chnlTypeSubCd = chnlTypeSubCd;
	}

	/**
	 * @return the chnlLvlNo
	 */
	public String getChnlLvlNo() {
		return chnlLvlNo;
	}

	/**
	 * @param chnlLvlNo the chnlLvlNo to set
	 */
	public void setChnlLvlNo(String chnlLvlNo) {
		this.chnlLvlNo = chnlLvlNo;
	}

	/**
	 * @return the parRid
	 */
	public String getParRid() {
		return parRid;
	}

	/**
	 * @param parRid the parRid to set
	 */
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}

	/**
	 * @return the ridTerms
	 */
	public String getRidTerms() {
		return ridTerms;
	}

	/**
	 * @param ridTerms the ridTerms to set
	 */
	public void setRidTerms(String ridTerms) {
		this.ridTerms = ridTerms;
	}

	/**
	 * @return the parRidTop
	 */
	public String getParRidTop() {
		return parRidTop;
	}

	/**
	 * @param parRidTop the parRidTop to set
	 */
	public void setParRidTop(String parRidTop) {
		this.parRidTop = parRidTop;
	}

	/**
	 * @return the ridPgm
	 */
	public String getRidPgm() {
		return ridPgm;
	}

	/**
	 * @param ridPgm the ridPgm to set
	 */
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}

	/**
	 * @return the ridCustPr
	 */
	public String getRidCustPr() {
		return ridCustPr;
	}

	/**
	 * @param ridCustPr the ridCustPr to set
	 */
	public void setRidCustPr(String ridCustPr) {
		this.ridCustPr = ridCustPr;
	}

	/**
	 * @return the acrlPsblYn
	 */
	public String getAcrlPsblYn() {
		return acrlPsblYn;
	}

	/**
	 * @param acrlPsblYn the acrlPsblYn to set
	 */
	public void setAcrlPsblYn(String acrlPsblYn) {
		this.acrlPsblYn = acrlPsblYn;
	}

	/**
	 * @return the usePsblYn
	 */
	public String getUsePsblYn() {
		return usePsblYn;
	}

	/**
	 * @param usePsblYn the usePsblYn to set
	 */
	public void setUsePsblYn(String usePsblYn) {
		this.usePsblYn = usePsblYn;
	}

	/**
	 * @return the mbrJoinPsblYn
	 */
	public String getMbrJoinPsblYn() {
		return mbrJoinPsblYn;
	}

	/**
	 * @param mbrJoinPsblYn the mbrJoinPsblYn to set
	 */
	public void setMbrJoinPsblYn(String mbrJoinPsblYn) {
		this.mbrJoinPsblYn = mbrJoinPsblYn;
	}

	public String getChnlRid() {
		return chnlRid;
	}

	public void setChnlRid(String chnlRid) {
		this.chnlRid = chnlRid;
	}

	public String getMainImg() {
		return mainImg;
	}

	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}

	public String getDescChnlImg() {
		return descChnlImg;
	}

	public void setDescChnlImg(String descChnlImg) {
		this.descChnlImg = descChnlImg;
	}

	public String getDupSeqNo() {
		return dupSeqNo;
	}

	public void setDupSeqNo(String dupSeqNo) {
		this.dupSeqNo = dupSeqNo;
	}

	public String getImgPathId() {
		return imgPathId;
	}

	public void setImgPathId(String imgPathId) {
		this.imgPathId = imgPathId;
	}


	public String getUploadValidCheck() {
		return uploadValidCheck;
	}

	public void setUploadValidCheck(String uploadValidCheck) {
		this.uploadValidCheck = uploadValidCheck;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public List<LoyChnlReqDto> getArray() {
		return array;
	}

	public void setArray(List<LoyChnlReqDto> array) {
		this.array = array;
	}

	public boolean isMessage() {
		return message;
	}

	public void setMessage(boolean message) {
		this.message = message;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
}
