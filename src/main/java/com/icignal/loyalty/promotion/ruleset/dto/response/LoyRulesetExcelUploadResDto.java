package com.icignal.loyalty.promotion.ruleset.dto.response;

import java.util.HashMap;
import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
* @name : infavor.loyalty.ruleSet.dto.response.LOYRulesetExcelUploadResponseDTO
* @date : 2018. 10. 12.
* @author : hy.jun
* @description : 룰셋 채널 엑셀 일괄업로드 응답
*/
public class LoyRulesetExcelUploadResDto extends GridPagingItemResDto {
	private List<HashMap<String,String>> channelList;
	private int allUploadCnt;
	private int successCnt;
	private int failCnt;
	private String fileName;

	/**
	 * validation 체크 후 파일 업로드 실패사유
	 *
	 * EXT  : 확장자 오류
	 * SIZE : 파일 용량 초과
	 *
	 */
    private boolean success;

	public List<HashMap<String, String>> getChannelList() {
		return channelList;
	}

	public void setChannelList(List<HashMap<String, String>> channelList) {
		this.channelList = channelList;
	}

	public int getAllUploadCnt() {
		return allUploadCnt;
	}

	public void setAllUploadCnt(int allUploadCnt) {
		this.allUploadCnt = allUploadCnt;
	}

	public int getSuccessCnt() {
		return successCnt;
	}

	public void setSuccessCnt(int successCnt) {
		this.successCnt = successCnt;
	}

	public int getFailCnt() {
		return failCnt;
	}

	public void setFailCnt(int failCnt) {
		this.failCnt = failCnt;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}
}
