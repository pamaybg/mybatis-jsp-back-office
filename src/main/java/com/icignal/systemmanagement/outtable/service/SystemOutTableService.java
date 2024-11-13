package com.icignal.systemmanagement.outtable.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.helper.IFVMErrorHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.external.aws.SecretsManager;
import com.icignal.external.aws.dto.request.AwsSecretManagerReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemColTypeReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteChnlRelReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteColConChnlRelReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteOutColumnReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteOutTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteOutTgtLvlReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteTvlConTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemEditOutColumnReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemEditOutTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemEditOutTgtLvlReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetChannelListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetChannelRelListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetDetailOutColumnReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetDetailOutTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetDetailOutTgtLvlReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetEmailHostListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetFtpConnectListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetOutColumnListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetOutTableListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetOutTgtLvllListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetPermissionListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetWebServiceListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemSetChnlRelReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemSetOutColumnReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemSetOutTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemSetOutTgtLvlReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemTableTypeCheckReqDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetChannelListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetChannelRelListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetDetailOutColumnlResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetDetailOutTalbleResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetDetailOutTgtLvllResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetEmailHostListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetFtpConnectListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetOutColumnListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetOutTalbleListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetOutTgtLvllListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetPermissionListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetWebServiceListResDto;
import com.icignal.systemmanagement.outtable.mapper.SystemOutTableMapper;

/*
 * 1. 클래스명	: SystemOutTableService
 * 2. 파일명	: SystemOutTableService.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.service
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 9. 21.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템운영 - 외부 테이블 관리 Service
 * </PRE>
 */ 
@Service("SystemOutTableService")
public class SystemOutTableService {

	@Autowired
	private SystemOutTableMapper systemOutTableMapper;
	
	@Autowired StandardPBEStringEncryptor encryptor;
	
	/**
	 * @programId : MKT_ADM_005
	 * @name : getpermissionList
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TARGET_LEVEL
	 * @return : GridPagingResDto
	 * @description : 퍼미션 테이블 컬럼 목록 조회
	 */
	public GridPagingResDto<SystemGetPermissionListResDto> getpermissionList(SystemGetPermissionListReqDto met){
		LogUtil.param(SystemOutTableService.class, met);
		met.setSVCAlias("mec");
		
		return new GridPagingResHelper<SystemGetPermissionListResDto>().newGridPagingResDto(
				met.init(CommonUtil.getInstance().getDBType()), systemOutTableMapper.selectpermissionList(met));
	}
	

/**
	 * @programId : MKT_ADM_005
	 * @name : getchannelrel
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TARGET_LEVEL
	 * @return : GridPagingResDto
	 * @description : 채널 관계 테이블 조회
	 */
	public GridPagingResDto<SystemGetChannelRelListResDto> getchannelrel(SystemGetChannelRelListReqDto met){
		LogUtil.param(SystemOutTableService.class, met);
		met.setSVCAlias("meccr");
		
		return new GridPagingResHelper<SystemGetChannelRelListResDto>().newGridPagingResDto(
				met.init(CommonUtil.getInstance().getDBType()), systemOutTableMapper.selectchannelrel(met), AnnotationType.CommCode);
	}
	

/**
	 * @programId : MKT_ADM_005
	 * @name : getchannel
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : comm_code
	 * @return : GridPagingResDto
	 * @description : 채널 목록 조회
	 */
	public GridPagingResDto<SystemGetChannelListResDto> getchannel(SystemGetChannelListReqDto met){
		LogUtil.param(SystemOutTableService.class, met);
		met.setSVCAlias("");
		
		return new GridPagingResHelper<SystemGetChannelListResDto>().newGridPagingResDto(
				met.init(CommonUtil.getInstance().getDBType()), systemOutTableMapper.selectchannel(met));
	}
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : getcolumnList
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TBL
	 * @return : GridPagingResDto
	 * @description : 외부 컬럼 리스트 조회
	 */
	public  GridPagingResDto<SystemGetOutColumnListResDto> getcolumnList(SystemGetOutColumnListReqDto met){
		LogUtil.param(SystemOutTableService.class, met);
		met.setSVCAlias("met");
		
		GridPagingResDto<SystemGetOutColumnListResDto> rtnValue = new GridPagingResDto<SystemGetOutColumnListResDto>();
		
		rtnValue = new GridPagingResHelper<SystemGetOutColumnListResDto>().newGridPagingResDto(
				met.init(CommonUtil.getInstance().getDBType()), systemOutTableMapper.selectcolumnList(met), AnnotationType.CommCode);
		
		//서비스명 별 AWS Secrets Manager 조회
		for(Object dbInfo : rtnValue.getRows()) {
			SystemGetOutColumnListResDto dbInfoDto = new SystemGetOutColumnListResDto();
			dbInfoDto = (SystemGetOutColumnListResDto) dbInfo;
			
			if(ObjectUtil.isNotEmpty(dbInfoDto.getSecretNm())) {

					Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(),  BeansUtil.getAwsRegion()).getSecretMap(dbInfoDto.getSecretNm());

					dbInfoDto.setColKorNm(map.get("colKorNm").toString());
					dbInfoDto.setColEngNm(map.get("colEngNm").toString());
					dbInfoDto.setFlagAtribVal(map.get("flagAtribVal").toString());
					dbInfoDto.setWhereSchMemid(map.get("whereSchMemid").toString());
					dbInfoDto.setWhereSchHp(map.get("whereSchHp").toString());
					dbInfoDto.setWhereSchEmail(map.get("whereSchEmail").toString());
					dbInfoDto.setAttrib01(map.get("attrib01").toString());
					dbInfoDto.setPrmsItemMappgCol(map.get("prmsItemMappgCol").toString());
					dbInfoDto.setWhereSchEmail(map.get("colTypeDefine").toString());
					
					dbInfo = dbInfoDto;
				
			}
		}		
		
		return rtnValue;
	}
	
	

	/**
	 * @programId : MKT_ADM_004 
	 * @name : getTgtLevelList
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TARGET_LEVEL
	 * @return : GridPagingResDto
	 * @description : 외부 타겟 레벨 리스트 조회
	 */
	public GridPagingResDto<SystemGetOutTgtLvllListResDto> getTgtLevelList(SystemGetOutTgtLvllListReqDto met){
		LogUtil.param(SystemOutTableService.class, met);
		met.setSVCAlias("met");
		GridPagingResDto<SystemGetOutTgtLvllListResDto> rtnValue = new GridPagingResDto<SystemGetOutTgtLvllListResDto>();
		rtnValue = new GridPagingResHelper<SystemGetOutTgtLvllListResDto>().newGridPagingResDto(
				met.init(CommonUtil.getInstance().getDBType()), systemOutTableMapper.selectTgtLevelList(met));
	
		//서비스명 별 AWS Secrets Manager 조회
		for(Object dbInfo : rtnValue.getRows()) {
			SystemGetOutTgtLvllListResDto dbInfoDto = new SystemGetOutTgtLvllListResDto();
			dbInfoDto = (SystemGetOutTgtLvllListResDto) dbInfo;
			
			if(ObjectUtil.isNotEmpty(dbInfoDto.getSecretNm())) {
				try {
					Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(),  BeansUtil.getAwsRegion()).getSecretMap(dbInfoDto.getSecretNm());

					if(map.get("dbName") != null) dbInfoDto.setDbNm(map.get("dbName").toString());
					dbInfoDto.setConIp(map.get("ip").toString());
					dbInfoDto.setConPort(map.get("port").toString());
					dbInfoDto.setConId(map.get("username").toString());
					dbInfoDto.setConPw(map.get("password").toString());
					dbInfo = dbInfoDto;
				} catch (ArithmeticException e) {
					LogUtil.error(e.getMessage());
				}

			}
		}
		return rtnValue;
	}
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : getTableList
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TBL
	 * @return : GridPagingResDto
	 * @description : 외부 테이블 리스트 조회
	 */
	public GridPagingResDto<SystemGetOutTalbleListResDto> getTableList(SystemGetOutTableListReqDto met){
		LogUtil.param(SystemOutTableService.class, met);
		met.setSVCAlias("met");
		
		return new GridPagingResHelper<SystemGetOutTalbleListResDto>().newGridPagingResDto(
				met.init(CommonUtil.getInstance().getDBType()), systemOutTableMapper.selectTableList(met), AnnotationType.CommCode);
	}
	
	
	/**
	 * @programId : MKT_ADM_004 
	 * @name : setTgtLevel
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TARGET_LEVEL
	 * @return : GridPagingResDto
	 * @description : 외부 타겟 레벨 추가
	 */
	public StatusResDto setTgtLevel(SystemSetOutTgtLvlReqDto met){
		LogUtil.param(SystemOutTableService.class, met);
		met.setId(CommonUtil.newRid());
		SecretsManager sm = new SecretsManager(BeansUtil.getAWSCredentials(), BeansUtil.getAwsRegion());
		//암호화
		//StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
		//encryptor.setPassword("9pwc3dke");
		
		StatusResDto rtnValue = new StatusResDto();
				
		if(met.isPwChk()){
			String pass = encryptor.encrypt(met.getConPw());
			met.setConPw(pass);
		}
		
	    String serviceMgtType = BeansUtil.getApplicationProperty("icignal.db-connection-info.management-type");

		if(ObjectUtil.isNotEmpty(met.getSecretNm()) && "AwsLoyalty".equals(serviceMgtType)) {

			met.setSecretNm(met.getServiceNm());

			try {
			//DB정보 AWS Secrets Manager 등록
			AwsSecretManagerReqDto param = new AwsSecretManagerReqDto();
			param.setName(met.getSecretNm());
			param.setDescription(met.getTargetDesc());
			
			Map<String, String> secretKeyValue = new HashMap<String, String>();
			secretKeyValue.put("dbName", met.getDbNm());
			secretKeyValue.put("username", met.getConId());
			secretKeyValue.put("password", met.getConPw());
			secretKeyValue.put("ip", met.getConIp());
			secretKeyValue.put("port", met.getConPort());
			
			param.setSecretKeyValue(secretKeyValue);
			
			sm.createSecret(param);
			
			//DB정보 DB 등록
			SystemSetOutTgtLvlReqDto reqDto = new SystemSetOutTgtLvlReqDto();
			reqDto.setId(met.getId());
			reqDto.setCreateBy(met.getCreateBy());
			reqDto.setModifyBy(met.getModifyBy());
			//_met.setAccntId(met.getAccntId());
			reqDto.setTargetLevelNm(met.getTargetLevelNm());
			reqDto.setConDbType(met.getConDbType());
			reqDto.setTargetDesc(met.getTargetLevelNm());
			reqDto.setSecretNm(met.getSecretNm());
			reqDto.setServiceNm(met.getServiceNm());
			
			//systemOutTableMapper.setTgtLevel(_met);
			systemOutTableMapper.insertTgtLevel(reqDto);
			String tgtId = reqDto.getId();
			rtnValue.setMessage(tgtId);
			rtnValue.setSuccess(true);
		}catch(IllegalArgumentException e) {
        	LogUtil.error(e);
        }
		}
			else {
			//systemOutTableMapper.setTgtLevel(met);
			systemOutTableMapper.insertTgtLevel(met);
			String tgtId = met.getId();
			rtnValue.setMessage(tgtId);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
		
	}



	/**
	 * @programId : MKT_ADM_004
	 * @name : setOutTable
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TBL
	 * @return : GridPagingResDto
	 * @description : 외부 테이블 추가
	 */
	public StatusResDto setOutTable(SystemSetOutTableReqDto met){
		LogUtil.param(SystemOutTableService.class, met);
		StatusResDto rtnValue = new StatusResDto();
		
		rtnValue.setSuccess(false);
		String tableId = CommonUtil.newRid();
		met.setId(tableId);
		
//		String tableId = (String) /this.insert("MKTOutTable.insertTable", met);
		
		if(systemOutTableMapper.insertTable( met)>0){
		rtnValue.setMessage(tableId);
		rtnValue.setSuccess(true);
		}
		 return rtnValue;
	}


	/**
	 * @programId : MKT_ADM_004
	 * @name : setOutColumn
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : GridPagingResDto
	 * @description : 컬럼 추가
	 */
	public StatusResDto setOutColumn(SystemSetOutColumnReqDto met){
		LogUtil.param(SystemOutTableService.class, met);
		//SecretsManager SecretsManager = null; 
		SecretsManager sm =	  new SecretsManager(BeansUtil.getAWSCredentials(), BeansUtil.getAwsRegion());
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		String columnId = CommonUtil.newRid();
		met.setId(columnId);
		
		String serviceMgtType = BeansUtil.getApplicationProperty("icignal.db-connection-info.management-type");
		
		if(ObjectUtil.isNotEmpty(met.getSecretNm()) && "AwsLoyalty".equals(serviceMgtType)) {
			
			met.setSecretNm(met.getServiceNm());
			
			//DB정보 AWS Secrets Manager 등록
			AwsSecretManagerReqDto param = new AwsSecretManagerReqDto();
			param.setName(met.getSecretNm());
			param.setDescription(met.getColDesc());
			
			Map<String, String> secretKeyValue = new HashMap<String, String>();
			secretKeyValue.put("colKorNm", met.getColKorNm());
			secretKeyValue.put("colEngNm", met.getColEngNm());
			secretKeyValue.put("flagAtribVal", met.getFlagAtribVal());
			secretKeyValue.put("colSize",met.getColSize());
			secretKeyValue.put("colDesc", met.getColDesc());
			secretKeyValue.put("whereSchMemid", met.getWhereSchMemid());
			secretKeyValue.put("whereSchHp", met.getWhereSchHp());
			secretKeyValue.put("whereSchEmail", met.getWhereSchEmail());
			secretKeyValue.put("prmsItemMappgCol", met.getPrmsItemMappgCol());
			secretKeyValue.put("colTypeDefine", met.getColTypeDefine());
			secretKeyValue.put("attrib01", met.getAttrib01());
			
			param.setSecretKeyValue(secretKeyValue);
			
			sm.createSecret(param);
			
			//DB정보 DB 등록
			SystemSetOutColumnReqDto reqDto = new SystemSetOutColumnReqDto();
			reqDto.setId(met.getId());
			reqDto.setMemId(met.getMemId());
			reqDto.setExtrTblId(met.getExtrTblId());
			reqDto.setSecretNm(met.getSecretNm());
			reqDto.setColTypeCd(met.getColTypeCd());
			
			//rtnValue = systemOutTableMapper.setOutColumn(_met);
			if(systemOutTableMapper.insertColumn(reqDto)>0) {
				rtnValue.setMessage(columnId);
				rtnValue.setSuccess(true);
			}
		}else {
			//rtnValue = systemOutTableMapper.setOutColumn(met);
			if(systemOutTableMapper.insertColumn(met)>0) {
				rtnValue.setMessage(columnId);
				rtnValue.setSuccess(true);
			}
		}
		
		return rtnValue;
	}
		
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : getDtlcolumn
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : GridPagingResDto
	 * @description : 외부 컬럼 상세 조회
	 */
	public SystemGetDetailOutColumnlResDto getDtlcolumn(SystemGetDetailOutColumnReqDto met){
		LogUtil.param(SystemOutTableService.class, met);
		met.setSVCAlias("met");
		SystemGetDetailOutColumnlResDto rtnValue = systemOutTableMapper.selectDtlColumn(met);
		
		return new AnnotationHelper<SystemGetDetailOutColumnlResDto>(AnnotationType.CommCode, rtnValue).getItem() ;
	}

	/**
	 * @programId : MKT_ADM_004
	 * @name : getDtlTable
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TBL
	 * @return : GridPagingResDto
	 * @description : 외부 테이블 상세 조회
	 */
	public SystemGetDetailOutTalbleResDto getDtlTable(SystemGetDetailOutTableReqDto met){
		LogUtil.param(SystemOutTableService.class, met);
		met.setSVCAlias("met");
		SystemGetDetailOutTalbleResDto rtnValue = systemOutTableMapper.selectDtlTable(met);
		
		return new AnnotationHelper<SystemGetDetailOutTalbleResDto>(AnnotationType.ALL, rtnValue).getItem();
	}
		

	/**
	 * @programId : MKT_ADM_004 
	 * @name : getDtlTgtLevel
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TARGET_LEVEL
	 * @return : GridPagingResDto
	 * @description : 외부 타겟 레벨 상세 조회
	 */
	public SystemGetDetailOutTgtLvllResDto getDtlTgtLevel(SystemGetDetailOutTgtLvlReqDto met){
		LogUtil.param(SystemOutTableService.class, met);
		met.setSVCAlias("met");
		
		 SystemGetDetailOutTgtLvllResDto dbInfo = systemOutTableMapper.selectDtlTgtLevel(met);
		//JSONObject dbInfoJSON = new JSONObject();
		if(ObjectUtil.isNotEmpty(dbInfo.getSecretNm())) {
				Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(),  BeansUtil.getAwsRegion()).getSecretMap(dbInfo.getSecretNm());
				
				dbInfo.setDbNm((String)map.get("dbName"));
				dbInfo.setConIp(map.get("ip").toString());
				dbInfo.setConPort(map.get("port").toString());
				dbInfo.setConId(map.get("username").toString());
				dbInfo.setConPw(map.get("password").toString());
					
		}
		return new AnnotationHelper<SystemGetDetailOutTgtLvllResDto>(AnnotationType.ALL, dbInfo).getItem();
	}
	
	
	
	/**
	 * @programId : MKT_ADM_004
	 * @name : deleteOutTbl
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : StatusResDto
	 * @description : 외부 테이블 삭제
	 */
	public StatusResDto removeOutTbl( SystemDeleteOutTableReqDto mdtl){
		LogUtil.param(SystemOutTableService.class, mdtl);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		mdtl.setSVCAlias("");
		systemOutTableMapper.deleteTable(mdtl);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId : MKT_ADM_004
	 * @name : deleteOutColumn
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : StatusResDto
	 * @description : 외부 컬럼 삭제
	 */
	public StatusResDto removeOutColumn( SystemDeleteOutColumnReqDto mdtl){
		LogUtil.param(SystemOutTableService.class, mdtl);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		mdtl.setSVCAlias("");
		systemOutTableMapper.deleteColumn(mdtl);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	

	/**
	 * @programId : MKT_ADM_004
	 * @name : deleteOutTgtLvl
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : StatusResDto
	 * @description : 외부 타겟 레벨 삭제
	 */
	public StatusResDto removeOutTgtLvl( SystemDeleteOutTgtLvlReqDto mdtl){
		LogUtil.param(SystemOutTableService.class, mdtl);
		StatusResDto rtnValue = new StatusResDto();
		SecretsManager sm =	  new SecretsManager(BeansUtil.getAWSCredentials(), BeansUtil.getAwsRegion());
		//mdtl.setSVCAlias("");
		rtnValue.setSuccess(false);
		
		//DB정보 AWS Secrets Manager 삭제
		List<String> secretNms = systemOutTableMapper.getDbinfromSecretNms(mdtl.getTargetLevelId());
		
		 String serviceMgtType = BeansUtil.getApplicationProperty("icignal.db-connection-info.management-type");

		if( "AwsLoyalty".equals(serviceMgtType )) {
		for(String secretNm : secretNms) {
			try{
			AwsSecretManagerReqDto param = new AwsSecretManagerReqDto();
			param.setSecretId(secretNm);
			param.setRecoveryWindowInDays((long) 7);
			
			sm.removeSecretKey(param);
			}catch(IllegalArgumentException e) {
				LogUtil.error(e);
			}
		}
		systemOutTableMapper.deleteTgtLevel(mdtl);
		rtnValue.setSuccess(true);}
		else {		
		systemOutTableMapper.deleteTgtLevel(mdtl);
		}
		return rtnValue;
	}
		
	/**
	 * @programId : MKT_ADM_004
	 * @name : editOutTgtLvl
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : StatusResDto
	 * @description : 외부 타겟 레벨 수정
	 */
	public StatusResDto editOutTgtLvl(SystemEditOutTgtLvlReqDto mdtl){
		LogUtil.param(SystemOutTableService.class, mdtl);
		
		SecretsManager sm = new SecretsManager(BeansUtil.getAWSCredentials(), BeansUtil.getAwsRegion());

		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		//암호화
		//StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
		//encryptor.setPassword("9pwc3dke");
						
		if(mdtl.isPwChk()){
			mdtl.setConPw(encryptor.encrypt(mdtl.getConPw()));
		}
		
	    String serviceMgtType = BeansUtil.getApplicationProperty("icignal.db-connection-info.management-type");
	    
	    if("AwsLoyalty".equals(serviceMgtType)) {
	    	mdtl.setSecretNm(mdtl.getServiceNm());
		
		if(ObjectUtil.isNotEmpty(mdtl.getSecretNm())) {
			
			try{
			//DB정보 AWS Secrets Manager 수정
			AwsSecretManagerReqDto param = new AwsSecretManagerReqDto();
			param.setSecretId(mdtl.getSecretNm());
			param.setDescription(mdtl.getTargetDesc());
			
			Map<String, String> secretKeyValue = new HashMap<String, String>();
			secretKeyValue.put("dbName", mdtl.getDbNm());
			secretKeyValue.put("username", mdtl.getConId());
			secretKeyValue.put("password", mdtl.getConPw());
			secretKeyValue.put("ip", mdtl.getConIp());
			secretKeyValue.put("port", mdtl.getConPort());
			
			param.setSecretKeyValue(secretKeyValue);

			sm.editSecretKey(param);

			//정보수정
			SystemEditOutTgtLvlReqDto reqDto = new SystemEditOutTgtLvlReqDto();
			reqDto.setId(mdtl.getId());
			reqDto.setCreateBy(mdtl.getCreateBy());
			reqDto.setModifyBy(mdtl.getModifyBy());
			//_mdtl.setAccntId(mdtl.getAccntId());
			reqDto.setTargetLevelNm(mdtl.getTargetLevelNm());
			reqDto.setConDbType(mdtl.getConDbType());
			reqDto.setTargetDesc(mdtl.getTargetLevelNm());

	    	systemOutTableMapper.updateTgtLevel(reqDto);
	    	rtnValue.setSuccess(true);
		}catch(IllegalArgumentException e) {
				LogUtil.error(e);
			}
			
		}
	    }
	    else{
			systemOutTableMapper.updateTgtLevel(mdtl);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}
	
		/**
	 * @programId : MKT_ADM_004
	 * @name : editOutColumn
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : StatusResDto
	 * @description : 외부 컬럼 수정
	 */
	public StatusResDto editOutColumn(SystemEditOutColumnReqDto mdtl){
		LogUtil.param(SystemOutTableService.class, mdtl);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		mdtl.setSVCAlias("");
		systemOutTableMapper.updateColumn(mdtl);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
		
	/**
	 * @programId : MKT_ADM_004
	 * @name : editOutTbl
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : StatusResDto
	 * @description : 외부 테이블 수정
	 */
	public StatusResDto editOutTbl(SystemEditOutTableReqDto mdtl){
		LogUtil.param(SystemOutTableService.class, mdtl);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		mdtl.setSVCAlias("");
		systemOutTableMapper.updateTable(mdtl);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	
	/**
	 * @programId : MKT_ADM_005
	 * @name : setChnlRel
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL_chnl_rel
	 * @return : StatusResDto
	 * @description : 챈러 관계 수정
	 */
	public StatusResDto setChnlRel(SystemSetChnlRelReqDto mscr){
		LogUtil.param(SystemOutTableService.class, mscr);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		String id = CommonUtil.newRid();
		mscr.setId(id);
		mscr.setSVCAlias("");
		
		if(systemOutTableMapper.insertChnlRel(mscr)>0){
			rtnValue.setMessage(id);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}


	/**
	 * @programId : MKT_ADM_005
	 * @name : removeChnlRel
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL_chnl_rel
	 * @return : StatusResDto
	 * @description : 채널 관꼐 삭제
	 */
	public StatusResDto removeChnlRel(SystemDeleteChnlRelReqDto mdcl){
		LogUtil.param(SystemOutTableService.class, mdcl);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		mdcl.setSVCAlias("");
		systemOutTableMapper.deleteChnlRel(mdcl);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	
	/**
	 * @programId : MKT_ADM_005
	 * @name : getTblcountCheck
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TBL
	 * @return : StatusResDto
	 * @description : 테이블 카운트 체크
	 */
	public StatusResDto getTblcountCheck(SystemTableTypeCheckReqDto mdtl){
		LogUtil.param(SystemOutTableService.class, mdtl);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		mdtl.setSVCAlias("met");

		String id = systemOutTableMapper.selectTblTypeChk(mdtl);
		rtnValue.setSuccess(true);
		
		if(id != null){
			rtnValue.setErrorType(IFVMErrorHelper.OUTALBE_TYPE_CHECK);
			rtnValue.setSuccess(false);
		}
		return rtnValue;
	}
	

	/**
	 * @programId : MKT_ADM_005
	 * @name : getcolCountCheck
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL_chnl_rel
	 * @return : StatusResDto
	 * @description : 컬럼 타입 체크
	 */
	public StatusResDto getcolCountCheck(SystemColTypeReqDto mdtl){
		LogUtil.param(SystemOutTableService.class, mdtl);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		mdtl.setSVCAlias("mec");

		String id = systemOutTableMapper.selectColTypeChk(mdtl);
		rtnValue.setSuccess(true);
		
		if(id != null){
			rtnValue.setErrorType(IFVMErrorHelper.OUTALBE_TYPE_CHECK);
			rtnValue.setSuccess(false);
		}
		return rtnValue;
	}
	

	/**
	 * @programId : MKT_ADM_005
	 * @name : removeTvlConTable
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_TBL
	 * @return : StatusResDto
	 * @description : 타겟레벨 하위 테이블 삭제
	 */
	public StatusResDto removeTvlConTable(SystemDeleteTvlConTableReqDto mdtl){
		LogUtil.param(SystemOutTableService.class, mdtl);
		StatusResDto rtnValue = new StatusResDto();
		mdtl.setSVCAlias("");
		systemOutTableMapper.deleteTvlConTable(mdtl);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId : MKT_ADM_005
	 * @name : removeTblConCol
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL
	 * @return : StatusResDto
	 * @description : 테이블 하위 컬럼 삭제
	 */
//	public StatusResDto removeTblConCol(SystemDeleteTblConColReqDto mdtl){
//		LogUtil.param(SystemOutTableService.class, mdtl);
//		StatusResDto rtnValue = new StatusResDto();
//		mdtl.setSVCAlias("");
//		systemOutTableMapper.deleteTblConCol(mdtl);
//		rtnValue.setSuccess(true);
//		return rtnValue;
//	}
	

	/**
	 * @programId : MKT_ADM_005
	 * @name : removeColConChnlRel
	 * @date : 2015. 01. 28
	 * @author : 박지열
	 * @table : COM_EXTR_COL_chnl_rel
	 * @return : StatusResDto
	 * @description : 채널 관계 삭제
	 */
	public StatusResDto removeColConChnlRel(SystemDeleteColConChnlRelReqDto mdtl){
		LogUtil.param(SystemOutTableService.class, mdtl);
		StatusResDto rtnValue = new StatusResDto();
		mdtl.setSVCAlias("");
		systemOutTableMapper.deleteColConChnlRel(mdtl);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	 * @programId : 
	 * @name : getFtpConnect
	 * @date : 2016. 04. 04
	 * @author : 송원희
	 * @table : COM_EXTR_FTP
	 * @return : GridPagingResDto
	 * @description : 외부 테이블 FTP 리스트 조회
	 */
	public GridPagingResDto<SystemGetFtpConnectListResDto> getFtpConnect(SystemGetFtpConnectListReqDto met){
		LogUtil.param(SystemOutTableService.class, met);
		met.setSVCAlias("met");
		return new GridPagingResHelper<SystemGetFtpConnectListResDto>().newGridPagingResDto(
				met.init(CommonUtil.getInstance().getDBType()), systemOutTableMapper.getFtpConnect(met));
	}
	
	/**
	 * @programId : 
	 * @name : setFtpConnect
	 * @date : 2016. 04. 05
	 * @author : 송원희
	 * @table : COM_EXTR_FTP
	 * @return : StatusResDto
	 * @description : 외부 테이블 FTP 등록
	 */
	public StatusResDto setFtpConnect(SystemGetFtpConnectListReqDto mor){
		LogUtil.param(SystemOutTableService.class, mor);
		StatusResDto rtnValue = new StatusResDto();
		mor.setId(CommonUtil.newRid());
		rtnValue.setSuccess(false);
		mor.setSVCAlias("");
		systemOutTableMapper.setFtpConnect(mor);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	 * @programId : 
	 * @name : editFtpConnect
	 * @date : 2016. 04. 05
	 * @author : 송원희
	 * @table : COM_EXTR_FTP
	 * @return : StatusResDto
	 * @description : 외부 테이블 FTP 수정
	 */
	public StatusResDto editFtpConnect(SystemGetFtpConnectListReqDto mor){
		LogUtil.param(SystemOutTableService.class, mor);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		mor.setSVCAlias("");
		systemOutTableMapper.editFtpConnect(mor);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	 * @programId : 
	 * @name : removeFtpConnect
	 * @date : 2016. 04. 05
	 * @author : 송원희
	 * @table : COM_EXTR_FTP
	 * @return : StatusResDto
	 * @description : 외부 테이블 FTP 삭제
	 */
	public StatusResDto removeFtpConnect(SystemGetFtpConnectListReqDto mor){
		LogUtil.param(SystemOutTableService.class, mor);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		mor.setSVCAlias("");
		systemOutTableMapper.removeFtpConnect(mor);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : getDbInfromServiceNms
	* @date : 2019. 3. 6.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description : 비밀명 조회
	*/
	public List<String> getDbInfromServiceNms(List<String> mdtl){
		
		return systemOutTableMapper.getDbInfromServiceNms(mdtl);
	}


	 /*
	  * 1. 메소드명: getEmailHost
	  * 2. 클래스명: SystemOutTableService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	외부 테이블 이메일 호스트 리스트 정보 조회	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mor
	 *   @return	
	 */
	
	public GridPagingResDto<SystemGetEmailHostListResDto> getEmailHost(SystemGetEmailHostListReqDto met) {
		LogUtil.param(SystemOutTableService.class, met);
		return new GridPagingResHelper<SystemGetEmailHostListResDto>().newGridPagingResDto(
				met.init(CommonUtil.getInstance().getDBType()), systemOutTableMapper.selectEmailHost(met));
	}


	 /*
	  * 1. 메소드명: getDetailEmailHost
	  * 2. 클래스명: SystemOutTableService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	외부 테이블 이메일 호스트 상세정보 조회	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mor
	 *   @return	
	 */
	
	public SystemGetEmailHostListResDto getDetailEmailHost(SystemGetEmailHostListReqDto mor) {
		LogUtil.param(SystemOutTableService.class, mor);
		SystemGetEmailHostListResDto resDto = new SystemGetEmailHostListResDto();
		resDto = systemOutTableMapper.selectDetailEmailHost(mor);
		
		if(resDto.getPwd() != null) {
			resDto.setPwd(encryptor.decrypt(resDto.getPwd()));
		}
		return resDto;
	}


	 /*
	  * 1. 메소드명: saveEmailHost
	  * 2. 클래스명: SystemOutTableService
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mdtl
	 *   @return	
	 */
	
	public StatusResDto saveEmailHost(SystemGetEmailHostListReqDto mor) {
		LogUtil.param(SystemOutTableService.class, mor);
		StatusResDto rtnValue = new StatusResDto();
		if(mor.isPwChk()){
			mor.setPwd(encryptor.encrypt(mor.getPwd()));
		}
		mor.setId(CommonUtil.newRid());
		systemOutTableMapper.insertEmailHost(mor);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: editemailHost
	  * 2. 클래스명: SystemOutTableService
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mdtl
	 *   @return	
	 */
	
	public StatusResDto editemailHost(SystemGetEmailHostListReqDto mor) {
		LogUtil.param(SystemOutTableService.class, mor);
		StatusResDto rtnValue = new StatusResDto();
		if(mor.isPwChk()){
			mor.setPwd(encryptor.encrypt(mor.getPwd()));
		}
		systemOutTableMapper.updateEmailHost(mor);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: removeEmailHost
	  * 2. 클래스명: SystemOutTableService
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mdtl
	 *   @return	
	 */
	
	public StatusResDto removeEmailHost(SystemGetEmailHostListReqDto mor) {
		LogUtil.param(SystemOutTableService.class, mor);
		StatusResDto rtnValue = new StatusResDto();
		systemOutTableMapper.deleteEmailHost(mor);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: getwebService
	  * 2. 클래스명: SystemOutTableService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 12. 08.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	외부 테이블 웹 서비스 전체 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mor
	 *   @return	
	 */
	
	public GridPagingResDto<SystemGetWebServiceListResDto> getwebService(SystemGetWebServiceListReqDto met) {
		LogUtil.param(SystemOutTableService.class, met);
		return new GridPagingResHelper<SystemGetWebServiceListResDto>().newGridPagingResDto(
				met.init(CommonUtil.getInstance().getDBType()), systemOutTableMapper.getwebService(met));
	}
	
	 /*
	  * 1. 메소드명: getwebServiceDetailPop
	  * 2. 클래스명: SystemOutTableService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 12. 08.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	외부 테이블 웹 서비스 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mor
	 *   @return	
	 */
	
	public SystemGetWebServiceListResDto getwebServiceDetailPop(SystemGetWebServiceListReqDto met) {
		LogUtil.param(SystemOutTableService.class, met);
		return  systemOutTableMapper.getwebServiceDetailPop(met);
	}
	 /*
	  * 1. 메소드명: insertWebService
	  * 2. 클래스명: SystemOutTableService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 12. 08.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	외부 테이블 웹 서비스 삽입
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mor
	 *   @return	
	 */
	
	public StatusResDto insertWebService(SystemGetWebServiceListReqDto met) {
		LogUtil.param(SystemOutTableService.class, met);
		StatusResDto rtnValue  = new StatusResDto();
		rtnValue.setSuccess(false);
		met.setWebServiceId(CommonUtil.newRid());
		systemOutTableMapper.insertWebService(met);
		rtnValue.setSuccess(true);

		return  rtnValue;
	}
	 /*
	  * 1. 메소드명: updateWebService
	  * 2. 클래스명: SystemOutTableService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 12. 08.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	외부 테이블 웹 서비스 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mor
	 *   @return	
	 */
	
	public StatusResDto updateWebService(SystemGetWebServiceListReqDto met) {
		LogUtil.param(SystemOutTableService.class, met);
		StatusResDto rtnValue  = new StatusResDto();
		rtnValue.setSuccess(false);
		systemOutTableMapper.updateWebService(met);
		rtnValue.setSuccess(true);

		return  rtnValue;
	}
	 /*
	  * 1. 메소드명: deleteWebService
	  * 2. 클래스명: SystemOutTableService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 12. 08.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	외부 테이블 웹 서비스 선택 행 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mor
	 *   @return	
	 */
	
	public StatusResDto deleteWebService(SystemGetWebServiceListReqDto met) {
		LogUtil.param(SystemOutTableService.class, met);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		systemOutTableMapper.deleteWebService(met);
		rtnValue.setSuccess(true);
		return  rtnValue;
	}	
}
