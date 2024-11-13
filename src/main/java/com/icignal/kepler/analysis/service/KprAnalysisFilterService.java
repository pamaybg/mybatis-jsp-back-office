package com.icignal.kepler.analysis.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.external.aws.SecretsManager;
import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonReqDto;
import com.icignal.kepler.analysis.common.service.KprAnalysisCommonSerivce;
import com.icignal.kepler.analysis.common.util.KprAnalysisConstants;
import com.icignal.kepler.analysis.dto.request.KprAnalysisFilterDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisAtribGroupColumnDetailResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisDataResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisDatabaseInfoResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisFilterDetailResDto;
import com.icignal.kepler.common.dto.request.KprCommonCodeReqDto;
import com.icignal.kepler.common.dto.request.KprCommonDateFunctionReqDto;
import com.icignal.kepler.common.dto.response.KprCommonCodeResDto;
import com.icignal.kepler.common.dto.response.KprCommonDateFunctionResDto;


/*
 * 1. 클래스명	: KPRAnalysisFilterService
 * 2. 파일명	: KPRAnalysisFilterService.java
 * 3. 패키지명	: com.icignal.kepler.analysis.service
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Service("KprAnalysisFilterService")
public class KprAnalysisFilterService extends KprAnalysisCommonSerivce{
	
	 /*
	  * 1. 메소드명: getAnalysisFilterBase
	  * 2. 클래스명: KPRAnalysisFilterService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param afr
	 *   @return	
	 */
	public KprAnalysisFilterDetailResDto getAnalysisFilterBase(KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisService.class, afr);

		KprCommonCodeReqDto codeDTO = new KprCommonCodeReqDto();
		codeDTO.setSystemColumn(afr.getSystemColumn());
		codeDTO.setGroupCode(afr.getOperationGroupCode());
		List<KprCommonCodeResDto> codeList = this.kprCommonMapper.getCommCodeList(codeDTO);

		KprAnalysisCommonReqDto atribGroupColumnDTO = new KprAnalysisCommonReqDto();
		atribGroupColumnDTO.setSystemColumn(afr.getSystemColumn());
		atribGroupColumnDTO.setLogicalCompId(afr.getLogicalCompId());
		List<KprAnalysisAtribGroupColumnDetailResDto> atribGroupColumnIdList = this.kprAnalysisMapper.selectAnalysisAtribGroupColumnList(atribGroupColumnDTO);

		KprAnalysisFilterDetailResDto rstValue = new KprAnalysisFilterDetailResDto();
		rstValue.setOperationCodeList(codeList);
		rstValue.setAtribGroupColumnIdList(atribGroupColumnIdList);
		rstValue.setSuccess(true);

		return rstValue;
	}

	 /*
	  * 1. 메소드명: getAnalysisFilterList
	  * 2. 클래스명: KPRAnalysisFilterService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param afr
	 *   @return	
	 */
	public List<KprAnalysisFilterDetailResDto> getAnalysisFilterList(KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisService.class, afr);
		afr.setSVCAlias("arf");
		List<KprAnalysisFilterDetailResDto> filterList = this.kprAnalysisFilterMapper.selectAnalysisFilterList(afr);
		if (ObjectUtil.isNotEmpty(filterList) && filterList.size() > 0) {
			for (KprAnalysisFilterDetailResDto filter : filterList) {
				String operationTypeCode = filter.getOperationTypeCode();
				String filterValue = filter.getFilterValue();
				filterValue = filterValue.replace("'", "");

				if (KprAnalysisConstants.SERC_OPRT_CODE.CUSTDTDEF.name().equals(operationTypeCode)) {
					KprCommonDateFunctionReqDto databaseReqDto = new KprCommonDateFunctionReqDto();
					databaseReqDto.setDatabaseType(CommonUtil.getInstance().getDatabaseType());
					databaseReqDto.setCodeName(filterValue);
					KprCommonDateFunctionResDto dateCodeResDto = this.kprCommonMapper.selectCommonDateCodeDetail(databaseReqDto);

					filter.setFilterValue(dateCodeResDto.getMarkName());
					filter.setCodeValue(dateCodeResDto.getCodeName());
				}
			}
		}

		return filterList;
	}

	 /*
	  * 1. 메소드명: getAnalysisFilterDetailBase
	  * 2. 클래스명: KPRAnalysisFilterService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param afr
	 *   @return	
	 */
	public KprAnalysisFilterDetailResDto getAnalysisFilterDetailBase(KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisService.class, afr);

		KprCommonCodeReqDto codeDTO = new KprCommonCodeReqDto();
		codeDTO.setSystemColumn(afr.getSystemColumn());
		codeDTO.setGroupCode(afr.getGroupFuncCode());
		List<KprCommonCodeResDto> groupFuncCodeList = this.kprCommonMapper.getCommCodeList(codeDTO);

		codeDTO.setGroupCode(afr.getSercOperatorCode());
		List<KprCommonCodeResDto> sercOperatorCodeList = this.kprCommonMapper.getCommCodeList(codeDTO);

		KprAnalysisFilterDetailResDto rstValue = new KprAnalysisFilterDetailResDto();
		rstValue.setGroupFuncCodeList(groupFuncCodeList);
		rstValue.setSercOperatorCodeList(sercOperatorCodeList);
		rstValue.setSuccess(true);

		return rstValue;
	}

	 /*
	  * 1. 메소드명: getAnalysisFilterCheck
	  * 2. 클래스명: KPRAnalysisFilterService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param afr
	 *   @return	
	 */
	public KprAnalysisDataResDto getAnalysisFilterCheck(KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisService.class, afr);

		String groupFuncTypeCode = afr.getGroupFuncTypeCode();
		StringBuilder strWhere = new StringBuilder();
		strWhere.append("\n ")
				.append(" WHERE ")
				.append("0 = 1");

		String operationTypeCode = afr.getOperationTypeCode();
		String filterValue = afr.getFilterValue();
		String andValue = afr.getAndValue();
		String singleQuoteFlag = afr.getSingleQuoteFlag();

		KprAnalysisCommonReqDto databaseReqDto = new KprAnalysisCommonReqDto();
		databaseReqDto.setSystemColumn(afr.getSystemColumn());
		databaseReqDto.setAnalysisId(afr.getAnalysisId());
		databaseReqDto.setAnalysisMasterFlag(afr.getAnalysisMasterFlag());
		databaseReqDto.setAtribGroupColumnId(afr.getAtribGroupColumnId());
		KprAnalysisDatabaseInfoResDto databaseInfo = this.kprAnalysisMapper.selectAnalysisDatabaseInfo(databaseReqDto);
		
		
		if(ObjectUtil.isNotEmpty(databaseInfo.getSecretNm())) {
			
				
		//	BeansUtil.getAWSCredentials()
				Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(), 
						 BeansUtil.getAwsRegion()
						 ).getSecretMap(databaseInfo.getSecretNm());					
				
			//	dbInfoJSON = AWSSecretsManagerConfig.getSecretValueResult(_dbInfo.getSecretNm());
				databaseInfo.setConnectUrl(map.get("url").toString());
				databaseInfo.setConnectId(map.get("username").toString());
				databaseInfo.setConnectPw(map.get("password").toString());
				databaseInfo.setConnectIp(map.get("ip").toString());
				databaseInfo.setConnectPort(map.get("port").toString());
			
			
		}
		
		

		MKTDBInfoDTO databaseConnDto = new MKTDBInfoDTO();
		databaseConnDto.setDriverClassName(databaseInfo.getConnectDatabaseClass());
		databaseConnDto.setConIp(databaseInfo.getConnectIp());
		databaseConnDto.setConPort(databaseInfo.getConnectPort());
		databaseConnDto.setUserName(databaseInfo.getConnectId());
		//databaseConnDto.setPassword(this.encrypor.decrypt(databaseInfo.getConnectPw()));
		databaseConnDto.setPassword(databaseInfo.getConnectPw());
		databaseConnDto.setUrl(databaseInfo.getConnectUrl());
		databaseConnDto.setConDbType(databaseInfo.getConnectDatabaseType());

		if (!(KprAnalysisConstants.SERC_OPRT_CODE.CUSTDTDEF.name().equals(operationTypeCode))) {
			filterValue = filterValue.replaceAll("'", "");
			filterValue = filterValue.replaceAll("\\%", "");
			filterValue = filterValue.replaceAll("\\(", "");
			filterValue = filterValue.replaceAll("\\)", "");

			if (KprAnalysisConstants.SERC_OPRT_CODE.BETWEEN.name().equals(operationTypeCode)) {
				andValue = andValue.replaceAll("'", "");
				andValue = andValue.replaceAll("\\%", "");
				andValue = andValue.replaceAll("\\(", "");
				andValue = andValue.replaceAll("\\)", "");

				if (!("Y".equals(singleQuoteFlag)))
					filterValue = "'" + filterValue + "'" + " AND " + "'" + andValue + "'";
				else
					filterValue = filterValue + " AND " + andValue;
			} else if (KprAnalysisConstants.SERC_OPRT_CODE.IN.name().equals(operationTypeCode) || "NOT IN".equals(operationTypeCode)) {
				String[] valueList = filterValue.split(",");
				filterValue = "";

				for (Integer idx = Integer.valueOf(0); idx.intValue() < valueList.length; idx = Integer.valueOf(idx.intValue() + 1)) {
					String value = valueList[idx.intValue()];
					value = value.trim();

					if (!("Y".equals(singleQuoteFlag)))
						filterValue = filterValue + "'" + value + "'";
					else {
						filterValue = filterValue + value;
					}

					if (idx.intValue() + 1 != valueList.length) {
						filterValue = filterValue + ", ";
					}
				}

				filterValue = " (" + filterValue + ") ";
			} else if (KprAnalysisConstants.SERC_OPRT_CODE.LIKE.name().equals(operationTypeCode)) {
				filterValue = "'%" + filterValue + "%'";
			} else if (!("Y".equals(singleQuoteFlag))) {
				filterValue = "'" + filterValue + "'";
			}
		} else {
			operationTypeCode = " = ";

			String databaseType = databaseInfo.getConnectDatabaseType();
			String codeValue = afr.getCodeValue();
			
			KprCommonDateFunctionReqDto dateFunctionReqDto = new KprCommonDateFunctionReqDto();
			dateFunctionReqDto.setDatabaseType(databaseType);
			dateFunctionReqDto.setCodeName(codeValue);
			KprCommonDateFunctionResDto dateFuncionResDto = this.kprCommonMapper.selectCommonDateCodeDetail(dateFunctionReqDto);

			filterValue = dateFuncionResDto.getDateFunc();
		}

		if (ObjectUtil.isNotEmpty(groupFuncTypeCode)) {
			String groupFuncDetail = null;

			if ("COUNT(DISTINCT)".equals(groupFuncTypeCode))
				groupFuncDetail = "COUNT( DISTINCT " + afr.getAtribGroupColumnAlias() + " )";
			else {
				groupFuncDetail = groupFuncTypeCode + "( " + afr.getAtribGroupColumnAlias() + " )";
			}

			StringBuilder strGroupBy = new StringBuilder();
			strGroupBy.append("\n ")
					  .append("GROUP BY ")
					  .append(afr.getAtribGroupColumnAlias())
					  .append("\n ")
					  .append("HAVING ")
					  .append(groupFuncDetail)
					  .append(" " + operationTypeCode + " ")
					  .append(filterValue);

			afr.setStrGroupBy(strGroupBy.toString());
		} else {
			strWhere.append("\n ");
			strWhere.append(" AND ");
			strWhere.append(afr.getAtribGroupColumnAlias());
			strWhere.append(" " + operationTypeCode + " ");
			strWhere.append(filterValue);
		}

		afr.setStrWhere(strWhere.toString());

		String rstSql = this.kprAnalysisFilterMapper.selectAnalysisFilterCheckSql(afr);
		
		KprAnalysisDataResDto rstValue = new KprAnalysisDataResDto();
		
		rstSql = rstSql.replaceAll("[|]", "");
//			this.mktCallQuery.callSelectObject("selectAnalysisFilterCheck", rstSql.replaceAll("|", "") , new ArrayList<String>(), databaseConnDto, Integer.class);
			this.mktCallQuery.callSelectObject("selectAnalysisFilterCheck", rstSql , new ArrayList<String>(), databaseConnDto, Integer.class);

			rstValue.setFilterValue(filterValue);
			rstValue.setSuccess(true);
		

		return rstValue;
	}

	 /*
	  * 1. 메소드명: saveAnalysisFilterList
	  * 2. 클래스명: KPRAnalysisFilterService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param afr
	 *   @return	
	 */
	@Transactional
	public StatusResDto saveAnalysisFilterList(KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisService.class, afr);
		StatusResDto rstValue = new StatusResDto();

//		startTransaction();

		List<KprAnalysisFilterDetailReqDto> filterList = afr.getFilterList();
		if (ObjectUtil.isNotEmpty(filterList)) {
			for (KprAnalysisFilterDetailReqDto filter : filterList) {
				filter.setEmpId(afr.getEmpId());
				filter.setAnalysisMasterFlag(afr.getAnalysisMasterFlag());

				Integer filterCheck = this.kprAnalysisFilterMapper.selectAnalysisFilterCount(filter);
				String operationTypeCode = filter.getOperationTypeCode();

				if (KprAnalysisConstants.SERC_OPRT_CODE.CUSTDTDEF.name().equals(operationTypeCode)) {
					String codeValue = filter.getCodeValue();
					filter.setFilterValue("'" + codeValue + "'");
				}

				if (filterCheck.intValue() == 0) {
					this.kprAnalysisFilterMapper.insertAnalysisFilterDetailInst(filter);
				} else {
					this.kprAnalysisFilterMapper.updateAnalysisFilterDetailInst(filter);
				}
			}

		}

		this.kprAnalysisFilterMapper.deleteAnalysisFilterDetailInst(afr);

//		commitTransaction();
//		endTransaction();

		rstValue.setSuccess(true);
		return rstValue;
	}


	/*
	  * 1. 메소드명: selectAnalysisFilterIdListInst
	  * 2. 클래스명: KPRAnalysisFilterService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param afr
	 *   @return	
	 */
	public List<String> selectAnalysisFilterIdListInst(KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisService.class, afr);
		afr.setSVCAlias("");

		return this.kprAnalysisFilterMapper.selectAnalysisFilterIdListInst(afr);
	}

//  Deprecated 메소드 주석
//	@Deprecated
//	public KprAnalysisFilterDetailResDto selectAnalysisFilterDefault(KprAnalysisFilterDetailReqDto afr) {
//		LogUtil.param(KPRAnalysisService.class, afr);
//		afr.setSVCAlias("");
//
//		return this.kprAnalysisFilterMapper.selectAnalysisFilterDefault(afr);
//	}


	 /*
	  * 1. 메소드명: insertAnalysisFilterDetailMasterToInst
	  * 2. 클래스명: KPRAnalysisFilterService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param afr
	 *   @return	
	 */
	public StatusResDto insertAnalysisFilterDetailMasterToInst(KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisService.class, afr);
		afr.setSVCAlias("arf");

		StatusResDto rstValue = new StatusResDto();
		this.kprAnalysisFilterMapper.insertAnalysisFilterDetailMasterToInst(afr);
		rstValue.setSuccess(true);

		return rstValue;
	}

	 /*
	  * 1. 메소드명: insertAnalysisFilterDetailInstToMaster
	  * 2. 클래스명: KPRAnalysisFilterService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param afr
	 *   @return	
	 */
	public StatusResDto insertAnalysisFilterDetailInstToMaster(KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisService.class, afr);
		afr.setSVCAlias("arf");

		StatusResDto rstValue = new StatusResDto();
		this.kprAnalysisFilterMapper.insertAnalysisFilterDetailInstToMaster(afr);
		rstValue.setSuccess(true);

		return rstValue;
	}

	 /*
	  * 1. 메소드명: insertAnalysisFilterDetailCopy
	  * 2. 클래스명: KPRAnalysisFilterService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param afr
	 *   @return	
	 */
	public StatusResDto insertAnalysisFilterDetailCopy(KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisService.class, afr);
		afr.setSVCAlias("arf");

		StatusResDto rstValue = new StatusResDto();
		this.kprAnalysisFilterMapper.insertAnalysisFilterDetailCopy(afr);
		rstValue.setSuccess(true);

		return rstValue;
	}


	 /*
	  * 1. 메소드명: updateAnalysisFilterDetailInstToMaster
	  * 2. 클래스명: KPRAnalysisFilterService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param afr
	 *   @return	
	 */
	public StatusResDto updateAnalysisFilterDetailInstToMaster(KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisService.class, afr);
		afr.setSVCAlias("arf");

		StatusResDto rstValue = new StatusResDto();
		this.kprAnalysisFilterMapper.updateAnalysisFilterDetailInstToMaster(afr);
		rstValue.setSuccess(true);

		return rstValue;
	}

	 /*
	  * 1. 메소드명: deleteAnalysisFilterDetailMaster
	  * 2. 클래스명: KPRAnalysisFilterService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param afr
	 *   @return	
	 */
	public StatusResDto deleteAnalysisFilterDetailMaster(KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisService.class, afr);
		afr.setSVCAlias("arf");

		StatusResDto rstValue = new StatusResDto();
		this.kprAnalysisFilterMapper.deleteAnalysisFilterDetailMaster(afr);
		rstValue.setSuccess(true);

		return rstValue;
	}

	 /*
	  * 1. 메소드명: deleteAnalysisFilterListInst
	  * 2. 클래스명: KPRAnalysisFilterService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param afr
	 *   @return	
	 */
	public StatusResDto deleteAnalysisFilterListInst(KprAnalysisFilterDetailReqDto afr) {
		LogUtil.param(KprAnalysisService.class, afr);
		afr.setSVCAlias("arf");

		StatusResDto rstValue = new StatusResDto();
		this.kprAnalysisFilterMapper.deleteAnalysisFilterListInst(afr);
		rstValue.setSuccess(true);

		return rstValue;
	}

}