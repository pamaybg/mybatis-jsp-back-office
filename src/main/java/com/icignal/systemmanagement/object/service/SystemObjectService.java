package com.icignal.systemmanagement.object.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;

import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.object.dto.request.SystemDeleteObjectListReqDto;
import com.icignal.systemmanagement.object.dto.request.SystemGetObjectDetailReqDto;
import com.icignal.systemmanagement.object.dto.request.SystemGetUIObjectDetailReqDto;
import com.icignal.systemmanagement.object.dto.request.SystemInsertObjectDetailReqDto;
import com.icignal.systemmanagement.object.dto.request.SystemUIObjectListReqDto;
import com.icignal.systemmanagement.object.dto.response.SystemGetObjectDetailResDTO;
import com.icignal.systemmanagement.object.dto.response.SystemGetUIObjectDetailResDto;
import com.icignal.systemmanagement.object.dto.response.SystemUIObjectListResDto;
import com.icignal.systemmanagement.object.mapper.SystemObjectMapper;
import com.icignal.systemmanagement.program.dto.request.SystemDeleteUIObjectListReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemInsertUIObjectDetailReqDto;
import com.icignal.systemmanagement.program.dto.request.SystemObjectListReqDto;
import com.icignal.systemmanagement.program.dto.response.SystemObjectListResDto;

@Service
public class SystemObjectService {
	
	@Autowired SystemObjectMapper systemObjectMapper;

	/**
	 * @name : getObjectList
	 * @date : 2017. 3. 13.
	 * @author : jun.lee
	 * @return : GridPagingResDto
	 * @description : 오브젝트 리스트 조회
	 */

	public GridPagingResDto<SystemObjectListResDto> getObjectList(SystemObjectListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("o");
	
		return new GridPagingResHelper<SystemObjectListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemObjectMapper.getObjectList(reqDto));
	}

	/**
	 * @name : insertObjectDetail
	 * @date : 2017. 3. 13.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 오브젝트 추가
	 */
	
	public StatusResDto insertObjectDetail(SystemInsertObjectDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		/* reqDto.setSVCAlias("o"); */
		Integer objCd = (Integer)systemObjectMapper.isObjCdExist(reqDto);
		 String rid = CommonUtil.newRid();
		 
		if(objCd <= 0){
			rtnValue.setMessage("1");
			reqDto.setId(rid);
			systemObjectMapper.insertObjectDetail(reqDto);
			rtnValue.setSuccess(true);
		}else{
			rtnValue.setSuccess(true);
		}
		
		
		/*
		 * if(rtnValue.getSuccess()==true) {
		 * this.insert("systemObjectMapper.insertObjectInitAuth", reqDto, false); }
		 */
		return rtnValue;
	}

	/**
	 * @name : getObjectDetail
	 * @date : 2017. 3. 13.
	 * @author : jun.lee
	 * @return : MKTGetObjectDetailResponseDTO
	 * @description : 오브젝트 상세 조회
	 */
	
	public SystemGetObjectDetailResDTO getObjectDetail(SystemGetObjectDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		SystemGetObjectDetailResDTO rtnValue = new SystemGetObjectDetailResDTO();
		
		reqDto.setSVCAlias("o");
		rtnValue = systemObjectMapper.getObjectDetail(reqDto);
		
		return rtnValue;
	}

	/**
	 * @name : updateObjectDetail
	 * @date : 2017. 3. 13.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 오브젝트 수정
	 */
	
	public StatusResDto updateObjectDetail(SystemInsertObjectDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		reqDto.setSVCAlias("o");
		

		Integer objCd = (Integer)systemObjectMapper.isObjCdExist(reqDto);

		if(objCd <= 0){
			rtnValue.setMessage("1");
			systemObjectMapper.updateObjectDetail(reqDto);
			rtnValue.setSuccess(true);
		}else{
			rtnValue.setSuccess(true);
		}
		
		return rtnValue;
	}

	/**
	 * @name : deleteObjectList
	 * @date : 2017. 3. 13.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 오브젝트 리스트 삭제
	 */
	
	public StatusResDto deleteObjectList(SystemDeleteObjectListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		systemObjectMapper.deleteObjectList(reqDto);
		systemObjectMapper.deleteUIObjectListByObjectList(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	/**
	 * @name : getUIObjectList
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : GridPagingResDto
	 * @description : UI오브젝트 리스트 조회
	 */
	
	public GridPagingResDto<SystemUIObjectListResDto> getUIObjectList(SystemUIObjectListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("uo");
		
		return new GridPagingResHelper<SystemUIObjectListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemObjectMapper.getUIObjectList(reqDto));
	}

	/**
	 * @name : getObjectCode
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : GridPagingResDto
	 * @description : UI오브젝트 상세 조회 시, 오브젝트 코드 조회
	 */
	
	public GridPagingResDto<SystemUIObjectListResDto> getObjectCode(SystemUIObjectListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setSVCAlias("uo");
		
		return new GridPagingResHelper<SystemUIObjectListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemObjectMapper.getObjectCode(reqDto));
	}

	/**
	 * @name : insertUIObjectDetail
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : StatusResDto 
	 * @description : UI오브젝트 추가
	 */
	
	public StatusResDto insertUIObjectDetail(SystemInsertUIObjectDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		
		rtnValue.setSuccess(false);
//		reqDto.setId(CommonUtil.newRid());
	//	systemObjectMapper.insertUIObjectDetail(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	/**
	 * @name : getUIObjectDetail
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : MKTGetUIObjectDetailResponseDTO 
	 * @description : UI오브젝트 상세 조회
	 */
	
	public SystemGetUIObjectDetailResDto getUIObjectDetail(SystemGetUIObjectDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		SystemGetUIObjectDetailResDto rtnValue = new SystemGetUIObjectDetailResDto();
		
		reqDto.setSVCAlias("uo");
		rtnValue = systemObjectMapper.getUIObjectDetail(reqDto);
		
		return rtnValue;
	}

	/**
	 * @name : deleteUIObjectList
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : UI오브젝트 삭제 
	 */
	
	public StatusResDto deleteUIObjectList(SystemDeleteUIObjectListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		systemObjectMapper.deleteUIObjectList(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	/**
	 * @name : updateUIObjectDetail
	 * @date : 2017. 3. 15.
	 * @author : jun.lee
	 * @return : StatusResDto 
	 * @description : UI오브젝트 수정 
	 */
	
	public StatusResDto updateUIObjectDetail(SystemInsertUIObjectDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		
		rtnValue.setSuccess(false);
		systemObjectMapper.updateUIObjectDetail(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
}
