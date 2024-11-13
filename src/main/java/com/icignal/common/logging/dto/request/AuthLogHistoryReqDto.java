package com.icignal.common.logging.dto.request;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.common.log.dto.request.ICNLoginHistoryRequestDTO
 * @date : 2019. 01. 28.
 * @author : "dw.keum"
 * @description : 권한 변경 이력 조회 Request
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class AuthLogHistoryReqDto extends CommonDataAuthReqDto {
	
	

}
