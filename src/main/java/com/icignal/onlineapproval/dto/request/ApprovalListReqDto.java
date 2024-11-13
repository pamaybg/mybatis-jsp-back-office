package com.icignal.onlineapproval.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : MKTElapprovalRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결제 정보 조회
 */
public class ApprovalListReqDto extends CommonDataAuthReqDto{
	private String id;                    //아이디
	private String memId;                 //요청 아이디
	private String accntId;               //어카운트 아이디
	private String searchType;

	private String nextYn;

	private String apvrId;
	private String dataVal;
	private String contents;

	private String checkSeq;
	private String elecAprvId;

	private String itemId;
	
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

	public String getAccntId() {
		return accntId;
	}

	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getDataVal() {return dataVal;}

	public void setDataVal(String dataVal) {this.dataVal = dataVal;}

	public String getApvrId() {return apvrId;}

	public void setApvrId(String apvrId) {this.apvrId = apvrId;}

	public String getContents() {return contents;}

	public void setContents(String contents) {this.contents = contents;}

	public String getNextYn() {return nextYn;}

	public void setNextYn(String nextYn) {this.nextYn = nextYn;}

	public String getCheckSeq() {return checkSeq;}

	public void setCheckSeq(String checkSeq) {this.checkSeq = checkSeq;}

	public String getElecAprvId() {return elecAprvId;}

	public void setElecAprvId(String elecAprvId) {this.elecAprvId = elecAprvId;}

	public String getItemId() {return itemId;}

	public void setItemId(String itemId) {this.itemId = itemId;}
}
