package com.icignal.loyalty.operationpolicymgt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.operationpolicymgt.dto.request.OperationPolicyDetailReqDto;
import com.icignal.loyalty.operationpolicymgt.dto.request.OperationPolicyReqDto;
import com.icignal.loyalty.operationpolicymgt.dto.response.OperationPolicyDetailResDto;
import com.icignal.loyalty.operationpolicymgt.dto.response.OperationPolicyResDto;
//import com.icignal.loyalty.operationpolicymgt.service.countSameAttrCd;

/*
 * 1. 클래스명	: OperationPolicyMgtMapper
 * 2. 파일명	: OperationPolicyMgtMapper.java
 * 3. 패키지명	: com.icignal.loyalty.operationpolicymgt.mapper
 * 4. 작성자명	: jb.kim
 * 5. 작성일자	: 2020. 12. 18.
 */
/**
 * <PRE>
 * 1. 설명
 *	: '프로그램 정책 - 운영정책관리' 에서 리스트들의 내용 조회 mapper
 * </PRE>
 */


@Mapper
public interface OperationPolicyMgtMapper {

	public List<OperationPolicyResDto> getOperationPolicyList(OperationPolicyReqDto opDto);
	
	public List<OperationPolicyDetailResDto> getOperationPolicyDetail1(OperationPolicyDetailReqDto opdDto);
	public List<OperationPolicyDetailResDto> getOperationPolicyDetail2(OperationPolicyDetailReqDto opdDto);

	public void addOperationPolicy(OperationPolicyReqDto opDto);
	public void updateOperationPolicy(OperationPolicyReqDto opDto);
	public void deleteOperationPolicy(OperationPolicyReqDto opDto);
	public int checkOperationPolicyDtl(OperationPolicyReqDto opDto);
	public void deleteOperationPolicyDtl(OperationPolicyReqDto opDto);

	public OperationPolicyResDto getOperationPolicyPop(OperationPolicyReqDto opDto);
	
	public List<OperationPolicyDetailResDto> selectOprDtlHist(OperationPolicyDetailReqDto opdDto);
	
	public void addOperationPolicyDetail(OperationPolicyDetailReqDto opDto);
	
	public OperationPolicyDetailResDto getOprPlcyDetailBeforeUpdate(OperationPolicyDetailReqDto opdDto);
	
	public void updateOperationPolicyDetail(OperationPolicyDetailReqDto opDto);
	
	public void deleteOperationPolicyDetail(OperationPolicyDetailReqDto opDto);
	
	public void addOperationPolicyDetailHist(OperationPolicyDetailReqDto opDto);
	
	public int checkAttrCdSingleValYn(OperationPolicyDetailReqDto opDto);
	
	public int countSameAttrCd(OperationPolicyDetailReqDto opDto);
	public int countSameAttrCdYes(OperationPolicyDetailReqDto opDto);
	
	public String getTheRecordRid(OperationPolicyDetailReqDto opDto);
	
	/*public int countSameAttrCdRecord(OperationPolicyDetailReqDto opDto);
	public void updateAllSingleValYnToN(OperationPolicyDetailReqDto opDto);*/
	
	
}
