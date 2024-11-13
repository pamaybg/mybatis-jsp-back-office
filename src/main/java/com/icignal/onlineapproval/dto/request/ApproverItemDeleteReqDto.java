package com.icignal.onlineapproval.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : MKTElapprovalUpdateRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결제 업데이트
 */
public class ApproverItemDeleteReqDto extends CommonDataAuthReqDto{
	private String id;                      //고유 아이디
	private String memId;					//회원 아이디
	private List<String> listChannelFlowId; //삭제 요청 리스트
	private String aprvId;					//전자결제 아이디
	private String seq;						//순서
	private String elecId;                  //전자결제 아이디
	private String apvrid;                  //결제 아이디
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public List<String> getListChannelFlowId() {
		return listChannelFlowId;
	}
	public void setListChannelFlowId(List<String> listChannelFlowId) {
		this.listChannelFlowId = listChannelFlowId;
	}
	public String getAprvId() {
		return aprvId;
	}
	public void setAprvId(String aprvId) {
		this.aprvId = aprvId;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getElecId() {
		return elecId;
	}
	public void setElecId(String elecId) {
		this.elecId = elecId;
	}
	public String getApvrid() {
		return apvrid;
	}
	public void setApvrid(String apvrid) {
		this.apvrid = apvrid;
	}
	
	
}
