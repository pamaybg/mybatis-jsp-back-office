package com.icignal.systemmanagement.authgroup.dto.response;

import java.io.Serializable;

public class AuthorityDataListResDto  implements Serializable {
	
	private static final long serialVersionUID = 455712398262641542L;
	
	private String accountName;		//어카운트명
	private String dataTypeCd;		//데이터유형코드

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getDataTypeCd() {
		return dataTypeCd;
	}

	public void setDataTypeCd(String dataTypeCd) {
		this.dataTypeCd = dataTypeCd;
	}
	
}
