package com.icignal.marketing.fatigue.mapper;

import java.util.List;

import com.icignal.marketing.fatigue.dto.response.MktFatigueChnlItemResDto;
import org.apache.ibatis.annotations.Mapper;

import com.icignal.marketing.fatigue.dto.request.MktDeleteFatigueReqDto;
import com.icignal.marketing.fatigue.dto.request.MktFatigueReqDto;
import com.icignal.marketing.fatigue.dto.request.MktFatigueModifyReqDto;
import com.icignal.marketing.fatigue.dto.request.MktFatigueDetailReqDto;
import com.icignal.marketing.fatigue.dto.request.MktFatigueSetReqDto;
import com.icignal.marketing.fatigue.dto.response.MktFatigueDetailResDto;
import com.icignal.marketing.fatigue.dto.response.MktFatigueResDto;

@Mapper
public interface MktFatigueMapper {

	public List<MktFatigueResDto> getFatigueList(MktFatigueReqDto dto);

	public MktFatigueDetailResDto getFatigueDetail(MktFatigueDetailReqDto dto);

	public int selectFatigueCheck(MktFatigueSetReqDto dto);

	public void insertFatigue(MktFatigueSetReqDto dto);

	public void updateFatigue(MktFatigueModifyReqDto dto);
	void updateFatigueItem(MktFatigueModifyReqDto dto);

	public void deleteFatigue(MktDeleteFatigueReqDto dto);

	public void updateFatigueState(MktFatigueModifyReqDto dto);

    List<MktFatigueResDto> selectFatigueChnlItemList(MktFatigueReqDto dto);

	MktFatigueChnlItemResDto selectFatigueItemDetail(MktFatigueReqDto dto);

	void insertFatiItem(MktFatigueReqDto dto);

	void updateFatiItem(MktFatigueReqDto dto);

	public void updateFatigueChnlItemOfMfm(MktFatigueModifyReqDto dto);

	void deleteFatigueChnlItem(MktFatigueReqDto dto);


}
