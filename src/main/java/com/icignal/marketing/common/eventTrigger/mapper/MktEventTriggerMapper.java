package com.icignal.marketing.common.eventTrigger.mapper;

import java.util.HashMap;
import java.util.List;

import com.icignal.marketing.common.eventTrigger.dto.response.*;
import org.apache.ibatis.annotations.Mapper;

import com.icignal.marketing.common.eventTrigger.dto.request.MktEventTriggerReqDto;

/**
 * @name : IMktEventTriggerDAO.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : 공통
 */
@Mapper
public interface MktEventTriggerMapper {
	
    /**
     * @programId : 
     * @name : insertIntactDataKe
     * @date : 2016. 11. 24.
     * @author : dg.ryu
     * @table : 
     * @return : 
     * @description : 인터랙트 데이터 등록(대한항공)
     */
	void insertIntactDataKe(MktEventTriggerReqDto param);

	/**
	 * @programId : 
	 * @name : selectEventTriggerCampaignList
	 * @date : 2016. 11. 24.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : 트리거 이벤트 캠페인 목록 조회 
	 */
	List<MktEventTriggerCampaignResDto> selectEventTriggerCampaignList(MktEventTriggerReqDto param);

    /**
     * @programId : 
     * @name : selectCampaignTargeting
     * @date : 2016. 11. 24.
     * @author : dg.ryu
     * @table : 
     * @return : 
     * @description : 타겟팅 헤더 조회
     */
	MktCampaignTargetingResDto selectCampaignTargeting(MktEventTriggerReqDto param);

	/**
	 * @programId : 
	 * @name : selectStartEventNodeList
	 * @date : 2016. 11. 24.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : 시작 이벤트 노드 목록 조회
	 */
	List<MktEventNodeResDto> selectStartEventNodeList(MktEventTriggerReqDto param);

	/**
	 * @programId : 
	 * @name : selectChildEventNodeList
	 * @date : 2016. 11. 24.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : 하위 이벤트 노드 목록 조회
	 */
	List<MktEventNodeResDto> selectChildEventNodeList(MktEventTriggerReqDto param);

    /**
     * @programId : 
     * @name : selectLogicalComponentInfo
     * @date : 2016. 11. 24.
     * @author : dg.ryu
     * @table : 
     * @return : 
     * @description : 로지컬 컴포넌트 정보 조회
     */
	MktLogicalComponentInfoResDto selectLogicalComponentInfo(MktEventTriggerReqDto param);
	
    /**
     * @programId : 
     * @name : selectContentsDetail
     * @date : 2016. 11. 24.
     * @author : dg.ryu
     * @table : 
     * @return : 
     * @description : 콘텐츠 상세 조회
     */
	MktContentsDetailResDto selectContentsDetail(MktEventTriggerReqDto param);

	/**
	 * @programId : 
	 * @name : selectSerarchPersonalType
	 * @date : 2016. 11. 25.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : 개인화 속성 목록 조회
	 */
	List<MktCondResDto> selectSerarchPersonalType(MktEventTriggerReqDto param);

	/**
	 * @programId : 
	 * @name : selectTargetGroupInfo
	 * @date : 2016. 12. 1.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : 타겟그룹 정보
	 */
	MktTargetGroupInfoResDto selectTargetGroupInfo(MktEventTriggerReqDto param);

	/**
	 * @programId : 
	 * @name : selectCampaignTargetingMemberCount
	 * @date : 2016. 12. 1.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : 타겟팅 고객 건수
	 */
	int selectTargetingMemberCount(MktEventTriggerReqDto param);
	
	/**
	 * @programId : 
	 * @name : selectETCampaignCondValList
	 * @date : 2016. 12. 1.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : et 조건값 목록 조회
	 */
	List<MktETCampaignCondValResDto> selectETCampaignCondValList(MktEventTriggerReqDto param);
	
	/**
	 * @programId : 
	 * @name : selectETCampaignActVal
	 * @date : 2016. 12. 1.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : et 캠페인 활동값 조회
	 */
	MktETCampaignActValResDto selectETCampaignActVal(MktEventTriggerReqDto param);
	
	/**
	 * @programId : 
	 * @name : selectETCampaignActParamList
	 * @date : 2016. 12. 1.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : et action param
	 */
	List<MktETCampaignActParamResDto> selectETCampaignActParamList(MktEventTriggerReqDto param);
	
	/**
	 * @programId : 
	 * @name : selectETCampaignActVal
	 * @date : 2016. 12. 1.
	 * @author : dg.ryu
	 * @table : 
	 * @return : 
	 * @description : et 캠페인 노드 조회
	 */
	MktETCampaignNodeResDto selectETCampaignNode(MktEventTriggerReqDto param);
	
	
	/**
	 * 고객명 조회
	 *
	 * @author dgryu
	 * @since 2020. 6. 11.
	 */
	String selectCustNm(MktEventTriggerReqDto param);
	
	/**
	 * 로지컬 컴포넌트 컬럼 목록
	 *
	 * @author dgryu
	 * @since 2020. 6. 15.
	 */
	List<MktETCampaignLCColumnListResDto> selectETLogicalComponentColumnList(MktEventTriggerReqDto param);
	
	/**
	 * 마일리지 적립
	 *
	 * @author dgryu
	 * @since 2020. 6. 15.
	 */
	HashMap procAcrlMile(HashMap<String, Object> callMap);
	
	/**
	 * 퀄리파잉 마일리지 적립
	 *
	 * @author dgryu
	 * @since 2020. 6. 15.
	 */
	HashMap procAcrlQualMile(HashMap<String, Object> param);
	
	/**
	 * 마일리지 사용
	 *
	 * @author dgryu
	 * @since 2020. 6. 15.
	 */
	HashMap procRdmMile(HashMap<String, Object> param);
	
	/**
	 * 마일리지 적립 요청
	 *
	 * @author dgryu
	 * @since 2020. 6. 15.
	 */
	HashMap procPntUpload(HashMap<String, Object> param);
	
	/**
	 * 마일리지 구매 취소
	 *
	 * @author dgryu
	 * @since 2020. 6. 15.
	 */
	HashMap procCancelMile(HashMap<String, Object> param);
	
	/**
	 * query 조회
	 *
	 * @author dgryu
	 * @since 2020. 6. 17.
	 */
	HashMap selectQuery(String param);
	
	/**
	 * query count조회
	 *
	 * @author dgryu
	 * @since 2020. 6. 17.
	 */
	Integer selectQueryCount(String param);
	
}
