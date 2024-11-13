package com.icignal.common.logging.dto.request;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.common.log.dto.request.ICNLoginHistoryRequestDTO
 * @date : 2019. 01. 28.
 * @author : "dw.keum"
 * @description : 공통 조회조건 이력 Request
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class CondLogHistoryReqDto extends CommonDataAuthReqDto {
	
	
}
