package com.icignal.marketing.common.eventTrigger.service;

import java.io.File;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.request.EmailSendLogReqDto;
import com.icignal.common.base.dto.request.MessageSendLogReqDto;
import com.icignal.common.base.dto.request.PushSendLogReqDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.DateUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.database.dao.DynamicDBDao;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.external.aws.SecretsManager;
import com.icignal.kepler.common.dto.request.KprCommonCodeReqDto;
import com.icignal.kepler.common.dto.response.KprCommonCodeResDto;
import com.icignal.kepler.common.mapper.KprCommonMapper;
import com.icignal.marketing.common.eventTrigger.dto.request.MktEventTriggerReqDto;
import com.icignal.marketing.common.eventTrigger.dto.response.MktCampaignTargetingResDto;
import com.icignal.marketing.common.eventTrigger.dto.response.MktCondResDto;
import com.icignal.marketing.common.eventTrigger.dto.response.MktContentsDetailResDto;
import com.icignal.marketing.common.eventTrigger.dto.response.MktETCampaignActParamResDto;
import com.icignal.marketing.common.eventTrigger.dto.response.MktETCampaignCondValResDto;
import com.icignal.marketing.common.eventTrigger.dto.response.MktETCampaignLCColumnListResDto;
import com.icignal.marketing.common.eventTrigger.dto.response.MktETCampaignNodeResDto;
import com.icignal.marketing.common.eventTrigger.dto.response.MktEventNodeResDto;
import com.icignal.marketing.common.eventTrigger.dto.response.MktEventTriggerCamResultResDto;
import com.icignal.marketing.common.eventTrigger.dto.response.MktEventTriggerCampaignResDto;
import com.icignal.marketing.common.eventTrigger.dto.response.MktEventTriggerResDto;
import com.icignal.marketing.common.eventTrigger.dto.response.MktLogicalComponentInfoResDto;
import com.icignal.marketing.common.eventTrigger.dto.response.MktTargetGroupInfoResDto;
import com.icignal.marketing.common.eventTrigger.mapper.MktEventTriggerMapper;

import net.sf.json.JSONObject;



/**
 * @name : MktEventTriggerService.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : 공통
 */
@Service("MktEventTriggerService")
public class MktEventTriggerService {
	
	@Autowired
	private MktEventTriggerMapper mktEventTriggerMapper;
	
	@Autowired
	private KprCommonMapper kprCommonMapper;
	
	@Autowired
	private MKTCallQueryDao mktCallQueryDao;
	
	@Autowired
	private CommonService commonService;
	
    @Autowired
    StandardPBEStringEncryptor encrypor;
    
    
	public MktEventTriggerService() {
		dynamicDBDaoList = new ArrayList<DynamicDBDao>();
	}
	
	private List<MKTDBInfoDTO> dbInfoList;
	
	private List<DynamicDBDao> dynamicDBDaoList;
	
	private DynamicDBDao getDynamicDBDao(MKTDBInfoDTO dbInfo) {
		DynamicDBDao rtnValue = null;

		/**
		 * 동시 호출시 중복 방지를 위한 대기시간을 준다.
		 */
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
		}

		//중복 DB 연결을 방지하기 위해 유형별 DB Dao를 확인
		for (DynamicDBDao dao : dynamicDBDaoList) {
			if (ObjectUtil.equalsObject(dao.getDbInfo(), dbInfo, MKTDBInfoDTO.class)) {
				rtnValue = dao;

				break;
			}
		}

		//없을경우 DB 연결 후 list에 담는다.
		if (rtnValue == null) {
			rtnValue = new DynamicDBDao(dbInfo);

			dynamicDBDaoList.add(rtnValue);
		}

		LogUtil.debug("dynamicDBDaoListSize : " + dynamicDBDaoList.size());

		return rtnValue;
	}
	
	private MKTDBInfoDTO getDbInfo(MktLogicalComponentInfoResDto param) {
		MKTDBInfoDTO rtnValue = null;
		
		if (dbInfoList == null) {
			dbInfoList = new ArrayList<MKTDBInfoDTO>();
		}
		
		for (MKTDBInfoDTO db : dbInfoList) {
			if (db.getDbId().equals(param.getDbId())) {
				rtnValue = db;
				
				break;
			}
		}
		
		if (ObjectUtil.isEmpty(rtnValue)) {
			MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
			dbInfo.setDbId(param.getDbId());
			dbInfo.setDriverClassName(param.getConDbClass());
			dbInfo.setConDbType(param.getConDbType());
			if (ObjectUtil.isNotEmpty(param.getAwsSecretNm())) {
				try {
					Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(), 
							 BeansUtil.getAwsRegion()
							 ).getSecretMap(param.getAwsSecretNm());					
					
					dbInfo.setUrl(map.get("url").toString());
					dbInfo.setUserName(map.get("username").toString());
					dbInfo.setPassword(map.get("password").toString());
					dbInfo.setConIp(map.get("ip").toString());
					dbInfo.setConPort(map.get("port").toString());
					dbInfo.setDriverClassName(map.get("driverClassName").toString());
				
				} catch(NullPointerException e) {
					LogUtil.error(e.getMessage());
				}
			} else {
		        dbInfo.setConIp(param.getConIp());
		        dbInfo.setConPort(param.getConPort());
		        dbInfo.setUserName(param.getConId());
		        dbInfo.setPassword(encrypor.decrypt(param.getConPassword()));
		        dbInfo.setUrl(param.getConUrl());
			}
			
			rtnValue = dbInfo;
			dbInfoList.add(dbInfo);
		}
		
		return rtnValue;
	}
	
	//노드 유형 코드
	private enum NODE_TYPE_CD {
		/**
		 * Info
		 */
		INFO,
		/**
		 * Role
		 */
		ETCOND,
		/**
		 * Action
		 */
		ETACT,
		/**
		 * SMS
		 */
		SMS,
		/**
		 * LMS
		 */
		LMS,
		/**
		 * MMS
		 */
		MMS,
		/**
		 * PUSH
		 */
		PUSH,
		/**
		 * Email
		 */
		EMAIL,
		/**
		 * Script
		 */
		CALL,
		KAKAO,
		KAKAONOTICE,
		DM,
		TM,
		APPNOTICE,
		TARGET,
	}
	
	//이벤트 트리거 노드 유형 코드
	private enum MKT_NODE_TYPE_CD {
		/**
		 * 정형
		 */
		STRUC,
		/**
		 * 비정형
		 */
		UNSTRUC
	}
	
	//연산자
	private enum CNCTR_TYPE_CD {
		NEXT, YES, NO
	};
	
	//데이터베이스 유형
	private enum DATABASE_TYPE {
		MYSQL, ORACLE
	};

	//컬럼 유형 코드
	private enum COL_TYPE_CD {
		MEASURE, DIMENSION
	}
	
	//연산자
	private enum SERC_OPRT_CODE {
		BETWEEN, IN, LIKE, CUSTDTDEF
	};

	static private final String CARRIAGE_RETURN_STR = "\n ";
	static private final String AND_STR = " AND ";
	static private final String WHERE_STR = " WHERE ";
	static private final String EQUAL_STR = " = ";
	static private final String BETWEEN_STR = " BETWEEN ";
	static private final String MKT_DT_DEFAULT = "MKT_DT_DEFAULT";
	static private final String SELECT_STR = "SELECT ";
	static private final String COUNT_STR = "COUNT(*) ";
	static private final String FROM_STR = "FROM ";
	static private final String GROUP_BY_STR = "GROUP BY ";
	static private final String HAVING_STR = "HAVING ";
	
	static private final String CREATE_BY = "ET_API";
	
	static private final String ACCNT_APP_KEY = "53e18abc0cf29fcb62a82310";
	static private final String PUTH_SOUND = "38407344e4ad11e3b9d4000c";
	
	static private final String BAT_SEND_STATUS = "N";
	
	//액션 노드 유형
	private enum LOY_ACT_NODE_TYPE {
		/**
		 * 오퍼지급
		 */
		OFF,
		/**
		 * 채널전송
		 */
		CHN,
		/**
		 * 타켓테이블전송
		 */
		TBL,
		/**
		 * IF호출
		 */
		SVR,
		/**
		 * Function호출
		 */
		FUNC,
		CAL,
		TR,
		RETURN,
	}
	
	//타겟팅 유형
	private enum MKT_TGT_TYPE {
		/**
		 * 업로드
		 */
		IMP,
		/**
		 * 타겟그룹(세그먼트)
		 */
		SEG
	}
	
	//실행 실패 코드
	private enum EXEC_TYPE_CD {
		/**
		 * Role 통과 실패
		 */
		ETCOND_F_001,
		/**
		 * Role 에러
		 */
		ETCOND_F_002,
		/**
		 * Action 에러
		 */
		ETACT_F_001,
		/**
		 * 캠페인 실행 오류
		 */
		ET_ERR_001,
		/**
		 * 캠페인 미존재
		 */
		ET_ERR_002
	}

	
	/**
	 * @programId : 
	 * @name : eventTrigger
	 * @date : 2016. 11. 24.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : 이벤트 트리거
	 */
	
    public MktEventTriggerResDto eventTrigger(MktEventTriggerReqDto param) {
		LogUtil.param(MktEventTriggerService.class, param);
		
		MktEventTriggerResDto rtnValue = new MktEventTriggerResDto();
		rtnValue.setSuccess(true);
		
		//인터랙트 데이터 등록(대한항공)
		param.setGuid(CommonUtil.newRid());
		param.setRid(param.getGuid());
		param.setTgNo(CommonUtil.newRid());
		param.setTrsDate(DateUtil.getToday("yyyyMMdd"));
		param.setTrsTime(DateUtil.getToday("hhmm")+"00");
		mktEventTriggerMapper.insertIntactDataKe(param);
		
		//캠페인 목록 조회
		List<MktEventTriggerCampaignResDto> getEventTriggerCampaignList = new ArrayList<MktEventTriggerCampaignResDto>();
		param.setIntactType1Cd(param.getEvtType());
		param.setIntactType2Cd(param.getEvtDtlType());
		getEventTriggerCampaignList = mktEventTriggerMapper.selectEventTriggerCampaignList(param);
		
		List<MktEventTriggerCamResultResDto> resultList = new ArrayList<MktEventTriggerCamResultResDto>();
		for (MktEventTriggerCampaignResDto campaign : getEventTriggerCampaignList) {
			//이벤트 트리거 캠페인 실행
			
			MktEventTriggerCamResultResDto result = new MktEventTriggerCamResultResDto();
			
			
			try {
				//이벤트 트리거캠페인 실행
				result = execEventTriggerCampaign(param, campaign);
				result.setRuleNo(campaign.getDispNo());
				
				resultList.add(result);
			} catch (Exception e) {
				result.setRuleNo(campaign.getDispNo());
				result.setSuccess(false);
				result.setMessage(EXEC_TYPE_CD.ET_ERR_001.name());
				
				resultList.add(result);
				
				LogUtil.error("[execEventTriggerCampaign Error]" + campaign.getId() + " : " + e);
			}
			//Thread campaignThread = new Thread(subBatch);
			//campaignThread.start();
		}
		
		rtnValue.setResultList(resultList);
		
		return rtnValue;
	}
	
	/**
	 * @programId : 
	 * @name : syncEventTrigger
	 * @date : 2016. 11. 28.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : 이벤트 트리거 sync
	 */
	
    public MktEventTriggerResDto syncEventTrigger(MktEventTriggerReqDto param) {
		LogUtil.param(MktEventTriggerService.class, param);
		
		MktEventTriggerResDto rtnValue = new MktEventTriggerResDto();
		rtnValue.setSuccess(true);
		
		//인터랙트 데이터 등록(대한항공)
		param.setGuid(CommonUtil.newRid());
		param.setRid(param.getGuid());
		param.setTgNo(CommonUtil.newRid());
		param.setTrsDate(DateUtil.getToday("yyyyMMdd"));
		param.setTrsTime(DateUtil.getToday("hhmm")+"00");
		mktEventTriggerMapper.insertIntactDataKe(param);
		
		//캠페인 목록 조회
		List<MktEventTriggerCampaignResDto> getEventTriggerCampaignList = new ArrayList<MktEventTriggerCampaignResDto>();
		getEventTriggerCampaignList = mktEventTriggerMapper.selectEventTriggerCampaignList(param);
		
		if (ObjectUtil.isNotEmpty(getEventTriggerCampaignList)) {
			for (MktEventTriggerCampaignResDto campaign : getEventTriggerCampaignList) {
				MktEventTriggerCamResultResDto result = new MktEventTriggerCamResultResDto();
				
				//이벤트 트리거 캠페인 실행
				try {
					//이벤트 트리거 캠페인 실행
					result = execEventTriggerCampaign(param, campaign);
					result.setRuleNo(campaign.getDispNo());
				} catch (Exception e) {
					result.setRuleNo(campaign.getDispNo());
					result.setSuccess(false);
					result.setMessage(EXEC_TYPE_CD.ET_ERR_001.name());
					
					LogUtil.error("[execEventTriggerCampaign Error]" + campaign.getId() + " : " + e);
				}
				
				List<MktEventTriggerCamResultResDto> resultList = new ArrayList<MktEventTriggerCamResultResDto>();
				resultList.add(result);
				rtnValue.setResultList(resultList);
				
				//Thread campaignThread = new Thread(subBatch);
				//campaignThread.start();
			}
		} else {
			LogUtil.error("[eventTrigger Error]no campaign");
			rtnValue.setMessage(EXEC_TYPE_CD.ET_ERR_002.name());
		}
		
		return rtnValue;
	}
	
	/**
	 * @programId : 
	 * @name : execEventTrigger
	 * @date : 2016. 11. 24.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : 이벤트 트리거 캠페인 실행
	 */
    @Async(value = "execEventTriggerCampaign")
	public MktEventTriggerCamResultResDto execEventTriggerCampaign(MktEventTriggerReqDto param, MktEventTriggerCampaignResDto campaign) {
    	MktEventTriggerCamResultResDto rtnValue = new MktEventTriggerCamResultResDto();
    	rtnValue.setRuleNo(campaign.getDispNo());
		
		param.setCampaignId(campaign.getId());
		
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>(); 
		
		
		//시작 이벤트트리거 노드 목록 조회
		List<MktEventNodeResDto> startNodeList = new ArrayList<MktEventNodeResDto>();
		startNodeList = mktEventTriggerMapper.selectStartEventNodeList(param);
		
		
		List<MktEventNodeResDto> nodeList = new ArrayList<MktEventNodeResDto>();
		nodeList = getChildEventNodeList(startNodeList, "", NODE_TYPE_CD.INFO.name());
		
		int idx = 0;
		while( nodeList.size() > idx) {
			MktEventNodeResDto node = nodeList.get(idx);
			
			String parTaskId = "";
			String cnctrTypeCd = "";
			
			MktEventNodeResDto nodeRtnValue = new MktEventNodeResDto();
			
			//INFO
			if (NODE_TYPE_CD.INFO.name().equals(node.getNodeTypeCd())) {
				nodeRtnValue.setSuccess(true);
			}
			//Target
			else if (NODE_TYPE_CD.TARGET.name().equals(node.getNodeTypeCd())) {
				nodeRtnValue = checkTargeting(param);
			}
			//Role
			else if (NODE_TYPE_CD.ETCOND.name().equals(node.getNodeTypeCd())) {
				nodeRtnValue = execRole(param, node);
			}
			
			//Action
			else if (NODE_TYPE_CD.ETACT.name().equals(node.getNodeTypeCd())) {
				nodeRtnValue = execAction(param, node);
				//결과 반환
				
				if (ObjectUtil.isNotEmpty(nodeRtnValue.getData())) {
					dataList.add(nodeRtnValue.getData());
				}
				
				if (!nodeRtnValue.getSuccess()) {
					break;
				}
			}
			
			//Channel
			else if (NODE_TYPE_CD.SMS.name().equals(node.getNodeTypeCd())
					|| NODE_TYPE_CD.LMS.name().equals(node.getNodeTypeCd())
					|| NODE_TYPE_CD.MMS.name().equals(node.getNodeTypeCd())
					|| NODE_TYPE_CD.PUSH.name().equals(node.getNodeTypeCd())
					|| NODE_TYPE_CD.EMAIL.name().equals(node.getNodeTypeCd())
					|| NODE_TYPE_CD.TM.name().equals(node.getNodeTypeCd())
					|| NODE_TYPE_CD.DM.name().equals(node.getNodeTypeCd())
					|| NODE_TYPE_CD.KAKAO.name().equals(node.getNodeTypeCd())
					|| NODE_TYPE_CD.KAKAONOTICE.name().equals(node.getNodeTypeCd())
					) {
				
				nodeRtnValue = execChannel(param, node);
				//rtnValueList.add(nodeRtnValue);
			}
			
			/**
			 * 실패여부 확인
			 * 1. 에러 인 경우 중지
			 * 2. Next Node 인 경우 다음 Start 노드 실행
			 * 3. 문제없이 실행 됐을경우 다음 노드 실행
			 */
			parTaskId = node.getTaskId();
			if (!nodeRtnValue.getSuccess()) {
				if (NODE_TYPE_CD.ETCOND.name().equals(node.getNodeTypeCd())) {
					cnctrTypeCd = CNCTR_TYPE_CD.NO.toString();
				} else {
					cnctrTypeCd = CNCTR_TYPE_CD.NEXT.toString();
				}
			} else {
				if (NODE_TYPE_CD.ETCOND.name().equals(node.getNodeTypeCd())) {
					cnctrTypeCd = CNCTR_TYPE_CD.YES.toString();
				} else {
					cnctrTypeCd = CNCTR_TYPE_CD.NEXT.toString();
				}
			}
			
			/**
			 * 하위 노드 추가
			 * 중복 있을경우 제외
			 */
			List<MktEventNodeResDto> childNodeList = getChildEventNodeList(startNodeList, parTaskId, cnctrTypeCd);
			for (MktEventNodeResDto cNode : childNodeList) {
				boolean f = true;
				for (MktEventNodeResDto sNode : nodeList) {
					if (sNode.getId().equals(cNode.getId())) {
						f = false;
					}
				}
				
				if (f) {
					nodeList.add(cNode);
				}
			}
			
			idx++;
		}
		
		Map<String, Object> data = new HashMap<String, Object>();
		
		for (Map<String, Object> map : dataList) {
 			for (Map.Entry<String, Object> entry : map.entrySet()) {
			    Object value = entry.getValue();
			    String key = entry.getKey();
			    if (data.containsKey(key)) {
			    	if (!key.equals("rstCd")) {
			        	if (data.get(key) != null && value != null) {
					        if (java.math.BigDecimal.class.equals(value.getClass())) {
					        	
					        	BigDecimal d1 = (BigDecimal) data.get(key); 
					  		  	BigDecimal d2 = (BigDecimal) value;
					        	
					        	data.put(key, d1.add(d2));
					        } 
			        	} else {
			        		data.put(key, value);
			        	}
			    	}
			    } else {
			        data.put(key, value);
			    }
			}
		}
		
		rtnValue.setData(data);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	public List<MktEventNodeResDto> getChildEventNodeList(List<MktEventNodeResDto> nodeList, String parTaskId, String type) {
		List<MktEventNodeResDto> rtnValue = new ArrayList<MktEventNodeResDto>();
		
		for (MktEventNodeResDto node : nodeList) {
			if (NODE_TYPE_CD.INFO.name().equals(type) && NODE_TYPE_CD.INFO.name().equals(node.getNodeTypeCd())) {
				rtnValue.add(node);
				break;
			} else if (ObjectUtil.isNotEmpty(node.getParTaskId()) && ObjectUtil.isNotEmpty(node.getCnctrTypeCd())
					&& node.getParTaskId().equals(parTaskId) 
					&& node.getCnctrTypeCd().equals(type)) {
					rtnValue.add(node);
			}
		}
		
		return rtnValue;
	}
	
	public MktEventNodeResDto checkTargeting(MktEventTriggerReqDto param) {
		LogUtil.debug("================ Targeting Start ====================");
		
		MktEventNodeResDto rtnValue = new MktEventNodeResDto();
		
		//타겟팅 조회
		MktCampaignTargetingResDto targeting = new MktCampaignTargetingResDto();
		targeting = mktEventTriggerMapper.selectCampaignTargeting(param);
		
		if (ObjectUtil.isNotEmpty(targeting)) {
			param.setCamTgtHadId(targeting.getId());
			
			//타겟그룹(세그먼트) 일 경우
			if (MKT_TGT_TYPE.SEG.name().equals(targeting.getCamTgtTypeCd())) {
				param.setTgtGroupId(targeting.getTgtGroupId());
				//타겟그룹 확인
				rtnValue = checkTargetGroup(param);
			}
			
			//업로드 일 경우
			else if (MKT_TGT_TYPE.IMP.name().equals(targeting.getCamTgtTypeCd())) {
				//타겟팅 고객 조회
				int targetCount = mktEventTriggerMapper.selectTargetingMemberCount(param);
				
				if (targetCount > 0) {
					rtnValue.setSuccess(true);
				} else {
					rtnValue.setSuccess(false);
					rtnValue.setMessage("No Target Member.");
				}
			}
		} else {
			rtnValue.setSuccess(true);
		}
		
		LogUtil.debug("================ Targeting End ====================");
		
		return rtnValue;
	}
	
	public MktEventNodeResDto checkTargetGroup(MktEventTriggerReqDto param) {
		LogUtil.debug("================ TargetGroup Start ====================");
		
		MktEventNodeResDto rtnValue = new MktEventNodeResDto();
		
		//타겟그룹 정보 조회
		MktTargetGroupInfoResDto tgtGroupInfo = new MktTargetGroupInfoResDto();
		tgtGroupInfo = mktEventTriggerMapper.selectTargetGroupInfo(param);
		
		if (ObjectUtil.isNotEmpty(tgtGroupInfo)) {
			/*
			//db info
			MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
			dbInfo.setDriverClassName(tgtGroupInfo.getConDbClass());
			dbInfo.setConDbType(tgtGroupInfo.getConDbType());
			if (ObjectUtil.isNotEmpty(tgtGroupInfo.getAwsSecretNm())) {
				try {
					Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(), 
							 BeansUtil.getAwsRegion()
							 ).getSecretMap(tgtGroupInfo.getAwsSecretNm());					
					
					dbInfo.setUrl(map.get("url").toString());
					dbInfo.setUserName(map.get("username").toString());
					dbInfo.setPassword(map.get("password").toString());
					dbInfo.setConIp(map.get("ip").toString());
					dbInfo.setConPort(map.get("port").toString());
					dbInfo.setDriverClassName(map.get("driverClassName").toString());
				
				} catch(NullPointerException e) {
					LogUtil.error(e.getMessage());
				}
			} else {
		        dbInfo.setConIp(tgtGroupInfo.getConIp());
		        dbInfo.setConPort(tgtGroupInfo.getConPort());
		        dbInfo.setUserName(tgtGroupInfo.getConId());
		        dbInfo.setPassword(encrypor.decrypt(tgtGroupInfo.getConPassword()));
		        dbInfo.setUrl(tgtGroupInfo.getConUrl());
			}
			*/
	        
	        //query String 생성
	        StringBuilder queryStr = new StringBuilder();
	        queryStr.append(SELECT_STR)
	        .append(CARRIAGE_RETURN_STR)
	        .append(COUNT_STR)
	        .append(CARRIAGE_RETURN_STR)
	        .append(FROM_STR)
	        .append("(" + tgtGroupInfo.getFilterSql() + ") t")
	        .append(WHERE_STR)
	        .append(tgtGroupInfo.getSegKeyColNm() + EQUAL_STR + "'" + param.getMemId() + "'");
			
	        //int queryCount = (Integer) mktCallQueryDao.callSelectObject("execRole", queryStr.toString(), new ArrayList<String>(), dbInfo, java.lang.Integer.class);
	        int queryCount = mktEventTriggerMapper.selectQueryCount(queryStr.toString());
	        
			//count 0 일 경우
			if (queryCount > 0) {
				rtnValue.setSuccess(true);
			} else {
				rtnValue.setSuccess(false);
				rtnValue.setMessage("No Target Member.");
			}
			
		} else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("No Target Group Info.");
		}
		
		LogUtil.debug("================ TargetGroup End ====================");
		
		return rtnValue;
	}
	
	/**
	 * @programId : 
	 * @name : execRole
	 * @date : 2016. 11. 24.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : Role 실행
	 */
	public MktEventNodeResDto execRole(MktEventTriggerReqDto param, MktEventNodeResDto eventNode) {
		LogUtil.debug("================ Rule Start ====================");
		
		MktEventNodeResDto rtnValue = new MktEventNodeResDto();
		
		param.setRidCamNode(eventNode.getActTaskId());
		//조건값 조회
		MktETCampaignNodeResDto condVal = mktEventTriggerMapper.selectETCampaignNode(param);
		
		//et 조건값 목록 조회
		if (ObjectUtil.isNotEmpty(condVal)) {
			condVal.setCondValList(mktEventTriggerMapper.selectETCampaignCondValList(param));
		}
		
		if (ObjectUtil.isNotEmpty(condVal)) {
			//정형
			if (MKT_NODE_TYPE_CD.STRUC.name().equals(condVal.getType()) && ObjectUtil.isNotEmpty(condVal.getCondValList()) && ObjectUtil.isNotEmpty(condVal.getCondValList().get(0).getLgclCmpntId())) {
				//로지컬 컴포넌트 정보 조회
				param.setLgcCompId(condVal.getCondValList().get(0).getLgclCmpntId());
				MktLogicalComponentInfoResDto lgcCompInfo = mktEventTriggerMapper.selectLogicalComponentInfo(param);
				
				//Rule 조건 Query 추출
				String query = getRuleLgcCompQuery(condVal, lgcCompInfo, param.getRid());
				/*
				MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
				dbInfo.setDriverClassName(lgcCompInfo.getConDbClass());
				dbInfo.setConDbType(lgcCompInfo.getConDbType());
				if (ObjectUtil.isNotEmpty(lgcCompInfo.getAwsSecretNm())) {
					try {
						Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(), 
								 BeansUtil.getAwsRegion()
								 ).getSecretMap(lgcCompInfo.getAwsSecretNm());					
						
						dbInfo.setUrl(map.get("url").toString());
						dbInfo.setUserName(map.get("username").toString());
						dbInfo.setPassword(map.get("password").toString());
						dbInfo.setConIp(map.get("ip").toString());
						dbInfo.setConPort(map.get("port").toString());
						dbInfo.setDriverClassName(map.get("driverClassName").toString());
					
					} catch(NullPointerException e) {
						LogUtil.error(e.getMessage());
					}
				} else {
			        dbInfo.setConIp(lgcCompInfo.getConIp());
			        dbInfo.setConPort(lgcCompInfo.getConPort());
			        dbInfo.setUserName(lgcCompInfo.getConId());
			        dbInfo.setPassword(encrypor.decrypt(lgcCompInfo.getConPassword()));
			        dbInfo.setUrl(lgcCompInfo.getConUrl());
				}
				*/
				
				//MKTDBInfoDTO dbInfo = getDbInfo(lgcCompInfo);
				//DynamicDBDao dao = getDynamicDBDao(dbInfo);
				
				//쿼리 실행
				//int count = (Integer) mktCallQueryDao.callSelectObject("execRole", query, new ArrayList<String>(), dbInfo, java.lang.Integer.class);
				/*int count = 0;
				try {
					count = (Integer) dao.queryForObject(java.lang.Integer.class, query);
				} catch (InstantiationException | IllegalAccessException e) {
					e.printStackTrace();
				}*/
				
				int count = mktEventTriggerMapper.selectQueryCount(query);
				
				if (count > 0) {
					rtnValue.setSuccess(true);
				} else {  
					rtnValue.setSuccess(false);
					rtnValue.setMessage("정형 Rule 이 다릅니다.");
				}
			}
			//비정형
			else if (MKT_NODE_TYPE_CD.UNSTRUC.name().equals(condVal.getSubTypeCd())) {
				
				//대한항공 Demo TPM 확인
				if ("KE_TPM_CHECK".equals(condVal.getExecCls())) {
					LogUtil.info("Rule : KE_TPM_CHECK");
					rtnValue.setSuccess(true);
				}
				
				//대한항공 Demo 중복 Validation
				else if ("KE_DUP_VALI".equals(condVal.getExecCls())) {
					LogUtil.info("Rule : KE_DUP_VALI");
					rtnValue.setSuccess(true);
				}
				
				//대한항공 Demo 승객명 Validation
				else if ("KE_NAME_VALI".equals(condVal.getExecCls())) {
					LogUtil.info("Rule : KE_NAME_VALI");
					
					rtnValue = this.KANameValidationAction(param, condVal);
				} else {
					rtnValue.setSuccess(false);
					rtnValue.setMessage("비정형 Rule 프로그램 없습니다.");
				}
				
			}
		}
		
		LogUtil.debug("================ Rule End ====================");
		
		return rtnValue;
	}
	
	public String getRuleLgcCompQuery(MktETCampaignNodeResDto condVal, MktLogicalComponentInfoResDto lgcCompInfo, String rid) {
		StringBuilder rtnValue = new StringBuilder();
		
		StringBuilder strWhere = new StringBuilder();
		strWhere.append(CARRIAGE_RETURN_STR).append(WHERE_STR);
		
		//rid 설정
		strWhere.append(lgcCompInfo.getTblAliasColNm() + EQUAL_STR + "'" + rid + "'");
		
		for (MktETCampaignCondValResDto cond : condVal.getCondValList()) {
			String groupFuncTypeCode = "";
			String operationTypeCode = cond.getLcCompOper();
			String filterValue = cond.getLcCompVal();
			String andValue = "";
			String singleQuoteFlag = "";
			String lcLogicOper = " " + cond.getLcLogicOper() + " ";
			String lcLeftbrkt = "1".equals(cond.getLcLeftbrkt()) ? "(" : "";
			String lcRightbrkt = "1".equals(cond.getLcRightbrkt()) ? ")" : ""; 
			
			// 유효성 검사 체크용 쿼리 생성
			// 연산자 타입이 사용자 날짜 함수가 아니라면, 일반적인 처리
			if( !SERC_OPRT_CODE.CUSTDTDEF.name().equals(operationTypeCode) ) {
				filterValue = filterValue.replaceAll("'", "");
				filterValue = filterValue.replaceAll("\\%", "");
				filterValue = filterValue.replaceAll("\\(", "");
				filterValue = filterValue.replaceAll("\\)", "");


				if ( SERC_OPRT_CODE.BETWEEN.name().equals(operationTypeCode) ) {
					andValue = andValue.replaceAll("'", "");
					andValue = andValue.replaceAll("\\%", "");
					andValue = andValue.replaceAll("\\(", "");
					andValue = andValue.replaceAll("\\)", "");

					if( !"Y".equals(singleQuoteFlag) ) {
						filterValue = "'" + filterValue + "'" + AND_STR + "'" + andValue + "'";
					} else {
						filterValue = filterValue + AND_STR + andValue;
					}
				} else if ( SERC_OPRT_CODE.IN.name().equals(operationTypeCode) || "NOT IN".equals(operationTypeCode) ) {
					String[] valueList = filterValue.split(",");
					filterValue = "";

					for( Integer idx = 0; idx < valueList.length; idx++ ) {
						String value = valueList[idx].trim();
						value = value.trim();

						if( !"Y".equals(singleQuoteFlag) ) {
							filterValue = filterValue + "'" + value + "'";
						} else {
							filterValue = filterValue + value;
						}


						if( idx + 1  != valueList.length ) {
							filterValue = filterValue + ", ";
						}
					}

					filterValue = " (" + filterValue + ") ";
				} else if ( SERC_OPRT_CODE.LIKE.name().equals(operationTypeCode) ) {
					filterValue = "'%" + filterValue + "%'";
				} else if ( "IS NULL".equals(operationTypeCode) || "IS NOT NULL".equals(operationTypeCode) ) {
					filterValue = operationTypeCode;
				} else {
					if( !"Y".equals(singleQuoteFlag) ) {
						filterValue = "'" + filterValue + "'";
					}
				}
			} else {
				operationTypeCode = EQUAL_STR;

				String codeValue = filterValue;
				KprCommonCodeReqDto codeReqDto = new KprCommonCodeReqDto();
				codeReqDto.setGroupCode(MKT_DT_DEFAULT);
				codeReqDto.setCodeName(codeValue);
				KprCommonCodeResDto codeResDto = kprCommonMapper.getCommCodeDetail(codeReqDto);

				String databaseType = lgcCompInfo.getConDbType();
				if( DATABASE_TYPE.MYSQL.name().equals(databaseType) ) {
					filterValue = codeResDto.getAttrib02();
				} else {
					filterValue = codeResDto.getAttrib03();
				}
			}

			// 그룹 함수 사용 시
			if (ObjectUtil.isNotEmpty(groupFuncTypeCode)) {
				String groupFuncDetail = null;

				if( "COUNT(DISTINCT)".equals(groupFuncTypeCode)) {
					groupFuncDetail = "COUNT( DISTINCT " + cond.getTblAliasColNm() + " )";
				} else {
					groupFuncDetail = groupFuncTypeCode + "( " + cond.getTblAliasColNm() + " )";
				}

				StringBuilder strGroupBy = new StringBuilder();
				strGroupBy.append(CARRIAGE_RETURN_STR)
				.append(GROUP_BY_STR)
				.append(cond.getTblAliasColNm())
				.append(CARRIAGE_RETURN_STR)
				.append(HAVING_STR)
				.append(groupFuncDetail)
				.append(" " + operationTypeCode + " ")
				.append(filterValue);

			}
			// 그룹 함수 미사용 시
			else {
				// AND 조건 설정
				strWhere.append(CARRIAGE_RETURN_STR);
				strWhere.append(lcLogicOper);
				strWhere.append(lcLeftbrkt);
				strWhere.append(cond.getTblAliasColNm());
				strWhere.append(" " + operationTypeCode + " ");
				strWhere.append(filterValue);
				strWhere.append(lcRightbrkt);
			}
		}
		
		//최종 로지컬 컴포넌트 Sql 포함 쿼리 생성
		rtnValue.append(SELECT_STR)
		.append(CARRIAGE_RETURN_STR)
		.append(COUNT_STR)
		.append(CARRIAGE_RETURN_STR);
		String lgcSql = "";
		
		if (lgcCompInfo.getLgcSql().indexOf("from") > 0) {
			lgcSql = lgcCompInfo.getLgcSql().substring(lgcCompInfo.getLgcSql().indexOf("from"));
		} else {
			lgcSql = lgcCompInfo.getLgcSql().substring(lgcCompInfo.getLgcSql().indexOf("FROM"));
		}
		
		rtnValue.append(lgcSql).append(strWhere.toString());
		
		
		return rtnValue.toString();
	}
	
	/**
	 * @programId : 
	 * @name : execAction
	 * @date : 2016. 11. 24.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : Action 실행
	 */
	public MktEventNodeResDto execAction(MktEventTriggerReqDto param, MktEventNodeResDto eventNode) {
		LogUtil.debug("================ Action 실행 Start ====================");
		
		MktEventNodeResDto rtnValue = new MktEventNodeResDto();
		rtnValue.setSuccess(true);
		
		param.setRidCamNode(eventNode.getActTaskId());
		
		//활동값 조회
		MktETCampaignNodeResDto actVal = mktEventTriggerMapper.selectETCampaignNode(param);
		
		//et 캠페인 활동값 조회
        if (ObjectUtil.isNotEmpty(actVal)) {
        	actVal.setActVal(mktEventTriggerMapper.selectETCampaignActVal(param));
        	
        	actVal.setActParamList(mktEventTriggerMapper.selectETCampaignActParamList(param));
        }
        
		if (ObjectUtil.isNotEmpty(actVal) && ObjectUtil.isNotEmpty(actVal.getActVal())) {
			String type = actVal.getType();
			String subTypeCd = actVal.getSubTypeCd();
			
			/**
			 * 오퍼지급
			 * OFF
			 */
			/*if (LOY_ACT_NODE_TYPE.OFF.name().equals(subTypeCd)) {
				
			}*/
			/**
			 * 타켓테이블전송
			 * TBL
			 */
			/*if (LOY_ACT_NODE_TYPE.TBL.name().equals(subTypeCd)) {
				
			}*/
			/**
			 * 채널전송
			 * CHN
			 */
			/*if (LOY_ACT_NODE_TYPE.CHN.name().equals(subTypeCd)) {
				
			}*/
			/**
			 * IF호출
			 * SVR
			 */
			/*if (LOY_ACT_NODE_TYPE.SVR.name().equals(subTypeCd)) {
				
			}*/
			/**
			 * Function호출
			 * FUNC
			 */
			if (LOY_ACT_NODE_TYPE.FUNC.name().equals(subTypeCd)) {
				String execCls = actVal.getExecCls();
				String execMthd = actVal.getExecMthd();
				
				//제주항공 Demo
				if ("JEJUAIR_API".equals(execCls) && "RatingBanner".equals(execMthd)) {
					rtnValue = execActionRatingBanner(param);
				}
				
				//한국인삼공사 Demo
				if ("KGC_EXEC_ACT1".equals(execCls)) {
					rtnValue = kgcExecAction1(param);
				}
				
				//한국인삼공사 Demo
				if ("KGC_EXEC_ACT2".equals(execCls)) {
					rtnValue = kgcExecAction2(param);
				}
				
				//한국인삼공사 Demo
				if ("KGC_EXEC_ACT3".equals(execCls)) {
					rtnValue = kgcExecAction3(param);
				}
				
				//대한항공 Demo 마일리지 계산 적립
				if ("KE_MILEAGE_CAL_ACRL".equals(execCls)) {
					LogUtil.info("Action : KE_MILEAGE_CAL_ACRL");
					rtnValue.setSuccess(true);
					rtnValue.setMessage("[Action : KE_MILEAGE_CAL_ACRL] " + actVal.getTitle());
				}
				
				//대한항공 Demo 마일리지 적립
				if ("KE_MILEAGE_ACRL".equals(execCls)) {
					LogUtil.info("Action : KE_MILEAGE_ACRL");
					rtnValue.setSuccess(true);
					rtnValue.setMessage("[Action : KE_MILEAGE_ACRL] " + actVal.getTitle());
				}
			}
			
			/**
			 * IF호출
			 * SVR
			 */
			if (LOY_ACT_NODE_TYPE.CAL.name().equals(type) && ObjectUtil.isNotEmpty(actVal.getActParamList())) {
					
					List<MktETCampaignActParamResDto> resultParams = new ArrayList<MktETCampaignActParamResDto>();
					List<MktETCampaignActParamResDto> inputParams = new ArrayList<MktETCampaignActParamResDto>();
					List<MktETCampaignActParamResDto> returnParams = new ArrayList<MktETCampaignActParamResDto>();
					
					Map<String, Object> resultMap = new HashMap<String, Object>();
					Map<String, Object> returnMap = new HashMap<String, Object>();
					
					for (MktETCampaignActParamResDto params : actVal.getActParamList()) {
						if ("RESULT".equals(params.getParamType())) {
							resultParams.add(params);
						} else if ("INPUT".equals(params.getParamType())) {
							inputParams.add(params);
						} else if ("RETURN".equals(params.getParamType())) {
							returnParams.add(params);
						}
					}
					
					if (ObjectUtil.isNotEmpty(actVal.getActVal().getLgclCmpntId())) {
					
						//로지컬 컴포넌트 정보 조회
						param.setLgcCompId(actVal.getActVal().getLgclCmpntId());
						MktLogicalComponentInfoResDto lgcCompInfo = mktEventTriggerMapper.selectLogicalComponentInfo(param);
						/*
						MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
						dbInfo.setDriverClassName(lgcCompInfo.getConDbClass());
						dbInfo.setConDbType(lgcCompInfo.getConDbType());
						if (ObjectUtil.isNotEmpty(lgcCompInfo.getAwsSecretNm())) {
							try {
								Map<String, Object> map =  new SecretsManager(BeansUtil.getAWSCredentials(), 
										 BeansUtil.getAwsRegion()
										 ).getSecretMap(lgcCompInfo.getAwsSecretNm());					
								
								dbInfo.setUrl(map.get("url").toString());
								dbInfo.setUserName(map.get("username").toString());
								dbInfo.setPassword(map.get("password").toString());
								dbInfo.setConIp(map.get("ip").toString());
								dbInfo.setConPort(map.get("port").toString());
								dbInfo.setDriverClassName(map.get("driverClassName").toString());
							
							} catch(NullPointerException e) {
								LogUtil.error(e.getMessage());
							}
						} else {
					        dbInfo.setConIp(lgcCompInfo.getConIp());
					        dbInfo.setConPort(lgcCompInfo.getConPort());
					        dbInfo.setUserName(lgcCompInfo.getConId());
					        dbInfo.setPassword(encrypor.decrypt(lgcCompInfo.getConPassword()));
					        dbInfo.setUrl(lgcCompInfo.getConUrl());
						}
						*/
						
						List<MktETCampaignLCColumnListResDto> lcColList = mktEventTriggerMapper.selectETLogicalComponentColumnList(param);
						
	
						
						// result param 관련 처리
						//Rule 조건 Query 추출
						String query = getActionLgcCompQuery(actVal, lgcCompInfo, param.getRid());
						
						//MKTDBInfoDTO dbInfo = getDbInfo(lgcCompInfo);
						//DynamicDBDao dao = getDynamicDBDao(dbInfo);
						
						//쿼리 실행
						//resultMap = dao.queryForMap(query);
						
						resultMap = mktEventTriggerMapper.selectQuery(query);
						
						//쿼리 실행
						//resultMap  = mktCallQueryDao.callSelectForMap("execRole", query, new ArrayList<String>(), dbInfo);
					} else {
						for (MktETCampaignActParamResDto rtnParam : resultParams) {
							resultMap.put(rtnParam.getParamNm(), getValue(rtnParam.getParamVal()));
						}
					}
					
					// Transaction 처리
					if (ObjectUtil.isNotEmpty(actVal.getActVal().getAcrlType())) {
						HashMap<String, Object> callMap = new HashMap<String, Object>();
						callMap.put("pEncryptKey", param.getCipherKey());
						callMap.put("pGuid", param.getGuid());
						callMap.put("pMbrNo", param.getMbrNo());
						callMap.put("pTxnAmt", 0);
						callMap.put("pMileage", 0);
						callMap.put("pQualMileage", 0);
						callMap.put("pMileageEffDt", "");
						callMap.put("pRst", "");
						callMap.put("pRstCd", "");
						callMap.put("pRstMsg", "");
						
						// input param 처리
						if (inputParams.size() > 0) {
							for (MktETCampaignActParamResDto params : inputParams) {
								Object value = params.getParamVal();
								
								if (ObjectUtil.isNotEmpty(resultMap) && ObjectUtil.isNotEmpty(resultMap.get(params.getParamVal()))) {
									value = resultMap.get(params.getParamVal());
								} else {
									value = getValue(value); 
								}
								
								if (value.equals(java.math.BigDecimal.class) || "java.math.BigDecimal".equals(value.getClass().getName())) {
									value = ((BigDecimal) value).intValue();
								}
								
								callMap.put(params.getParamNm(), value);
							}
						}
						
						if ("ACRL_MILE".equals(actVal.getActVal().getAcrlType())) {
							mktEventTriggerMapper.procAcrlMile(callMap);
							
							returnMap.put("rst", callMap.get("pRst"));
							returnMap.put("rstCd", callMap.get("pRstCd"));
							returnMap.put("rstMsg", callMap.get("pRstMsg"));
							
						} else if ("ACRL_Q_MILE".equals(actVal.getActVal().getAcrlType())) {
							mktEventTriggerMapper.procAcrlQualMile(callMap);
							
							returnMap.put("rst", callMap.get("pRst"));
							returnMap.put("rstCd", callMap.get("pRstCd"));
							returnMap.put("rstMsg", callMap.get("pRstMsg"));
							
						} else if ("RDM_MILE".equals(actVal.getActVal().getAcrlType())) {
							mktEventTriggerMapper.procRdmMile(callMap);
							
							returnMap.put("rst", callMap.get("pRst"));
							returnMap.put("rstCd", callMap.get("pRstCd"));
							returnMap.put("rstMsg", callMap.get("pRstMsg"));
						
						} else if ("PUR_MILE".equals(actVal.getActVal().getAcrlType())) {
							mktEventTriggerMapper.procPntUpload(callMap);
							
							returnMap.put("rst", callMap.get("pRst"));
							returnMap.put("rstCd", callMap.get("pRstCd"));
							returnMap.put("rstMsg", callMap.get("pRstMsg"));
							
						} else if ("CANCEL_PUR_MILE".equals(actVal.getActVal().getAcrlType())) {
							mktEventTriggerMapper.procCancelMile(callMap);
							
							returnMap.put("rst", callMap.get("pRst"));
							returnMap.put("rstCd", callMap.get("pRstCd"));
							returnMap.put("rstMsg", callMap.get("pRstMsg"));
						}
						
					}
					
					// return param 처리
					if (returnParams.size() > 0) {
						for (MktETCampaignActParamResDto params : returnParams) {
							
							Object value = params.getParamVal();
							
							if (ObjectUtil.isNotEmpty(resultMap)) {
								Object val = resultMap.get(params.getParamVal());
								
								if (ObjectUtil.isNotEmpty(val)) {
									value = getValue(val);
								} else {
									value = getValue(value);
								}
							} else {
								value = getValue(value);
							}
							
							returnMap.put(params.getParamNm(), value);
						}
					}
					
					
					if (ObjectUtil.isNotEmpty(returnMap)) {
						if ("F".equals(returnMap.get("rst"))) {
							rtnValue.setSuccess(false);
						} else {
							rtnValue.setSuccess(true);
						}
						
						rtnValue.setData(returnMap);
					} else {  
						rtnValue.setSuccess(false);
						rtnValue.setMessage("결과가 없습니다.");
					}
			}
		}
		
		LogUtil.debug("================ Action 실행 End ====================");
		
		return rtnValue;
	}
	
	public static Object getValue(Object val) {
	    Object rtnValue;
	    
		ScriptEngineManager mgr = new ScriptEngineManager();
	    ScriptEngine engine = mgr.getEngineByName("JavaScript");
	    
	    try {
			rtnValue = engine.eval((String) val);
		} catch (Exception e) {
			rtnValue = val;
		}
	    
	    try {
	    	Double i = Double.parseDouble((String) rtnValue); 
	        rtnValue = BigDecimal.valueOf(i); 
	    } catch (Exception e) {
	    }
	    
	    try {
	    	Double i = Double.valueOf((int) rtnValue);
	        rtnValue = BigDecimal.valueOf(i); 
	    } catch (Exception e) {
	    }
	    
	    try {
	        rtnValue = BigDecimal.valueOf((Double) rtnValue); 
	    } catch (Exception e) {
	    }
	    
	    return rtnValue;
	}
	
	public String getActionLgcCompQuery(MktETCampaignNodeResDto actVal, MktLogicalComponentInfoResDto lgcCompInfo, String rid) {
		StringBuilder rtnValue = new StringBuilder();
		
		StringBuilder strWhere = new StringBuilder();
		strWhere.append(CARRIAGE_RETURN_STR).append(WHERE_STR);
		
		//rid 설정
		strWhere.append(lgcCompInfo.getTblAliasColNm() + EQUAL_STR + "'" + rid + "'");
		
		//최종 로지컬 컴포넌트 Sql 포함 쿼리 생성
		String strCol = "";
		String lgcSql = "";
		
		/*
		if (lgcCompInfo.getLgcSql().indexOf("from") > 0) {
			strCol = lgcCompInfo.getLgcSql().substring(0, lgcCompInfo.getLgcSql().indexOf("from"));
			lgcSql = lgcCompInfo.getLgcSql().substring(lgcCompInfo.getLgcSql().indexOf("from"));
		} else {
			strCol = lgcCompInfo.getLgcSql().substring(0, lgcCompInfo.getLgcSql().indexOf("FROM"));
			lgcSql = lgcCompInfo.getLgcSql().substring(lgcCompInfo.getLgcSql().indexOf("FROM"));
		}
		
		rtnValue.append(strCol);
		
		rtnValue.append(CARRIAGE_RETURN_STR);
		rtnValue.append(lgcSql);
		rtnValue.append(strWhere.toString());
		*/
		
		rtnValue.append("SELECT T.* ");
		
		boolean fst = true;
		for (MktETCampaignActParamResDto param : actVal.getActParamList()) {
			if ("RESULT".equals(param.getParamType())) {
				
				rtnValue.append(CARRIAGE_RETURN_STR);
				//if (!fst) {
				//	rtnValue.append(",");
				//}
				
				rtnValue.append(",");
				rtnValue.append(param.getParamVal() + " as \"" + param.getParamNm() + "\" ");
				
				fst = false;
			}
		}
		
		rtnValue.append(CARRIAGE_RETURN_STR)
		.append(" FROM (")
		.append(CARRIAGE_RETURN_STR)
		.append(lgcCompInfo.getLgcSql())
		.append(CARRIAGE_RETURN_STR)
		.append(strWhere.toString())
		.append(CARRIAGE_RETURN_STR)
		.append(" ) T");
		
		return rtnValue.toString();
	}
	
	/**
	 * @programId : 
	 * @name : execChannel
	 * @date : 2016. 11. 24.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : 채널 실행
	 */
	public MktEventNodeResDto execChannel(MktEventTriggerReqDto param, MktEventNodeResDto eventNode) {
		LogUtil.debug("================ 채널 실행 Start ====================");
		
		MktEventNodeResDto rtnValue = new MktEventNodeResDto();
		rtnValue.setSuccess(true);
		
		param.setContentsId(eventNode.getActTaskId());
		
		//콘텐츠 조회
		MktContentsDetailResDto contents = mktEventTriggerMapper.selectContentsDetail(param);
		
		//콘텐츠 제목
		String contentsTitle = contents.getTitle();
		
		//콘텐츠 Text
		String contentsText = contents.getContents();
		
		//콘텐츠 유형
		String contentsType = contents.getContentsType();
		
		//수신자 거부 메세지 추가
		if(NODE_TYPE_CD.SMS.name().equals(contentsType) || NODE_TYPE_CD.MMS.name().equals(contentsType) || NODE_TYPE_CD.LMS.name().equals(contentsType)) {
			contentsText = contentsText + CARRIAGE_RETURN_STR + contents.getBottom();
		}
		
		//email 일 경우 html이 콘텐츠 Text가 된다
		else if(NODE_TYPE_CD.EMAIL.name().equals(contentsType)) {
			contentsText = contents.getHtml();
		}
		
        String phone = "";
        String email = "";
        String name = "";
		
		//개인화 속성 조회
		List<MktCondResDto> condList = new ArrayList<MktCondResDto>();
		condList = mktEventTriggerMapper.selectSerarchPersonalType(param);
		
		//개인화 속성 적용
		for (MktCondResDto cond : condList) {
			//db 정보
			MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
            dbInfo.setDriverClassName(cond.getClassNm());
            dbInfo.setConIp(cond.getConIp());
            dbInfo.setConPort(cond.getConPort());
            dbInfo.setUserName(cond.getConId());
            dbInfo.setPassword(encrypor.decrypt(cond.getConPw()));
            dbInfo.setUrl(cond.getConUrl());
            dbInfo.setConDbType(cond.getConDbType());
            
			//컬럼
			String colName = cond.getColName();
			
			//컬럼산출식 확인
			if (ObjectUtil.isNotEmpty(cond.getCondCalmt())) {
			    colName = cond.getCondCalmt();
			}
			
			//key 컬럼
			
			StringBuilder query = new StringBuilder();
			query.append(SELECT_STR)
			.append(colName + " as value,")
			.append(cond.getSchPhone() + " as schPhone, ")
			.append(cond.getSchEmail() + " as schEmail ")
			.append(FROM_STR)
			.append(cond.getSchName() + "." + cond.getTblName())
			.append(WHERE_STR)
			.append(cond.getSchMemId() + EQUAL_STR + "'" + param.getMemId() + "'");
			
            //쿼리 실행
			Map rtnQuery = new HashMap();
            rtnQuery = (Map) mktCallQueryDao.callSelectForMap("getPersonalValue", query.toString(), new ArrayList<String>(), dbInfo);
            
            String personalValue = "";
            
            //쿼리 결과 확인
            if (ObjectUtil.isNotEmpty(rtnQuery)) {
            	personalValue = (String) rtnQuery.get("value");
            	phone = (String) rtnQuery.get("schPhone");
            	email = (String) rtnQuery.get("schEmail");
            }
            
            //개인화
            if (ObjectUtil.isNotEmpty(personalValue)) {
            	//변경할 문자
            	String replaceText = "$$" +  cond.getMarkName() + "$$";
            	
            	//개인화 변경
            	//제목
            	contentsTitle = contentsTitle.replace(replaceText, personalValue);
            	
            	//내용
            	contentsText = contentsText.replace(replaceText, personalValue);
            	
            	if ("회원명".equals(cond.getMarkName())) {
            		name = personalValue;
            	}
            }
		}
		
		
		//현재시간
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREAN);
		String dateStr = sdf.format(cal.getTime());
		
		//실행정보 아이템 아이디
		String mktExeInfoItemId = commonService.getRowID(); 
		
		//send log 등록
		//SMS, LMS, MMS
		if(NODE_TYPE_CD.SMS.name().equals(contentsType) || NODE_TYPE_CD.LMS.name().equals(contentsType) || NODE_TYPE_CD.MMS.name().equals(contentsType)) {
			MessageSendLogReqDto msgRequest = new MessageSendLogReqDto();
			
			msgRequest.setContsId(contents.getId());
			msgRequest.setSystemColumn(param.getSystemColumn());
			msgRequest.setCamId(param.getCampaignId());
			msgRequest.setScheduleType("0");
			msgRequest.setInputDt(dateStr);
			msgRequest.setSendPlanDt(dateStr);
			msgRequest.setToCallbackNo("080-801-7512");
			msgRequest.setMsgSendType(contentsType);
			msgRequest.setMsgType("0");
			msgRequest.setMsgSubject(contentsTitle);
			msgRequest.setMsgSbst(contentsText);
			msgRequest.setRecvCallNo(phone);
			msgRequest.setRecvMemId(param.getMemId());
			msgRequest.setFileCnt("0");
			msgRequest.setBatSendStatus(BAT_SEND_STATUS);
			msgRequest.setMktExeInfoItemId(mktExeInfoItemId);
			
			//MMS일 경우 이미지 등 처리
			if (NODE_TYPE_CD.MMS.name().equals(contentsType)) {
				msgRequest.setFileCnt("1");
				String filePath1 = File.separator + "app" + File.separator + contents.getImagepath();
				String fileType1 =  contents.getImagepath().substring(contents.getImagepath().lastIndexOf(".") + 1);
				String filePathFilename1 = contents.getImagepath().substring(contents.getImagepath().lastIndexOf("/") + 1);
				
				msgRequest.setFileType1(fileType1);
				msgRequest.setFilePath1(filePath1);
				msgRequest.setFilePathFilename1(filePathFilename1);
			}
			
			//등록
			commonService.addMessageSendLog(msgRequest);
		}
		//EMAIL
		else if(NODE_TYPE_CD.EMAIL.name().equals(contentsType)) {
			EmailSendLogReqDto emailRequest = new EmailSendLogReqDto();
			
			emailRequest.setContsId(contents.getId());
			emailRequest.setSystemColumn(param.getSystemColumn());
			emailRequest.setCamId(param.getCampaignId());
			emailRequest.setScheduleType("0");
			emailRequest.setInputDt(dateStr);
			emailRequest.setSendPlanDt(dateStr);
			emailRequest.setMsgSubject(contentsTitle);
			emailRequest.setMsgSbst(contentsText);
			emailRequest.setFileCnt("0");
			emailRequest.setBatSendStatus(BAT_SEND_STATUS);
			emailRequest.setMktExeInfoItemId(mktExeInfoItemId);
			
			emailRequest.setRecvMemId(param.getMemId());
			emailRequest.setRecvEmail(email);
			emailRequest.setRecvNm(name);
			
			emailRequest.setSenderEmail("iCignalMarketing@quintet.co.kr");
			emailRequest.setSenderNm("마케팅 발신용 메일");
			
			/*String [] fileTypeArr;
			fileTypeArr = mcr.getFilePath().split("\\.");
			String fileType = fileTypeArr[fileTypeArr.length -1];
			String textStore = null;
			  
			if(j==0){
			//FTP 이미지 전송
			String [] fileNameArr;
			fileNameArr = mcr.getFilePath().split("/");
			fileName = fileNameArr[fileNameArr.length-1];
			filePath = CommonDAO.ftpFileUplaod(mcr.getFilePath(), "EMAIL_TMP",  fileName, mcr.getLang());
			}
			  
			smsrequest.setFileCnt(1);
			smsrequest.setFileType1(fileType);
			smsrequest.setFilePath1(File.separator + "app" + File.separator + mcr.getFilePath());
			}
			Status = ContentDAO.sendEmailTest(smsrequest);*/
			
			//등록
			commonService.addEmailSendLog(emailRequest);
		}
		//PUSH
		else if(NODE_TYPE_CD.PUSH.name().equals(contentsType)) {
			
			PushSendLogReqDto pushRequest = new PushSendLogReqDto();
			
			pushRequest.setContsId(contents.getId());
			pushRequest.setSystemColumn(param.getSystemColumn());
			pushRequest.setCamId(param.getCampaignId());
			pushRequest.setScheduleType("0");
			pushRequest.setBatSendStatus(BAT_SEND_STATUS);
			pushRequest.setInputDt(dateStr);
			pushRequest.setSendPlanDt(dateStr);
			pushRequest.setMsgSubject(contentsTitle);
			pushRequest.setMsgSbst(contentsText);
			pushRequest.setRecvMemId(param.getMemId());
			pushRequest.setPushTypeCd(contents.getContsPushTypeCode());
			pushRequest.setAccntAppKey(ACCNT_APP_KEY);
			pushRequest.setPuthSound(PUTH_SOUND);
			pushRequest.setMktExeInfoItemId(mktExeInfoItemId);
			   
			//등록
			commonService.addPushSendLog(pushRequest);
		}
		
		LogUtil.debug("================ 채널 실행 End ====================");
		
		return rtnValue;
	}
	
	
	
	/**
	 * @name : execActionRatingBanner
	 * @date : 2017. 3. 27.
	 * @author : new one
	 * @return : MktEventTriggerResDto
	 * @description : 제주항공 이벤트 배너
	 */
	public MktEventNodeResDto execActionRatingBanner(MktEventTriggerReqDto param) {
		MktEventNodeResDto rtnValue = new MktEventNodeResDto();
		
		List<MktCondResDto> condList = new ArrayList<MktCondResDto>();
		condList = mktEventTriggerMapper.selectSerarchPersonalType(param);
		
		String personalValue = "";
		
		//개인화 속성 적용
		for (MktCondResDto cond : condList) {
			if ("회원등급".equals(cond.getMarkName())) {
				MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
	            dbInfo.setDriverClassName(cond.getClassNm());
	            dbInfo.setConIp(cond.getConIp());
	            dbInfo.setConPort(cond.getConPort());
	            dbInfo.setUserName(cond.getConId());
	            dbInfo.setPassword(encrypor.decrypt(cond.getConPw()));
	            dbInfo.setUrl(cond.getConUrl());
	            dbInfo.setConDbType(cond.getConDbType());
	            
				//컬럼
				String colName = cond.getColName();
				
				//컬럼산출식 확인
				if (ObjectUtil.isNotEmpty(cond.getCondCalmt())) {
				    colName = cond.getCondCalmt();
				}
				
				//key 컬럼
				
				StringBuilder query = new StringBuilder();
				query.append(SELECT_STR)
				.append(colName + " as value,")
				.append(cond.getSchPhone() + " as schPhone, ")
				.append(cond.getSchEmail() + " as schEmail ")
				.append(FROM_STR)
				.append(cond.getSchName() + "." + cond.getTblName())
				.append(WHERE_STR)
				.append(cond.getSchMemId() + EQUAL_STR + "'" + param.getMemId() + "'");
				
				//쿼리 실행
				Map rtnQuery = new HashMap();
	            rtnQuery = (Map) mktCallQueryDao.callSelectForMap("getPersonalValue", query.toString(), new ArrayList<String>(), dbInfo);
	            
	            //쿼리 결과 확인
	            if (ObjectUtil.isNotEmpty(rtnQuery)) {
	            	personalValue = (String) rtnQuery.get("value");
	            	
	            	JSONObject jsonObject = new JSONObject();
					jsonObject.put("value", personalValue);
	            	String text = "";
	            	if ("VIP".equals(personalValue)) {
	            		text = "VIP 고객님을 위한 Special Event!! \n 포인트 구매시 구매금액의 최대 20%를 포인트로 추가 적립해드립니다.";
	            	}
	            	else if ("GOLD".equals(personalValue)) {
	            		text = "GOLD 고객님을 위한 Special Event!! \n 포인트 구매시 구매금액의 최대 15%를 포인트로 추가 적립해드립니다.";
	            	}
	            	else if ("SILVER".equals(personalValue)) {
	            		text = "SILVER 고객님을 위한 Special Event!! \n 포인트 구매시 구매금액의 최대 10%를 포인트로 추가 적립해드립니다.";
	            	}
	            	
	            	jsonObject.put("text", text);
	            	
	            	personalValue = jsonObject.toString();
	            }
			}
		}
		
		if (ObjectUtil.isNotEmpty(personalValue)) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage(personalValue);
		}
		
		return rtnValue;
	}
	
	/**
	 * @name : kgcExecAction1
	 * @date : 2017. 3. 27.
	 * @author : dg.ryu
	 * @return : MktEventTriggerResDto
	 * @description : 한국인삼공사 Demo 장바구니 처리1
	 */
	public MktEventNodeResDto kgcExecAction1(MktEventTriggerReqDto param) {
		MktEventNodeResDto rtnValue = new MktEventNodeResDto();
				
		//이벤트 팝업1
    	JSONObject jsonObject = new JSONObject();
		jsonObject.put("value", "event_popup1");
	
		rtnValue.setSuccess(true);
		rtnValue.setMessage(jsonObject.toString());
		
		return rtnValue;
	}
	
	/**
	 * @name : kgcExecAction2
	 * @date : 2017. 3. 27.
	 * @author : dg.ryu
	 * @return : MktEventTriggerResDto
	 * @description : 한국인삼공사 Demo 장바구니 처리2
	 */
	public MktEventNodeResDto kgcExecAction2(MktEventTriggerReqDto param) {
		MktEventNodeResDto rtnValue = new MktEventNodeResDto();
				
		//이벤트 팝업1
    	JSONObject jsonObject = new JSONObject();
		jsonObject.put("value", "event_popup2");
	
		rtnValue.setSuccess(true);
		rtnValue.setMessage(jsonObject.toString());
		
		return rtnValue;
	}
	
	/**
	 * @name : kgcExecAction3
	 * @date : 2017. 3. 27.
	 * @author : dg.ryu
	 * @return : MktEventTriggerResDto
	 * @description : 한국인삼공사 Demo 구매시
	 */
	public MktEventNodeResDto kgcExecAction3(MktEventTriggerReqDto param) {
		MktEventNodeResDto rtnValue = new MktEventNodeResDto();
				
		//이벤트 팝업1
    	JSONObject jsonObject = new JSONObject();
		jsonObject.put("value", "event_popup3");
	
		rtnValue.setSuccess(true);
		rtnValue.setMessage(jsonObject.toString());
		
		return rtnValue;
	}
	
	/**
	 * 대항항공 Demo 이름 유사성 확인
	 *
	 * @author dgryu
	 * @since 2020. 6. 11.
	 */
	public MktEventNodeResDto KANameValidationAction(MktEventTriggerReqDto param, MktETCampaignNodeResDto condVal) {
		MktEventNodeResDto rtnValue = new MktEventNodeResDto();
		
		String custNm = mktEventTriggerMapper.selectCustNm(param);
		
		double check = StringUtil.similarity(custNm, param.getPassenger());
		
		int compVal = Integer.parseInt(condVal.getCondValList().get(0).getIrreglrCompVal());
		
		if (check >= compVal) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage("고객명 유사성 기준 성공 : " + check);
		} else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("고객명 유사성 기준 미달 : " + check);
		}
		
		return rtnValue;
	}
	

}