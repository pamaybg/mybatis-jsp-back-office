/**
 *
 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;




/**
* @name : infavor.Loyalty.member.mbr.dto.response.LoyMbrVocListResponseDTO
* @date : 2017. 10. 20.
* @author : 이성원
* @description :
*/
@CommCode
@PersonalData
public class LoyMbrVocListResDto  extends GridPagingItemResDto {

	private String rid;
	private String mbrRid;
	private String srNo;
	private String rcp_dt;
	private String srTrtStatus;
	@MarkName(groupCode="SR_STATUS",codeField="srTrtStatus")
	private String srTrtStatusNm;
	private String memNo;
	private String memNm;
	private String cnctDesk;
	private String memPtblNo;
	private String cnslgTypeCdl;
	@MarkName(groupCode="SR_AREA_L",codeField="cnslgTypeCdl")
	private String cnslgTypeCdlNm;
	private String cnslgTypeCdm;
	@MarkName(groupCode="SR_AREA_M",codeField="cnslgTypeCdm")
	private String cnslgTypeCdmNm;
	private String cnslgTypeCds;
	@MarkName(groupCode="SR_AREA_S",codeField="cnslgTypeCds")
	private String cnslgTypeCdsNm;
	private String cnslgTitle;
	private String cnslgSbst;
	private String createBy;
	private String rcp_meth;
	private String rcpDt;
	private String endDt;

	private String crmuserName;
	private String rcpMeth;
	@MarkName(groupCode="CALL_TYPE",codeField="rcpMeth")
	private String rcpMethNm;
	
	private String buyPlace;
	private String adminId;
	
	private String prodCd;
	private String prodNm;
	private String conslSbst;
	private String reContent;
	
	private String mmZzitemCd;
	
	private String prodId;
	private String goodsName;
	@Decrypted(masked = "none")
	private String writer;
	
	
	
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getProdCd() {
		return prodCd;
	}
	public void setProdCd(String prodCd) {
		this.prodCd = prodCd;
	}
	public String getProdNm() {
		return prodNm;
	}
	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
	}
	public String getConslSbst() {
		return conslSbst;
	}
	public void setConslSbst(String conslSbst) {
		this.conslSbst = conslSbst;
	}
	public String getReContent() {
		return reContent;
	}
	public void setReContent(String reContent) {
		this.reContent = reContent;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getBuyPlace() {
		return buyPlace;
	}
	public void setBuyPlace(String buyPlace) {
		this.buyPlace = buyPlace;
	}
	public String getRcpMeth() {
		return rcpMeth;
	}
	public void setRcpMeth(String rcpMeth) {
		this.rcpMeth = rcpMeth;
	}
	public String getRcpMethNm() {
		return rcpMethNm;
	}
	public void setRcpMethNm(String rcpMethNm) {
		this.rcpMethNm = rcpMethNm;
	}
	public String getSrTrtStatusNm() {
		return srTrtStatusNm;
	}
	public void setSrTrtStatusNm(String srTrtStatusNm) {
		this.srTrtStatusNm = srTrtStatusNm;
	}
	public String getCnslgTypeCdl() {
		return cnslgTypeCdl;
	}
	public void setCnslgTypeCdl(String cnslgTypeCdl) {
		this.cnslgTypeCdl = cnslgTypeCdl;
	}
	public String getCnslgTypeCdlNm() {
		return cnslgTypeCdlNm;
	}
	public void setCnslgTypeCdlNm(String cnslgTypeCdlNm) {
		this.cnslgTypeCdlNm = cnslgTypeCdlNm;
	}
	public String getCnslgTypeCdm() {
		return cnslgTypeCdm;
	}
	public void setCnslgTypeCdm(String cnslgTypeCdm) {
		this.cnslgTypeCdm = cnslgTypeCdm;
	}
	public String getCnslgTypeCdmNm() {
		return cnslgTypeCdmNm;
	}
	public void setCnslgTypeCdmNm(String cnslgTypeCdmNm) {
		this.cnslgTypeCdmNm = cnslgTypeCdmNm;
	}
	public String getCnslgTypeCds() {
		return cnslgTypeCds;
	}
	public void setCnslgTypeCds(String cnslgTypeCds) {
		this.cnslgTypeCds = cnslgTypeCds;
	}
	public String getCnslgTypeCdsNm() {
		return cnslgTypeCdsNm;
	}
	public void setCnslgTypeCdsNm(String cnslgTypeCdsNm) {
		this.cnslgTypeCdsNm = cnslgTypeCdsNm;
	}
	public String getCrmuserName() {
		return crmuserName;
	}
	public void setCrmuserName(String crmuserName) {
		this.crmuserName = crmuserName;
	}
	public String getRcpDt() {
		return rcpDt;
	}
	public void setRcpDt(String rcpDt) {
		this.rcpDt = rcpDt;
	}
	public String getRcp_meth() {
		return rcp_meth;
	}
	public void setRcp_meth(String rcp_meth) {
		this.rcp_meth = rcp_meth;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSrNo() {
		return srNo;
	}
	public void setSrNo(String srNo) {
		this.srNo = srNo;
	}
	public String getRcp_dt() {
		return rcp_dt;
	}
	public void setRcp_dt(String rcp_dt) {
		this.rcp_dt = rcp_dt;
	}
	public String getSrTrtStatus() {
		return srTrtStatus;
	}
	public void setSrTrtStatus(String srTrtStatus) {
		this.srTrtStatus = srTrtStatus;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public String getMemNm() {
		return memNm;
	}
	public void setMemNm(String memNm) {
		this.memNm = memNm;
	}
	public String getCnctDesk() {
		return cnctDesk;
	}
	public void setCnctDesk(String cnctDesk) {
		this.cnctDesk = cnctDesk;
	}
	public String getMemPtblNo() {
		return memPtblNo;
	}
	public void setMemPtblNo(String memPtblNo) {
		this.memPtblNo = memPtblNo;
	}
	public String getCnslgTitle() {
		return cnslgTitle;
	}
	public void setCnslgTitle(String cnslgTitle) {
		this.cnslgTitle = cnslgTitle;
	}
	public String getCnslgSbst() {
		return cnslgSbst;
	}
	public void setCnslgSbst(String cnslgSbst) {
		this.cnslgSbst = cnslgSbst;
	}
	public String getMbrRid() {
		return mbrRid;
	}
	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
	}
	public String getMmZzitemCd() {
		return mmZzitemCd;
	}
	public void setMmZzitemCd(String mmZzitemCd) {
		this.mmZzitemCd = mmZzitemCd;
	}
	
	
	
	
	



}
