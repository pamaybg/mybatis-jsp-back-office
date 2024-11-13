package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.marketing.campaign.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : et function 목록 ResDto
 */
public class MktETFunctionListResDto extends GridPagingItemResDto {
	
	private String rid;			      //RID
	private String nodeTypeCd;       //노드 유형 코드
	private String nodeTypeCdNm;     //노드 유형 코드명
	private String dspVal;           //표시 값
	private String iconNm;           //아이콘 명
	private String size;             //사이즈
	private String inputScrn;        //입력 화면

	private String subTypeCd;        //서브 유형 코드
	private String execCls;          //실행 클래스
	private String execMthd;         //실행 메쏘드
	private String subInputScrn;     //입력 화면
	private String subDesctxt;       //설명
	
	private String createByNm;		  //등록자
	private String createDate;		  //등록일시
	
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getNodeTypeCd() {
		return nodeTypeCd;
	}

	public void setNodeTypeCd(String nodeTypeCd) {
		this.nodeTypeCd = nodeTypeCd;
	}

	public String getNodeTypeCdNm() {
		return nodeTypeCdNm;
	}

	public void setNodeTypeCdNm(String nodeTypeCdNm) {
		this.nodeTypeCdNm = nodeTypeCdNm;
	}

	public String getDspVal() {
		return dspVal;
	}

	public void setDspVal(String dspVal) {
		this.dspVal = dspVal;
	}

	public String getIconNm() {
		return iconNm;
	}

	public void setIconNm(String iconNm) {
		this.iconNm = iconNm;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getInputScrn() {
		return inputScrn;
	}

	public void setInputScrn(String inputScrn) {
		this.inputScrn = inputScrn;
	}

	public String getSubTypeCd() {
		return subTypeCd;
	}

	public void setSubTypeCd(String subTypeCd) {
		this.subTypeCd = subTypeCd;
	}

	public String getExecCls() {
		return execCls;
	}

	public void setExecCls(String execCls) {
		this.execCls = execCls;
	}

	public String getExecMthd() {
		return execMthd;
	}

	public void setExecMthd(String execMthd) {
		this.execMthd = execMthd;
	}

	public String getSubInputScrn() {
		return subInputScrn;
	}

	public void setSubInputScrn(String subInputScrn) {
		this.subInputScrn = subInputScrn;
	}

	public String getSubDesctxt() {
		return subDesctxt;
	}

	public void setSubDesctxt(String subDesctxt) {
		this.subDesctxt = subDesctxt;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateByNm() {
		return createByNm;
	}

	public void setCreateByNm(String createByNm) {
		this.createByNm = createByNm;
	}


}
