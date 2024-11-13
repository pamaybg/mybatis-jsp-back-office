package com.icignal.systemmanagement.roadaddress.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.common.base.dto.request.GridPagingReqDto;
import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.loyalty.chnlgrp.dto.request.LoyChnlGrpListReqDto;

public class RoadAddressReqDto extends CommonDataAuthReqDto { // <--- request용 Dto를 만들 때 상속해줄걸로는 CommonDataAuthReqDto를 상속해주면 된다(울 시스템에서 가장 호환성 높은 ReqDto)

	// 멤버 필드
	private String rid;      // RID
	private String code;	 // 법정동코드
	private String code_nm;	 // 법정동명
	private String sido;	 // 시도
	private String sigungu;	 // 시군구
	private String del_flag; // 폐지여부
		
	private String uploadValidCheck; // 업로드유효성체크여부 변수
	private String fileName;		 //파일명
	private String descText;
	
	private String cellNo;
	
	
		//private String lvlCd;
	
	// 엑셀내용데이타들을 (유효성검사까지 다 거친 후) 싹 다 통째로 담아주는데 사용할 리스트 array 변수
	private List<RoadAddressReqDto> array;
	//private List<RoadAddressReqDto> ridList;
	private int cnt;
	private boolean message;
	
	
	// 게터 세터
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCode_nm() {
		return code_nm;
	}
	public void setCode_nm(String code_nm) {
		this.code_nm = code_nm;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getSigungu() {
		return sigungu;
	}
	public void setSigungu(String sigungu) {
		this.sigungu = sigungu;
	}
	public String getDel_flag() {
		return del_flag;
	}
	public void setDel_flag(String del_flag) {
		this.del_flag = del_flag;
	}
	
	
	// LoyChnlGrpListReqDto 내용 참고
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
	public String getDescText() {
		return descText;
	}
	public void setDescText(String descText) {
		this.descText = descText;
	}
	public List<RoadAddressReqDto> getArray() {
		return array;
	}
	public void setArray(List<RoadAddressReqDto> array) {
		this.array = array;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public boolean isMessage() {
		return message;
	}
	public void setMessage(boolean message) {
		this.message = message;
	}
		
	public String getCellNo() {
		return cellNo;
	}
	public void setCellNo(String cellNo) {
		this.cellNo = cellNo;
	}
	
}
