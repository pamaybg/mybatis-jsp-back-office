package com.icignal.marketing.common.eventTrigger.dto.response;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : ICNETCampaignNodeResponseDTO.java
 * @date : 2016. 11. 16.
 * @author : dg.ryu
 * @description : et 캠페인 노드
 */
public class MktETCampaignNodeResDto extends StatusResDto {
	
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
	private String createByNm;		   //등록자명
	private String createDate;		   //등록일시
	private String modifyDate;		   //수정일시
	
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
	
	private List<MktETCampaignCondValResDto> condValList;	//조건값 목록
	private MktETCampaignActValResDto actVal;					//활동값
	private List<MktETCampaignActParamResDto> actParamList;	//조건값 목록
    
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

	public String getCreateByNm() {
		return createByNm;
	}

	public void setCreateByNm(String createByNm) {
		this.createByNm = createByNm;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public List<MktETCampaignCondValResDto> getCondValList() {
		return condValList;
	}

	public void setCondValList(List<MktETCampaignCondValResDto> condValList) {
		this.condValList = condValList;
	}

	public MktETCampaignActValResDto getActVal() {
		return actVal;
	}

	public void setActVal(MktETCampaignActValResDto actVal) {
		this.actVal = actVal;
	}

	public List<MktETCampaignActParamResDto> getActParamList() {
		return actParamList;
	}

	public void setActParamList(List<MktETCampaignActParamResDto> actParamList) {
		this.actParamList = actParamList;
	}

}
