package com.icignal.marketing.campaign.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;
/**
 * @name : MktLoyCampaignNodeReqDto.java
 * @date : 2016. 11. 16.
 * @author : dg.ryu
 * @description : 로얄티 캠페인 노드 ResponseDto
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class MktETCampaignNodeReqDto extends MKTBaseReqDto {
    
	private String campaignId;		   //캠페인 아이디
	private String dataStatus;		   //데이터 상태
	
	private String rid;               //RID
	private String ridMktCamMst;      //RID_캠페인마스터
	private String ridNodeType;       //RID_NODE_TYPE
	private String ridNodeSubType;    //RID_NODE_SUB_TYPE
	private String title;             //타이틀
	private String type;              //유형
	private String desctxt;           //설명
	private String xCoord;            //X 좌표
	private String yCoord;            //Y 좌표
	private String execSeq;           //실행 순서
	
	private List<MktETCampaignCondValReqDto> condValList;		//조건값 목록
	private MktETCampaignActValReqDto actVal;					//활동값
	private List<MktETCampaignActParamReqDto> actParam;		//Action Param
	
	private String ridPgm;
	
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

	public String getRidMktCamMst() {
		return ridMktCamMst;
	}

	public void setRidMktCamMst(String ridMktCamMst) {
		this.ridMktCamMst = ridMktCamMst;
	}

	public String getRidNodeType() {
		return ridNodeType;
	}

	public void setRidNodeType(String ridNodeType) {
		this.ridNodeType = ridNodeType;
	}

	public String getRidNodeSubType() {
		return ridNodeSubType;
	}

	public void setRidNodeSubType(String ridNodeSubType) {
		this.ridNodeSubType = ridNodeSubType;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDesctxt() {
		return desctxt;
	}

	public void setDesctxt(String desctxt) {
		this.desctxt = desctxt;
	}

	public String getxCoord() {
		return xCoord;
	}

	public void setxCoord(String xCoord) {
		this.xCoord = xCoord;
	}

	public String getyCoord() {
		return yCoord;
	}

	public void setyCoord(String yCoord) {
		this.yCoord = yCoord;
	}

	public String getExecSeq() {
		return execSeq;
	}

	public void setExecSeq(String execSeq) {
		this.execSeq = execSeq;
	}

	public String getCampaignId() {
		return campaignId;
	}

	public void setCampaignId(String campaignId) {
		this.campaignId = campaignId;
	}

	public List<MktETCampaignCondValReqDto> getCondValList() {
		return condValList;
	}

	public void setCondValList(List<MktETCampaignCondValReqDto> condValList) {
		this.condValList = condValList;
	}

	public MktETCampaignActValReqDto getActVal() {
		return actVal;
	}

	public void setActVal(MktETCampaignActValReqDto actVal) {
		this.actVal = actVal;
	}

	public String getDataStatus() {
		return dataStatus;
	}

	public void setDataStatus(String dataStatus) {
		this.dataStatus = dataStatus;
	}

	public String getRidPgm() {
		return ridPgm;
	}

	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}

	public List<MktETCampaignActParamReqDto> getActParam() {
		return actParam;
	}

	public void setActParam(List<MktETCampaignActParamReqDto> actParam) {
		this.actParam = actParam;
	}
}
