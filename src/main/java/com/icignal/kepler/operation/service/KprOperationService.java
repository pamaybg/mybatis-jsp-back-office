/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemOperationService.java
 * 2. Package	: com.icignal.systemmanagement.operation.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 12. 오전 11:48:39
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 12.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */

package com.icignal.kepler.operation.service;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.icignal.common.base.service.EnDeCryptedService;
import com.icignal.common.util.*;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.core.component.Messages;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.external.aws.SecretsManager;
import com.icignal.external.aws.dto.request.AwsSecretManagerReqDto;
import com.icignal.kepler.analysis.common.util.KprAnalysisConstants;
import com.icignal.kepler.common.dto.request.KprCommonCodeReqDto;
import com.icignal.kepler.common.dto.response.KprCommonCodeResDto;
import com.icignal.kepler.common.mapper.KprCommonMapper;
import com.icignal.kepler.operation.dto.request.KprCardListReqDto;
import com.icignal.kepler.operation.dto.request.KprComboListReqDto;
import com.icignal.kepler.operation.dto.request.KprCustListReqDto;
import com.icignal.kepler.operation.dto.request.KprDatabaseUseSchemaReqDto;
import com.icignal.kepler.operation.dto.request.KprDbRegistReqDto;
import com.icignal.kepler.operation.dto.request.KprDelDbInformReqDto;
import com.icignal.kepler.operation.dto.request.KprDelIdxColListReqDto;
import com.icignal.kepler.operation.dto.request.KprDelIdxListReqDto;
import com.icignal.kepler.operation.dto.request.KprDelSubjectAreaReqDto;
import com.icignal.kepler.operation.dto.request.KprDelTableAddColReqDto;
import com.icignal.kepler.operation.dto.request.KprDelTableReqDto;
import com.icignal.kepler.operation.dto.request.KprEditDbInformReqDto;
import com.icignal.kepler.operation.dto.request.KprEditIdxAdvanceReqDto;
import com.icignal.kepler.operation.dto.request.KprEditIdxColListReqDto;
import com.icignal.kepler.operation.dto.request.KprEditIdxListReqDto;
import com.icignal.kepler.operation.dto.request.KprEditSubjectAreaReqDto;
import com.icignal.kepler.operation.dto.request.KprEditSubjectDbReqDto;
import com.icignal.kepler.operation.dto.request.KprEditTableAddColReqDto;
import com.icignal.kepler.operation.dto.request.KprEditTableAdvanceReqDto;
import com.icignal.kepler.operation.dto.request.KprEditTableColConvertReqDto;
import com.icignal.kepler.operation.dto.request.KprEditTableListReqDto;
import com.icignal.kepler.operation.dto.request.KprExcelUpLoadReqDto;
import com.icignal.kepler.operation.dto.request.KprGetIdxColListReqDto;
import com.icignal.kepler.operation.dto.request.KprGetIdxListReqDto;
import com.icignal.kepler.operation.dto.request.KprGetTableColListReqDto;
import com.icignal.kepler.operation.dto.request.KprGetTableReqDto;
import com.icignal.kepler.operation.dto.request.KprGetUploadErrorReqDto;
import com.icignal.kepler.operation.dto.request.KprOperationListReqDto;
import com.icignal.kepler.operation.dto.request.KprProdListReqDto;
import com.icignal.kepler.operation.dto.request.KprSalesDtlListReqDto;
import com.icignal.kepler.operation.dto.request.KprSalesListReqDto;
import com.icignal.kepler.operation.dto.request.KprSalesMileageListReqDto;
import com.icignal.kepler.operation.dto.request.KprSalesPayListReqDto;
import com.icignal.kepler.operation.dto.request.KprSetDbInformReqDto;
import com.icignal.kepler.operation.dto.request.KprSetIdxColListReqDto;
import com.icignal.kepler.operation.dto.request.KprSetIdxListReqDto;
import com.icignal.kepler.operation.dto.request.KprSetSubjectAreaMappingReqDto;
import com.icignal.kepler.operation.dto.request.KprSetSubjectAreaReqDto;
import com.icignal.kepler.operation.dto.request.KprSetTableAddColReqDto;
import com.icignal.kepler.operation.dto.request.KprSetTableListReqDto;
import com.icignal.kepler.operation.dto.request.KprSetUploadErrorReqDto;
import com.icignal.kepler.operation.dto.request.KprSetUploadResultReqDto;
import com.icignal.kepler.operation.dto.request.KprStoreListReqDto;
import com.icignal.kepler.operation.dto.request.KprSubjectAreaListReqDto;
import com.icignal.kepler.operation.dto.request.KprTableColImportReqDto;
import com.icignal.kepler.operation.dto.request.KprTableColInfoReqDto;
import com.icignal.kepler.operation.dto.request.KprTableImportTreeReqDto;
import com.icignal.kepler.operation.dto.request.KprTableMstListReqDto;
import com.icignal.kepler.operation.dto.response.KprCardListResDto;
import com.icignal.kepler.operation.dto.response.KprComboListResDto;
import com.icignal.kepler.operation.dto.response.KprCustListResDto;
import com.icignal.kepler.operation.dto.response.KprDatabaseUseSchemaResDto;
import com.icignal.kepler.operation.dto.response.KprDbRegistResDto;
import com.icignal.kepler.operation.dto.response.KprDuplicateValResDto;
import com.icignal.kepler.operation.dto.response.KprExcelUploadResDto;
import com.icignal.kepler.operation.dto.response.KprExcelUploadResultResDto;
import com.icignal.kepler.operation.dto.response.KprGetIdxColListResDto;
import com.icignal.kepler.operation.dto.response.KprGetIdxColListsResDto;
import com.icignal.kepler.operation.dto.response.KprGetIdxListResDto;
import com.icignal.kepler.operation.dto.response.KprGetTableColListResDto;
import com.icignal.kepler.operation.dto.response.KprGetTableColListsResDto;
import com.icignal.kepler.operation.dto.response.KprGetTableResDto;
import com.icignal.kepler.operation.dto.response.KprOperationListResDto;
import com.icignal.kepler.operation.dto.response.KprProdListResDto;
import com.icignal.kepler.operation.dto.response.KprSalesDtlListResDto;
import com.icignal.kepler.operation.dto.response.KprSalesListResDto;
import com.icignal.kepler.operation.dto.response.KprSalesMileageListResDto;
import com.icignal.kepler.operation.dto.response.KprSalesPayListResDto;
import com.icignal.kepler.operation.dto.response.KprStoreListResDto;
import com.icignal.kepler.operation.dto.response.KprSubjectAreaListResDto;
import com.icignal.kepler.operation.dto.response.KprSubjectAreaTreesResDto;
import com.icignal.kepler.operation.dto.response.KprTableColImportResDto;
import com.icignal.kepler.operation.dto.response.KprTableColInfoResDto;
import com.icignal.kepler.operation.dto.response.KprTableImportTreeOracleResDto;
import com.icignal.kepler.operation.dto.response.KprTableImportTreeResDto;
import com.icignal.kepler.operation.dto.response.KprTableImportTreesResDto;
import com.icignal.kepler.operation.dto.response.KprTableMstListResDto;
import com.icignal.kepler.operation.dto.response.KprTableResDto;
import com.icignal.kepler.operation.mapper.KprOperationMapper;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.commcode.service.SystemCommCodeService;


/*
 * 1. 클래스명	: SystemOperationService
 * 2. 파일명	: SystemOperationService.java
 * 3. 패키지명	: com.icignal.systemmanagement.operation.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 12.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class KprOperationService {

	@Autowired
	public KprOperationMapper kprOperationMapper;

	@Autowired
	public SystemCommCodeService systemCommCodeService;

	@Autowired
	MKTCallQueryDao mktCallQueryDao;

	@Autowired 
	KprCommonMapper kprCommonMapper;

	@Autowired
	private StandardPBEStringEncryptor encryptor;



	/**
	 * @programId : ANL_DB_001
	 * @name : getDbInformList
	 * @date : 2016. 7. 14.
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : DB정보관리 조회
	 */
	public GridPagingResDto<KprOperationListResDto> getDbInformList(KprOperationListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("d");

		//GridPagingResDto<KprOperationListResDto> rtnValue = systemOperationMapper.selectDbInformList(dir);
		GridPagingResDto<KprOperationListResDto> rtnValue = new GridPagingResHelper<KprOperationListResDto>().newGridPagingResDto(dir.init(CommonUtil.getInstance().getDBType())
				,kprOperationMapper.selectDbInformList(dir));

		//서비스명 별 AWS Secrets Manager 조회
		for(Object dbInfo : rtnValue.getRows()) {
			//JSONObject dbInfoJSON = new JSONObject();
			KprOperationListResDto kprDbInfo = new KprOperationListResDto();
			kprDbInfo = (KprOperationListResDto) dbInfo;

			if(ObjectUtil.isNotEmpty(kprDbInfo.getSecretNm())) {	
				try {

					Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(),  BeansUtil.getAwsRegion()).getSecretMap(kprDbInfo.getSecretNm());
					//dbInfoJSON = AWSSecretsManagerConfig.getSecretValueResult(_dbInfo.getSecretNm());
					kprDbInfo.setConUrl(map.get("url").toString());
					kprDbInfo.setConId(map.get("username").toString());
					kprDbInfo.setConPw(map.get("password").toString());
					kprDbInfo.setConIp(map.get("ip").toString());
					kprDbInfo.setConPort(map.get("port").toString());

					dbInfo = kprDbInfo;

				} catch(ArithmeticException e) {
					LogUtil.error(e.getMessage());
				}
			}
		}

		return rtnValue;
	}

	/**
	 * @programId : ANL_DB_P01
	 * @name : getDbRegist
	 * @date : 2016. 7. 14.
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : DB정보관리 조회
	 */
	public KprDbRegistResDto getDbRegist(KprDbRegistReqDto dir) {
		LogUtil.param(this.getClass(), dir);

		dir.setSVCAlias("d");
		KprDbRegistResDto dbInfo = kprOperationMapper.selectDbRegist(dir);

		if(ObjectUtil.isNotEmpty(dbInfo.getSecretNm())) {
			try {
				Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(),  BeansUtil.getAwsRegion()).getSecretMap(dbInfo.getSecretNm());
				//dbInfoJSON = AWSSecretsManagerConfig.getSecretValueResult(dbInfo.getSecretNm());
				dbInfo.setConUrl(map.get("url").toString());
				dbInfo.setConId(map.get("username").toString());
				dbInfo.setConPw(map.get("password").toString());
				dbInfo.setConIp(map.get("ip").toString());
				dbInfo.setConPort(map.get("port").toString());

			} catch(ArithmeticException e) {
				LogUtil.error(e.getMessage());
			}
		}

		return dbInfo;
	}

	/**
	 * 
	 * @programId : ANL_DB_P01
	 * @name : getDbChkRegist
	 * @date : 2016. 7. 22.
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : 서비스명 Key 중복체크
	 */
	public KprDbRegistResDto getDbChkRegist(KprDbRegistReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("");

		return kprOperationMapper.selectDbChkRegist(dir);
	}

	/**
	 * 
	 * @programId : ANL_DB_P01
	 * @name : getIpPortChk
	 * @date : 2016. 9. 7.
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : IP / PORT Key 중복체크
	 */
	public KprDbRegistResDto getIpPortChk(KprDbRegistReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("di");

		return kprOperationMapper.selectIpPortChk(dir);
	}

	/**
	 * 
	 * @programId : ANL_DB_001
	 * @name : dbInformDelChk
	 * @date : 2016. 7. 25.
	 * @author : 이원준
	 * @table : anl.anl_db_inform, anl.anl_subject_db_rel, anl.anl_table_mst
	 * @return :
	 * @description : 삭제 여부 체크
	 */
	public KprDbRegistResDto dbInformDelChk(KprDbRegistReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("d");

		return kprOperationMapper.selectdbInformDelChk(dir);
	}

	/**
	 * @programId : ANL_DB_P01
	 * @name : setDbRegist
	 * @date : 2016. 7. 14.
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : DB정보관리 등록
	 */
	public StatusResDto setDbRegist(KprSetDbInformReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		String id = CommonUtil.newRid();

		// 암호화
		SecretsManager sm = new SecretsManager(BeansUtil.getAWSCredentials(), BeansUtil.getAwsRegion());

		StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
		encryptor.setPassword("9pwc3dke");

		//StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
		//encryptor.setPassword("9pwc3dke");

//		EnDeCryptedService cryptService = (EnDeCryptedService) BeansUtil.getBean("enDeCryptedService");
//		String dataKey = BeansUtil.getDbEncryptDataKey();


		StatusResDto rtnValue = new StatusResDto();

		if (dir.isPwChk()) {
			dir.setConPw(dir.getConPw());
		}

		if(StringUtil.isNotEmpty(dir.getConPw())) {
			dir.setConPw(encryptor.encrypt(dir.getConPw()));
		}

		String serviceMgtType = BeansUtil.getApplicationProperty("icignal.db-connection-info.management-type");
		if( "AwsLoyalty".equals(serviceMgtType )) {
			dir.setSecretNm(dir.getSecretNm());

			if(ObjectUtil.isNotEmpty(dir.getSecretNm())) {
				//DB정보 AWS Secrets Manager 등록
				AwsSecretManagerReqDto param = new AwsSecretManagerReqDto();
				param.setName(dir.getSecretNm());
				param.setDescription(dir.getDbDesc());
				param.setSecretId(dir.getSecretNm());

				Map<String, String> secretKeyValue = new HashMap<String, String>();
				secretKeyValue.put("url", dir.getConUrl());
				secretKeyValue.put("username", dir.getConId());
				secretKeyValue.put("password", dir.getConPw());
				secretKeyValue.put("ip", dir.getConIp());
				secretKeyValue.put("port", dir.getConPort());

				param.setSecretKeyValue(secretKeyValue);

				sm.createSecret(param);

				//AWSSecretsManagerConfig.createSecret(param);

				//DB정보 DB 등록
				KprSetDbInformReqDto dbDir = new KprSetDbInformReqDto();
				dbDir.setCreateBy(dir.getCreateBy());
				dbDir.setModifyBy(dir.getModifyBy());
				/*   _dir.setCountry(dir.getCountry());
	         _dir.setAccountId(dir.getAccountId());
	         _dir.setAppServiceId(dir.getAppServiceId());*/
				dbDir.setServiceNm(dir.getServiceNm());
				dbDir.setSecretNm(dir.getSecretNm());
				dbDir.setDbDesc(dir.getDbDesc());
				dbDir.setConDbType(dir.getConDbType());

				dbDir.setDbInformId(id); 



				kprOperationMapper.insertDbInform(dbDir);
				if (id != null) {
					rtnValue.setSuccess(true);
					rtnValue.setMessage(id);
				}
			}else {
				dir.setDbInformId(id);
				kprOperationMapper.insertDbInform(dir);

				if (id != null) {
					rtnValue.setSuccess(true);
					rtnValue.setMessage(id);
				}

			}
		}else {
			dir.setDbInformId(id); 
			kprOperationMapper.insertDbInform(dir);
			if (id != null) {
				rtnValue.setSuccess(true);
				rtnValue.setMessage(id);
			}

		}
		return rtnValue;
	}

	/**
	 * @programId : ANL_DB_P01
	 * @name : editDbRegist
	 * @date : 2016. 7. 14.
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : DB정보관리 수정
	 */
	public StatusResDto editDbRegist(KprEditDbInformReqDto dir) {
		LogUtil.param(this.getClass(), dir);

		// 암호화
		SecretsManager sm = new SecretsManager(BeansUtil.getAWSCredentials(), BeansUtil.getAwsRegion());

		StatusResDto rtnValue = new StatusResDto();

//		EnDeCryptedService cryptService = (EnDeCryptedService) BeansUtil.getBean("enDeCryptedService");

		if (dir.isPwChk()) {
			String pass = encryptor.encrypt(dir.getConPw());
			dir.setConPw(pass);
		}
		String serviceMgtType = BeansUtil.getApplicationProperty("icignal.db-connection-info.management-type");
		if("AwsLoyalty".equals(serviceMgtType)) {
			dir.setSecretNm(dir.getSecretNm());
			if(ObjectUtil.isNotEmpty(dir.getSecretNm())) {
				//DB정보 AWS Secrets Manager 수정
				//AWSSMUpdateSecretReqDto param = new AWSSMUpdateSecretReqDto();
				/*param.setSecretId(dir.getSecretNm());
			param.setDescription(dir.getDbDesc());*/
				AwsSecretManagerReqDto param = new AwsSecretManagerReqDto();
				param.setName(dir.getSecretNm());
				param.setDescription(dir.getDbDesc());
				param.setSecretId(dir.getSecretNm());
				Map<String, String> secretKeyValue = new HashMap<String, String>();
				secretKeyValue.put("url", dir.getConUrl());
				secretKeyValue.put("username", dir.getConId());
				secretKeyValue.put("password", dir.getConPw());
				secretKeyValue.put("ip", dir.getConIp());
				secretKeyValue.put("port", dir.getConPort());
				param.setSecretKeyValue(secretKeyValue);

				sm.editSecretKey(param);

				//DB정보 DB 수정
				KprEditDbInformReqDto dbDir = new KprEditDbInformReqDto();
				dbDir.setCreateBy(dir.getCreateBy());
				dbDir.setModifyBy(dir.getModifyBy());
				//_dir.setCountry(dir.getCountry());
				dbDir.setAccountId(dir.getAccountId());
				//_dir.setAppServiceId(dir.getAppServiceId());
				dbDir.setServiceNm(dir.getServiceNm());
				dbDir.setDbDesc(dir.getDbDesc());
				dbDir.setDbInformId(dir.getDbInformId());
				dbDir.setSecretNm(dir.getSecretNm());

				kprOperationMapper.updateDbInfrom(dbDir);
				rtnValue.setSuccess(true);
			}else {
				kprOperationMapper.updateDbInfrom(dir);
				rtnValue.setSuccess(true);
			}
		}else {
			kprOperationMapper.updateDbInfrom(dir);
			rtnValue.setSuccess(true);
		}

		return rtnValue;
	}

	/**
	 * @programId : ANL_DB_P01
	 * @name : removeDbInform
	 * @date : 2016. 7. 14.
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : DB정보관리 삭제
	 */
	public StatusResDto removeDbInform(KprDelDbInformReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		StatusResDto rtnValue = new StatusResDto();

		SecretsManager sm =     new SecretsManager(BeansUtil.getAWSCredentials(), BeansUtil.getAwsRegion());
		List<String> secretNms = kprOperationMapper.getDbInfromServiceNms(dir.getDbInformId()); 
		String serviceMgtType = BeansUtil.getApplicationProperty("icignal.db-connection-info.management-type");

		//DB정보 AWS Secrets Manager 삭제
		if( "AwsLoyalty".equals(serviceMgtType )) {
				for (String secretNm : secretNms) {
					if(secretNm!=null) {
						//AWSSMDeleteSecretRequestDTO param = new AWSSMDeleteSecretRequestDTO();
						AwsSecretManagerReqDto param = new AwsSecretManagerReqDto();
						param.setSecretId(secretNm);
						param.setRecoveryWindowInDays((long) 7);
						sm.removeSecretKey(param);
					/*param.setSecretId(serviceNm);
					param.setRecoveryWindowInDays((long) 7);

					AWSSecretsManagerConfig.deleteSecret(param);*/
					}
			}
			kprOperationMapper.deleteDbInfrom(dir);
			rtnValue.setSuccess(true);
		}
		if (dir.getDbInformId() != null && dir.getDbInformId().size() > 0) {
			kprOperationMapper.deleteDbInfrom(dir);
		}
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * @programId : ANL_SBJ_001
	 * @name : getSubjectAreaList
	 * @date : 2016. 7. 14.
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 주제영역 조회
	 */
	public GridPagingResDto<KprSubjectAreaListResDto> getSubjectAreaList(KprSubjectAreaListReqDto sb) {
		LogUtil.param(this.getClass(), sb);

		sb.setSVCAlias("s");
		return new GridPagingResHelper<KprSubjectAreaListResDto>().newGridPagingResDto(
				sb.init(CommonUtil.getInstance().getDBType()),
				kprOperationMapper.selectSubjectAreaList(sb));
	}

	/**
	 * 
	 * @programId : ANL_SBJ_001
	 * @name : getSubjectAreaChkRegist
	 * @date : 2016. 7. 22.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description :
	 */
	public KprSubjectAreaListResDto getSubjectAreaChkRegist(KprSubjectAreaListReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		sb.setSVCAlias("");
		return kprOperationMapper.selectSubjectAreaChk(sb);
	}

	/**
	 * 
	 * @programId : ANL_SBJ_001
	 * @name : subjectAreaDelChk
	 * @date : 2016. 7. 25.
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 삭제여부 조회
	 */
	public KprSubjectAreaListResDto subjectAreaDelChk(KprSubjectAreaListReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		sb.setSVCAlias("d");
		return kprOperationMapper.subjectAreaDelChk(sb);
	}

	/**
	 * @programId : ANL_SBJ_P01
	 * @name : getSubjectArea
	 * @date : 2016. 7. 05.
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 주제영역 생성 조회
	 */
	public KprSubjectAreaListResDto getSubjectArea(KprSubjectAreaListReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		sb.setSVCAlias("s");

		return kprOperationMapper.selectSubjectArea(sb);
	}

	/**
	 * @programId : ANL_SBJ_P01
	 * @name : setSubjectArea
	 * @date : 2016. 7. 14.
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 주제영역 등록
	 */
	public StatusResDto setSubjectArea(KprSetSubjectAreaReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		StatusResDto rtnValue = new StatusResDto();

		String id = CommonUtil.newRid();
		rtnValue.setSuccess(false);


		sb.setSubjectAreaId(id);
		kprOperationMapper.insertSubjectArea(sb);

		if (id != null) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage(id);
		}

		return rtnValue;
	}

	/**
	 * @programId : ANL_SBJ_P01
	 * @name : editSubjectArea
	 * @date : 2016. 07. 15
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 주제영역 수정
	 */
	public StatusResDto editSubjectArea(KprEditSubjectAreaReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);

		sb.setSVCAlias("");
		kprOperationMapper.updateSubjectArea(sb);

		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * @programId : ANL_SBJ_001
	 * @name : removeSubjectArea
	 * @date : 2016. 07. 15
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 주제영역 삭제
	 */
	public StatusResDto removeSubjectArea(KprDelSubjectAreaReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);
		kprOperationMapper.deleteSubjectArea(sb);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId : ANL_SBJ_002
	 * @name : getSubjectAreaMapping
	 * @date : 2016. 07. 19
	 * @author : 이원준
	 * @table : anl.anl_subject_area, anl.anl_subject_db_rel
	 * @return :
	 * @description : 주제영역 조회
	 */
	public List<KprSubjectAreaTreesResDto> getSubjectAreaMapping(KprSubjectAreaListReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		sb.setSVCAlias("sd");

		return kprOperationMapper.selectSubjectAreaMapping(sb);
	}

	/**
	 * 
	 * @programId : ANL_SBJ_001
	 * @name : subjectDBDelChk
	 * @date : 2016. 8. 4.
	 * @author : 이원준
	 * @table : anl.anl_subject_area, anl.anl_subject_db_rel, anl.anl_table_mst
	 * @return :
	 * @description : 주제영역 삭제 체크
	 */
	public KprSubjectAreaListResDto subjectDBDelChk(KprSubjectAreaListReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		sb.setSVCAlias("c");
		return kprOperationMapper.subjectDBDelChk(sb);
	}

	/**
	 * 
	 * @programId : ANL_SBJ_002
	 * @name : removeSubjectDb
	 * @date : 2016. 8. 4.
	 * @author : 이원준
	 * @table : anl.anl_subject_db_rel
	 * @return :
	 * @description : 서비스/주제영역 맵핑 삭제
	 */
	public StatusResDto removeSubjectDb(KprDelSubjectAreaReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);
		kprOperationMapper.deleteSubjectDb(sb);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_SBJ_P02
	 * @name : editSubjectDb
	 * @date : 2016. 8. 5.
	 * @author : 이원준
	 * @table : anl.anl_subject_db_rel
	 * @return :
	 * @description : 맵핑 주제영역 순서 변경
	 */
	public StatusResDto editSubjectDb(KprEditSubjectDbReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);
		kprOperationMapper.updateSubjectDb(sb);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_SBJ_P02
	 * @name : getSubjectAreaPop
	 * @date : 2016. 07. 19
	 * @author : 이원준
	 * @table : anl.anl_subject_area, anl.anl_subject_db_rel
	 * @return : GridPagingResDto<>
	 * @description : 주제영역 조회
	 */
	public GridPagingResDto<KprSubjectAreaListResDto> getSubjectAreaPop(KprSubjectAreaListReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		sb.setSVCAlias("s");
		return new GridPagingResHelper<KprSubjectAreaListResDto>().newGridPagingResDto(
				sb.init(CommonUtil.getInstance().getDBType()), kprOperationMapper.selectSubjectAreaPop(sb));
	}

	/**
	 * 
	 * @programId : ANL_SBJ_P02
	 * @name : getMapping
	 * @date : 2016. 8. 17.
	 * @author : 이원준
	 * @table : anl.anl_subject_db_rel
	 * @return :
	 * @description : 주제영역 맵핑 여부확인
	 */
	public KprSubjectAreaListResDto getMapping(KprSubjectAreaListReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		sb.setSVCAlias("");
		return kprOperationMapper.selectSubjectRelCnt(sb);
	}

	/**
	 * 
	 * @programId : ANL_SBJ_P02
	 * @name : setMapping
	 * @date : 2016. 7. 19.
	 * @author : 이원준
	 * @table :
	 * @return : anl.anl_subject_db_rel
	 * @description : 주제영역 맵핑
	 */
	public StatusResDto setMapping(KprSetSubjectAreaMappingReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		StatusResDto rtnValue = new StatusResDto();
		String id = CommonUtil.newRid();
		rtnValue.setSuccess(false);

		sb.setSubjectDbId(id);
		kprOperationMapper.insertSubjectAreaMapping(sb);

		rtnValue.setSuccess(true);
		rtnValue.setMessage(id);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_SBJ_P02
	 * @name : editMapping
	 * @date : 2016. 7. 19.
	 * @author : 이원준
	 * @table :
	 * @return : anl.anl_subject_db_rel
	 * @description : 주제영역 맵핑
	 */
	public StatusResDto editMapping(KprSetSubjectAreaMappingReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);
		kprOperationMapper.updateSubjectAreaMapping(sb);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_001
	 * @name : getTableMstList
	 * @date : 2016. 7. 20.
	 * @author : 이원준
	 * @table :
	 * @return : anl.anl_table_mst
	 * @description : 테이블관리 조회
	 */
	public GridPagingResDto<KprTableMstListResDto> getTableMstList(KprTableMstListReqDto tm) {
		LogUtil.param(this.getClass(), tm);
		tm.setSVCAlias("t");
		return new GridPagingResHelper<KprTableMstListResDto>().newGridPagingResDto(
				tm.init(CommonUtil.getInstance().getDBType()), kprOperationMapper.selectTableMstList(tm));
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : getDbServiceComboList
	 * @date : 2016. 7. 27.
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : 서비스명 조회
	 */
	public GridPagingResDto<KprComboListResDto> getDbServiceComboList(KprComboListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("adi");
		return new GridPagingResHelper<KprComboListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), kprOperationMapper.selectDbServiceComboList(reqDto));
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : getSubjectAreaComboList
	 * @date : 2016. 7. 26.
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 주제영역 조회
	 */
	public GridPagingResDto<KprComboListResDto> getSubjectAreaComboList(KprComboListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("s");
		return new GridPagingResHelper<KprComboListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), kprOperationMapper.selectSubjectAreaComboList(reqDto));
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : getTableColList
	 * @date : 2016. 7. 26.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 테이블 컬럼정보 조회
	 */
	public GridPagingResDto<KprGetTableColListResDto> getTableColList(KprGetTableColListReqDto tm) {
		LogUtil.param(this.getClass(), tm);
		tm.setSVCAlias("c");
		return new GridPagingResHelper<KprGetTableColListResDto>().newGridPagingResDto(
				tm.init(CommonUtil.getInstance().getDBType()), kprOperationMapper.selectTableColList(tm));
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : getTableList
	 * @date : 2016. 7. 26.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 정보 조회
	 */
	public KprGetTableResDto getTableList(KprGetTableReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		KprGetTableResDto rtnValue = new KprGetTableResDto();

		rtnValue.setSuccess(false);
		dir.setSVCAlias("t");
		rtnValue = kprOperationMapper.selectTableList(dir);

		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : tablrIdReturn
	 * @date : 2016. 7. 29.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블아이디 조회
	 */
	public KprTableMstListResDto tableIdReturn(KprTableMstListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("");
		return kprOperationMapper.selectTableIdReturn(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : tableNmChk
	 * @date : 2016. 7. 29.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블명 Key 중복 체크
	 */
	public KprTableMstListResDto tableNmChk(KprTableMstListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("tm");
		return kprOperationMapper.selectTableNmChk(dir);
	}

	/**
	 * 
	 * @programId :ANL_TBL_002
	 * @name : getTableLgcChk
	 * @date : 2016. 9. 6.
	 * @author : 이원준
	 * @table : anl.anl_table_mst, anl.anl_column_mst, anl.anl_lgc_join_column
	 * @return :
	 * @description : L.C사용유무 체크
	 */
	public KprTableMstListResDto getTableLgcChk(KprTableMstListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("tm");
		return kprOperationMapper.selectTblLgcChk(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : tableAddColDelChk
	 * @date : 2016. 7. 29.
	 * @author : 이원준
	 * @table : anl.anl_lgc_join_column, anl.anl_column_mst
	 * @return :
	 * @description : 테이블 컬럼 삭제체크
	 */
	public KprGetTableColListResDto tableAddColDelChk(KprGetTableColListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		return kprOperationMapper.tableAddColDelChk(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : setTableList
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 정보 저장
	 */
	public StatusResDto setTableList(KprSetTableListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		StatusResDto rtnValue = new StatusResDto();
		KprGetTableReqDto di = new KprGetTableReqDto();
		KprGetTableResDto tblInfo = new KprGetTableResDto();

		rtnValue.setSuccess(false);
		String tableId = CommonUtil.newRid();

		dir.setTableId(tableId);
		kprOperationMapper.insertTableList(dir);

		if (tableId != null) {
			di.setTableId(dir.getTableId());
			tblInfo = getTableList(di);
			rtnValue.setSuccess(true);
		}
		return tblInfo;
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : editTableList
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 정보 수정
	 */
	public StatusResDto editTableList(KprEditTableListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		dir.setSVCAlias("");
		kprOperationMapper.updateTableList(dir);

		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : getTableColList
	 * @date : 2016. 7. 26.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 테이블 컬럼정보 조회
	 */
	public KprGetTableColListResDto getTableAddColList(KprGetTableColListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("c");
		return kprOperationMapper.selectTableAddColList(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P02
	 * @name : getTblColNmChk
	 * @date : 2016. 8. 3.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 컬럼명 Key 중복 체크
	 */
	public KprGetTableColListResDto getTblColNmChk(KprGetTableColListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("");
		return kprOperationMapper.selectTblColNmChk(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P02
	 * @name : setTableAddColList
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 컬럼정보 등록
	 */
	public StatusResDto setTableAddColList(KprSetTableAddColReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		StatusResDto rtnValue = new StatusResDto();
		String id = CommonUtil.newRid();
		rtnValue.setSuccess(false);
		sb.setColId(id);
		kprOperationMapper.insertTableAddColList(sb);

		if (id != null) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage(id);
		}
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : editTableAddColList
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description :
	 */
	public StatusResDto editTableAddColList(KprEditTableAddColReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);

		sb.setSVCAlias("");
		kprOperationMapper.updateTableAddColList(sb);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : removeTableAddColList
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 컬럼정보 삭제
	 */
	public StatusResDto removeTableAddColList(KprDelTableAddColReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);
		if (sb.getColId() != null && sb.getColId().size() > 0) {
			kprOperationMapper.deleteTableAddColList(sb);
		}
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P01
	 * @name : getTableAdvance
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 고급설정 조회
	 */
	public KprGetTableResDto getTableAdvance(KprGetTableReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("");
		return kprOperationMapper.selectTableAdvance(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P01
	 * @name : editTableAdvance
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 고급설정 등록
	 */
	public StatusResDto editTableAdvance(KprEditTableAdvanceReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		sb.setSVCAlias("");
		kprOperationMapper.updateTableAdvance(sb);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : getDbType
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_db_inform, anl.anl_table_mst
	 * @return :
	 * @description : DB 유형 조회
	 */
	public KprDbRegistResDto getDbType(KprDbRegistReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("d");
		return kprOperationMapper.selectDbType(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P02
	 * @name : getTableAddColSeq
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 컬럼 순서
	 */
	public KprGetTableColListResDto getTableAddColSeq(KprGetTableColListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("");
		return kprOperationMapper.selectColSeq(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_003
	 * @name : getIdxList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스 목록 조회
	 */
	public GridPagingResDto<KprGetIdxListResDto> getIdxList(KprGetIdxListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("m");
		return new GridPagingResHelper<KprGetIdxListResDto>().newGridPagingResDto(
				dir.init(CommonUtil.getInstance().getDBType()), kprOperationMapper.selectIdxList(dir));
	}

	/**
	 * 
	 * @programId : ANL_TBL_P03
	 * @name : getIdxInform
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스 목록조회
	 */
	public KprGetIdxListResDto getIdxInform(KprGetIdxListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		KprGetIdxListResDto rtnValue = new KprGetIdxListResDto();
		dir.setSVCAlias("m");
		rtnValue.setSuccess(false);
		rtnValue =kprOperationMapper.selectIdxInform(dir);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P03
	 * @name : getIdxNmChk
	 * @date : 2016. 8. 2.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스명 Key 중복 체크
	 */
	public KprGetIdxListResDto getIdxNmChk(KprGetIdxListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		KprGetIdxListResDto rtnValue = new KprGetIdxListResDto();
		rtnValue.setSuccess(false);
		dir.setSVCAlias("");
		rtnValue = kprOperationMapper.selectIdxNmChk(dir);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P03
	 * @name : setIdxList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스 등록
	 */
	public StatusResDto setIdxList(KprSetIdxListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		StatusResDto rtnValue = new StatusResDto();
		String tableId =CommonUtil.newRid();
		rtnValue.setSuccess(false);
		dir.setIdxId(tableId);
		kprOperationMapper.insertIndexList(dir);
		rtnValue.setSuccess(true);
		rtnValue.setMessage(tableId);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P03
	 * @name : editIdxList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스 수정
	 */
	public StatusResDto editIdxList(KprEditIdxListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		dir.setSVCAlias("");
		kprOperationMapper.updateIndexList(dir);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_003
	 * @name : removeIdxList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스 삭제
	 */
	public StatusResDto removeIdxList(KprDelIdxListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		if (dir.getIdxId() != null && dir.getIdxId().size() > 0) {
			kprOperationMapper.deleteIndexList(dir);
		}
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_003
	 * @name : getIdxColList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_column
	 * @return :
	 * @description : 인덱스 컬럼 목록 조회
	 */
	public GridPagingResDto<KprGetIdxColListResDto> getIdxColList(KprGetIdxColListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("c");
		return new GridPagingResHelper<KprGetIdxColListResDto>().newGridPagingResDto(
				dir.init(CommonUtil.getInstance().getDBType()), kprOperationMapper.selectIdxColList(dir));
	}

	/**
	 * 
	 * @programId : ANL_TBL_P04
	 * @name : getIdxColInform
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_column
	 * @return :
	 * @description : 인덱스 정보 조회
	 */
	public KprGetIdxColListResDto getIdxColInform(KprGetIdxColListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		KprGetIdxColListResDto rtnValue = new KprGetIdxColListResDto();
		rtnValue.setSuccess(false);
		dir.setSVCAlias("c");
		rtnValue = kprOperationMapper.selectIdxColInform(dir);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P04
	 * @name : getIdxColNmChk
	 * @date : 2016. 8. 2.
	 * @author : 이원준
	 * @table : anl.anl_index_column
	 * @return :
	 * @description : 컬럼명 Key 중복체크
	 */
	public KprGetIdxColListResDto getIdxColNmChk(KprGetIdxColListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		KprGetIdxColListResDto rtnValue = new KprGetIdxColListResDto();
		rtnValue.setSuccess(false);
		dir.setSVCAlias("");
		rtnValue = kprOperationMapper.selectIdxColNmChk(dir);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P04
	 * @name : setIdxColList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_column
	 * @return :
	 * @description : 컬럼정보 등록
	 */
	public StatusResDto setIdxColList(KprSetIdxColListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		String newId = CommonUtil.newRid();
		dir.setIdxColId(newId);
		kprOperationMapper.insertIndexColList(dir);
		if (newId != null) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage(newId);
		}
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P04
	 * @name : editIdxColList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_column
	 * @return :
	 * @description : 컬럼정보 수정
	 */
	public StatusResDto editIdxColList(KprEditIdxColListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		dir.setSVCAlias("");
		kprOperationMapper.updateIndexColList(dir);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_003
	 * @name : removeIdxColList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_column
	 * @return :
	 * @description : 컬럼정보 삭제
	 */
	public StatusResDto removeIdxColList(KprDelIdxColListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		kprOperationMapper.deleteIndexColList(dir);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P05
	 * @name : getIdxAdvance
	 * @date : 2016. 8. 2.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스 고급설정 조회
	 */
	public KprGetIdxListResDto getIdxAdvance(KprGetIdxListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		KprGetIdxListResDto rtnValue = new KprGetIdxListResDto();
		rtnValue.setSuccess(false);
		dir.setSVCAlias("");
		rtnValue = kprOperationMapper.selectIdxAdvance(dir);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P05
	 * @name : editIdxAdvance
	 * @date : 2016. 8. 4.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스 고급설정 저장
	 */
	public StatusResDto editIdxAdvance(KprEditIdxAdvanceReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		sb.setSVCAlias("");
		kprOperationMapper.updateIdxAdvance(sb);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P07
	 * @name : getCreatTblCol
	 * @date : 2016. 8. 3.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 테이블 생성
	 */
	public List<KprGetTableColListsResDto> getCreatTblCol(KprGetTableColListReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		sb.setSVCAlias("c");
		return kprOperationMapper.selectCreatTableColList(sb);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P07
	 * @name : getCreatIdxCol
	 * @date : 2016. 8. 3.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 테이블 컬럼정보 조회
	 */
	public List<KprGetIdxColListsResDto> getCreatIdxCol(KprGetIdxColListReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		sb.setSVCAlias("c");
		return kprOperationMapper.selectCreatIdxColList(sb);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : getSourceTreeMySqlData
	 * @date : 2016. 8. 4.
	 * @author : 이원준
	 * @table : information_schema.tables, information_schema.columns
	 * @return :
	 * @description : 스키마 하위 테이블 조회
	 */
	public List<KprTableImportTreesResDto> getSourceTreeMySqlData(KprTableImportTreeReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		List<KprTableImportTreesResDto> rtnList = new ArrayList<>();
		KprTableImportTreeResDto rtnSqlQuery = new KprTableImportTreeResDto();

		rtnSqlQuery = kprOperationMapper.selectSourceTreeMysqlList(sb);

		if (ObjectUtil.isNotEmpty(rtnSqlQuery)) {
			String selectContent = rtnSqlQuery.getMySql();
			KprOperationListReqDto di = new KprOperationListReqDto();
			di.setDbInformId(sb.getDbInformId());
			di.setLang(sb.getLang());

			// 로지컬 컴포넌트 db 정보 조회
			MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
			dbInfo = getDBInfo(di);

			if (ObjectUtil.isNotEmpty(dbInfo)) {
				// 쿼리 실행
				rtnList = mktCallQueryDao.callSelectForList("sourceTreeMySQLList", selectContent, new ArrayList<String>(), dbInfo, KprTableImportTreeResDto.class);
			}
		}

		return rtnList;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : getSourceTreeOracleData
	 * @date : 2016. 8. 4.
	 * @author : 이원준
	 * @table : information_schema.tables, information_schema.columns
	 * @return :
	 * @description : 스키마 하위 테이블 조회
	 */
	public List<KprTableImportTreeOracleResDto> getSourceTreeOracleData(KprTableImportTreeReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		List<KprTableImportTreeOracleResDto> rtnList = new ArrayList<>();
		KprTableImportTreeOracleResDto rtnSqlQuery = new KprTableImportTreeOracleResDto();

		rtnSqlQuery = kprOperationMapper.selectSourceTreeOracleList(sb);

		if (ObjectUtil.isNotEmpty(rtnSqlQuery)) {
			String selectContent = rtnSqlQuery.getOracleSql();
			KprOperationListReqDto di = new KprOperationListReqDto();
			di.setDbInformId(sb.getDbInformId());
			di.setLang(sb.getLang());

			// 로지컬 컴포넌트 db 정보 조회
			MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
			dbInfo = getDBInfo(di);

			if (ObjectUtil.isNotEmpty(dbInfo)) {
				rtnList = mktCallQueryDao.callSelectForList("sourceTreeOracleList", selectContent, new ArrayList<String>(), dbInfo, KprTableImportTreeOracleResDto.class);
			}
		}

		return rtnList;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : getSourceTreeOracleData
	 * @date : 2016. 8. 4.
	 * @author : 이원준
	 * @table : information_schema.tables, information_schema.columns
	 * @return :
	 * @description : 스키마 하위 테이블 조회
	 * 							수정 필요!!!!!
	 */
	public List<KprTableImportTreesResDto> getSourceTreeData(KprTableImportTreeReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		List<KprTableImportTreesResDto> resList = new ArrayList<KprTableImportTreesResDto>();
		KprOperationListReqDto databaseInfo = new KprOperationListReqDto();
		databaseInfo.setDbInformId(sb.getDbInformId());
		databaseInfo.setLang(sb.getLang());

		MKTDBInfoDTO dbInfo = getDBInfo(databaseInfo);

		String databaseType = dbInfo.getConDbType();
		MKTCommonCodeRequestDTO codeReqDto = new MKTCommonCodeRequestDTO();
		codeReqDto.setLang(sb.getLang());
		codeReqDto.setGroupCode(CommonUtil.ANL_DB_TYPE_CD);
		codeReqDto.setCodeName(databaseType);
		MKTCommonCodeResponseDTO codeResDto = systemCommCodeService.getCommCodeDetail(codeReqDto);

		List<String> databaseUseSchemaNameList = kprOperationMapper.selectDatabaseUseSchemaNameList(sb.getDbInformId());

		StringBuilder tableSelectSQL = new StringBuilder();
		tableSelectSQL.append(" select * ")
					  .append(" from (")
					  .append(codeResDto.getAttrib03())
					  .append(" ) t");
		if (ObjectUtil.isNotEmpty(databaseUseSchemaNameList)) {
			tableSelectSQL.append(" where t.\"schmaNm\" in ('" + String.join("', '", databaseUseSchemaNameList) + "')\n");
			
			if(databaseType.equalsIgnoreCase("MsSQL"))
				tableSelectSQL.append(" ORDER BY 2");
			
		}

		resList.addAll(mktCallQueryDao.callSelectForList("systemOperationMapper.selectSourceTreeData", tableSelectSQL.toString(), new ArrayList<String>(), dbInfo, KprTableImportTreeResDto.class));

		return resList;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : targetTreeData
	 * @date : 2016. 8. 5.
	 * @author : 이원준
	 * @table : anl.anl_subject_area, anl.anl_subject_rel
	 * @return :
	 * @description : Target 주제영역 조회
	 */
	public List<KprTableImportTreesResDto> getTargetTreeData(KprTableImportTreeReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		sb.setSVCAlias("sa");
		return kprOperationMapper.selectTargetTreeList(sb);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : getTableColImport
	 * @date : 2016. 8. 8.
	 * @author : 이원준
	 * @table : information_schema.columns
	 * @return :
	 * @description : 테이블 컬럼정보 조회
	 * 
	 * @history ======================================================================================
	 *          변경일 작성자 변경내용
	 *          ======================================================================================
	 *          2017. 7. 26. jh.kim 타 DB에서 테이블 컬럼 정보를 조회할 수 있도록 수정.
	 *          ======================================================================================
	 */
	public List<KprTableColImportResDto> getTableColImport(KprTableColImportReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		sb.setSVCAlias("");
		List<KprTableColImportResDto> rtnList = new ArrayList<>();
		StringBuilder columnSelectSQL = new StringBuilder();

		KprOperationListReqDto di = new KprOperationListReqDto();
		di.setDbInformId(sb.getDbInformId());
		di.setLang(sb.getLang());

		// 로지컬 컴포넌트 db 정보 조회
		MKTDBInfoDTO dbInfo = getDBInfo(di);

		String databaseType = dbInfo.getConDbType();
		KprCommonCodeReqDto codeReqDto = new KprCommonCodeReqDto();
		codeReqDto.setLang(sb.getLang());
		codeReqDto.setGroupCode(CommonUtil.ANL_DB_TYPE_CD);
		codeReqDto.setCodeName(databaseType);
		//KprCommonCodeResDto codeResDto = iKPRCommon.getCommCodeDetail(codeReqDto);
		KprCommonCodeResDto codeResDto = kprCommonMapper.getCommCodeDetail(codeReqDto);
		// DB 유형 확인
		// 테이블 정보를 조회하기 위한 쿼리 조회
		columnSelectSQL.append("select t.col_nm     as \"colNm\"")
						.append("     , t.col_dp_nm  as \"dpNm\"")
						.append("     , t.seq        as \"seq\"")
						.append("     , t.null_yn    as \"nullYn\"")
						.append("     , t.pk_yn      as \"pkYn\"")
						.append("     , t.data_type  as \"dataTypeCd\"")
						.append("     , t.column_len as \"len\"")
						.append("     , t.deft_val   as \"deftVal\"")
						.append("  from (\n")
						.append("    " + codeResDto.getAttrib02())
						.append(") t\n")
						.append(" where t.schma_nm = '" + sb.getSchmaNm() + "'")
						.append("   and t.tbl_nm   = '" + sb.getTblNm() + "'");

		if (ObjectUtil.isNotEmpty(dbInfo)) {
			// 테이블 컬럼 정보 조회
			rtnList = mktCallQueryDao.callSelectForList("selectTableColList", columnSelectSQL.toString(), new ArrayList<String>(), dbInfo, KprTableColImportResDto.class);
		}
		return rtnList;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : setTableImport
	 * @date : 2016. 8. 8.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 정보 불러오기
	 * 
	 * @history =================================================================================
	 *          변경일 작성자 변경내용
	 *          =================================================================================
	 *          2017. 7. 26. jh.kim 타 DB에서 테이블 정보를 조회할 수 있도록 수정.
	 *          =================================================================================
	 */
	public StatusResDto setTableImport(KprSetTableListReqDto dir) {
		LogUtil.param(this.getClass(), dir);

		StatusResDto statusDto = new StatusResDto();
		StringBuilder tableSelectSQL = new StringBuilder();

		KprOperationListReqDto di = new KprOperationListReqDto();
		di.setDbInformId(dir.getDbInformId());
		di.setLang(dir.getLang());

		// 로지컬 컴포넌트 db 정보 조회
		MKTDBInfoDTO dbInfo = getDBInfo(di);

		String databaseType = dbInfo.getConDbType();
		KprCommonCodeReqDto codeReqDto = new KprCommonCodeReqDto();
		codeReqDto.setLang(dir.getLang());
		codeReqDto.setGroupCode(CommonUtil.ANL_DB_TYPE_CD);
		codeReqDto.setCodeName(databaseType);
		KprCommonCodeResDto codeResDto = kprCommonMapper.getCommCodeDetail(codeReqDto);

		// DB 유형 확인
		// 테이블 정보를 조회하기 위한 쿼리 조회
		tableSelectSQL.append("select t.schma_nm  as \"parentId\"\n")
					  .append("     , t.tbl_nm    as \"id\"\n")
					  .append("     , t.tbl_nm    as \"text\"\n")
					  .append("     , t.schma_nm  as \"schmaNm\"\n")
					  .append("     , ''          as \"nodeType\"\n")
					  .append("     , t.tbl_dp_nm as \"comment\"\n")
					  .append("     , t.engine    as \"engine\"\n")
					  .append("  from (\n")
					  .append("    select t.schma_nm  as schma_nm\n")
					  .append("         , t.tbl_nm    as tbl_nm\n")
					  .append("         , t.tbl_dp_nm as tbl_dp_nm\n")
					  .append("         , t.engine    as engine\n")
					  .append("      from (\n")
					  .append("        " + codeResDto.getAttrib02() + "\n")
					  .append("    ) t\n")
					  .append("     group by t.schma_nm, t.tbl_nm, t.tbl_dp_nm, t.engine\n")
					  .append(") t\n");
		if(StringUtil.isNotEmpty(dir.getSchmaNm())) {
			if(StringUtil.isNotEmpty(dir.getTblNm())) {
				tableSelectSQL.append(" where t.schma_nm = '" + dir.getSchmaNm() + "'")
						      .append("   and t.tbl_nm   = '" + dir.getTblNm() + "'");
			} else {
				tableSelectSQL.append(" where t.schma_nm = '" + dir.getSchmaNm() + "'");
			}
		} else {
			tableSelectSQL.append(" where t.tbl_nm = '" + dir.getTblNm() + "'");
		}

		if (ObjectUtil.isNotEmpty(dbInfo)) {

			// 테이블 정보 조회
			List<KprTableImportTreeResDto> rtnList = mktCallQueryDao.callSelectForList("sourceTreeMySQLList", tableSelectSQL.toString(), new ArrayList<String>(), dbInfo, KprTableImportTreeResDto.class);

			for (KprTableImportTreeResDto itr : rtnList) {
				dir.setTblNm(itr.getText());
				dir.setSchmaNm(itr.getSchmaNm());
				dir.setEngine(itr.getEngine());
				dir.setComment(itr.getComment());
				dir.setTableId(CommonUtil.newRid());
				// insert
				kprOperationMapper.insertTableImport(dir);
				statusDto.setSuccess(true);
			}
		}
		return statusDto;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : setTableColImport
	 * @date : 2016. 8. 9.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 테이블 컬럼정보 불러오기
	 */
	public StatusResDto setTableColImport(KprSetTableAddColReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		dir.setSVCAlias("");
		String newId = CommonUtil.newRid();
		dir.setColId(newId);
		kprOperationMapper.insertTableColImport(dir);
		rtnValue.setSuccess(true);
		rtnValue.setMessage(newId);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P07
	 * @name : setTableCreat
	 * @date : 2016. 8. 5.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 테이블생성 외부쿼리 호출
	 */
	public StatusResDto setTableCreat(KprOperationListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		StatusResDto rtnQuery = new StatusResDto();

		KprOperationListReqDto di = new KprOperationListReqDto();
		di.setDbInformId(dir.getDbInformId());
		di.setLang(dir.getLang());
		String sqlQuery = dir.getSqlQuery(); // 쿼리정보 변수에 담기

		// 로지컬 컴포넌트 db 정보 조회
		MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
		dbInfo = getDBInfo(di);

		if (ObjectUtil.isNotEmpty(dbInfo)) {
			// 쿼리 실행
			rtnQuery = mktCallQueryDao.callUpdate("tableCreate", sqlQuery, new ArrayList<String>(), dbInfo, true);
		}

		return rtnQuery;
	}

	/**
	 * 
	 * @programId :
	 * @name : getDBInfo
	 * @date : 2016. 8. 4.
	 * @author : 이원준
	 * @table : anl.anl_db_infom
	 * @return :
	 * @description : db 정보 조회
	 */
	public MKTDBInfoDTO getDBInfo(KprOperationListReqDto di) {
		LogUtil.param(KprOperationService.class, di);
		KprOperationListResDto lgcDbInfo = new KprOperationListResDto();

		// 로지컬 컴포넌트 db 정보 조회
		lgcDbInfo = kprOperationMapper.selectDBInfo(di);

		// 접속 db 정보 설정
		MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();

		if(ObjectUtil.isNotEmpty(lgcDbInfo.getSecretNm())) {
			//AWS Secrets Manager db 정보 조회
			try {
				//JSONObject dbInfoJSON = AWSSecretsManagerConfig.getSecretValueResult(lgcDbInfo.getSecretNm());
				Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(), 
						BeansUtil.getAwsRegion()
						).getSecretMap(lgcDbInfo.getSecretNm());	

				dbInfo.setUrl(map.get("url").toString());
				dbInfo.setUserName(map.get("username").toString());
				dbInfo.setPassword(map.get("password").toString());
				dbInfo.setConIp(map.get("ip").toString());
				dbInfo.setConPort(map.get("port").toString());

			}catch(ArithmeticException e) {
				LogUtil.error(e.getMessage());
			}
		}else {
			dbInfo.setConIp(lgcDbInfo.getConIp());
			dbInfo.setConPort(lgcDbInfo.getConPort());
			dbInfo.setUserName(lgcDbInfo.getConId());
			dbInfo.setPassword(encryptor.decrypt(lgcDbInfo.getConPw()));
			dbInfo.setUrl(lgcDbInfo.getConUrl());
		}
		dbInfo.setDriverClassName(lgcDbInfo.getConDbClass());
		dbInfo.setConDbType(lgcDbInfo.getConDbType());


		return dbInfo;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : tableLgcChk
	 * @date : 2016. 8. 12.
	 * @author : 이원준
	 * @table : anl.anl_table_mst, anl.anl_lgc_comp_table_rel
	 * @return :
	 * @description : 테이블 불어오기 사용여부 체크
	 */
	public KprTableMstListResDto tableLgcChk(KprTableMstListReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		dir.setSVCAlias("c");
		return kprOperationMapper.tableLgcChk(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : removeTableColumn
	 * @date : 2016. 8. 12.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 테이블 불러오기 컬럼 삭제
	 */
	public StatusResDto removeTableColumn(KprDelTableReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		dir.setSVCAlias("");
		kprOperationMapper.removeTableColumn(dir);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : removeTable
	 * @date : 2016. 8. 12.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 불러오기 테이블 삭제
	 */
	public StatusResDto removeTable(KprDelTableReqDto dir) {
		LogUtil.param(this.getClass(), dir);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		dir.setSVCAlias("");
		kprOperationMapper.removeTable(dir);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : getSubjectAreaNmRtn
	 * @date : 2016. 8. 19.
	 * @author : 이원준
	 * @table : anl.anl_subject_area, anl.anl_subject_db_rel
	 * @return :
	 * @description : 주제영역명 return
	 */
	public KprSubjectAreaListResDto getSubjectAreaNmRtn(KprSubjectAreaListReqDto sb) {
		LogUtil.param(this.getClass(), sb);
		sb.setSVCAlias("sa");
		return kprOperationMapper.selectSubjectAreaNmRtn(sb);
	}

	/**
	 * 
	 * @programId :
	 * @name : getAccountNm
	 * @date : 2016. 9. 28.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description :어카운트명 조회
	 */
	public GridPagingResDto<KprComboListResDto> getAccountNm(KprComboListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");
		return new GridPagingResHelper<KprComboListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), kprOperationMapper.selectAccountComboList(reqDto));
	}

	/**
	 * 
	 * @programId :
	 * @name : getMappingColInfo
	 * @date : 2016. 10. 4.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 테이블 목록 컬럼 정보 조회
	 */
	public GridPagingResDto<KprTableColInfoResDto> getMappingColInfo(KprTableColInfoReqDto dir) {
		LogUtil.param(this.getClass(), dir);

		return new GridPagingResHelper<KprTableColInfoResDto>().newGridPagingResDto(
				dir.init(CommonUtil.getInstance().getDBType()), kprOperationMapper.selectTableColInfo(dir));
	}

	/**
	 * 
	 * @programId :
	 * @name : getUploadErrorSeq
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 업로드 오류테이블 seq 생성
	 */
	public Integer getUploadErrorSeq(KprGetUploadErrorReqDto dir) {
		LogUtil.param(this.getClass(), dir);

		return kprOperationMapper.selectExcelUpSeq(dir);
	}

	/**
	 * 
	 * @programId :
	 * @name : setCustExcelUpload
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 회원 임시테이블 저장
	 */
	public KprExcelUploadResDto setCustExcelUpload(KprCustListReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		KprExcelUploadResDto rtnValue = new KprExcelUploadResDto();

		try {
			rtnValue = kprOperationMapper.insertCustList(slr);
			rtnValue.setSuccess(true);
		} catch (Exception e) {
			String str = getPrintStacTraceString(e);
			int sIdx = str.indexOf("Cause:");
			int eIdx = str.indexOf("; nested");

			rtnValue.setSuccess(false);
			rtnValue.setErrorMessage((String) str.substring(sIdx, eIdx));
		}
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : setStoreExcelUpload
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 매장 임시테이블 저장
	 */
	public KprExcelUploadResDto setStoreExcelUpload(KprStoreListReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		KprExcelUploadResDto rtnValue = new KprExcelUploadResDto();

		try {
			rtnValue = kprOperationMapper.insertStoreList(slr);
			rtnValue.setSuccess(true);
		} catch (Exception e) {
			String str = getPrintStacTraceString(e);
			int sIdx = str.indexOf("Cause:");
			int eIdx = str.indexOf("; nested");

			rtnValue.setSuccess(false);
			rtnValue.setErrorMessage((String) str.substring(sIdx, eIdx));
		}
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : setSalesExcelUpload
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 매출 임시테이블 저장
	 */
	public KprExcelUploadResDto setSalesExcelUpload(KprSalesListReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		KprExcelUploadResDto rtnValue = new KprExcelUploadResDto();

		try {
			rtnValue = kprOperationMapper.insertSalesList(slr);
			rtnValue.setSuccess(true);
		} catch (Exception e) {
			String str = getPrintStacTraceString(e);
			int sIdx = str.indexOf("Cause:");
			int eIdx = str.indexOf("; nested");

			rtnValue.setSuccess(false);
			rtnValue.setErrorMessage((String) str.substring(sIdx, eIdx));
		}
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : setSalesDtlExcelUpload
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 매출상세 임시테이블 저장
	 */
	public KprExcelUploadResDto setSalesDtlExcelUpload(KprSalesDtlListReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		KprExcelUploadResDto rtnValue = new KprExcelUploadResDto();

		try {
			rtnValue = kprOperationMapper.insertSalesDtlList(slr);
			rtnValue.setSuccess(true);
		} catch (Exception e) {
			String str = getPrintStacTraceString(e);
			int sIdx = str.indexOf("Cause:");
			int eIdx = str.indexOf("; nested");

			rtnValue.setSuccess(false);
			rtnValue.setErrorMessage((String) str.substring(sIdx, eIdx));
		}
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : setSalesPayExcelUpload
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 매출결제 임시테이블 저장
	 */
	public KprExcelUploadResDto setSalesPayExcelUpload(KprSalesPayListReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		KprExcelUploadResDto rtnValue = new KprExcelUploadResDto();

		try {
			rtnValue = kprOperationMapper.insertSalesPayList(slr);
			rtnValue.setSuccess(true);
		} catch (Exception e) {
			String str = getPrintStacTraceString(e);
			int sIdx = str.indexOf("Cause:");
			int eIdx = str.indexOf("; nested");

			rtnValue.setSuccess(false);
			rtnValue.setErrorMessage((String) str.substring(sIdx, eIdx));
		}
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : setCardExcelUpload
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 맴버쉽카드 임시테이블 저장
	 */
	public KprExcelUploadResDto setCardExcelUpload(KprCardListReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		KprExcelUploadResDto rtnValue = new KprExcelUploadResDto();

		try {
			rtnValue = kprOperationMapper.insertCardList(slr);
			rtnValue.setSuccess(true);
		} catch (Exception e) {
			String str = getPrintStacTraceString(e);
			int sIdx = str.indexOf("Cause:");
			int eIdx = str.indexOf("; nested");

			rtnValue.setSuccess(false);
			rtnValue.setErrorMessage((String) str.substring(sIdx, eIdx));
		}
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : setSalesMileageExcelUpload
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 매출마일리지 임시테이블 저장
	 */
	public KprExcelUploadResDto setSalesMileageExcelUpload(KprSalesMileageListReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		KprExcelUploadResDto rtnValue = new KprExcelUploadResDto();

		try {
			rtnValue = kprOperationMapper.insertSalesMileageList(slr);
			rtnValue.setSuccess(true);
		} catch (Exception e) {
			String str = getPrintStacTraceString(e);
			int sIdx = str.indexOf("Cause:");
			int eIdx = str.indexOf("; nested");

			rtnValue.setSuccess(false);
			rtnValue.setErrorMessage((String) str.substring(sIdx, eIdx));
		}
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : setProdExcelUpload
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 상품 임시테이블 저장
	 */
	public KprExcelUploadResDto setProdExcelUpload(KprProdListReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		KprExcelUploadResDto rtnValue = new KprExcelUploadResDto();

		try {
			rtnValue = kprOperationMapper.insertProdList(slr);
			rtnValue.setSuccess(true);
		} catch (Exception e) {
			String str = getPrintStacTraceString(e);
			int sIdx = str.indexOf("Cause:");
			int eIdx = str.indexOf("; nested");

			rtnValue.setSuccess(false);
			rtnValue.setErrorMessage((String) str.substring(sIdx, eIdx));
		}
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : setUploadResult
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 엑셀업로드 결과 저장
	 */
	public KprExcelUploadResultResDto setUploadResult(KprSetUploadResultReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		KprExcelUploadResultResDto rtnValue = new KprExcelUploadResultResDto();
		rtnValue.setSuccess(false);
		String id = CommonUtil.newRid();
		slr.setId(id);
		rtnValue = kprOperationMapper.insertExcelUpResult(slr);
		rtnValue.setSuccess(true);
		rtnValue.setMessage(id);

		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : delTmpCustList
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 회원 임시테이블 삭제
	 */
	public StatusResDto delTmpCustList(KprExcelUpLoadReqDto eul) {
		LogUtil.param(this.getClass(), eul);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		kprOperationMapper.deleteCustList(eul);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : delTmpStoreList
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 매장 임시테이블 삭제
	 */
	public StatusResDto delTmpStoreList(KprExcelUpLoadReqDto eul) {
		LogUtil.param(this.getClass(), eul);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		kprOperationMapper.deleteStoreList(eul);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : delTmpSalesList
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 매출 임시테이블 삭제
	 */
	public StatusResDto delTmpSalesList(KprExcelUpLoadReqDto eul) {
		LogUtil.param(this.getClass(), eul);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		kprOperationMapper.deleteSalesList(eul);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : delTmpSalesDtlList
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 매출상세 임시테이블 삭제
	 */
	public StatusResDto delTmpSalesDtlList(KprExcelUpLoadReqDto eul) {
		LogUtil.param(this.getClass(), eul);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		kprOperationMapper.deleteSalesDtlList(eul);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : delTmpSalesPayList
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 매출결제 임시테이블 삭제
	 */
	public StatusResDto delTmpSalesPayList(KprExcelUpLoadReqDto eul) {
		LogUtil.param(this.getClass(), eul);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		kprOperationMapper.deleteSalesPayList(eul);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : delTmpCardList
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 맴버쉽카드 임시테이블 삭제
	 */
	public StatusResDto delTmpCardList(KprExcelUpLoadReqDto eul) {
		LogUtil.param(this.getClass(), eul);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		kprOperationMapper.deleteCardList(eul);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : delTmpSalesMileageList
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 매출마일리지 임시테이블 삭제
	 */
	public StatusResDto delTmpSalesMileageList(KprExcelUpLoadReqDto eul) {
		LogUtil.param(this.getClass(), eul);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		kprOperationMapper.deleteSalesMileageList(eul);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : delTmpProdList
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 상품 임시테이블 삭제
	 */
	public StatusResDto delTmpProdList(KprExcelUpLoadReqDto eul) {
		LogUtil.param(this.getClass(), eul);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		kprOperationMapper.deleteProdList(eul);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : setReExcelUpload
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 메인 테이블 저장
	 */
	public KprExcelUploadResDto setReExcelUpload(KprExcelUpLoadReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		KprExcelUploadResDto rtnValue = new KprExcelUploadResDto();

		KprCustListReqDto custDto = new KprCustListReqDto();
		KprStoreListReqDto storeDto = new KprStoreListReqDto();
		KprSalesListReqDto salesDto = new KprSalesListReqDto();
		KprSalesDtlListReqDto salesDtlDto = new KprSalesDtlListReqDto();
		KprSalesPayListReqDto salesPayDto = new KprSalesPayListReqDto();
		KprCardListReqDto cardDto = new KprCardListReqDto();
		KprSalesMileageListReqDto salesMilDto = new KprSalesMileageListReqDto();
		KprProdListReqDto prodDto = new KprProdListReqDto();

		int totCnt = 0; // 총건수
		int successCnt = 0; // 성공건수
		int failCnt = 0; // 실패건수
		int notInCnt = 0; // 키Key 중복건수
		List<String> errorMessages = new ArrayList<String>(); // 오류메세지

		long startTime = System.currentTimeMillis(); // 시작시간
		if (slr.getTableId().equals("T_O_CUST")) {
			List<KprCustListResDto> rptCust = kprOperationMapper.selectTmpCustList(slr);
			List<KprDuplicateValResDto> rptCustDup = kprOperationMapper.selectCustDupList(slr);
			totCnt = rptCust.size(); // 임시테이블에 저장된 총건수
			notInCnt = kprOperationMapper.selectCustNoCnt(slr); // 임시테이블에 메인테이블 Key 중복된
			// 값 제외 건수
			// 임포트유형 A 타입(삭제후 Insert)
			if (slr.getImportType().equals("A")) {
				// 메인테이블 삭제
				kprOperationMapper.deleteReCustList(slr);
				// 메인테이블 저장
				StatusResDto insertReCustList = new StatusResDto();
				try {
					kprOperationMapper.insertReCustList(slr);
					insertReCustList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertReCustList.setSuccess(false);
					insertReCustList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertReCustList.getSuccess()) {
					// select inset 방식이기 때문에 오류발생시 총건수가 실패건수로 된다.
					failCnt = totCnt;
					errorMessages.add(insertReCustList.getMessage());
				} else {
					successCnt = totCnt;
				}
				// 임포트유형 B 타입(Insert)
			} else if (slr.getImportType().equals("B")) {
				// 키값 Key 중복 Data는 제외 후 Insert
				//StatusResDto insertNotInCustList = systemOperationMapper.insertNotInCustList(slr);

				StatusResDto insertNotInCustList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInCustList(slr);
					insertNotInCustList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInCustList.setSuccess(false);
					insertNotInCustList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInCustList.getSuccess()) {
					// select inset 방식이기 때문에 오류발생시 총건수가 실패건수로 된다.
					failCnt = totCnt;
					errorMessages.add(insertNotInCustList.getMessage());
				} else {
					// 오류 미발생시 키Key 중복제외 건수를 성공 건수
					successCnt = notInCnt;
					failCnt = totCnt - notInCnt;
				}
				for (int i = 0; i < rptCustDup.size(); i++) {
					errorMessages.add("Key 중복 ID : " + rptCustDup.get(i).getId());
				}
				// 임포트유형 C 타입(Update)
			} else if (slr.getImportType().equals("C")) {
				// 업데이트시 메인테이블에 없는 신규값이 있을수 있기 때문에 insert처리를 먼저 해준다.
				// 키값 Key 중복 Data는 제외 후 Insert
				//StatusResDto insertNotInCustList = systemOperationMapper.insertNotInCustList(slr);

				StatusResDto insertNotInCustList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInCustList(slr);
					insertNotInCustList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInCustList.setSuccess(false);
					insertNotInCustList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInCustList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInCustList.getMessage());
				} else {
					custDto = new KprCustListReqDto();
					for (int i = 0; i < rptCust.size(); i++) {
						custDto.setAccntId(rptCust.get(i).getAccntId());
						custDto.setId(rptCust.get(i).getId());
						custDto.setMbrId(rptCust.get(i).getMbrId());
						custDto.setMbrNm(rptCust.get(i).getMbrNm());
						custDto.setMbrYn(rptCust.get(i).getMbrYn());
						custDto.setAge(rptCust.get(i).getAge());
						custDto.setGndrCd(rptCust.get(i).getGndrCd());
						custDto.setBirthDt(rptCust.get(i).getBirthDt());
						custDto.setZipcd(rptCust.get(i).getZipcd());
						custDto.setAddr1(rptCust.get(i).getAddr1());
						custDto.setAddr2(rptCust.get(i).getAddr2());
						custDto.setFstJoinDt(rptCust.get(i).getFstJoinDt());
						custDto.setFstJoinStoreId(rptCust.get(i).getFstJoinStoreId());
						custDto.setRfmGrdCd(rptCust.get(i).getRfmGrdCd());
						custDto.setDmRecvYn(rptCust.get(i).getDmRecvYn());
						custDto.setSmsRecvYn(rptCust.get(i).getSmsRecvYn());
						custDto.setTmRecvYn(rptCust.get(i).getTmRecvYn());
						custDto.setEmailRecvYn(rptCust.get(i).getEmailRecvYn());
						custDto.setHpNum(rptCust.get(i).getHpNum());
						custDto.setEmail(rptCust.get(i).getEmail());
						custDto.setInformMdfDt(rptCust.get(i).getInformMdfDt());
						custDto.setWithdrawDt(rptCust.get(i).getWithdrawDt());
						custDto.setEmpYn(rptCust.get(i).getEmpYn());
						custDto.setFstPurDt(rptCust.get(i).getFstPurDt());
						custDto.setEmailPublicYn(rptCust.get(i).getEmailPublicYn());
						custDto.setAlarmFavSiteYn(rptCust.get(i).getAlarmFavSiteYn());
						custDto.setAlarmMySiteYn(rptCust.get(i).getAlarmMySiteYn());
						custDto.setAlarmJoinSiteYn(rptCust.get(i).getAlarmJoinSiteYn());
						custDto.setAlarmPostReplyYn(rptCust.get(i).getAlarmPostReplyYn());
						custDto.setAlarmSiteNoticeYn(rptCust.get(i).getAlarmSiteNoticeYn());
						custDto.setMbrSts(rptCust.get(i).getMbrSts());
						custDto.setMbrValue(rptCust.get(i).getMbrValue());
						custDto.setMbrLc(rptCust.get(i).getMbrLc());
						custDto.setMbrGrd(rptCust.get(i).getMbrGrd());
						custDto.setMbrGrwType(rptCust.get(i).getMbrGrwType());
						custDto.setMbrStsChgDt(rptCust.get(i).getMbrStsChgDt());
						custDto.setMileage(rptCust.get(i).getMileage());
						custDto.setLstPurDt(rptCust.get(i).getLstPurDt());
						// 모든 Data Key값 기준으로 Update
						//StatusResDto updateReCustList = systemOperationMapper.updateReCustList(custDto);

						StatusResDto updateReCustList = new StatusResDto();

						try {
							kprOperationMapper.updateReCustList(custDto);
							updateReCustList.setSuccess(true);
						} catch (Exception e) {
							String str = getPrintStacTraceString(e);
							int sIdx = str.indexOf("Cause:");
							int eIdx = str.indexOf("; nested");

							updateReCustList.setSuccess(false);
							updateReCustList.setMessage((String) str.substring(sIdx, eIdx));
						}

						if (updateReCustList.getSuccess()) {
							successCnt++;
						} else {
							failCnt++;
							errorMessages.add(updateReCustList.getMessage());
						}
					}
				}
			}
		} else if (slr.getTableId().equals("T_O_STORE")) {
			List<KprStoreListResDto> rptStore = kprOperationMapper.selectTmpStoreList(slr);
			List<KprDuplicateValResDto> rptStoreDup = kprOperationMapper.selectStoreDupList(slr);
			totCnt = rptStore.size();
			notInCnt = kprOperationMapper.selectStoreNoCnt(slr);
			if (slr.getImportType().equals("A")) {
				kprOperationMapper.deleteReStoreList(slr);
				//StatusResDto insertReStoreList = systemOperationMapper.insertReStoreList(slr);

				StatusResDto insertReStoreList = new StatusResDto();

				try {
					kprOperationMapper.insertReStoreList(slr);
					insertReStoreList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertReStoreList.setSuccess(false);
					insertReStoreList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertReStoreList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertReStoreList.getMessage());
				} else {
					successCnt = totCnt;
				}
			} else if (slr.getImportType().equals("B")) {
				//StatusResDto insertNotInStoreList = systemOperationMapper.insertNotInStoreList(slr);

				StatusResDto insertNotInStoreList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInStoreList(slr);
					insertNotInStoreList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInStoreList.setSuccess(false);
					insertNotInStoreList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInStoreList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInStoreList.getMessage());
				} else {
					successCnt = notInCnt;
					failCnt = totCnt - notInCnt;
				}
				for (int i = 0; i < rptStoreDup.size(); i++) {
					errorMessages.add("Key 중복 ID : " + rptStoreDup.get(i).getId());
				}
			} else if (slr.getImportType().equals("C")) {
				//StatusResDto insertNotInStoreList = systemOperationMapper.insertNotInStoreList(slr);

				StatusResDto insertNotInStoreList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInStoreList(slr);
					insertNotInStoreList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInStoreList.setSuccess(false);
					insertNotInStoreList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInStoreList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInStoreList.getMessage());
				} else {
					storeDto = new KprStoreListReqDto();
					for (int i = 0; i < rptStore.size(); i++) {
						storeDto.setAccntId(rptStore.get(i).getAccntId());
						storeDto.setId(rptStore.get(i).getId());
						storeDto.setBrand(rptStore.get(i).getBrand());
						storeDto.setStoreNm(rptStore.get(i).getStoreNm());
						storeDto.setStoreType(rptStore.get(i).getStoreType());
						storeDto.setTelNo(rptStore.get(i).getTelNo());
						storeDto.setDeptId(rptStore.get(i).getDeptId());
						storeDto.setParAccntId(rptStore.get(i).getParAccntId());
						storeDto.setOrgId(rptStore.get(i).getOrgId());

						//StatusResDto updateReStoreList = systemOperationMapper.updateReStoreList(storeDto);

						StatusResDto updateReStoreList = new StatusResDto();

						try {
							kprOperationMapper.updateReStoreList(storeDto);
							updateReStoreList.setSuccess(true);
						} catch (Exception e) {
							String str = getPrintStacTraceString(e);
							int sIdx = str.indexOf("Cause:");
							int eIdx = str.indexOf("; nested");

							updateReStoreList.setSuccess(false);
							updateReStoreList.setMessage((String) str.substring(sIdx, eIdx));
						}

						if (updateReStoreList.getSuccess()) {
							successCnt++;
						} else {
							failCnt++;
							errorMessages.add(updateReStoreList.getMessage());
						}
					}
				}
			}
		} else if (slr.getTableId().equals("T_O_SALES")) {
			List<KprSalesListResDto> rptSales = kprOperationMapper.selectTmpSalesList(slr);
			List<KprDuplicateValResDto> rptSalesDup = kprOperationMapper.selectSalesDupList(slr);
			totCnt = rptSales.size();
			notInCnt = kprOperationMapper.selectSalesNoCnt(slr);
			if (slr.getImportType().equals("A")) {
				kprOperationMapper.deleteReSalesList(slr);
				//StatusResDto insertReSalesList = systemOperationMapper.insertReSalesList(slr);

				StatusResDto insertReSalesList = new StatusResDto();

				try {
					kprOperationMapper.insertReSalesList(slr);
					insertReSalesList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertReSalesList.setSuccess(false);
					insertReSalesList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertReSalesList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertReSalesList.getMessage());
				} else {
					successCnt = totCnt;
				}
			} else if (slr.getImportType().equals("B")) {
				//StatusResDto insertNotInSalesList = systemOperationMapper.insertNotInSalesList(slr);

				StatusResDto insertNotInSalesList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInSalesList(slr);
					insertNotInSalesList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInSalesList.setSuccess(false);
					insertNotInSalesList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInSalesList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInSalesList.getMessage());
				} else {
					successCnt = notInCnt;
					failCnt = totCnt - notInCnt;
				}
				for (int i = 0; i < rptSalesDup.size(); i++) {
					errorMessages.add("Key 중복 ID : " + rptSalesDup.get(i).getId());
				}
			} else if (slr.getImportType().equals("C")) {
				//StatusResDto insertNotInSalesList = systemOperationMapper.insertNotInSalesList(slr);

				StatusResDto insertNotInSalesList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInSalesList(slr);
					insertNotInSalesList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInSalesList.setSuccess(false);
					insertNotInSalesList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInSalesList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInSalesList.getMessage());
				} else {
					salesDto = new KprSalesListReqDto();
					for (int i = 0; i < rptSales.size(); i++) {
						salesDto.setAccntId(rptSales.get(i).getAccntId());
						salesDto.setId(rptSales.get(i).getId());
						salesDto.setStoreId(rptSales.get(i).getStoreId());
						salesDto.setSalesDt(rptSales.get(i).getSalesDt());
						salesDto.setSalesType(rptSales.get(i).getSalesType());
						salesDto.setQty(rptSales.get(i).getQty());
						salesDto.setTotSalesAmt(rptSales.get(i).getTotSalesAmt());
						salesDto.setRealSalesAmt(rptSales.get(i).getRealSalesAmt());
						salesDto.setTotDcAmt(rptSales.get(i).getTotDcAmt());
						salesDto.setSalesEmpId(rptSales.get(i).getSalesEmpId());
						salesDto.setCpnNo(rptSales.get(i).getCpnNo());
						salesDto.setMbrId(rptSales.get(i).getMbrId());
						salesDto.setOfferNo(rptSales.get(i).getOfferNo());

						//StatusResDto updateReSalesList = systemOperationMapper.updateReSalesList(salesDto);

						StatusResDto updateReSalesList = new StatusResDto();

						try {
							kprOperationMapper.updateReSalesList(salesDto);
							updateReSalesList.setSuccess(true);
						} catch (Exception e) {
							String str = getPrintStacTraceString(e);
							int sIdx = str.indexOf("Cause:");
							int eIdx = str.indexOf("; nested");

							updateReSalesList.setSuccess(false);
							updateReSalesList.setMessage((String) str.substring(sIdx, eIdx));
						}
						if (updateReSalesList.getSuccess()) {
							successCnt++;
						} else {
							failCnt++;
							errorMessages.add(updateReSalesList.getMessage());
						}
					}
				}
			}
		} else if (slr.getTableId().equals("T_O_SALES_DTL")) {
			List<KprSalesDtlListResDto> rptSalesDtl = kprOperationMapper.selectTmpSalesDtlList(slr);
			List<KprDuplicateValResDto> rptSalesDtlDup = kprOperationMapper.selectSalesDtlDupList(slr);
			totCnt = rptSalesDtl.size();
			notInCnt = kprOperationMapper.selectSalesDtlNoCnt(slr);
			if (slr.getImportType().equals("A")) {
				kprOperationMapper.deleteReSalesDtlList(slr);
				//StatusResDto insertReSalesDtlList = systemOperationMapper.insertReSalesDtlList(slr);

				StatusResDto insertReSalesDtlList = new StatusResDto();

				try {
					kprOperationMapper.insertReSalesDtlList(slr);
					insertReSalesDtlList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertReSalesDtlList.setSuccess(false);
					insertReSalesDtlList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertReSalesDtlList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertReSalesDtlList.getMessage());
				} else {
					successCnt = totCnt;
				}
			} else if (slr.getImportType().equals("B")) {
				//StatusResDto insertNotInSalesDtlList = systemOperationMapper.insertNotInSalesDtlList(slr);

				StatusResDto insertNotInSalesDtlList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInSalesDtlList(slr);
					insertNotInSalesDtlList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInSalesDtlList.setSuccess(false);
					insertNotInSalesDtlList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInSalesDtlList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInSalesDtlList.getMessage());
				} else {
					successCnt = notInCnt;
					failCnt = totCnt - notInCnt;
				}
				for (int i = 0; i < rptSalesDtlDup.size(); i++) {
					errorMessages.add("Key 중복 ID : " + rptSalesDtlDup.get(i).getId());
				}
			} else if (slr.getImportType().equals("C")) {
				//StatusResDto insertNotInSalesDtlList = systemOperationMapper.insertNotInSalesDtlList(slr);

				StatusResDto insertNotInSalesDtlList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInSalesDtlList(slr);
					insertNotInSalesDtlList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInSalesDtlList.setSuccess(false);
					insertNotInSalesDtlList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInSalesDtlList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInSalesDtlList.getMessage());
				} else {
					salesDtlDto = new KprSalesDtlListReqDto();
					for (int i = 0; i < rptSalesDtl.size(); i++) {
						salesDtlDto.setAccntId(rptSalesDtl.get(i).getAccntId());
						salesDtlDto.setId(rptSalesDtl.get(i).getId());
						salesDtlDto.setSalesId(rptSalesDtl.get(i).getSalesId());
						salesDtlDto.setSalesDt(rptSalesDtl.get(i).getSalesDt());
						salesDtlDto.setProdId(rptSalesDtl.get(i).getProdId());
						salesDtlDto.setQty(rptSalesDtl.get(i).getQty());
						salesDtlDto.setAmt(rptSalesDtl.get(i).getAmt());

						//StatusResDto updateReSalesDtlList = systemOperationMapper.updateReSalesDtlList(salesDtlDto);

						StatusResDto updateReSalesDtlList = new StatusResDto();

						try {
							kprOperationMapper.updateReSalesDtlList(salesDtlDto);
							updateReSalesDtlList.setSuccess(true);
						} catch (Exception e) {
							String str = getPrintStacTraceString(e);
							int sIdx = str.indexOf("Cause:");
							int eIdx = str.indexOf("; nested");

							updateReSalesDtlList.setSuccess(false);
							updateReSalesDtlList.setMessage((String) str.substring(sIdx, eIdx));
						}

						if (updateReSalesDtlList.getSuccess()) {
							successCnt++;
						} else {
							failCnt++;
							errorMessages.add(updateReSalesDtlList.getMessage());
						}
					}
				}
			}
		} else if (slr.getTableId().equals("T_O_SALES_PAY")) {
			List<KprSalesPayListResDto> rptSalesPay = kprOperationMapper.selectTmpSalesPayList(slr);
			List<KprDuplicateValResDto> rptSalesPayDup = kprOperationMapper.selectSalesPayDupList(slr);
			totCnt = rptSalesPay.size();
			notInCnt = kprOperationMapper.selectSalesPayNoCnt(slr);
			if (slr.getImportType().equals("A")) {
				kprOperationMapper.deleteReSalesPayList(slr);
				//StatusResDto insertReSalesPayList = systemOperationMapper.insertReSalesPayList(slr);

				StatusResDto insertReSalesPayList = new StatusResDto();

				try {
					kprOperationMapper.insertReSalesPayList(slr);
					insertReSalesPayList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertReSalesPayList.setSuccess(false);
					insertReSalesPayList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertReSalesPayList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertReSalesPayList.getMessage());
				} else {
					successCnt = totCnt;
				}
			} else if (slr.getImportType().equals("B")) {
				//StatusResDto insertNotInSalesPayList = systemOperationMapper.insertNotInSalesPayList(slr);

				StatusResDto insertNotInSalesPayList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInSalesPayList(slr);
					insertNotInSalesPayList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInSalesPayList.setSuccess(false);
					insertNotInSalesPayList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInSalesPayList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInSalesPayList.getMessage());
				} else {
					successCnt = notInCnt;
					failCnt = totCnt - notInCnt;
				}
				for (int i = 0; i < rptSalesPayDup.size(); i++) {
					errorMessages.add("Key 중복 ID : " + rptSalesPayDup.get(i).getId());
				}
			} else if (slr.getImportType().equals("C")) {
				//StatusResDto insertNotInSalesPayList = systemOperationMapper.insertNotInSalesPayList(slr);

				StatusResDto insertNotInSalesPayList = new StatusResDto();

				try {
					insertNotInSalesPayList.setSuccess(true);
					kprOperationMapper.insertNotInSalesPayList(slr);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInSalesPayList.setSuccess(false);
					insertNotInSalesPayList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInSalesPayList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInSalesPayList.getMessage());
				} else {
					salesPayDto = new KprSalesPayListReqDto();
					for (int i = 0; i < rptSalesPay.size(); i++) {
						salesPayDto.setAccntId(rptSalesPay.get(i).getAccntId());
						salesPayDto.setId(rptSalesPay.get(i).getId());
						salesPayDto.setSalesId(rptSalesPay.get(i).getSalesId());
						salesPayDto.setPayType(rptSalesPay.get(i).getPayType());
						salesPayDto.setPayAmt(rptSalesPay.get(i).getPayAmt());
						salesPayDto.setDcAmt(rptSalesPay.get(i).getDcAmt());

						//StatusResDto updateReSalesPayList = systemOperationMapper.updateReSalesPayList(salesPayDto);

						StatusResDto updateReSalesPayList = new StatusResDto();

						try {
							kprOperationMapper.updateReSalesPayList(salesPayDto);
							updateReSalesPayList.setSuccess(true);
						} catch (Exception e) {
							String str = getPrintStacTraceString(e);
							int sIdx = str.indexOf("Cause:");
							int eIdx = str.indexOf("; nested");

							updateReSalesPayList.setSuccess(false);
							updateReSalesPayList.setMessage((String) str.substring(sIdx, eIdx));
						}

						if (updateReSalesPayList.getSuccess()) {
							successCnt++;
						} else {
							failCnt++;
							errorMessages.add(updateReSalesPayList.getMessage());
						}
					}
				}
			}
		} else if (slr.getTableId().equals("T_O_CARD")) {
			List<KprCardListResDto> rptCard = kprOperationMapper.selectTmpCardList(slr);
			List<KprDuplicateValResDto> rptCardDup = kprOperationMapper.selectCardDupList(slr);
			totCnt = rptCard.size();
			notInCnt = kprOperationMapper.selectCardNoCnt(slr);
			if (slr.getImportType().equals("A")) {
				kprOperationMapper.deleteReCardList(slr);
				//StatusResDto insertReCardList = systemOperationMapper.insertReCardList(slr);

				StatusResDto insertReCardList = new StatusResDto();

				try {
					kprOperationMapper.insertReCardList(slr);
					insertReCardList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertReCardList.setSuccess(false);
					insertReCardList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertReCardList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertReCardList.getMessage());
				} else {
					successCnt = totCnt;
				}
			} else if (slr.getImportType().equals("B")) {
				//StatusResDto insertNotInCardList = systemOperationMapper.insertNotInCardList(slr);

				StatusResDto insertNotInCardList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInCardList(slr);
					insertNotInCardList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInCardList.setSuccess(false);
					insertNotInCardList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInCardList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInCardList.getMessage());
				} else {
					successCnt = notInCnt;
					failCnt = totCnt - notInCnt;
				}
				for (int i = 0; i < rptCardDup.size(); i++) {
					errorMessages.add("Key 중복 ID : " + rptCardDup.get(i).getId());
				}
			} else if (slr.getImportType().equals("C")) {
				//StatusResDto insertNotInCardList = systemOperationMapper.insertNotInCardList(slr);

				StatusResDto insertNotInCardList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInCardList(slr);
					insertNotInCardList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInCardList.setSuccess(false);
					insertNotInCardList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInCardList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInCardList.getMessage());
				} else {
					cardDto = new KprCardListReqDto();
					for (int i = 0; i < rptCard.size(); i++) {
						cardDto.setAccntId(rptCard.get(i).getAccntId());
						cardDto.setId(rptCard.get(i).getId());
						cardDto.setUseYn(rptCard.get(i).getUseYn());
						cardDto.setIssueDt(rptCard.get(i).getIssueDt());
						cardDto.setCardNo(rptCard.get(i).getCardNo());
						cardDto.setBarcodeNo(rptCard.get(i).getBarcodeNo());
						cardDto.setQrCd(rptCard.get(i).getQrCd());
						cardDto.setMbrId(rptCard.get(i).getMbrId());

						//StatusResDto updateReCardList = systemOperationMapper.updateReCardList(cardDto);
						StatusResDto updateReCardList = new StatusResDto();

						try {
							kprOperationMapper.updateReCardList(cardDto);
							updateReCardList.setSuccess(true);
						} catch (Exception e) {
							String str = getPrintStacTraceString(e);
							int sIdx = str.indexOf("Cause:");
							int eIdx = str.indexOf("; nested");

							updateReCardList.setSuccess(false);
							updateReCardList.setMessage((String) str.substring(sIdx, eIdx));
						}

						if (updateReCardList.getSuccess()) {
							successCnt++;
						} else {
							failCnt++;
							errorMessages.add(updateReCardList.getMessage());
						}
					}
				}
			}
		} else if (slr.getTableId().equals("T_O_SALES_MILEAGE")) {
			List<KprSalesMileageListResDto> rptSalesMileage = kprOperationMapper.selectTmpSalesMileageList(slr);
			List<KprDuplicateValResDto> rptSalesMileageDup = kprOperationMapper.selectSalesMileageDupList(slr);
			totCnt = rptSalesMileage.size();
			notInCnt = kprOperationMapper.selectSalesMileageNoCnt(slr);
			if (slr.getImportType().equals("A")) {
				kprOperationMapper.deleteReSalesMileageList(slr);
				//StatusResDto insertReSalesMileageList = systemOperationMapper.insertReSalesMileageList(slr);

				StatusResDto insertReSalesMileageList = new StatusResDto();

				try {
					kprOperationMapper.insertReSalesMileageList(slr);
					insertReSalesMileageList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertReSalesMileageList.setSuccess(false);
					insertReSalesMileageList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertReSalesMileageList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertReSalesMileageList.getMessage());
				} else {
					successCnt = totCnt;
				}
			} else if (slr.getImportType().equals("B")) {
				//StatusResDto insertNotInSalesMileageList = systemOperationMapper.insertNotInSalesMileageList(slr);

				StatusResDto insertNotInSalesMileageList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInSalesMileageList(slr);
					insertNotInSalesMileageList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInSalesMileageList.setSuccess(false);
					insertNotInSalesMileageList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInSalesMileageList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInSalesMileageList.getMessage());
				} else {
					successCnt = notInCnt;
					failCnt = totCnt - notInCnt;
				}
				for (int i = 0; i < rptSalesMileageDup.size(); i++) {
					errorMessages.add("Key 중복 ID : " + rptSalesMileageDup.get(i).getId());
				}
			} else if (slr.getImportType().equals("C")) {
				//				StatusResDto insertNotInSalesMileageList = systemOperationMapper.insertNotInSalesMileageList(slr);

				StatusResDto insertNotInSalesMileageList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInSalesMileageList(slr);
					insertNotInSalesMileageList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					rtnValue.setSuccess(false);
					rtnValue.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInSalesMileageList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInSalesMileageList.getMessage());
				} else {
					salesMilDto = new KprSalesMileageListReqDto();
					for (int i = 0; i < rptSalesMileage.size(); i++) {
						salesMilDto.setAccntId(rptSalesMileage.get(i).getAccntId());
						salesMilDto.setId(rptSalesMileage.get(i).getId());
						salesMilDto.setSalesId(rptSalesMileage.get(i).getSalesId());
						salesMilDto.setMileType(rptSalesMileage.get(i).getMileType());
						salesMilDto.setMileAmt(rptSalesMileage.get(i).getMileAmt());
						salesMilDto.setCardId(rptSalesMileage.get(i).getCardId());

						//						StatusResDto updateReSalesMileageList = systemOperationMapper.updateReSalesMileageList(salesMilDto);

						StatusResDto updateReSalesMileageList = new StatusResDto();

						try {
							kprOperationMapper.updateReSalesMileageList(salesMilDto);
							rtnValue.setSuccess(true);
						} catch (Exception e) {
							String str = getPrintStacTraceString(e);
							int sIdx = str.indexOf("Cause:");
							int eIdx = str.indexOf("; nested");

							rtnValue.setSuccess(false);
							rtnValue.setMessage((String) str.substring(sIdx, eIdx));
						}

						if (updateReSalesMileageList.getSuccess()) {
							successCnt++;
						} else {
							failCnt++;
							errorMessages.add(updateReSalesMileageList.getMessage());
						}
					}
				}
			}
		} else if (slr.getTableId().equals("T_O_PROD")) {
			List<KprProdListResDto> rptProd = kprOperationMapper.selectTmpProdList(slr);
			List<KprDuplicateValResDto> rptProdDup = kprOperationMapper.selectProdDupList(slr);
			totCnt = rptProd.size();
			notInCnt = kprOperationMapper.selectProdNoCnt(slr);
			if (slr.getImportType().equals("A")) {
				kprOperationMapper.deleteReProdList(slr);
				//StatusResDto insertReProdList = systemOperationMapper.insertReProdList(slr);

				StatusResDto insertReProdList = new StatusResDto();

				try {
					kprOperationMapper.insertReProdList(slr);
					insertReProdList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertReProdList.setSuccess(false);
					insertReProdList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertReProdList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertReProdList.getMessage());
				} else {
					successCnt = totCnt;
				}
			} else if (slr.getImportType().equals("B")) {
				//StatusResDto insertNotInProdList = systemOperationMapper.insertNotInProdList(slr);

				StatusResDto insertNotInProdList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInProdList(slr);
					insertNotInProdList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInProdList.setSuccess(false);
					insertNotInProdList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInProdList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInProdList.getMessage());
				} else {
					successCnt = notInCnt;
					failCnt = totCnt - notInCnt;
				}
				for (int i = 0; i < rptProdDup.size(); i++) {
					errorMessages.add("Key 중복 ID : " + rptProdDup.get(i).getId());
				}
			} else if (slr.getImportType().equals("C")) {
				//StatusResDto insertNotInProdList = systemOperationMapper.insertNotInProdList(slr);

				StatusResDto insertNotInProdList = new StatusResDto();

				try {
					kprOperationMapper.insertNotInProdList(slr);
					insertNotInProdList.setSuccess(true);
				} catch (Exception e) {
					String str = getPrintStacTraceString(e);
					int sIdx = str.indexOf("Cause:");
					int eIdx = str.indexOf("; nested");

					insertNotInProdList.setSuccess(false);
					insertNotInProdList.setMessage((String) str.substring(sIdx, eIdx));
				}

				if (!insertNotInProdList.getSuccess()) {
					failCnt = totCnt;
					errorMessages.add(insertNotInProdList.getMessage());
				} else {
					prodDto = new KprProdListReqDto();
					for (int i = 0; i < rptProd.size(); i++) {
						prodDto.setAccntId(rptProd.get(i).getAccntId());
						prodDto.setId(rptProd.get(i).getId());
						prodDto.setPrdCd(rptProd.get(i).getPrdCd());
						prodDto.setPrdNm(rptProd.get(i).getPrdNm());
						prodDto.setBrand(rptProd.get(i).getBrand());
						prodDto.setPrdLar(rptProd.get(i).getPrdLar());
						prodDto.setPrdMid(rptProd.get(i).getPrdMid());
						prodDto.setPrdSml(rptProd.get(i).getPrdSml());

						//StatusResDto updateReProdList = systemOperationMapper.updateReProdList(prodDto);

						StatusResDto updateReProdList = new StatusResDto();

						try {
							kprOperationMapper.updateReProdList(prodDto);
							updateReProdList.setSuccess(true);
						} catch (Exception e) {
							String str = getPrintStacTraceString(e);
							int sIdx = str.indexOf("Cause:");
							int eIdx = str.indexOf("; nested");

							updateReProdList.setSuccess(false);
							updateReProdList.setMessage((String) str.substring(sIdx, eIdx));
						}

						if (updateReProdList.getSuccess()) {
							successCnt++;
						} else {
							failCnt++;
							errorMessages.add(updateReProdList.getMessage());
						}
					}
				}
			}
		}
		long endTime = System.currentTimeMillis(); // 종료시간

		// Calendar c = Calendar.getInstance();
		String yyyymmdd = DateUtil.getToday("YYYYMMDD"); // String.valueOf(c.get(Calendar.YEAR))+String.valueOf(c.get(Calendar.MONTH)+1)+String.valueOf(c.get(Calendar.DATE));
		Float uploadTime = (endTime - startTime) / 1000.0f;
		String upTime = String.format("%.2f", uploadTime);

		// 업로드 결과 저장
		KprSetUploadResultReqDto urr = new KprSetUploadResultReqDto();
		urr.setAllCnt(totCnt);
		urr.setOkCnt(successCnt);
		urr.setNoCnt(failCnt);
		urr.setFileNm(slr.getFileNm());
		urr.setCreateBy(slr.getCreateBy());
		urr.setAccntId(slr.getAccountId());
		urr.setUploadTime(upTime);
		urr.setUploadStartTime(yyyymmdd + formatTime(startTime));
		urr.setUploadEndTime(yyyymmdd + formatTime(endTime));
		urr.setTableType("MAIN"); // 메인테이블 구분
		urr.setTblNm(slr.getTableId());


		String id = CommonUtil.newRid();
		urr.setId(id);
		KprExcelUploadResultResDto setUploadResult = kprOperationMapper.insertExcelUpResult(urr);
		// 업로드 결과ID 리턴값 설정
		rtnValue.setId(setUploadResult.getMessage());

		// 업로드 Error 내역 저장
		for (int k = 0; k < errorMessages.size(); k++) {
			KprSetUploadErrorReqDto uer = new KprSetUploadErrorReqDto();
			KprGetUploadErrorReqDto guer = new KprGetUploadErrorReqDto();
			String errorMsg = errorMessages.get(k);

			uer.setAccntId(slr.getAccountId());
			uer.setId(setUploadResult.getMessage());
			guer.setAccntId(slr.getAccountId());
			guer.setId(setUploadResult.getMessage());

			Integer seq = kprOperationMapper.selectExcelUpSeq(guer);
			if (seq != null) {
				uer.setSeqIndex(seq);
				uer.setTblNm(slr.getTableId());
				uer.setErrorDesc(errorMsg);

				kprOperationMapper.insertExcelUpErrorList(uer);
			}
		}
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : setUploadError
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 업로드 오류내역 저장
	 */
	public StatusResDto setUploadError(KprSetUploadErrorReqDto uer) {
		LogUtil.param(KprOperationService.class, uer);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		kprOperationMapper.insertExcelUpErrorList(uer);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : getExcelUpResultList
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 업로드 결과 조회 (ACCNT_ID 기준)
	 */
	public GridPagingResDto<KprExcelUploadResDto> getExcelUpResultList(KprExcelUpLoadReqDto dir) {
		LogUtil.param(KprOperationService.class, dir);
		dir.setSVCAlias("aur");
		return new GridPagingResHelper<KprExcelUploadResDto>().newGridPagingResDto(
				dir.init(CommonUtil.getInstance().getDBType()), kprOperationMapper.selectExcelUpResultList(dir));
	}

	/**
	 * 
	 * @programId :
	 * @name : getExcelUpResult
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 업로드 결과 조회 (ACCNT_ID, ID 기준)
	 */
	public GridPagingResDto<KprExcelUploadResDto> getExcelUpResult(KprExcelUpLoadReqDto dir) {
		LogUtil.param(KprOperationService.class, dir);
		dir.setSVCAlias("aur");
		return new GridPagingResHelper<KprExcelUploadResDto>().newGridPagingResDto(
				dir.init(CommonUtil.getInstance().getDBType()), kprOperationMapper.selectExcelUpResult(dir));
	}

	/**
	 * 
	 * @programId :
	 * @name : getUploadErrorList
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 업로드 오류내역 조회
	 */
	public GridPagingResDto<KprExcelUploadResDto> getUploadErrorList(KprExcelUpLoadReqDto dir) {
		LogUtil.param(KprOperationService.class, dir);
		dir.setSVCAlias("");
		return new GridPagingResHelper<KprExcelUploadResDto>().newGridPagingResDto(
				dir.init(CommonUtil.getInstance().getDBType()), kprOperationMapper.selectUploadErrorList(dir));
	}

	/**
	 * 
	 * @programId :
	 * @name : formatTime
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 날짜 포맷지정
	 */
	public String formatTime(long lTime) {
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(lTime);
		return String.format("%02d%02d%02d", c.get(Calendar.HOUR_OF_DAY), c.get(Calendar.MINUTE), c.get(Calendar.SECOND));
	}

	/**
	 * @programId :
	 * @name : getTableColListByType
	 * @date : 2017. 7. 25.
	 * @author : jh.kim
	 * @table :
	 * @return : List<KprGetTableColListResDto>
	 * @description : 테이블 컬럼 타입별 목록 조회
	 */
	public List<KprGetTableColListResDto> getTableColListByType(KprGetTableColListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("c");
		return kprOperationMapper.selectTableColListByType(reqDto);
	}

	/**
	 * @programId :
	 * @name : editTableColsConvert
	 * @date : 2017. 7. 26.
	 * @author : jh.kim
	 * @table :
	 * @return :
	 * @description : 테이블 컬럼 타입 일괄 변경
	 */
	public StatusResDto editTableColsType(KprEditTableColConvertReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		kprOperationMapper.updateTableColsType(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId : ANL_TBL_P06
	 * @name : setTableImport
	 * @date : 2017. 12. 20.
	 * @author : 이기오
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 정보 불러오기
	 */
	public KprTableResDto saveTableImport(KprSetTableListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		KprTableResDto resDto = new KprTableResDto();
		StringBuilder messageBuilder = new StringBuilder();
		List<KprSetTableListReqDto> tableDataList = reqDto.getTableDataList();

		int successCnt = 0;
		int failureCnt = 0;

		if (ObjectUtil.isNotEmpty(tableDataList)) {
			//this.startTransaction();
			for (KprSetTableListReqDto tableData : tableDataList) {
				tableData.setCreateBy(reqDto.getCreateBy());
				tableData.setModifyBy(reqDto.getModifyBy());
				tableData.setDbType(reqDto.getDbType());

				KprSubjectAreaListReqDto subjectReqDto = new KprSubjectAreaListReqDto();
				subjectReqDto.setSubjectDbRelId(tableData.getSubjectDbRelId());
				subjectReqDto.setDbInformId(tableData.getDbInformId());

				KprTableMstListReqDto tableMstReqDto = new KprTableMstListReqDto();
				tableMstReqDto.setTblNm(tableData.getTblNm());
				tableMstReqDto.setSchmaNm(tableData.getSchmaNm());
				tableMstReqDto.setDbInformId(tableData.getDbInformId());

				subjectReqDto.setSVCAlias("sa");
				KprSubjectAreaListResDto subjectResDto = kprOperationMapper.selectSubjectAreaNmRtn(subjectReqDto);
				String subjectAreaNm = subjectResDto.getSubjectAreaNm();
				String tblTypeCode = null;

				if ("DIMENSION".equalsIgnoreCase(subjectAreaNm)) {
					tblTypeCode = "DIM";
				} else if ("AGGREGATION".equalsIgnoreCase(subjectAreaNm)) {
					tblTypeCode = "AGG";
				} else {
					tblTypeCode = "FACT";
				}

				tableData.setTblTypeCd(tblTypeCode);

				KprTableMstListResDto tableMstResDto = this.tableNmChk(tableMstReqDto);
				if (ObjectUtil.isNotEmpty(tableMstResDto) && tableMstResDto.getCnt() > 0) {
					tableMstResDto = kprOperationMapper.tableLgcChk(tableMstReqDto);

					if (ObjectUtil.isEmpty(tableMstResDto) || tableMstResDto.getCnt() == 0) {
						KprDelTableReqDto delTableColReqDto = new KprDelTableReqDto();
						delTableColReqDto.setTblNm(tableData.getTblNm());
						delTableColReqDto.setSchmaNm(tableData.getSchmaNm());

						this.removeTableColumn(delTableColReqDto);
						this.removeTable(delTableColReqDto);

						boolean saveTableColumnFlag = this.saveTableColumnData(tableData);
						if (saveTableColumnFlag) {
							successCnt++;
						}
					} else {
						messageBuilder.append(tableData.getTblNm() + " " + Messages.getMessage("M01649", reqDto.getLang()) + "\n");
						failureCnt++;
					}
				} else {
					boolean saveTableColumnFlag = this.saveTableColumnData(tableData);
					if (saveTableColumnFlag) {
						successCnt++;
					}
				}
			}

			resDto.setSuccess(true);
			resDto.setTotalTableCnt(tableDataList.size());
			resDto.setSuccessTableCnt(successCnt);
			resDto.setFailureTableCnt(failureCnt);

			//this.commitTransaction();
			//this.endTransaction();
		}

		if (ObjectUtil.isNotEmpty(messageBuilder.toString())) {
			resDto.setMessage(messageBuilder.toString());
		}
		return resDto;
	}

	private boolean saveTableColumnData(KprSetTableListReqDto tableDataDto) {
		StatusResDto tableImportResDto = this.setTableImport(tableDataDto);
		if (tableImportResDto.getSuccess()) {
			KprTableColImportReqDto colImportReqDto = new KprTableColImportReqDto();
			colImportReqDto.setTblNm(tableDataDto.getTblNm());
			colImportReqDto.setSchmaNm(tableDataDto.getSchmaNm());
			colImportReqDto.setDbInformId(tableDataDto.getDbInformId());
			List<KprTableColImportResDto> colImportResList = this.getTableColImport(colImportReqDto);

			if (ObjectUtil.isNotEmpty(colImportResList)) {
				for (KprTableColImportResDto colImportResData : colImportResList) {
					KprSetTableAddColReqDto tableColReqDto = new KprSetTableAddColReqDto();
					tableColReqDto.setCreateBy(tableDataDto.getCreateBy());
					tableColReqDto.setModifyBy(tableDataDto.getModifyBy());
					tableColReqDto.setTblNm(tableDataDto.getTblNm());
					tableColReqDto.setTableId(tableDataDto.getTableId());
					tableColReqDto.setSchmaNm(tableDataDto.getSchmaNm());
					tableColReqDto.setDbInformId(tableDataDto.getDbInformId());
					tableColReqDto.setColNm(colImportResData.getColNm());
					tableColReqDto.setDataTypeCd(colImportResData.getDataTypeCd());
					tableColReqDto.setLen(Double.valueOf(colImportResData.getLen()));
					tableColReqDto.setNullYn(colImportResData.getNullYn());
					tableColReqDto.setPkYn(colImportResData.getPkYn());
					tableColReqDto.setSeq(Integer.valueOf(colImportResData.getSeq()));
					tableColReqDto.setDeftVal(colImportResData.getDeftVal());
					tableColReqDto.setDpNm(colImportResData.getDpNm());
					tableColReqDto.setColTypeCd(KprAnalysisConstants.COL_TYPE_CD.DIMENSION.name());
					tableColReqDto.setGropCode("DB_DATA_TYPE_CD");

					this.setTableColImport(tableColReqDto);
				}
			}

			return true;
		}

		return false;
	}

	/**
	 * 
	 * @programId :
	 * @name : getPrintStacTraceString
	 * @date : 2016. 10. 13.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : String 형으로 printStackTrace message 를 돌려 주는 method
	 */
	public static String getPrintStacTraceString(Exception e) {
		String returnValue = "";
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		PrintStream printStream = new PrintStream(out);
		e.printStackTrace(printStream);
		returnValue = out.toString();
		return returnValue;
	}

	/**
	 * @programId :
	 * @name : getDatabaseUseSchema
	 * @date : 2017. 12. 20.
	 * @author : 이기오
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 대상 데이터베이스 스키마 리스트 조회
	 */
	public KprDatabaseUseSchemaResDto getDatabaseUseSchema(KprDatabaseUseSchemaReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		KprDatabaseUseSchemaResDto resDto = new KprDatabaseUseSchemaResDto();

		KprOperationListReqDto databaseInfo = new KprOperationListReqDto();
		databaseInfo.setDbInformId(reqDto.getDatabaseId());
		databaseInfo.setLang(reqDto.getLang());
		MKTDBInfoDTO dbInfo = getDBInfo(databaseInfo);
		String databaseType = dbInfo.getConDbType();
		MKTCommonCodeRequestDTO codeReqDto = new MKTCommonCodeRequestDTO();
		codeReqDto.setLang(reqDto.getLang());
		codeReqDto.setGroupCode(CommonUtil.ANL_DB_TYPE_CD);
		codeReqDto.setCodeName(databaseType);
		MKTCommonCodeResponseDTO codeResDto = systemCommCodeService.getCommCodeDetail(codeReqDto);

		StringBuilder schemaSQL = new StringBuilder();
		schemaSQL.append("select t.schma_nm as \"nodeId\"\n")
				 .append("     , t.schma_nm as \"nodeText\"\n")
				 .append("  from (\n")
				 .append("    " + codeResDto.getAttrib02() + "\n")
				 .append(") t\n")
				 .append(" group by t.schma_nm\n")
				 .append(" order by t.schma_nm");

		resDto.setSuccess(true);
		resDto.setSourceSchemaNameList(mktCallQueryDao.callSelectForList("KPROperation.selectSourceSchemaList", schemaSQL.toString(), new ArrayList<String>(), dbInfo, KprDatabaseUseSchemaResDto.class));
		resDto.setTargetSchemaNameList(kprOperationMapper.selectDatabaseUseSchemaList(reqDto));

		return resDto;
	}

	/**
	 * @programId :
	 * @name : saveDatabaseUseSchemaList
	 * @date : 2017. 12. 20.
	 * @author : 이기오
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 대상 데이터베이스 스키마 C, U, D
	 */
	public StatusResDto saveDatabaseUseSchemaList(KprDatabaseUseSchemaReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto resDto = new StatusResDto();

		//this.startTransaction();
		List<KprDatabaseUseSchemaReqDto> useSchemaList = reqDto.getUseSchemaList();
		if (ObjectUtil.isNotEmpty(useSchemaList)) {
			kprOperationMapper.deleteDatabaseUseSchema(reqDto);

			for (KprDatabaseUseSchemaReqDto useSchemaDto : useSchemaList) {
				useSchemaDto.setDatabaseId(reqDto.getDatabaseId());
				useSchemaDto.setCreateBy(reqDto.getCreateBy());
				useSchemaDto.setModifyBy(reqDto.getModifyBy());

				int cntSchemaName = kprOperationMapper.selectDatabaseUseSchemaNameCount(useSchemaDto);
				if (cntSchemaName == 0) {
					kprOperationMapper.insertDatabaseUseSchema(useSchemaDto);
				}
			}
		}

		//		this.commitTransaction();
		//		this.endTransaction();

		resDto.setSuccess(true);
		return resDto;
	}

	/**
	 * @programId :
	 * @name : getDBConCheck
	 * @date : 2020. 03. 27.
	 * @author : yj.choi
	 * @table : 
	 * @return :
	 * @description : db연결확인
	 */

	public StatusResDto getDBConCheck(KprOperationListReqDto dir) {
		StatusResDto resDto = new StatusResDto();
		resDto.setSuccess(false);
		dir.setSVCAlias("d");
		MKTDBInfoDTO dbInfo = getDBInfo(dir);
		StringBuilder sql = new StringBuilder();

		if(dbInfo.getConDbType().equalsIgnoreCase("mssql")){
			sql.append(" select 1 ");
		}
		else { 
			sql.append(" select 1 ");
			sql.append(" from dual");
		}
		try {
			if (ObjectUtil.isNotEmpty(dbInfo)) {

				//resDto =  (StatusResDto) 
				mktCallQueryDao.callSelectObject("getDBConCheck", sql.toString(), new ArrayList<String>(), dbInfo, java.lang.Integer.class);
				resDto.setSuccess(true);
				resDto.setMessage("연결되었습니다.");
			}
		}catch (Exception e) {
			LogUtil.error(e.getMessage(),e);
		}
		return resDto;

	}






}
