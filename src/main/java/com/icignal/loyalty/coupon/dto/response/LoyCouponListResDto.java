package com.icignal.loyalty.coupon.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;

/**
 *
* <pre>
* infavor.loyalty.simulation.dto.response
*  |_ LOYChnlComboResponseDTO.java
* </pre>
* @작성일		: 2017. 1. 11.
* @작성자		: wjlee
* @프로그램설명	:
 */
@CommCode
public class LoyCouponListResDto extends GridPagingItemResDto{

	private String rid;
	private String filePath;
	private String fileName;
	private String createDate;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}


}
