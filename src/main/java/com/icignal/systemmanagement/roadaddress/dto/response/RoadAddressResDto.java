package com.icignal.systemmanagement.roadaddress.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;


public class RoadAddressResDto extends GridPagingItemResDto { // <--- response용 Dto를 만들 때 상속해줄걸로는 GridPagingItemResDto를 상속해주면 된다(울 시스템에서 가장 호환성 높은 ResDto) 
	// 멤버 필드
	private String rid;
	private String code;
	private String code_nm;
	private String sido;
	private String sigungu;
	private String del_flag;
	
	
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
			
	

	
}
