package com.icignal.kepler.operation.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.operation.dto.request.KprDrillDownGroupReqDto;
import com.icignal.kepler.operation.dto.response.KprDrillDownGroupResDto;
import com.icignal.kepler.operation.mapper.KprDrillDownGroupMapper;

@Service
public class KprDrillDownGroupService {

//	@Autowired
//	private KPRDrillDownGroupMapper KPRDrillDownGroupMapper;
	
	@Autowired
	private KprDrillDownGroupMapper KPRDrillDownGroupMapper;

	public List<KprDrillDownGroupResDto> getMetaServiceList(KprDrillDownGroupReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");

		return KPRDrillDownGroupMapper.selectMetaServiceList(reqDto);
	}

	public List<KprDrillDownGroupResDto> getMetaTableColumnList(KprDrillDownGroupReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("atm");

		return KPRDrillDownGroupMapper.selectMetaTableColumnList(reqDto);
	}

	public List<KprDrillDownGroupResDto> getDrillDownGroupList(KprDrillDownGroupReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("adg");

		return KPRDrillDownGroupMapper.selectDrillDownGroupList(reqDto);
	}

	public List<KprDrillDownGroupResDto> addDrillDownGroup(KprDrillDownGroupReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("adg");
		StatusResDto resDto = new StatusResDto();
		KPRDrillDownGroupMapper.insertDrillDownGroup(reqDto);
		resDto.setSuccess(true);
		
		return KPRDrillDownGroupMapper.selectDrillDownGroupList(reqDto);
	}

	public List<KprDrillDownGroupResDto> editDrillDownGroup(KprDrillDownGroupReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("adg");
		StatusResDto resDto = new StatusResDto();
		KPRDrillDownGroupMapper.updateDrillDownGroup(reqDto);
		resDto.setSuccess(true);
		return KPRDrillDownGroupMapper.selectDrillDownGroupList(reqDto);
	}

	public List<KprDrillDownGroupResDto> removeDrillDownGroup(KprDrillDownGroupReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("adg");
		StatusResDto resDto = new StatusResDto();
		KPRDrillDownGroupMapper.deleteDrillDownGroup(reqDto);
		resDto.setSuccess(true);
		return KPRDrillDownGroupMapper.selectDrillDownGroupList(reqDto);
	}

}