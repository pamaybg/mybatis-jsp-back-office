package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;
@PersonalData
@CommCode
public class KprReportEmpPntResDto extends GridPagingItemResDto{
	@Decrypted(masked = "none")
	private String custNm;
	private String ofrNm;
	private String empNo;
	private String companyNm;
	private String chnlTypeCd;
	private String chnlType;
	private String chnlNo;
	private String chnlNm;
	private String txnDtlType;
	@MarkName(groupCode = "PNT_TXN_DTL_TYPE", codeField = "txnDtlType")
	private String txnDtlTypeNm;
	private String teamNm;
	private String a1;
	private String b1;
	private String b2;
	private String b3;
	private String c1;
	private String c2;
	private String c3;
	private String c4;
	private String d1;
	private String d2;
	private String d3;
	private String e1;
	private String e2;
	private String e3;
	private String e4;
	private String ridMbr;
	private String ridOfr;
	private String A1_SUM;
	private String B1_SUM;
	private String B2_SUM;
	private String B3_SUM;
	private String C1_SUM;
	private String C2_SUM;
	private String C3_SUM;
	private String C4_SUM;
	private String D1_SUM;
	private String D2_SUM;
	private String D3_SUM;
	private String E1_SUM;
	private String E2_SUM;
	private String E3_SUM;
	private String E4_SUM;
	private String txnDt;
	private String txnDesc;
	private String rceptNo;

private String parRceptNo;
	

	public String getE2_SUM() {
	return E2_SUM;
}
public void setE2_SUM(String e2_SUM) {
	E2_SUM = e2_SUM;
}
public String getE3_SUM() {
	return E3_SUM;
}
public void setE3_SUM(String e3_SUM) {
	E3_SUM = e3_SUM;
}
public String getE4_SUM() {
	return E4_SUM;
}
public void setE4_SUM(String e4_SUM) {
	E4_SUM = e4_SUM;
}
	public String getE4() {
	return e4;
}
public void setE4(String e4) {
	this.e4 = e4;
}
	public String getE2() {
	return e2;
}
public void setE2(String e2) {
	this.e2 = e2;
}
public String getE3() {
	return e3;
}
public void setE3(String e3) {
	this.e3 = e3;
}
	public String getC1_SUM() {
		return C1_SUM;
	}
	public void setC1_SUM(String c1_SUM) {
		C1_SUM = c1_SUM;
	}
	public String getC2_SUM() {
		return C2_SUM;
	}
	public void setC2_SUM(String c2_SUM) {
		C2_SUM = c2_SUM;
	}
	public String getC3_SUM() {
		return C3_SUM;
	}
	public void setC3_SUM(String c3_SUM) {
		C3_SUM = c3_SUM;
	}
	public String getC4_SUM() {
		return C4_SUM;
	}
	public void setC4_SUM(String c4_SUM) {
		C4_SUM = c4_SUM;
	}
	public String getD1_SUM() {
		return D1_SUM;
	}
	public void setD1_SUM(String d1_SUM) {
		D1_SUM = d1_SUM;
	}
	public String getD2_SUM() {
		return D2_SUM;
	}
	public void setD2_SUM(String d2_SUM) {
		D2_SUM = d2_SUM;
	}
	public String getD3_SUM() {
		return D3_SUM;
	}
	public void setD3_SUM(String d3_SUM) {
		D3_SUM = d3_SUM;
	}
	public String getA1_SUM() {
		return A1_SUM;
	}
	public void setA1_SUM(String a1_SUM) {
		A1_SUM = a1_SUM;
	}
	public String getB1_SUM() {
		return B1_SUM;
	}
	public void setB1_SUM(String b1_SUM) {
		B1_SUM = b1_SUM;
	}
	public String getB2_SUM() {
		return B2_SUM;
	}
	public void setB2_SUM(String b2_SUM) {
		B2_SUM = b2_SUM;
	}
	public String getB3_SUM() {
		return B3_SUM;
	}
	public void setB3_SUM(String b3_SUM) {
		B3_SUM = b3_SUM;
	}
	
	
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getCompanyNm() {
		return companyNm;
	}
	public void setCompanyNm(String companyNm) {
		this.companyNm = companyNm;
	}

	public String getChnlTypeCd() {
		return chnlTypeCd;
	}
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}
	public String getChnlType() {
		return chnlType;
	}
	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}

	public String getA1() {
		return a1;
	}
	public void setA1(String a1) {
		this.a1 = a1;
	}
	public String getB1() {
		return b1;
	}
	public void setB1(String b1) {
		this.b1 = b1;
	}
	public String getB2() {
		return b2;
	}
	public void setB2(String b2) {
		this.b2 = b2;
	}
	public String getB3() {
		return b3;
	}
	public void setB3(String b3) {
		this.b3 = b3;
	}
	public String getC1() {
		return c1;
	}
	public void setC1(String c1) {
		this.c1 = c1;
	}
	public String getC2() {
		return c2;
	}
	public void setC2(String c2) {
		this.c2 = c2;
	}
	public String getC3() {
		return c3;
	}
	public void setC3(String c3) {
		this.c3 = c3;
	}
	public String getC4() {
		return c4;
	}
	public void setC4(String c4) {
		this.c4 = c4;
	}
	public String getD1() {
		return d1;
	}
	public void setD1(String d1) {
		this.d1 = d1;
	}
	public String getD2() {
		return d2;
	}
	public void setD2(String d2) {
		this.d2 = d2;
	}
	public String getD3() {
		return d3;
	}
	public void setD3(String d3) {
		this.d3 = d3;
	}
	public String getE1() {
		return e1;
	}
	public void setE1(String e1) {
		this.e1 = e1;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getE1_SUM() {
		return E1_SUM;
	}
	public void setE1_SUM(String e1_SUM) {
		E1_SUM = e1_SUM;
	}
	public String getTeamNm() {
		return teamNm;
	}
	public void setTeamNm(String teamNm) {
		this.teamNm = teamNm;
	}
	public String getTxnDtlType() {
		return txnDtlType;
	}
	public void setTxnDtlType(String txnDtlType) {
		this.txnDtlType = txnDtlType;
	}
	public String getTxnDtlTypeNm() {
		return txnDtlTypeNm;
	}
	public void setTxnDtlTypeNm(String txnDtlTypeNm) {
		this.txnDtlTypeNm = txnDtlTypeNm;
	}
	public String getTxnDt() {
		return txnDt;
	}
	public void setTxnDt(String txnDt) {
		this.txnDt = txnDt;
	}
	public String getTxnDesc() {
		return txnDesc;
	}
	public void setTxnDesc(String txnDesc) {
		this.txnDesc = txnDesc;
	}
	public String getRceptNo() {
		return rceptNo;
	}
	public void setRceptNo(String rceptNo) {
		this.rceptNo = rceptNo;
	}
	public String getParRceptNo() {
		return parRceptNo;
	}
	public void setParRceptNo(String parRceptNo) {
		this.parRceptNo = parRceptNo;
	}

}
