package com.icignal.kepler.analysis.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;


/*
 * 1. 클래스명	: KPRAnalysisListRequestDTO
 * 2. 파일명	: KPRAnalysisListRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.analysis.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprAnalysisListReqDto extends MKTGridPagingReqDto {
	
	private String nodeId;
	private String analysisMasterFlag;

	public String getNodeId() {
		return this.nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getAnalysisMasterFlag() {
		return this.analysisMasterFlag;
	}

	public void setAnalysisMasterFlag(String analysisMasterFlag) {
		this.analysisMasterFlag = analysisMasterFlag;
	}
}