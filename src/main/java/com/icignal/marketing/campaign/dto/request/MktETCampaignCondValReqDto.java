package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.marketing.campaign.dto.request
 * @date : 2016. 11. 16
 * @author : dg.ryu
 * @description : 캠페인 조건값 목록
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class MktETCampaignCondValReqDto extends CommonDataAuthReqDto {
	
	private String rid;                 //RID
	private String ridCamNode;          //RID_CAM_NODE
	private String seq;                 //순서
	private String lgclCmpntId;         //로지컬 컴포넌트 ID
	private String lgclFld;             //로지컬 필드
	private String lcLogicOper;         //LC_논리 연산자
	private String lcLeftbrkt;          //LC_좌괄호
	private String lcRightbrkt;         //LC_우괄호
	private String lcCompValType;       //LC_비교 값 유형
	private String lcCompVal;           //LC_비교 값
	private String lcCompOper;          //LC_비교 연산자
	private String irreglrExecCls;      //비정형_실행 클래스
	private String irreglrExecMthd;     //비정형_실행 메쏘드
	private String irreglrRtnFld;       //비정형_리턴 필드
	private String irreglrRtnFldVal;    //비정형_리턴 필드 값
	private String irreglrCompOper;     //비정형_비교 연산자
	private String irreglrLogicOper;    //비정형_논리 연산자
	private String irreglrCompVal;     //비정형_비교 값
	
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getRidCamNode() {
		return ridCamNode;
	}

	public void setRidCamNode(String ridCamNode) {
		this.ridCamNode = ridCamNode;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getLgclCmpntId() {
		return lgclCmpntId;
	}

	public void setLgclCmpntId(String lgclCmpntId) {
		this.lgclCmpntId = lgclCmpntId;
	}

	public String getLgclFld() {
		return lgclFld;
	}

	public void setLgclFld(String lgclFld) {
		this.lgclFld = lgclFld;
	}

	public String getLcLogicOper() {
		return lcLogicOper;
	}

	public void setLcLogicOper(String lcLogicOper) {
		this.lcLogicOper = lcLogicOper;
	}

	public String getLcLeftbrkt() {
		return lcLeftbrkt;
	}

	public void setLcLeftbrkt(String lcLeftbrkt) {
		this.lcLeftbrkt = lcLeftbrkt;
	}

	public String getLcRightbrkt() {
		return lcRightbrkt;
	}

	public void setLcRightbrkt(String lcRightbrkt) {
		this.lcRightbrkt = lcRightbrkt;
	}

	public String getLcCompValType() {
		return lcCompValType;
	}

	public void setLcCompValType(String lcCompValType) {
		this.lcCompValType = lcCompValType;
	}

	public String getLcCompVal() {
		return lcCompVal;
	}

	public void setLcCompVal(String lcCompVal) {
		this.lcCompVal = lcCompVal;
	}

	public String getLcCompOper() {
		return lcCompOper;
	}

	public void setLcCompOper(String lcCompOper) {
		this.lcCompOper = lcCompOper;
	}

	public String getIrreglrExecCls() {
		return irreglrExecCls;
	}

	public void setIrreglrExecCls(String irreglrExecCls) {
		this.irreglrExecCls = irreglrExecCls;
	}

	public String getIrreglrExecMthd() {
		return irreglrExecMthd;
	}

	public void setIrreglrExecMthd(String irreglrExecMthd) {
		this.irreglrExecMthd = irreglrExecMthd;
	}

	public String getIrreglrRtnFld() {
		return irreglrRtnFld;
	}

	public void setIrreglrRtnFld(String irreglrRtnFld) {
		this.irreglrRtnFld = irreglrRtnFld;
	}

	public String getIrreglrRtnFldVal() {
		return irreglrRtnFldVal;
	}

	public void setIrreglrRtnFldVal(String irreglrRtnFldVal) {
		this.irreglrRtnFldVal = irreglrRtnFldVal;
	}

	public String getIrreglrCompOper() {
		return irreglrCompOper;
	}

	public void setIrreglrCompOper(String irreglrCompOper) {
		this.irreglrCompOper = irreglrCompOper;
	}

	public String getIrreglrLogicOper() {
		return irreglrLogicOper;
	}

	public void setIrreglrLogicOper(String irreglrLogicOper) {
		this.irreglrLogicOper = irreglrLogicOper;
	}

	public String getIrreglrCompVal() {
		return irreglrCompVal;
	}

	public void setIrreglrCompVal(String irreglrCompVal) {
		this.irreglrCompVal = irreglrCompVal;
	}
}
