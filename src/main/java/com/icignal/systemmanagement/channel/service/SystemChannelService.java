package com.icignal.systemmanagement.channel.service;

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
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.external.aws.SecretsManager;
import com.icignal.external.aws.dto.request.AwsSecretManagerReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemChannelDetailReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemChannelInsertReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemChannelReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemChannelcapaDeleteReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemChannelcapaReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemDeleteSnsAdtnInfoReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionDeleteReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionListReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionlInsertReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemImgOptionlUpdateReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemInsertSnsAdtnInfoReqDto;
import com.icignal.systemmanagement.channel.dto.request.SystemSnsAdtnInfoReqDto;
import com.icignal.systemmanagement.channel.dto.response.SystemAccountResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemChannelDetailResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemChannelResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemChannelcapaResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemGetDetailSnsAdtnInfoResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemImgOptionListResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemImgOptionResDto;
import com.icignal.systemmanagement.channel.dto.response.SystemSnsAdtnInfoResDto;
import com.icignal.systemmanagement.channel.mapper.SystemChannelMapper;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;

@Service
public class SystemChannelService {

	@Autowired SystemChannelMapper systemChannelMapper;
	
	@Autowired StandardPBEStringEncryptor encryptor;

	public GridPagingResDto<SystemChannelResDto> getChannel(SystemChannelReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		GridPagingResDto<SystemChannelResDto> rtnValue = new GridPagingResDto<SystemChannelResDto>();
		
		rtnValue = new GridPagingResHelper<SystemChannelResDto>().newGridPagingResDto(
				mcr.init(CommonUtil.getInstance().getDBType()),
				systemChannelMapper.selectChannel(mcr),AnnotationType.ALL);
		
		//서비스명 별 AWS Secrets Manager 조회
/*		for (Object dbInfo : rtnValue.getRows()) {
			SystemChannelResDto _dbInfo = new SystemChannelResDto();
			_dbInfo = (SystemChannelResDto) dbInfo;

			if (ObjectUtil.isNotEmpty(_dbInfo.getSecretNm())) {
				try {

					Map<String, Object> map = new SecretsManager(BeansUtil.getAWSCredentials(),
							BeansUtil.getAwsRegion()
					).getSecretMap(_dbInfo.getSecretNm());

					_dbInfo.setConUrl(map.get("url").toString());
					_dbInfo.setConId(map.get("username").toString());
					_dbInfo.setConPw(map.get("password").toString());
					_dbInfo.setConIp(map.get("ip").toString());
					_dbInfo.setConPort(map.get("port").toString());

					dbInfo = _dbInfo;

				} catch (NullPointerException e) {
					LogUtil.error(e.getMessage());
				}
			}
		}*/
			
			
			return rtnValue;
	}

	public StatusResDto removeImgOption(SystemImgOptionDeleteReqDto midr) {
		LogUtil.param(this.getClass(), midr);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
	
		systemChannelMapper.deleteImgOption(midr);

		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	public SystemChannelDetailResDto getDetailChannel(SystemChannelDetailReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		mcr.setSVCAlias("mc");		
		
		SystemChannelDetailResDto dbInfo = new AnnotationHelper<SystemChannelDetailResDto>(AnnotationType.ALL,(SystemChannelDetailResDto)systemChannelMapper.selectDetailChannel(mcr)).getItem();

		//JSONObject dbInfoJSON = new JSONObject();
		if(ObjectUtil.isNotEmpty(dbInfo.getSecretNm())) {
			try {
				
				Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(), 
						 BeansUtil.getAwsRegion()
						 ).getSecretMap(dbInfo.getSecretNm());			
				
				//dbInfoJSON = AWSSecretsManagerConfig.getSecretValueResult(dbInfo.getSecretNm());
				dbInfo.setConUrl(map.get("url").toString());
				dbInfo.setConId(map.get("username").toString());
				dbInfo.setConPw(map.get("password").toString());
				dbInfo.setConIp(map.get("ip").toString());
				dbInfo.setConPort(map.get("port").toString());
				
			}catch(ArithmeticException e) {
				LogUtil.error(e.getMessage());
			}
		}
		
		return dbInfo;
	}

	public StatusResDto editResponseChannel(SystemChannelReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		//암호화
				
				SecretsManager sm =	  new SecretsManager(BeansUtil.getAWSCredentials(), BeansUtil.getAwsRegion());
				StatusResDto rtnValue = new StatusResDto();
				
				if (mcr.isPasswordChk()) {
		        	String pass = encryptor.encrypt(mcr.getConPw());
					mcr.setConPw(pass);
		        }
				
			    String serviceMgtType = BeansUtil.getApplicationProperty("icignal.db-connection-info.management-type");

				if(ObjectUtil.isNotEmpty(mcr.getSecretNm()) && "AwsLoyalty".equals(serviceMgtType)) {
					
					mcr.setSecretNm(mcr.getServiceNm());
					
					try {
					//DB정보 AWS Secrets Manager 수정
					AwsSecretManagerReqDto param = new AwsSecretManagerReqDto();
					param.setSecretId(mcr.getSecretNm());
					param.setDescription(mcr.getDescription());
					
					Map<String, String> secretKeyValue = new HashMap<String, String>();
					secretKeyValue.put("url", mcr.getConUrl());
					secretKeyValue.put("username", mcr.getConId());
					secretKeyValue.put("password", mcr.getConPw());
					secretKeyValue.put("ip", mcr.getConIp());
					secretKeyValue.put("port", mcr.getConPort());
					
					param.setSecretKeyValue(secretKeyValue);
					
					sm.editSecretKey(param);
					
					//정보수정
					SystemChannelReqDto reqDto = new SystemChannelReqDto();
					reqDto.setId(mcr.getId());
					reqDto.setMemId(mcr.getMemId());
			    	//_mcr.setCountry(mcr.getCountry());
			    	//_mcr.setAppServiceId(mcr.getAppServiceId());
					reqDto.setChnlName(mcr.getChnlName());
					reqDto.setChnlTypeCd(mcr.getChnlTypeCd());
					reqDto.setCommStatus(mcr.getCommStatus());
			    	//_mcr.setAccountId(mcr.getAccountId());
					reqDto.setPtraccntId(mcr.getPtraccntId());
					reqDto.setApplyStrDate(mcr.getApplyStrDate());
					reqDto.setApplyEndDate(mcr.getApplyEndDate());
					reqDto.setDescription(mcr.getDescription());
					reqDto.setUcost(mcr.getUcost());
					reqDto.setDbtype(mcr.getDbtype());
					reqDto.setSendableStartTime(mcr.getSendableStartTime());
					reqDto.setSendableEndTime(mcr.getSendableEndTime());
					reqDto.setChnlGuide(mcr.getChnlGuide());
					reqDto.setSecretNm(mcr.getSecretNm());
					reqDto.setServiceNm(mcr.getServiceNm());

					rtnValue.setSuccess(false);
					
					systemChannelMapper.updateResponseChannel(reqDto);
					
					rtnValue.setSuccess(true);
					
					
					}catch(IllegalArgumentException e) {
						LogUtil.error(e);
					}
				}
			    else{

					rtnValue.setSuccess(false);
					
					systemChannelMapper.updateResponseChannel(mcr);
										
					rtnValue.setSuccess(true);
				}
				
				return rtnValue;
			   }


	public SystemChannelResDto getChannelCheck(SystemChannelReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		SystemChannelResDto rtnValue = new SystemChannelResDto();
		rtnValue = (SystemChannelResDto)systemChannelMapper.selectChannelCheck(mcr);
		return rtnValue;
	}
	
	
	//서정환 처리 필요
	public StatusResDto setChannel(SystemChannelInsertReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		// 암호화
		/*
		 * String accesskey =
		 * BeansUtil.getApplicationProperty("aws.credentials.access-key"); String
		 * secretkey = BeansUtil.getApplicationProperty("aws.credentials.secret-key");
		 * String region = BeansUtil.getAwsRegion();
		 */
		/*
		 * Credentials creds = new Credentials();
		 * creds.createAWSCredentials(encryptor.decrypt(),
		 * encryptor.decrypt(env.getProperty("aws.credentials.secret-key")));
		 */
		SecretsManager sm =	  new SecretsManager(BeansUtil.getAWSCredentials(), BeansUtil.getAwsRegion()	 );
		
		/* SecretsManager secretsManager = new SecretsManager(id1,region); */
		/*
		 * StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
		 * encryptor.setPassword("9pwc3dke");
		 */

        StatusResDto rtnValue = new StatusResDto();
        
        if (mcr.isPasswordChk()) {
        	String pass = encryptor.encrypt(mcr.getConPw());
			mcr.setConPw(pass);
        }
        
       String serviceMgtType = BeansUtil.getApplicationProperty("icignal.db-connection-info.management-type");
        
       if( "AwsLoyalty".equals(serviceMgtType )) {
    	   mcr.setSecretNm(mcr.getServiceNm());      
       
	        try {
	        	//DB정보 AWS Secrets Manager 등록
	        	AwsSecretManagerReqDto param = new AwsSecretManagerReqDto();
	            LogUtil.info("mcr.getSecretNm(): " + mcr.getSecretNm());
	              
		    	param.setName(mcr.getSecretNm());
		    	param.setDescription(mcr.getDescription());
		      
		    	Map<String, String> secretKeyValue = new HashMap<String, String>();
		    	secretKeyValue.put("url", mcr.getConUrl());
		    	secretKeyValue.put("username", mcr.getConId());
		    	secretKeyValue.put("password", mcr.getConPw());
		    	secretKeyValue.put("ip", mcr.getConIp());
		    	secretKeyValue.put("port", mcr.getConPort());
		    	
		    	param.setSecretKeyValue(secretKeyValue);
				sm.createSecret(param);
	    	
		    	SystemChannelInsertReqDto reqDto = new SystemChannelInsertReqDto();
		    	reqDto.setId(mcr.getId());
		    	reqDto.setMemId(mcr.getMemId());
		    	//_mcr.setCountry(mcr.getCountry());
		    	//_mcr.setAppServiceId(mcr.getAppServiceId());
		    	reqDto.setChnlName(mcr.getChnlName());
		    	reqDto.setChnlTypeCd(mcr.getChnlTypeCd());
		    	reqDto.setCommStatus(mcr.getCommStatus());
		    	reqDto.setAccountId(mcr.getAccountId());
		    	reqDto.setPtraccntId(mcr.getPtraccntId());
		    	reqDto.setApplyStrDate(mcr.getApplyStrDate());
		    	reqDto.setApplyEndDate(mcr.getApplyEndDate());
		    	reqDto.setDescription(mcr.getDescription());
		    	reqDto.setUcost(mcr.getUcost());
		    	reqDto.setDbtype(mcr.getDbtype());
		    	reqDto.setSendableStartTime(mcr.getSendableStartTime());
		    	reqDto.setSendableEndTime(mcr.getSendableEndTime());
		    	reqDto.setChnlGuide(mcr.getChnlGuide());
		    	reqDto.setSecretNm(mcr.getSecretNm());
		    	reqDto.setServiceNm(mcr.getServiceNm());
		    	
				rtnValue.setSuccess(false);
				
				String id = CommonUtil.newRid();
				reqDto.setId(id);			
				
//				String id = (String) /this.insert("MKTChannel.insertChannel", mcr);
				systemChannelMapper.insertChannel(reqDto);
				
				rtnValue.setMessage(id);
				rtnValue.setSuccess(true);
		    	
	        }catch(IllegalArgumentException e) {
	        	LogUtil.error(e);
	        }	
        }else {
        	
    		rtnValue.setSuccess(false);
    		
    	//	String id =StringUtil.genID();
    		
    		String id = CommonUtil.newRid();
    		mcr.setId(id);
    		    		
    		
//    		String id = (String) /this.insert("MKTChannel.insertChannel", mcr);
    		systemChannelMapper.insertChannel(mcr);
    		
    		rtnValue.setMessage(id);
    		rtnValue.setSuccess(true);
        }
        return rtnValue;
	}

	public StatusResDto deleteSnsAdtnInfo(SystemDeleteSnsAdtnInfoReqDto mcdr) {
		LogUtil.param(this.getClass(), mcdr);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		systemChannelMapper.deleteSnsAdtnInfo(mcdr);

		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	public StatusResDto getDateInfo(MKTCommonCodeRequestDTO slir) {
		LogUtil.param(this.getClass(), slir);
		StatusResDto rtnValue = new StatusResDto();
		String rtnText = (String)systemChannelMapper.getDateInfo(slir);

		rtnValue.setMessage(rtnText);
		rtnValue.setSuccess(true);

		return rtnValue;
	}	

	public StatusResDto removeCapa(SystemChannelcapaDeleteReqDto mcdr) {
		LogUtil.param(this.getClass(), mcdr);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		systemChannelMapper.deleteCapa(mcdr);

		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	public GridPagingResDto<SystemAccountResDto> getChannelOrg(SystemChannelReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		mcr.setSVCAlias("ac");
		
		return new GridPagingResHelper<SystemAccountResDto>().newGridPagingResDto(
				mcr.init(CommonUtil.getInstance().getDBType()),
				systemChannelMapper.selectChannelOrg(mcr));
	}

	public GridPagingResDto<SystemSnsAdtnInfoResDto> getSnsAdtnInfoList(SystemSnsAdtnInfoReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		mcr.setSVCAlias("mcsai");
		
		return new GridPagingResHelper<SystemSnsAdtnInfoResDto>().newGridPagingResDto(
				mcr.init(CommonUtil.getInstance().getDBType()),
				systemChannelMapper.getSnsAdtnInfoList(mcr));
	}

	public GridPagingResDto<SystemChannelcapaResDto> getChannelStore(SystemChannelcapaReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		mcr.setSVCAlias("mc");
		
		return new GridPagingResHelper<SystemChannelcapaResDto>().newGridPagingResDto(
				mcr.init(CommonUtil.getInstance().getDBType()),
				systemChannelMapper.selectChannelStore(mcr));
	}

	public GridPagingResDto<SystemImgOptionListResDto> getImgOption(SystemImgOptionListReqDto molr) {
		LogUtil.param(this.getClass(), molr);
		
		molr.setSVCAlias("mcc");
		
		return new GridPagingResHelper<SystemImgOptionListResDto>().newGridPagingResDto(
				molr.init(CommonUtil.getInstance().getDBType()),
				systemChannelMapper.selectImgOption(molr));
	}

	public StatusResDto editImgOption(SystemImgOptionlUpdateReqDto miou) {
		LogUtil.param(this.getClass(), miou);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		systemChannelMapper.updateImgOption(miou);

		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	public SystemImgOptionResDto getContypeId(SystemChannelReqDto mcdr) {
		LogUtil.param(this.getClass(), mcdr);
		mcdr.setSVCAlias("mc");
		
		SystemImgOptionResDto res = systemChannelMapper.selectContypeId(mcdr);
		return new AnnotationHelper<SystemImgOptionResDto>(AnnotationType.Nothing , res).getItem();
	}

	public StatusResDto setImgOption(SystemImgOptionlInsertReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		String id = StringUtil.genID();
		mcr.setId(id);
		
		SystemChannelcapaReqDto mor = new SystemChannelcapaReqDto();
		mor.setMktChlId(mcr.getMktChnlId());
		mor.setType("ATTACH_USAGE");
		String seq = (String) systemChannelMapper.selectSeq(mor);
		
		mcr.setSeq(seq);
//		String id = (String) /this.insert("MKTChannel.insertImgOption", mori);
		systemChannelMapper.insertImgOption(mcr);

		rtnValue.setMessage(id);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	public List<SystemImgOptionResDto> getImageOptionList(SystemImgOptionReqDto mior) {
		LogUtil.param(this.getClass(), mior);

		mior.setSVCAlias("mcc");

		List<SystemImgOptionResDto> rtnvalue = systemChannelMapper.selectImageOptionList(mior);

		return rtnvalue;
	}

	public SystemImgOptionResDto getImgDetailOption(SystemImgOptionReqDto mior) {
		LogUtil.param(this.getClass(), mior);
		
		mior.setSVCAlias("mcc");
		
		SystemImgOptionResDto res = systemChannelMapper.selectImgDetailOption(mior);
		
		return new AnnotationHelper<SystemImgOptionResDto>(AnnotationType.Nothing , res).getItem();
	}

	public SystemChannelcapaResDto getDetailCapa(SystemChannelcapaReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		mcr.setSVCAlias("mcc");
		
		SystemChannelcapaResDto res = systemChannelMapper.selectDetailCapa(mcr);
		
		return new AnnotationHelper<SystemChannelcapaResDto>(AnnotationType.Nothing , res).getItem();
	}

	public StatusResDto editCapaChannel(SystemChannelcapaReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		if(mcr.isChangeChk()){
			mcr.setSVCAlias("mc");
			String errorChk = (String) systemChannelMapper.selectperiodType(mcr);
			
			if(errorChk != null){
				rtnValue.setErrorType(IFVMErrorHelper.OUTALBE_TYPE_CHECK);
				rtnValue.setSuccess(false);
			}
			else{
				mcr.setSVCAlias("");
				systemChannelMapper.updateCapaChannel(mcr);
				
				rtnValue.setSuccess(true);
			}
		}
		else{
			systemChannelMapper.updateCapaChannel(mcr);
			
			rtnValue.setSuccess(true);
		}
		
		return rtnValue;
	}

	public StatusResDto setChannelStore(SystemChannelcapaReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		mcr.setSVCAlias("mc");
		String errorChk = (String)systemChannelMapper.selectperiodType(mcr);
		
		if(errorChk != null){
			rtnValue.setErrorType(IFVMErrorHelper.OUTALBE_TYPE_CHECK);
			rtnValue.setSuccess(false);
		}
		else{
		
			String id = StringUtil.genID();
			mcr.setId(id);
			mcr.setType("SYS_USAGE");
			String seq = (String)systemChannelMapper.selectSeq(mcr);
			
			mcr.setSeq(seq);
//			String id = (String) /this.insert("MKTChannel.insertChannelStore", mcr);
			systemChannelMapper.insertChannelStore(mcr);
	
			rtnValue.setMessage(id);
			rtnValue.setSuccess(true);
		}
		
		return rtnValue;
	}

	public StatusResDto insertSnsAdtnInfo(SystemInsertSnsAdtnInfoReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		StatusResDto rtnValue = new StatusResDto();	
		rtnValue.setSuccess(false);
		String id = mcr.getId();
		mcr.setId(CommonUtil.newRid());
		if((int)systemChannelMapper.insertSnsAdtnInfo(mcr)>0){
			rtnValue.setMessage(id);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}

	public SystemGetDetailSnsAdtnInfoResDto getDetailSnsAdtnInfo(SystemSnsAdtnInfoReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		mcr.setSVCAlias("mcsai");
		
		SystemGetDetailSnsAdtnInfoResDto rtnvalue = new SystemGetDetailSnsAdtnInfoResDto();
		rtnvalue = (SystemGetDetailSnsAdtnInfoResDto) systemChannelMapper.getDetailSnsAdtnInfo(mcr);
		
		return rtnvalue;
	}

	public StatusResDto updateSnsAdtnInfo(SystemInsertSnsAdtnInfoReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		
		StatusResDto rtnValue = new StatusResDto();	
		rtnValue.setSuccess(false);
		
		String id = mcr.getId();
		if((int)systemChannelMapper.updateSnsAdtnInfo(mcr)>0){
			rtnValue.setMessage(id);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}


}
