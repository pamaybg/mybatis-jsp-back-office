package com.icignal.onlineapproval.dto.response;


import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
/**
 * @name : MKTElapprovalDetailResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결제 상세 정보 조회
 */

public class ApprovalDetailResDto extends GridPagingItemResDto{
	 
	private String id;        //고유 아이디
	private String camNm;	  //캠페인 제목
	private String camDesc;   //캠페인 설명
	private String camCode;	  //캠페인 id
    private String createBy;  //기안자
    private String Dept;      //기안자 부서
    private String createDd;  //기안 작성일
    private String rqtDd;     //기안 요철일
    private String status;    //상태
    private String aprvDesc;  //설명
    private String contetnt;  //결재 내용
    private String camId;     //캠페인 Id
	private String fileName;  //파일명
	private String createId;  //기안자 Row ID
	
	private String elecAprvRqtrOrgId;  //승인요청자부서ID
	private String elecAprvRqtrOrgNm;  //승인요청자부서명
	private String elecAprvRqtrId;     //승인요청자ID
	private String elecAprvRqtrNm;     //승인요청자명
	private String elecAprvEmpNo;		//승인요청자 매장코드
	private String elecAprvTypeCd;     //전자결제유형코드
	private String elecAprvStatusCd;   //전자결제상태코드

	private String rejectRsn;		//반려사유
	private String dispNo;
	private String elecAprvNo;

	private String lastApvDd;		//결재일자
	private String contsSbst;
	private String exeChnlTypeCd;

	public String getElecAprvStatusCd() {
        return elecAprvStatusCd;
    }
    public void setElecAprvStatusCd(String elecAprvStatusCd) {
        this.elecAprvStatusCd = elecAprvStatusCd;
    }
    public String getElecAprvRqtrOrgId() {
        return elecAprvRqtrOrgId;
    }
    public void setElecAprvRqtrOrgId(String elecAprvRqtrOrgId) {
        this.elecAprvRqtrOrgId = elecAprvRqtrOrgId;
    }
    public String getElecAprvRqtrOrgNm() {
        return elecAprvRqtrOrgNm;
    }
    public void setElecAprvRqtrOrgNm(String elecAprvRqtrOrgNm) {
        this.elecAprvRqtrOrgNm = elecAprvRqtrOrgNm;
    }
    public String getElecAprvRqtrId() {
        return elecAprvRqtrId;
    }
    public void setElecAprvRqtrId(String elecAprvRqtrId) {
        this.elecAprvRqtrId = elecAprvRqtrId;
    }
    public String getElecAprvRqtrNm() {
        return elecAprvRqtrNm;
    }
    public void setElecAprvRqtrNm(String elecAprvRqtrNm) {
        this.elecAprvRqtrNm = elecAprvRqtrNm;
    }
    public String getElecAprvTypeCd() {
        return elecAprvTypeCd;
    }
    public void setElecAprvTypeCd(String elecAprvTypeCd) {
        this.elecAprvTypeCd = elecAprvTypeCd;
    }
    public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getCamDesc() {
		return camDesc;
	}
	public void setCamDesc(String camDesc) {
		this.camDesc = camDesc;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getDept() {
		return Dept;
	}
	public void setDept(String dept) {
		Dept = dept;
	}
	public String getCreateDd() {
		return createDd;
	}
	public void setCreateDd(String createDd) {
		this.createDd = createDd;
	}
	public String getRqtDd() {
		return rqtDd;
	}
	public void setRqtDd(String rqtDd) {
		this.rqtDd = rqtDd;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAprvDesc() {
		return aprvDesc;
	}
	public void setAprvDesc(String aprvDesc) {
		this.aprvDesc = aprvDesc;
	}
	public String getContetnt() {
		return contetnt;
	}
	public void setContetnt(String contetnt) {
		this.contetnt = contetnt;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getCreateId() {
		return createId;
	}
	public void setCreateId(String createId) {
		this.createId = createId;
	}
	public String getCamCode() {return camCode;}
	public void setCamCode(String camCode) {this.camCode = camCode;}
	public String getRejectRsn() {return rejectRsn;}
	public void setRejectRsn(String rejectRsn) {this.rejectRsn = rejectRsn;}
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
	public String getDispNo() {return dispNo;}
	public void setDispNo(String dispNo) {this.dispNo = dispNo;}
	public String getElecAprvNo() {return elecAprvNo;}
	public void setElecAprvNo(String elecAprvNo) {this.elecAprvNo = elecAprvNo;}
	public String getLastApvDd() {
		return lastApvDd;
	}
	public void setLastApvDd(String lastApvDd) {
		this.lastApvDd = lastApvDd;
	}
	public String getElecAprvEmpNo() {
		return elecAprvEmpNo;
	}
	public void setElecAprvEmpNo(String elecAprvEmpNo) {
		this.elecAprvEmpNo = elecAprvEmpNo;
	}

	public String getContsSbst() {
		return contsSbst;
	}

	public void setContsSbst(String contsSbst) {
		this.contsSbst = contsSbst;
	}

	public String getExeChnlTypeCd() {
		return exeChnlTypeCd;
	}

	public void setExeChnlTypeCd(String exeChnlTypeCd) {
		this.exeChnlTypeCd = exeChnlTypeCd;
	}
}
