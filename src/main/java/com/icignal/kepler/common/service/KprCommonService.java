package com.icignal.kepler.common.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.component.Messages;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.external.aws.SecretsManager;
import com.icignal.kepler.common.dto.request.KprAnalysisModifyCheckReqDto;
import com.icignal.kepler.common.dto.request.KprAnalysisSetupPropertyReqDto;
import com.icignal.kepler.common.dto.request.KprCommonAttributeGroupListReqDto;
import com.icignal.kepler.common.dto.request.KprCommonColumnReqDto;
import com.icignal.kepler.common.dto.request.KprCommonDateFunctionReqDto;
import com.icignal.kepler.common.dto.request.KprCommonLogicalComponentListReqDto;
import com.icignal.kepler.common.dto.request.KprNodeDetailReqDto;
import com.icignal.kepler.common.dto.request.KprNodeListReqDto;
import com.icignal.kepler.common.dto.response.KprAnalysisColumnItemResDto;
import com.icignal.kepler.common.dto.response.KprAnalysisModifyCheckResDto;
import com.icignal.kepler.common.dto.response.KprAnalysisPromptItemResDto;
import com.icignal.kepler.common.dto.response.KprCommonAttributeGroupListResDto;
import com.icignal.kepler.common.dto.response.KprCommonColumnResDto;
import com.icignal.kepler.common.dto.response.KprCommonDateFunctionResDto;
import com.icignal.kepler.common.dto.response.KprCommonLogicalComponentListResDto;
import com.icignal.kepler.common.dto.response.KprNodeListResDto;
import com.icignal.kepler.common.mapper.KprCommonMapper;


/*
 * 1. 클래스명	: KPRCommonService
 * 2. 파일명	: KPRCommonService.java
 * 3. 패키지명	: com.icignal.kepler.common.service
 * 4. 작성자명	: 류동균
 * 5. 작성일자	: 2015. 9. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *	
 * </PRE>
 */ 
@Service("KprCommonService")
public class KprCommonService {
	
	@Autowired
	private KprCommonMapper kprCommonMapper;

	// @Autowired
	// private IMKTCommonDAO mktCommonDAO;

	@Autowired
	StandardPBEStringEncryptor encrypor;

	@Autowired
	private MKTCallQueryDao mktCallQueryDao;

	private enum ANL_PRMT_TYPE_CD {
		LIST_BOX, DATE, DATE_BETWEEN
	}

	 /*
	  * 1. 메소드명: getLogicalComponentTreeList
	  * 2. 클래스명: KPRCommonService
	  * 3. 작성자명: 류동균 
	  * 4. 작성일자: 2016. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 트리 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param caglr
	 *   @return	
	 */
	public List<KprCommonAttributeGroupListResDto> getLogicalComponentTreeList(KprCommonAttributeGroupListReqDto caglr) {
		LogUtil.param(KprCommonService.class, caglr);
		caglr.setSVCAlias("g");
		List<KprCommonAttributeGroupListResDto> rtnList = new ArrayList<KprCommonAttributeGroupListResDto>();

		// 어트리뷰트그룹 목록 조회
		rtnList = kprCommonMapper.selectAttributeGroupList(caglr);
		
		// 어트리뷰트그룹컬럼 목록 조회
		for (KprCommonAttributeGroupListResDto atribGroup : rtnList) {
			caglr.setAtribGroupId(atribGroup.getId());
			caglr.setSVCAlias("ac");
			// 어트리뷰트그룹컬럼 목록 조회
			atribGroup.setTreeList(kprCommonMapper.selectAttributeGroupColumnList(caglr));
		}

		return rtnList;
	}

	 /*
	  * 1. 메소드명: getCommonLogicalComponentList
	  * 2. 클래스명: KPRCommonService
	  * 3. 작성자명: 류동균
	  * 4. 작성일자: 2016. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공통 로지컬 컴포넌트 목록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param clclr
	 *   @table : anl.anl_lgc_comp_mst, com.employee
	 *   @return	
	 */
	public GridPagingResDto<KprCommonLogicalComponentListResDto> getCommonLogicalComponentList(KprCommonLogicalComponentListReqDto clclr) {
		LogUtil.param(KprCommonService.class, clclr);
		clclr.setSVCAlias("l");
		return new GridPagingResHelper<KprCommonLogicalComponentListResDto>().newGridPagingResDto(
				clclr.init(CommonUtil.getInstance().getDBType()), kprCommonMapper.selectCommonLogicalComponentList(clclr));
	}

	 /*
	  * 1. 메소드명: getCommonDateCodeList
	  * 2. 클래스명: KPRCommonService
	  * 3. 작성자명: KioLee 
	  * 4. 작성일자: 2016. 9. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		날짜 공통 코드 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param ccr
	 *   @return	
	 */
	public GridPagingResDto<KprCommonDateFunctionResDto> getCommonDateCodeList(KprCommonDateFunctionReqDto ccr) {
		LogUtil.param(KprCommonService.class, ccr);

		ccr.setDatabaseType(CommonUtil.getInstance().getDatabaseType());
		GridPagingResDto<KprCommonDateFunctionResDto> rstValue = new GridPagingResHelper<KprCommonDateFunctionResDto>().newGridPagingResDto(
				ccr.init(CommonUtil.getInstance().getDBType()), kprCommonMapper.selectCommonDateCodeGridList(ccr));
		List<KprCommonDateFunctionResDto> rows = rstValue.getRows();

		for (Object row : rows) {
			KprCommonDateFunctionResDto thisObj = (KprCommonDateFunctionResDto) row;
			String paramValue = thisObj.getDateFunc();
			String funcValue = null;

			if (ObjectUtil.isNotEmpty(paramValue)) {
				funcValue = kprCommonMapper.selectCommonDateCodeValue(paramValue);
			}

			thisObj.setFuncValue(funcValue);
		}

		return rstValue;
	}

	 /*
	  * 1. 메소드명: getNodeList
	  * 2. 클래스명: KPRCommonService
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		폴더 및 분석 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param nlr
	 *   @return	
	 */
	public KprNodeListResDto getNodeList(KprNodeListReqDto nlr) {
		LogUtil.param(KprCommonService.class, nlr);
		nlr.setSVCAlias("");
		List<KprNodeListResDto> nodeList = kprCommonMapper.selectNodeList(nlr);

		KprNodeListResDto rstValue = new KprNodeListResDto();
		rstValue.setNodeList(nodeList);

		return rstValue;
	}

	 /*
	  * 1. 메소드명: addFolder
	  * 2. 클래스명: KPRCommonService
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		퐅더 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param nlr
	 *   @return	
	 */
	public StatusResDto addFolder(KprNodeDetailReqDto nlr) {
		LogUtil.param(KprCommonService.class, nlr);
		nlr.setSVCAlias("");
		StatusResDto rstValue = new StatusResDto();
		kprCommonMapper.insertFolder(nlr);
		rstValue.setSuccess(true);

		return rstValue;
	}

	 /*
	  * 1. 메소드명: editFolder
	  * 2. 클래스명: KPRCommonService
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		퐅더 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param nlr
	 *   @return	
	 */
	public StatusResDto editFolder(KprNodeDetailReqDto nlr) {
		LogUtil.param(KprCommonService.class, nlr);
		nlr.setSVCAlias("");
		StatusResDto rtnValue = new StatusResDto();
		kprCommonMapper.updateFolder(nlr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeFolder
	  * 2. 클래스명: KPRCommonService
	  * 3. 작성자명: KioLee 
	  * 4. 작성일자: 2016. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		퐅더 삭제( 논리 삭제 )
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param nlr
	 *   @return	
	 */
	public StatusResDto removeFolder(KprNodeDetailReqDto nlr) {
		LogUtil.param(KprCommonService.class, nlr);
		nlr.setSVCAlias("asi");
		Integer folderDeletableFlag = kprCommonMapper.selectFolderDeletableCheck(nlr);

		StatusResDto rstValue = new StatusResDto();

		if (folderDeletableFlag == 1) {
			nlr.setSVCAlias("");
			kprCommonMapper.deleteFolder(nlr);
			rstValue.setSuccess(true);
		} else {
			rstValue.setSuccess(false);
			rstValue.setMessage(Messages.getMessage("M01644", nlr.getLang()));
		}

		return rstValue;
	}

	 /*
	  * 1. 메소드명: getAnalysisModifyCheck
	  * 2. 클래스명: KPRCommonService
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 9. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		분석/대시보드 수정 가능여부 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param acr
	 *   @return	
	 */
	public KprAnalysisModifyCheckResDto getAnalysisModifyCheck(KprAnalysisModifyCheckReqDto acr) {
		LogUtil.param(KprCommonService.class, acr);
		KprAnalysisModifyCheckResDto resDto = new KprAnalysisModifyCheckResDto();
		acr.setSVCAlias("arm");
		// 생성자 체크, 동일 유저라면 수정 내역이 있는지 확인
		Integer createrCheckValue = kprCommonMapper.selectAnalysisCreaterCheck(acr);
		if (createrCheckValue == 1) {
			Integer analysisModifyCheckValue = kprCommonMapper.selectAnalysisModifyCheck(acr);

			resDto.setCreaterFlag(true);
			if (analysisModifyCheckValue > 0) {
				resDto.setMessage(Messages.getMessage("M01543", acr.getLang()));
			}
		} else {
			resDto.setCreaterFlag(false);
		}

		resDto.setSuccess(true);
		return resDto;
	}

	 /*
	  * 1. 메소드명: getAnalysisSetupColumnList
	  * 2. 클래스명: KPRCommonService
	  * 3. 작성자명: kj.kang 
	  * 4. 작성일자: 2016. 8. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		분석에서 그룹 컬럼 체크 시 해당 분석의 컬럼 영역에 있는 Dimension 리스트를 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public List<KprAnalysisColumnItemResDto> getAnalysisSetupColumnList(KprAnalysisSetupPropertyReqDto reqDto) {
		LogUtil.param(KprCommonService.class, reqDto);
		reqDto.setSVCAlias("");
		return kprCommonMapper.selectAnalysisSetupColumnList(reqDto);
	}

	 /*
	  * 1. 메소드명: getAnalysisSetupPromptList
	  * 2. 클래스명: KPRCommonService
	  * 3. 작성자명: kj.kang
	  * 4. 작성일자: 2016. 8. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		분석에서 프롬프트 설정 시 해당 분석의 프롬프트 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	@SuppressWarnings("unchecked")
	public List<KprAnalysisPromptItemResDto> getAnalysisSetupPromptList(KprAnalysisSetupPropertyReqDto reqDto) {
		LogUtil.param(KprCommonService.class, reqDto);
		reqDto.setSVCAlias("");
		List<KprAnalysisPromptItemResDto> promptList = kprCommonMapper.selectAnalysisSetupPromptList(reqDto);
		List<KprAnalysisPromptItemResDto> rstList = new ArrayList<KprAnalysisPromptItemResDto>();

		MKTDBInfoDTO dbInfo;
		StringBuilder dimensionSql;
		if (ObjectUtil.isNotEmpty(promptList)) {
			for (KprAnalysisPromptItemResDto promptDto : promptList) {
				String promptType = promptDto.getPromptTypeCode();
				List<KprAnalysisPromptItemResDto> promptValueList = null;

				if (ANL_PRMT_TYPE_CD.LIST_BOX.name().equals(promptType)) {
					dbInfo = new MKTDBInfoDTO();
					dbInfo.setDriverClassName(promptDto.getConnectDatabaseClass());
					dbInfo.setConIp(promptDto.getConnectIp());
					dbInfo.setConPort(promptDto.getConnectPort());
					dbInfo.setUserName(promptDto.getConnectId());
					dbInfo.setPassword(encrypor.decrypt(promptDto.getConnectPw()));
					dbInfo.setUrl(promptDto.getConnectUrl());
					dbInfo.setConDbType(promptDto.getConnectDatabaseType());

					dimensionSql = new StringBuilder();
					dimensionSql.append("\n	SELECT	DISTINCT " + promptDto.getColumnName() + "	AS	\"promptValue\"");
					dimensionSql.append("\n FROM	" + promptDto.getTableSchemaName() + "." + promptDto.getTableName());
					dimensionSql.append("\n ORDER BY 1");

					promptValueList = mktCallQueryDao.callSelectForList("getAnalysisSetupPromptValueList", dimensionSql.toString(), new ArrayList<String>(), dbInfo, KprAnalysisPromptItemResDto.class);
				}

				KprAnalysisPromptItemResDto rstDto = new KprAnalysisPromptItemResDto();
				rstDto.setAnalysisId(promptDto.getAnalysisId());
				rstDto.setPromptId(promptDto.getPromptId());
				rstDto.setPromptValue(promptDto.getPromptValue());
				rstDto.setPromptAlias(promptDto.getPromptAlias());
				rstDto.setAtribGroupColumnId(promptDto.getAtribGroupColumnId());
				rstDto.setAtribGroupColumnName(promptDto.getAtribGroupColumnName());
				rstDto.setPromptTypeCode(promptDto.getPromptTypeCode());
				rstDto.setPromptValueList(promptValueList);
				rstDto.setTableAliasColumnName(promptDto.getTableAliasColumnName());

				rstList.add(rstDto);
			}
		}

		return rstList;
	}

	 /*
	  * 1. 메소드명: getCommonColumnValueList
	  * 2. 클래스명: KPRCommonService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2016. 8. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	@SuppressWarnings("unchecked")
	public GridPagingResDto<Object> getCommonColumnValueList(KprCommonColumnReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");
		KprCommonColumnResDto valueDetailDto = this.kprCommonMapper.selectCommonColumnValueDetail(reqDto);
		
		if(ObjectUtil.isNotEmpty(valueDetailDto.getSecretNm())) {
			try {
				
		//	BeansUtil.getAWSCredentials()
				Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(), 
						 BeansUtil.getAwsRegion()
						 ).getSecretMap(valueDetailDto.getSecretNm());					
				
			//	dbInfoJSON = AWSSecretsManagerConfig.getSecretValueResult(_dbInfo.getSecretNm());
				valueDetailDto.setConnectUrl(map.get("url").toString());
				valueDetailDto.setConnectId(map.get("username").toString());
				valueDetailDto.setConnectPw(map.get("password").toString());
				valueDetailDto.setConnectIp(map.get("ip").toString());
				valueDetailDto.setConnectPort(map.get("port").toString());
			
			} catch(ArithmeticException e) {
				LogUtil.error(e.getMessage());
			}
		}
		
		
		MKTDBInfoDTO databaseInfo = new MKTDBInfoDTO();
		databaseInfo.setDriverClassName(valueDetailDto.getConnectDatabaseClass());
		databaseInfo.setConIp(valueDetailDto.getConnectIp());
		databaseInfo.setConPort(valueDetailDto.getConnectPort());
		databaseInfo.setUserName(valueDetailDto.getConnectId());
		//databaseInfo.setPassword(this.encrypor.decrypt(valueDetailDto.getConnectPw()));
		databaseInfo.setPassword(valueDetailDto.getConnectPw());
		databaseInfo.setUrl(valueDetailDto.getConnectUrl());
		databaseInfo.setConDbType(valueDetailDto.getConnectDatabaseType());

		StringBuilder valueGridListSQL = new StringBuilder();
		valueGridListSQL.append("select " + valueDetailDto.getColumnName() + " as \"colValue\"\n")
						.append("  from " + valueDetailDto.getSchemaName() + "." + valueDetailDto.getTableName() + "\n")
						.append(" where 1=1\n");
		
		String upperColumnId = reqDto.getUpperColumnId();
		if (ObjectUtil.isNotEmpty(upperColumnId)) {
			KprCommonColumnReqDto upperValueDetailReqDto = new KprCommonColumnReqDto();
			upperValueDetailReqDto.setColumnId(upperColumnId);
			KprCommonColumnResDto upperValueDetailResDto = this.kprCommonMapper.selectCommonColumnValueDetail(upperValueDetailReqDto);
			
			valueGridListSQL.append("   and " + upperValueDetailResDto.getColumnName() + " = '" + reqDto.getConditionValue() + "'\n");
		}

		String tableName = reqDto.getTableName();	//d_branch, d_station_region
		String columnName = reqDto.getColumnName();	//branch_nm, station_nm
		
		if ("d_branch".equals(tableName) && ("branch_nm".equals(columnName) || "brancd_cd".equals(columnName))){
				valueGridListSQL.append("   and branch_cd = '" + reqDto.getBranchCode() + "'\n");
		}
		
		if ("d_station_region".equals(tableName)){
			if(("station_nm".equals(columnName) || "station_cd".equals(columnName)) && reqDto.getStationCode() != null && !reqDto.getStationCode().isEmpty()){
				valueGridListSQL.append("   and station_cd = '" + reqDto.getStationCode() + "'\n");
			}
			if(("branch_nm".equals(columnName) || "brancd_cd".equals(columnName)) && reqDto.getBranchCode() != null && !reqDto.getBranchCode().isEmpty()){
				valueGridListSQL.append("   and branch_cd = '" + reqDto.getBranchCode() + "'\n");
			}
		}
		
		valueGridListSQL.append(" group by " + valueDetailDto.getColumnName() + "\n")
						.append(" order by " + valueDetailDto.getColumnName() + "\n");

		if (!reqDto.getPagingFlag()) {
			KprCommonColumnResDto resDto = new KprCommonColumnResDto();
			resDto.setSuccess(true);
			resDto.setRows(this.mktCallQueryDao.callSelectForList("KprCommonMapper.selectCommonColumnValueGridList", valueGridListSQL.toString(), new ArrayList<String>(), databaseInfo, String.class));
			return resDto;
		} else {
			return this.mktCallQueryDao.callSelectForGridList("KprCommonMapper.selectCommonColumnValueGridList", valueGridListSQL.toString(), new ArrayList<String>(), databaseInfo, reqDto);
		}

	}
}
