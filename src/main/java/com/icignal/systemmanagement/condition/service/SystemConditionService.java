/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemConditionService.java
 * 2. Package	: com.icignal.systemmanagement.condition.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 5. 오후 4:04:29
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 5.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.condition.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.commcode.service.SystemCommCodeService;
import com.icignal.systemmanagement.condition.dto.request.SystemGetBaseTableListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetConditionDetailReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetConditionListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetDropDownListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetMenuListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetSrcColumListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemModifyConditionReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemRemoveConditionReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemSetConditionReqDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetBaseTableListResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetConditionDetailResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetConditionResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetDropDownListResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetSrcColumListResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemgetMenuListResDto;
import com.icignal.systemmanagement.condition.mapper.SystemConditionMapper;


/*
 * 1. 클래스명	: SystemConditionService
 * 2. 파일명	: SystemConditionService.java
 * 3. 패키지명	: com.icignal.systemmanagement.condition.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 5.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class SystemConditionService {
	
	@Autowired
	public SystemConditionMapper systemConditionMapper;
	/**
	 * @name : getMenuList
	 * @date : 2015. 9. 23.
	 * @author : 장용
	 * @table : MENU (메뉴 목록 리스트) 
	 * @return : GridPagingResDto<>
	 * @description : 조건을 등록할 화면 목록을 조회
	 */
	public GridPagingResDto<SystemgetMenuListResDto> getMenuList(SystemGetMenuListReqDto mlr){
		LogUtil.param(this.getClass(), mlr);
		mlr.setSVCAlias("p");
		
		return new GridPagingResHelper<SystemgetMenuListResDto>().newGridPagingResDto(
				mlr.init(CommonUtil.getInstance().getDBType()),
				systemConditionMapper.selectMenuList(mlr), AnnotationType.CommCode
				);
	}
	
	/**
	 * @name : getConditionList
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : MKT_CMN_SRCH (조회조건 리스트) 
	 * @return : GridPagingResDto<>
	 * @description : 화면별 조회 조건 리스트를 조회
	 */
	public GridPagingResDto<SystemGetConditionResDto> getConditionList(SystemGetConditionListReqDto clr){
		LogUtil.param(this.getClass(), clr);
		clr.setSVCAlias("mcs");
		GridPagingResDto<SystemGetConditionResDto> resDto = new GridPagingResDto<SystemGetConditionResDto>();
		resDto = new GridPagingResHelper<SystemGetConditionResDto>().newGridPagingResDto(
				clr.init(CommonUtil.getInstance().getDBType()),
				systemConditionMapper.selectConditionList(clr), AnnotationType.ALL
				);
		return resDto;
	}
	
	/**
	 * @name : getDropDownList
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : COMMCODE (조회조건 리스트) 
	 * @return : GridPagingResDto<>
	 * @description : 드롭다운 리스트 그룹 목록 조회
	 */
	public GridPagingResDto<SystemGetDropDownListResDto> getDropDownList(SystemGetDropDownListReqDto ddl){
		LogUtil.param(this.getClass(), ddl);
		ddl.setSVCAlias("");
		
		return new GridPagingResHelper<SystemGetDropDownListResDto>().newGridPagingResDto(
				ddl.init(CommonUtil.getInstance().getDBType()),
				systemConditionMapper.selectDropDownList(ddl));
	}
	
	/**
	 * @name : getBaseTableList
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : TABLELIST (테이블 리스트) 
	 * @return : GridPagingResDto<>
	 * @description : 드롭다운 리스트 그룹 목록 조회
	 */
	public GridPagingResDto<SystemGetBaseTableListResDto> getBaseTableList(SystemGetBaseTableListReqDto btl){
		LogUtil.param(this.getClass(), btl);
		btl.setSVCAlias("");
		
		return new GridPagingResHelper<SystemGetBaseTableListResDto>().newGridPagingResDto(
				btl.init(CommonUtil.getInstance().getDBType()),
				systemConditionMapper.selectBaseTableList(btl));
	}
	
	/**
	 * @name : getSrcColumList
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : TABLEL_COLUM_LIST(테이블 컬럼 리스트) 
	 * @return : GridPagingResDto<>
	 * @description : 테이블에 해당하는 컬럼 리스트 조회
	 */
	public GridPagingResDto<SystemGetSrcColumListResDto> getSrcColumList(SystemGetSrcColumListReqDto scl){
		LogUtil.param(this.getClass(), scl);
		scl.setSVCAlias("");
		
		return new GridPagingResHelper<SystemGetSrcColumListResDto>().newGridPagingResDto(
				scl.init(CommonUtil.getInstance().getDBType()),
				systemConditionMapper.selectSrcColumList(scl));
	}
	
	/**
	 * @name : setCondition
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : MKT_CMN_SRCH (조건 테이블)
	 * @return : StatusResDto
	 * @description : 조건 저장
	 */
	public StatusResDto setCondition(SystemSetConditionReqDto scr){
		LogUtil.param(this.getClass(), scr);
		
			//템플릿 목록을 리스트로 리턴
				StatusResDto rtnValue = new StatusResDto();
				rtnValue.setSuccess(false);
				
				scr.setId(StringUtil.genID());
				systemConditionMapper.insertCondition(scr);
				String id = scr.getId();
				rtnValue.setMessage(id);
				rtnValue.setSuccess(true);
				return rtnValue;
	}
	
	/**
	 * @name : getConditionDetail
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : MKT_CMN_SRCH (조건 테이블)
	 * @return : MKTgetConditionDetailResponseDTO
	 * @description : 조건 상세 조회
	 */
	public SystemGetConditionDetailResDto getConditionDetail(SystemGetConditionDetailReqDto cdr){
		LogUtil.param(this.getClass(), cdr);
		
		//템플릿 목록을 리스트로 리턴	
			cdr.setSVCAlias("mcs");
			SystemGetConditionDetailResDto rtnValue = systemConditionMapper.selectConditionDetail(cdr);
			rtnValue = new AnnotationHelper<SystemGetConditionDetailResDto>(AnnotationType.Nothing, rtnValue).getItem();
			rtnValue.setSuccess(true);
			return rtnValue;
	}
	
	/**
	 * @name : modifyCondition
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : MKT_CMN_SRCH (조건 테이블)
	 * @return : StatusResDto
	 * @description : 조건 상세 조회
	 */
	public StatusResDto modifyCondition(SystemModifyConditionReqDto mcr){
		LogUtil.param(this.getClass(), mcr);
		
		
		//템플릿 목록을 리스트로 리턴
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
				
		mcr.setSVCAlias("");
		systemConditionMapper.updateCondition(mcr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	 * @name : removeCondition
	 * @date : 2015. 10. 13.
	 * @author : 장용
	 * @table : MKT_CMN_SRCH (조건 테이블)
	 * @return : StatusResDto
	 * @description : 조건 삭제
	 */
	public StatusResDto removeCondition(SystemRemoveConditionReqDto rcr){
		LogUtil.param(this.getClass(), rcr);
		
		//템플릿 목록을 리스트로 리턴
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
				
		rcr.setSVCAlias("");
		systemConditionMapper.deleteCondition(rcr);

		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	 * @name : groupDetailList
	 * @date : 2015. 9. 22.
	 * @author : 장용
	 * @description : 그룹코드 상세 조회
	 */
	public GridPagingResDto<MKTCommonCodeResponseDTO> groupDetailList(MKTCommonCodeRequestDTO slir){
		LogUtil.param(this.getClass(), slir);
		
		slir.setSVCAlias("");
		return new GridPagingResHelper<MKTCommonCodeResponseDTO>().newGridPagingResDto(
				slir.init(CommonUtil.getInstance().getDBType()),
				systemConditionMapper.selectGroupDetailList(slir));
	}

	 /*
	  * 1. 메소드명: getDropDownListColumList
	  * 2. 클래스명: SystemConditionService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scl
	 *   @return	
	 */
	
	public GridPagingResDto<SystemGetSrcColumListResDto> getDropDownListColumList(SystemGetSrcColumListReqDto scl) {
		LogUtil.param(this.getClass(), scl);
		scl.setSVCAlias("");
		
		return new GridPagingResHelper<SystemGetSrcColumListResDto>().newGridPagingResDto(
				scl.init(CommonUtil.getInstance().getDBType()),
				systemConditionMapper.selectDropDownListColumList(scl));
	}

	 /*
	  * 1. 메소드명: addTableList
	  * 2. 클래스명: SystemConditionService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scl
	 *   @return	
	 */
	
	public StatusResDto addTableList(SystemGetSrcColumListReqDto reqDto) {
		LogUtil.param(SystemCommCodeService.class, reqDto);
        StatusResDto rtnValue = new StatusResDto();
        
        systemConditionMapper.callTableList(reqDto);
        rtnValue.setSuccess(true);

        return rtnValue;
	}
}
