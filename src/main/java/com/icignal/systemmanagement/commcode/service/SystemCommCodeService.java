package com.icignal.systemmanagement.commcode.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.common.base.dto.response.CommCodeResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCondListRequestDTO;
import com.icignal.systemmanagement.commcode.dto.request.SystemCommCodeExGridReqDto;
import com.icignal.systemmanagement.commcode.dto.request.SystemCommCodeExReqDto;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCondListResponseDTO;
import com.icignal.systemmanagement.commcode.dto.response.SystemCommCodeExCountryItemsResDto;
import com.icignal.systemmanagement.commcode.dto.response.SystemCommCodeExGridResDto;
import com.icignal.systemmanagement.commcode.mapper.SystemCommCodeMapper;


/*
 * 1. 클래스명	: SystemCommService
 * 2. 파일명	: SystemCommService.java
 * 3. 패키지명	: com.icignal.systemmanagement.commcode.service
 * 4. 작성자명	:  kj.kang
 * 5. 작성일자	: 2016. 8. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템운영 - CommonCode 관리 Service
 * </PRE>
 */ 
@Service("SystemCommService")
public class SystemCommCodeService {

	@Autowired 
	private SystemCommCodeMapper  systemCommCodeMapper;
	
	@Autowired
	private CommonService CommonService;
	
	
	/**
	 * @name : getCommCodeList
	 * @date : 2015. 9. 22.
	 * @author : 류동균
	 * @description : 공통코드 목록 조회
	 */
	public GridPagingResDto<MKTCommonCodeResponseDTO> getCommCodeList(MKTCommonCodeRequestDTO reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);
		reqDto.setSVCAlias("");
		String pagingFlag = reqDto.getPagingFlag();
		if (ObjectUtil.isNotEmpty(pagingFlag) && "1".equals(pagingFlag)) {
		return new GridPagingResHelper<MKTCommonCodeResponseDTO>().newGridPagingResDto(
					reqDto.init(CommonUtil.getInstance().getDBType()),  systemCommCodeMapper.getCommCodeGridList(reqDto));
		}
		
		return new GridPagingResHelper<MKTCommonCodeResponseDTO>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),  systemCommCodeMapper.getCommCodeList(reqDto));
	}
	
	 /*
	  * 1. 메소드명: getParIdNullCodeList
	  * 2. 클래스명: SystemCommCodeService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		PAR_CODE_ID  = NULL
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<MKTCommonCodeResponseDTO> getParIdNullCodeList(MKTCommonCodeRequestDTO reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);
		reqDto.setSVCAlias("");
		String pagingFlag = reqDto.getPagingFlag();
		if (ObjectUtil.isNotEmpty(pagingFlag) && "1".equals(pagingFlag)) {
			return new GridPagingResHelper<MKTCommonCodeResponseDTO>().newGridPagingResDto(
					reqDto.init(CommonUtil.getInstance().getDBType()),  systemCommCodeMapper.getParIdNullCodeList(reqDto));
		}
		
		return new GridPagingResHelper<MKTCommonCodeResponseDTO>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),  systemCommCodeMapper.getParIdNullCodeList(reqDto));
	}
	
	/**
	 * @name : getCommCondLIst
	 * @date : 2015. 9. 21.
	 * @author : 장용
	 * @table : mkt_cmn_srch (조건 목록 테이블)
	 * @return : GridPagingResDto
	 * @description : 공통 조건 조회
	 */
	public GridPagingResDto<MKTCommonCondListResponseDTO> getCommCondLIst(MKTCommonCondListRequestDTO reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);
		reqDto.setSVCAlias("mcs");
		return new GridPagingResHelper<MKTCommonCondListResponseDTO>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),  systemCommCodeMapper.selectCommCondList(reqDto));
	
	}
	
	
	
	 /*
	  * 1. 메소드명: getCommCodeExGroupList
	  * 2. 클래스명: SystemCommService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 8. 30.
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
	public GridPagingResDto<SystemCommCodeExGridResDto> getCommCodeExGroupList(SystemCommCodeExGridReqDto reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);
		reqDto.setSVCAlias("");
		return new GridPagingResHelper<SystemCommCodeExGridResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemCommCodeMapper.selectCommCodeExGroupList(reqDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getCommCodeExSubList
	  * 2. 클래스명: SystemCommService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 8. 30.
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
	public GridPagingResDto<SystemCommCodeExGridResDto> getCommCodeExSubList(SystemCommCodeExGridReqDto reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);
		reqDto.setSVCAlias("A");
		return  new GridPagingResHelper<SystemCommCodeExGridResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemCommCodeMapper.selectCommCodeExSubList(reqDto), AnnotationType.CommCode);
	}
	
	 /*
	  * 1. 메소드명: getCommCodeExParCodeList
	  * 2. 클래스명: SystemCommService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 8. 30.
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
	public GridPagingResDto<SystemCommCodeExGridResDto> getCommCodeExParCodeList(SystemCommCodeExGridReqDto reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);
		reqDto.setSVCAlias("");
		return new GridPagingResHelper<SystemCommCodeExGridResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemCommCodeMapper.selectCommCodeExParCodeList(reqDto));
	}

	 /*
	  * 1. 메소드명: addCommCodeExGroupCode
	  * 2. 클래스명: SystemCommService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 8. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공통 토드 그룹코드 신규
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto addCommCodeExGroupCode(SystemCommCodeExReqDto reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto();
		CommCodeResDto commCode = new CommCodeResDto();
		reqDto.setSVCAlias("");
		reqDto.setId(CommonUtil.newRid());
		
		Integer cntGroupCode =  systemCommCodeMapper.selectCommCodeExGroupCheck(reqDto);
		if(cntGroupCode > 0) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("DUPLICATE_GROUP");
		} else {
			try {
				//this.startTransaction();
				systemCommCodeMapper.insertCommCodeExNewCode(reqDto);
				rtnValue.setSuccess(true);
				
				//공통코드 캐시올리기 추가
				commCode.setCodeName(reqDto.getCodeName());
				commCode.setGroupCode(reqDto.getGroupCode());
				commCode.setJobType(CommCodeResDto.TYPE.CODENAME_ADD);
				commCode.setLang(reqDto.getLang());
				commCode.setMarkName(reqDto.getMarkName());
				CommonService.editCommCodeList(commCode);
				//this.commitTransaction();
			} catch(IllegalArgumentException e) {
				rtnValue.setSuccess(false);
			}
		}
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: addCommCodeExCodeName
	  * 2. 클래스명: SystemCommService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 8. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공통 코드 추가
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto addCommCodeExCodeName(SystemCommCodeExReqDto reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto();
		CommCodeResDto commCode  = new CommCodeResDto();
		reqDto.setSVCAlias("");
		reqDto.setId(CommonUtil.newRid());
		
		Integer cntCodeName =  systemCommCodeMapper.selectCommCodeExCodeNameCheck(reqDto);
		if(cntCodeName > 0) {
			Integer cntCodeNameLang =  systemCommCodeMapper.selectCommCodeExCodeNameCheckWithLang(reqDto);
			if(cntCodeNameLang > 0) {
				rtnValue.setSuccess(false);
				rtnValue.setMessage("DUPLICATE_CODE");
			} else {
				try {
					systemCommCodeMapper.insertCommCodeExCodeExtend(reqDto);
					rtnValue.setSuccess(true);
					
					//공통코드 캐시올리기 추가
					commCode.setCodeName(reqDto.getCodeName());
					commCode.setGroupCode(reqDto.getGroupCode());
					commCode.setJobType(CommCodeResDto.TYPE.CODENAME_ADD);
					commCode.setLang(reqDto.getLang());
					commCode.setMarkName(reqDto.getMarkName());
					CommonService.editCommCodeList(commCode);
				} catch(IllegalArgumentException e) {
					rtnValue.setSuccess(false);
				}
			}
		} else {
			try {
				systemCommCodeMapper.insertCommCodeExNewCode(reqDto);
				rtnValue.setSuccess(true);
				
				//공통코드 캐시올리기 추가
				commCode.setCodeName(reqDto.getCodeName());
				commCode.setGroupCode(reqDto.getGroupCode());
				commCode.setJobType(CommCodeResDto.TYPE.CODENAME_ADD);
				commCode.setLang(reqDto.getLang());
				commCode.setMarkName(reqDto.getMarkName());
				CommonService.editCommCodeList(commCode);
			} catch(IllegalArgumentException e) {
				rtnValue.setSuccess(false);
			} 
		}
		
        SystemCommCodeExGridReqDto param = new SystemCommCodeExGridReqDto();
        param.setSelectLang(reqDto.getSelectLang());
        param.setGroupCode(reqDto.getGroupCode());
		
        reqDto.setSVCAlias("A");
        
		return rtnValue;
	}

	
	 /*
	  * 1. 메소드명: editCommCodeExGroupName
	  * 2. 클래스명: SystemCommService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 8. 30.
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
	public StatusResDto editCommCodeExGroupName(SystemCommCodeExReqDto reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);		
		StatusResDto rtnValue = new StatusResDto();
		reqDto.setSVCAlias("");

        SystemCommCodeExGridReqDto param = new SystemCommCodeExGridReqDto();
        param.setGroupCode(reqDto.getGroupCode());
        param.setSelectLang(reqDto.getSelectLang());
        
        systemCommCodeMapper.updateCommCodeExGroupName(reqDto);
        rtnValue.setSuccess(true);
        
        return rtnValue;
	}

	 /*
	  * 1. 메소드명: editCommCodeExCodeProperty
	  * 2. 클래스명: SystemCommService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 8. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		그룹코드 상세 - 코드 네임 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto editCommCodeExCodeProperty(SystemCommCodeExReqDto reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto();
		CommCodeResDto commCode = new CommCodeResDto();
		reqDto.setSVCAlias("");

        SystemCommCodeExGridReqDto param = new SystemCommCodeExGridReqDto();
        param.setId(reqDto.getId());
        param.setSelectLang(reqDto.getSelectLang());
        
        systemCommCodeMapper.updateCommCodeExCodeProperty(reqDto);
        rtnValue.setSuccess(true);
        
        //공통코드 캐시올리기 수정
		commCode.setCodeName(reqDto.getCodeName());
		commCode.setGroupCode(reqDto.getGroupCode());
		commCode.setJobType(CommCodeResDto.TYPE.CODENAME_EDIT);
		commCode.setLang(reqDto.getLang());
		commCode.setMarkName(reqDto.getMarkName());
		CommonService.editCommCodeList(commCode);
		
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editCommCodeExCodeAttribProperty
	  * 2. 클래스명: SystemCommService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 8. 30.
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
	public StatusResDto editCommCodeExCodeAttribProperty(SystemCommCodeExReqDto reqDto) {
        LogUtil.param(SystemCommCodeService.class, reqDto);
        StatusResDto rtnValue = new StatusResDto();
        reqDto.setSVCAlias("");

        SystemCommCodeExGridReqDto param = new SystemCommCodeExGridReqDto();
        param.setId(reqDto.getId());
        param.setSelectLang(reqDto.getSelectLang());
        
        systemCommCodeMapper.updateCommCodeExCodeAttribProperty(reqDto);
        rtnValue.setSuccess(true);

        return rtnValue;
    }

	 /*
	  * 1. 메소드명: editCommCodeExGroupCodeDel
	  * 2. 클래스명: SystemCommService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 8. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공통코드 -  그룹코드 삭제 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto editCommCodeExGroupCodeDel(SystemCommCodeExReqDto reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto();
		CommCodeResDto commCode = new CommCodeResDto();
		reqDto.setSVCAlias("");
		
		SystemCommCodeExGridReqDto param = new SystemCommCodeExGridReqDto();
		param.setGroupCode(reqDto.getGroupCode());
		
        systemCommCodeMapper.updateCommCodeExGroupCodeDel(reqDto);
        rtnValue.setSuccess(true);
        
        //공통코드 - 그룹코드 삭제시 전체 코드네임 캐시에서 내리기
        //CommonService.reloadingCommComcodeList();
		commCode.setCodeName(reqDto.getCodeName());
		commCode.setGroupCode(reqDto.getGroupCode());
		commCode.setJobType(CommCodeResDto.TYPE.GROUPCODE_DEL);
		commCode.setLang(reqDto.getLang());
		commCode.setMarkName(reqDto.getMarkName());
		CommonService.editCommCodeList(commCode);
        
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editCommCodeExCodeNameDel
	  * 2. 클래스명: SystemCommService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 8. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공통코드 Code_Name 단일 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto editCommCodeExCodeNameDel(SystemCommCodeExReqDto reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto();
		CommCodeResDto commCode = new CommCodeResDto();
		reqDto.setSVCAlias("");
		
        SystemCommCodeExGridReqDto param = new SystemCommCodeExGridReqDto();
        param.setGroupCode(reqDto.getGroupCode());
        param.setCodeName(reqDto.getCodeName());
        
        systemCommCodeMapper.updateCommCodeExCodeNameDel(reqDto);
        
        //승인서버 데이터 동기화
//        for ( SystemCommCodeExGridResDto resDto : list ) {
//            iMKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.COMM_CODE, resDto.getId(), DATA_SYNC_TYPE.U);
//        }
//        CacheCommon cache = new CacheCommonImpl();
//        String key = CommonUtil.CacheKeyProduce(reqDto.getGroupCode(),reqDto.getCodeName(),reqDto.getLang());
//        cache.getAllValue(cachemanager);
//        
//        cache.deleteValue(key);
//        try {
//			Thread.sleep(1000); //1초 대기
//			cache.getAllValue(cachemanager);
//		} catch (InterruptedException e) {
//			e.printStackTrace();
//		}
            
		rtnValue.setSuccess(true);
		
        //공통코드 캐시 삭제
		commCode.setCodeName(reqDto.getCodeName());
		commCode.setGroupCode(reqDto.getGroupCode());
		commCode.setJobType(CommCodeResDto.TYPE.CODENAME_DEL);
		commCode.setLang(reqDto.getLang());
		commCode.setMarkName(reqDto.getMarkName());
		CommonService.editCommCodeList(commCode);
		
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getCommCodeExCountryCode
	  * 2. 클래스명: SystemCommService
	  * 3. 작성자명: kj.kang  
	  * 4. 작성일자: 2016. 8. 30.
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
	public SystemCommCodeExCountryItemsResDto getCommCodeExCountryCode(MKTBaseReqDto reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);
		SystemCommCodeExCountryItemsResDto rtnValue = new SystemCommCodeExCountryItemsResDto();
		reqDto.setSVCAlias("");
		rtnValue.setItems(systemCommCodeMapper.selectCommCodeExCountryCode(reqDto));
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: reApplyServerCommCode
	  * 2. 클래스명: SystemCommCodeService
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공통코드 서버 재적용
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	public StatusResDto reApplyServerCommCode() {
		StatusResDto rtnValue = new StatusResDto();
		CommonService.reloadingCommComcodeList();
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: getCommCodeDetail
	  * 2. 클래스명: SystemCommCodeService
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 3. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공통코드 서버 재적용
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	public MKTCommonCodeResponseDTO getCommCodeDetail(MKTCommonCodeRequestDTO reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);
		
		return systemCommCodeMapper.selectCommCodeDetail(reqDto);
	}

}
