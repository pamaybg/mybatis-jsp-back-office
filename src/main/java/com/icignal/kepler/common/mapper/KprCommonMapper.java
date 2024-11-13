package com.icignal.kepler.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.common.dto.request.KprAnalysisModifyCheckReqDto;
import com.icignal.kepler.common.dto.request.KprAnalysisSetupPropertyReqDto;
import com.icignal.kepler.common.dto.request.KprCommonAttributeGroupListReqDto;
import com.icignal.kepler.common.dto.request.KprCommonCodeReqDto;
import com.icignal.kepler.common.dto.request.KprCommonColumnReqDto;
import com.icignal.kepler.common.dto.request.KprCommonDateFunctionReqDto;
import com.icignal.kepler.common.dto.request.KprCommonLogicalComponentListReqDto;
import com.icignal.kepler.common.dto.request.KprNodeDetailReqDto;
import com.icignal.kepler.common.dto.request.KprNodeListReqDto;
import com.icignal.kepler.common.dto.response.KprAnalysisColumnItemResDto;
import com.icignal.kepler.common.dto.response.KprAnalysisPromptItemResDto;
import com.icignal.kepler.common.dto.response.KprCommonAttributeGroupColumnListResDto;
import com.icignal.kepler.common.dto.response.KprCommonAttributeGroupListResDto;
import com.icignal.kepler.common.dto.response.KprCommonCodeResDto;
import com.icignal.kepler.common.dto.response.KprCommonColumnResDto;
import com.icignal.kepler.common.dto.response.KprCommonDateFunctionResDto;
import com.icignal.kepler.common.dto.response.KprCommonLogicalComponentListResDto;
import com.icignal.kepler.common.dto.response.KprNodeListResDto;

/*
 * 1. 클래스명	: KprCommonMapper
 * 2. 파일명	: KprCommonMapper.java
 * 3. 패키지명	: com.icignal.kepler.common.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 

@Mapper
public interface KprCommonMapper {

	Integer selectAnalysisModifyCheck(KprAnalysisModifyCheckReqDto modifyReqDto);

	List<KprCommonCodeResDto> getCommCodeList(KprCommonCodeReqDto langCodeReqDto);

	KprCommonDateFunctionResDto selectCommonDateCodeDetail(KprCommonDateFunctionReqDto dateFunctionReqDto);

	List<KprCommonAttributeGroupListResDto> selectAttributeGroupList(KprCommonAttributeGroupListReqDto caglr);

	List<KprCommonAttributeGroupColumnListResDto> selectAttributeGroupColumnList(KprCommonAttributeGroupListReqDto caglr);

	List<KprCommonLogicalComponentListResDto> selectCommonLogicalComponentList(KprCommonLogicalComponentListReqDto clclr);

	List<KprCommonDateFunctionResDto> selectCommonDateCodeGridList(KprCommonDateFunctionReqDto ccr);

	String selectCommonDateCodeValue(String paramValue);

	List<KprNodeListResDto> selectNodeList(KprNodeListReqDto nlr);

	void insertFolder(KprNodeDetailReqDto nlr);

	void updateFolder(KprNodeDetailReqDto nlr);

	Integer selectFolderDeletableCheck(KprNodeDetailReqDto nlr);

	void deleteFolder(KprNodeDetailReqDto nlr);

	Integer selectAnalysisCreaterCheck(KprAnalysisModifyCheckReqDto acr);

	List<KprAnalysisColumnItemResDto> selectAnalysisSetupColumnList(KprAnalysisSetupPropertyReqDto reqDto);

	List<KprAnalysisPromptItemResDto> selectAnalysisSetupPromptList(KprAnalysisSetupPropertyReqDto reqDto);

	KprCommonColumnResDto selectCommonColumnValueDetail(KprCommonColumnReqDto reqDto);

	KprCommonCodeResDto getCommCodeDetail(KprCommonCodeReqDto ccr);

}
