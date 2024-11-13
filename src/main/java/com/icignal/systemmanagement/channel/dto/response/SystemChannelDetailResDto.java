package com.icignal.systemmanagement.channel.dto.response;

import java.sql.Date;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;


/**
 * @name : MKTChannelResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 채널 정보 조회
 */
@CommCode
public class SystemChannelDetailResDto extends GridPagingItemResDto{
	private String id;               //아이디
	private String chnlName;         //채널명
	
	//@MarkName(groupCode = "MKT_CAM_CHNL_TYPE_CD", codeField = "chnlType")
	private String chnlTypeCd;       //마케팅 실행 채널 유형
	private String chnlType;
	
	//@MarkName(groupCode = "COMM_STATUS", codeField = "commStatusCd")
	private String commStatus;       //상태
	private String commStatusCd;
	
	
	private String accountId;        //Account ID
	private Date applyStrDate;       //적용시작일자
	private Date applyEndDate;       //적용종료일자
	private String conId;            //접속ID
	private String conPw;            //접속암호
	private String conIp;            //접속IP
	private String conPort;          //접속PORT
	private String conUrl;           //접속 웹페이지/API
	private String description;      //설명 
	private String createBy;         //생성자
	private String createDate;       //생성일
	private String modifyBy;         //수정자
	private String modifyDate;       //수정일
	private String ptraccntId;		 //파트너 업체 아이디
	private String ptraccntNm;       //파트너명
	private String ucost;            //단가
	
	//@MarkName(groupCode = "CHNL_CON_DB_TYPE", codeField = "dbtypeCd")
	private String dbtype;           //DB연결 유형	
	private String dbtypeCd;

	private String chnlGuide;		 //채널 가이드
	private String secretNm;		 //서비스명
	private String serviceNm;
	
	private String sendableStartTime;  //발송가능 시작시간
	private String sendableEndTime;    //발송가능 종료시간
	
	public String getSendableStartTime() {
        return sendableStartTime;
    }
    public void setSendableStartTime(String sendableStartTime) {
        this.sendableStartTime = sendableStartTime;
    }
    public String getSendableEndTime() {
        return sendableEndTime;
    }
    public void setSendableEndTime(String sendableEndTime) {
        this.sendableEndTime = sendableEndTime;
    }
    public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getChnlName() {
		return chnlName;
	}
	public void setChnlName(String chnlName) {
		this.chnlName = chnlName;
	}
	public String getChnlTypeCd() {
		return chnlTypeCd;
	}
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}
	public String getCommStatus() {
		return commStatus;
	}
	public void setCommStatus(String commStatus) {
		this.commStatus = commStatus;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public Date getApplyStrDate() {
		return applyStrDate;
	}
	public void setApplyStrDate(Date applyStrDate) {
		this.applyStrDate = applyStrDate;
	}
	public Date getApplyEndDate() {
		return applyEndDate;
	}
	public void setApplyEndDate(Date applyEndDate) {
		this.applyEndDate = applyEndDate;
	}
	public String getConId() {
		return conId;
	}
	public void setConId(String conId) {
		this.conId = conId;
	}
	public String getConPw() {
		return conPw;
	}
	public void setConPw(String conPw) {
		this.conPw = conPw;
	}
	public String getConIp() {
		return conIp;
	}
	public void setConIp(String conIp) {
		this.conIp = conIp;
	}
	public String getConPort() {
		return conPort;
	}
	public void setConPort(String conPort) {
		this.conPort = conPort;
	}
	public String getConUrl() {
		return conUrl;
	}
	public void setConUrl(String conUrl) {
		this.conUrl = conUrl;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getPtraccntId() {
		return ptraccntId;
	}
	public void setPtraccntId(String ptraccntId) {
		this.ptraccntId = ptraccntId;
	}
	public String getPtraccntNm() {
		return ptraccntNm;
	}
	public void setPtraccntNm(String ptraccntNm) {
		this.ptraccntNm = ptraccntNm;
	}
	public String getUcost() {
		return ucost;
	}
	public void setUcost(String ucost) {
		this.ucost = ucost;
	}
	public String getChnlGuide() {
		return chnlGuide;
	}
	public void setChnlGuide(String chnlGuide) {
		this.chnlGuide = chnlGuide;
	}
	public String getSecretNm() {
		return secretNm;
	}
	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
	public String getServiceNm() {
		return serviceNm;
	}
	public void setServiceNm(String serviceNm) {
		this.serviceNm = serviceNm;
	}
	public String getChnlType() {
		return chnlType;
	}
	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}
	public String getCommStatusCd() {
		return commStatusCd;
	}
	public void setCommStatusCd(String commStatusCd) {
		this.commStatusCd = commStatusCd;
	}
	public String getDbtypeCd() {
		return dbtypeCd;
	}
	public void setDbtypeCd(String dbtypeCd) {
		this.dbtypeCd = dbtypeCd;
	}
	
	public String getDbtype() {
		return dbtype;
	}
	public void setDbtype(String dbtype) {
		this.dbtype = dbtype;
	}
}
