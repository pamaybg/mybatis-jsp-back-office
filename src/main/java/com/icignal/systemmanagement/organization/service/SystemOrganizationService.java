package com.icignal.systemmanagement.organization.service;

import java.util.List;

import com.icignal.common.util.ObjectUtil;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;

import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.organization.dto.request.SystemModifyOrganizationReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemOrganizationDetailReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemOrganizationInfoListReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemOrganizationListReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemOrganziationNodeListReqDto;
import com.icignal.systemmanagement.organization.dto.request.SystemSetOrganizationReqDto;
import com.icignal.systemmanagement.organization.dto.response.SystemOrganizationDetailResDto;
import com.icignal.systemmanagement.organization.dto.response.SystemOrganizationInfoListResDto;
import com.icignal.systemmanagement.organization.dto.response.SystemOrganizationListResDto;
import com.icignal.systemmanagement.organization.dto.response.SystemOrganizationLvlResDto;
import com.icignal.systemmanagement.organization.dto.response.SystemOrganizationNodeListResDto;
import com.icignal.systemmanagement.organization.mapper.SystemOrganizationMapper;


@Service("SytemOrganizationService")
public class SystemOrganizationService {

	@Autowired
	private SystemOrganizationMapper systemOrganizationMapper;
	
	/**
	 * @name : getOrganizationList
	 * @date : 2017. 2. 20.
	 * @author : jun.lee
	 * @return : GridPagingResDto
	 * @description : 조직관리 리스트 조회 
	 */
	public GridPagingResDto<SystemOrganizationListResDto> getOrganizationList(SystemOrganizationListReqDto dto){
		LogUtil.param(SystemOrganizationService.class, dto);		  
		dto.setSVCAlias("cd1");
		
		return new GridPagingResHelper<SystemOrganizationListResDto>().newGridPagingResDto(
				dto.init(CommonUtil.getInstance().getDBType()), systemOrganizationMapper.getOrganizationList(dto), AnnotationType.CommCode);
	}
	
	/**
	 * @name : getOrganizationDetailList
	 * @date : 2017. 2. 20.
	 * @author : jun.lee
	 * @return : SystemOrganizationDetailResDto
	 * @description : 조직관리 상세 조회 
	 */
	public SystemOrganizationDetailResDto getOrganizationDetail(SystemOrganizationDetailReqDto dto){
		LogUtil.param(SystemOrganizationService.class, dto);		     		
		return systemOrganizationMapper.getOrganizationDetail(dto);
	}
	
	/**
	 * @name : insertOrganization
	 * @date : 2017. 2. 21.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 조직관리 추가 
	 */
	public StatusResDto insertOrganization(SystemSetOrganizationReqDto dto) {
		LogUtil.param(SystemOrganizationService.class, dto);
		StatusResDto rtnValue = new StatusResDto();
		String rid = CommonUtil.newRid();
		dto.setRid(rid);
		//조직레벨값 갱신 시작
		String ridParDiv = dto.getRidParDiv();
		if(ObjectUtil.isNotEmpty(ridParDiv)){
			dto.setDivLvl((String) systemOrganizationMapper.getDivLvlByRidParDiv(ridParDiv));

			SystemOrganizationLvlResDto dto2 = (SystemOrganizationLvlResDto) systemOrganizationMapper.getRidLvlByRidParDiv(ridParDiv);
			dto.setRidLvl1(dto2.getRidLvl1());
			dto.setRidLvl2(dto2.getRidLvl2());
			dto.setRidLvl3(dto2.getRidLvl3());
			dto.setRidLvl4(dto2.getRidLvl4());
			dto.setRidLvl5(dto2.getRidLvl5());
			dto.setRidLvl6(dto2.getRidLvl6());
			dto.setRidLvl7(dto2.getRidLvl7());
			dto.setRidLvl8(dto2.getRidLvl8());
			dto.setRidLvl9(dto2.getRidLvl9());
			dto.setRidLvl10(dto2.getRidLvl10());
			dto.setRidLvl11(dto2.getRidLvl11());



			switch(dto.getDivLvl()){
				case "1":
					dto.setRidLvl1(dto.getRid());
					break;
				case "2":
					dto.setRidLvl2(dto.getRid());
					break;
				case "3":
					dto.setRidLvl3(dto.getRid());
					break;
				case "4":
					dto.setRidLvl4(dto.getRid());
					break;
				case "5":
					dto.setRidLvl5(dto.getRid());
					break;
				case "6":
					dto.setRidLvl6(dto.getRid());
					break;
				case "7":
					dto.setRidLvl7(dto.getRid());
					break;
				case "8":
					dto.setRidLvl8(dto.getRid());
					break;
				case "9":
					dto.setRidLvl9(dto.getRid());
					break;
				case "10":
					dto.setRidLvl10(dto.getRid());
					break;
				case "11":
					dto.setRidLvl11(dto.getRid());
					break;
				default :
					throw new IllegalArgumentException();
			}//조직레벨값 갱신 끝
		}
				
		systemOrganizationMapper.insertOrganization(dto);
		rtnValue.setSuccess(true);
		rtnValue.setMessage(rid);

		return rtnValue;
	}

	/**
	 * @name : updateOrganization
	 * @date : 2017. 2. 21.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 조직관리 수정 
	 */
	public StatusResDto updateOrganization(SystemModifyOrganizationReqDto dto) {
		LogUtil.param(SystemOrganizationService.class, dto);
		StatusResDto rtnValue = new StatusResDto();
		//조직레벨값 갱신 시작
		String ridParDiv = dto.getRidParDiv();
		if(ObjectUtils.isNotEmpty(ridParDiv)){
			dto.setDivLvl((String) systemOrganizationMapper.getDivLvlByRidParDiv(ridParDiv));

			SystemOrganizationLvlResDto dto2 = (SystemOrganizationLvlResDto) systemOrganizationMapper.getRidLvlByRidParDiv(ridParDiv);
			dto.setRidLvl1(dto2.getRidLvl1());
			dto.setRidLvl2(dto2.getRidLvl2());
			dto.setRidLvl3(dto2.getRidLvl3());
			dto.setRidLvl4(dto2.getRidLvl4());
			dto.setRidLvl5(dto2.getRidLvl5());
			dto.setRidLvl6(dto2.getRidLvl6());
			dto.setRidLvl7(dto2.getRidLvl7());
			dto.setRidLvl8(dto2.getRidLvl8());
			dto.setRidLvl9(dto2.getRidLvl9());
			dto.setRidLvl10(dto2.getRidLvl10());
			dto.setRidLvl11(dto2.getRidLvl11());

			switch(dto.getDivLvl()){
				case "1":
					dto.setRidLvl1(dto.getRid());
					break;
				case "2":
					dto.setRidLvl2(dto.getRid());
					break;
				case "3":
					dto.setRidLvl3(dto.getRid());
					break;
				case "4":
					dto.setRidLvl4(dto.getRid());
					break;
				case "5":
					dto.setRidLvl5(dto.getRid());
					break;
				case "6":
					dto.setRidLvl6(dto.getRid());
					break;
				case "7":
					dto.setRidLvl7(dto.getRid());
					break;
				case "8":
					dto.setRidLvl8(dto.getRid());
					break;
				case "9":
					dto.setRidLvl9(dto.getRid());
					break;
				case "10":
					dto.setRidLvl10(dto.getRid());
					break;
				case "11":
					dto.setRidLvl11(dto.getRid());
					break;
				default :
					throw new IllegalArgumentException();
			}

		}//조직레벨값 갱신 끝
		systemOrganizationMapper.updateOrganization(dto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @name : getOrganizationInfoList
	 * @date : 2017. 2. 22.
	 * @author : jun.lee
	 * @return : GridPagingResDto
	 * @description : 조직정보 리스트 조회 
	 */
	public GridPagingResDto<SystemOrganizationInfoListResDto> getOrganizationInfoList(SystemOrganizationInfoListReqDto dto) {
		LogUtil.param(SystemOrganizationService.class, dto);
		dto.setSVCAlias("cd1");
		return new GridPagingResHelper<SystemOrganizationInfoListResDto>().newGridPagingResDto(
				dto.init(CommonUtil.getInstance().getDBType()), systemOrganizationMapper.getOrganizationInfoList(dto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getNodeList
	  * 2. 클래스명: SystemOrganizationService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param nlr
	 *   @return	
	 */
	public SystemOrganizationNodeListResDto getNodeList(SystemOrganziationNodeListReqDto nlr) {
		LogUtil.param(SystemOrganizationService.class, nlr);
		List<SystemOrganizationNodeListResDto> nodeList = systemOrganizationMapper.selectNodeList(nlr);
		nlr.setSVCAlias("");
		SystemOrganizationNodeListResDto rstValue = new SystemOrganizationNodeListResDto();
		rstValue.setNodeList(nodeList);

		return rstValue;
	}
}
