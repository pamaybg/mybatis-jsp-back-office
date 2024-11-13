package com.icignal.mobile.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : MktCampaignApprovalReqListResDto.java
 * @date : 2022. 3. 3.
 * @author : ps.lee
 * @description : 모바일 캠페인 승인 대상 리스트 조회 ResDto
 */
public class MktCampaignApprovalReqListResDto extends GridPagingItemResDto {
	
    private String camNm;           	//캠페인명
    private String reqName;     		//요청자명
    private String createDate;   		//요청일시
    private String exeChnlTypeCd;		//발송채널
    
    private Integer camTgtCnt;      	//대상자수
    private String imagePath;    		//이미지경로
    private String contsSbst;    		//발송내용
    private String camStatusCd;    		//캠페인상태
    private String elecAprvId;       	//전자결제아이디
    private String elecAprvStatusCd;    //전자결제아이템상태
    
    private Integer monthAccrueCnt;		//월누적수
    private String seq;					//전자결제순서
    private String apvrTypeCd;			//결재순서 타입
    private String recordRid;			//캠페인ID
    private String itemId;              //선택한 RowId
	private String reqHhp;
	private String exeDt;
	private String camId;
    
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
	
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getReqName() {
		return reqName;
	}
	public void setReqName(String reqName) {
		this.reqName = reqName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getExeChnlTypeCd() {
		return exeChnlTypeCd;
	}
	public void setExeChnlTypeCd(String exeChnlTypeCd) {
		this.exeChnlTypeCd = exeChnlTypeCd;
	}
	public Integer getCamTgtCnt() {
		return camTgtCnt;
	}
	public void setCamTgtCnt(Integer camTgtCnt) {
		this.camTgtCnt = camTgtCnt;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getContsSbst() {
		return contsSbst;
	}
	public void setContsSbst(String contsSbst) {
		this.contsSbst = contsSbst;
	}
	public String getCamStatusCd() {
		return camStatusCd;
	}
	public void setCamStatusCd(String camStatusCd) {
		this.camStatusCd = camStatusCd;
	}
	public String getElecAprvId() {
		return elecAprvId;
	}
	public void setElecAprvId(String elecAprvId) {
		this.elecAprvId = elecAprvId;
	}
	public String getElecAprvStatusCd() {
		return elecAprvStatusCd;
	}
	public void setElecAprvStatusCd(String elecAprvStatusCd) {
		this.elecAprvStatusCd = elecAprvStatusCd;
	}

	public Integer getMonthAccrueCnt() {
		return monthAccrueCnt;
	}

	public void setMonthAccrueCnt(Integer monthAccrueCnt) {
		this.monthAccrueCnt = monthAccrueCnt;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getApvrTypeCd() {
		return apvrTypeCd;
	}

	public void setApvrtypeCd(String apvrTypeCd) {
		this.apvrTypeCd = apvrTypeCd;
	}

	public String getRecordRid() {
		return recordRid;
	}

	public void setRecordRid(String recordRid) {
		this.recordRid = recordRid;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getReqHhp() {
		return reqHhp;
	}

	public void setReqHhp(String reqHhp) {
		this.reqHhp = reqHhp;
	}

	public String getExeDt() {
		return exeDt;
	}

	public void setExeDt(String exeDt) {
		this.exeDt = exeDt;
	}

	public String getCamId() {
		return camId;
	}

	public void setCamId(String camId) {
		this.camId = camId;
	}
}
