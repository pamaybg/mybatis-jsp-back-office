package com.icignal.systemmanagement.intact.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;

import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.intact.dto.request.SystemIntactCheckReqDto;
import com.icignal.systemmanagement.intact.dto.request.SystemIntactDetailReqDto;
import com.icignal.systemmanagement.intact.dto.request.SystemIntactListReqDto;
import com.icignal.systemmanagement.intact.dto.response.SystemIntactCheckResDto;
import com.icignal.systemmanagement.intact.dto.response.SystemIntactDetailResDto;
import com.icignal.systemmanagement.intact.dto.response.SystemIntactListResDto;
import com.icignal.systemmanagement.intact.mapper.SystemIntactMapper;

/*
 * 1. 클래스명	: SystemIntactService
 * 2. 파일명	: SystemIntactService.java
 * 3. 패키지명	: com.icignal.systemmanagement.intact.service
 * 4. 작성자명	: jh.kim
 * 5. 작성일자	: 2017. 6. 23.
 */
/**
 * <PRE>
 * 1. 설명
 *		인터렉션 유형 관리 Service
 * </PRE>
 */ 
@Service("SystemIntactService")
public class SystemIntactService {
	
	@Autowired
    SystemIntactMapper systemIntactMapper;

     /*
      * 1. 메소드명: getLoyIntactList
      * 2. 클래스명: LoyIntactService
      * 3. 작성자명: 
      * 4. 작성일자: jh.kim 
      */
    /**
     * <PRE>
     * 1. 설명
     *		인터렉션 유형 목록 조회
     * 2. 사용법
     *		
     * </PRE>
     *   @param param
     *   @return	
     */
    public GridPagingResDto<SystemIntactListResDto> getLoyIntactList(SystemIntactListReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setSVCAlias("t1");
        
        return new GridPagingResHelper<SystemIntactListResDto>().newGridPagingResDto(
        		param.init(CommonUtil.getInstance().getDBType()), systemIntactMapper.selectLoyIntactList(param), AnnotationType.CommCode);
    }

     /*
      * 1. 메소드명: getLoyIntactItem
      * 2. 클래스명: LoyIntactService
      * 3. 작성자명: jh.kim 
      * 4. 작성일자: 2017. 6. 23.
      */
    /**
     * <PRE>
     * 1. 설명
     *		인터렉션 유형 상세 조회
     * 2. 사용법
     *		
     * </PRE>
     *   @param param
     *   @return	
     */
    public SystemIntactDetailResDto getLoyIntactItem(SystemIntactDetailReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setSVCAlias("t1");
        
        return systemIntactMapper.selectLoyIntactItem(param);
    }

     /*
      * 1. 메소드명: checkCampaignsUsingIntect
      * 2. 클래스명: LoyIntactService
      * 3. 작성자명: jh.kim 
      * 4. 작성일자: 2017. 6. 23.
      */
    /**
     * <PRE>
     * 1. 설명
     *		인터렉션 유형을 사용하고 있는 캠페인 체크 
     * 2. 사용법
     *		
     * </PRE>
     *   @param param
     *   @return	
     */
    public SystemIntactCheckResDto checkCampaignsUsingIntect(SystemIntactCheckReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        return systemIntactMapper.checkCampaignsUsingIntect(param);
    }

     /*
      * 1. 메소드명: checkDuplicationIntactType
      * 2. 클래스명: LoyIntactService
      * 3. 작성자명: jh.kim 
      * 4. 작성일자: 2017. 6. 23.
      */
    /**
     * <PRE>
     * 1. 설명
     *		인터렉션 유형 중복 체크 
     * 2. 사용법
     *		
     * </PRE>
     *   @param param
     *   @return	
     */
    public SystemIntactCheckResDto checkDuplicationIntactType(SystemIntactCheckReqDto param) {
        LogUtil.param(this.getClass(), param);
        
        return systemIntactMapper.checkDuplicationIntactType(param);
    }

     /*
      * 1. 메소드명: addIntactItem
      * 2. 클래스명: LoyIntactService
      * 3. 작성자명: jh.kim 
      * 4. 작성일자: 2017. 6. 23.
      */
    /**
     * <PRE>
     * 1. 설명
     *		인터렉션 유형 등록
     * 2. 사용법
     *		
     * </PRE>
     *   @param param
     *   @return	
     */
    public StatusResDto addIntactItem(SystemIntactDetailReqDto param) {
        LogUtil.param(this.getClass(), param);
        StatusResDto rtnValue = new StatusResDto();
        
        String rid = CommonUtil.newRid();
        
        param.setRid(rid);
        
//        if (systemIntactMapper.insertIntactItem(param) > 0) {
//            statusResDto.setSuccess(true);
//            statusResDto.setMessage(rid);
//        }
        
        systemIntactMapper.insertIntactItem(param);
        rtnValue.setSuccess(true);
        rtnValue.setMessage(rid);
        return rtnValue;
    }

     /*
      * 1. 메소드명: editIntactItem
      * 2. 클래스명: LoyIntactService
      * 3. 작성자명: jh.kim 
      * 4. 작성일자: 2017. 6. 23.
      */
    /**
     * <PRE>
     * 1. 설명
     *		인터렉션 유형 수정
     * 2. 사용법
     *		
     * </PRE>
     *   @param param
     *   @return	
     */
    public StatusResDto editIntactItem(SystemIntactDetailReqDto param) {
        LogUtil.param(this.getClass(), param);
        StatusResDto rtnValue = new StatusResDto();
        systemIntactMapper.updateIntactItem(param);
        rtnValue.setSuccess(true);
        return rtnValue;
    }

     /*
      * 1. 메소드명: removeIntactItem
      * 2. 클래스명: LoyIntactService
      * 3. 작성자명: jh.kim 
      * 4. 작성일자: 2017. 6. 23.
      */
    /**
     * <PRE>
     * 1. 설명
     *		인터렉션 유형 삭제
     * 2. 사용법
     *		
     * </PRE>
     *   @param param
     *   @return	
     */
    public StatusResDto removeIntactItem(SystemIntactDetailReqDto param) {
        LogUtil.param(this.getClass(), param);
        StatusResDto rtnValue = new StatusResDto();
        systemIntactMapper.deleteIntactItem(param);
        rtnValue.setSuccess(true);
        return rtnValue;
    }
}
