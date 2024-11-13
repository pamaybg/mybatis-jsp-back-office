package com.icignal.loyalty.qna.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.qna.dto.request.LoyQnaReqDto;
import com.icignal.loyalty.qna.dto.response.LoyQnaResDto;

@Mapper
public interface LoyQnaMapper {

	public List<LoyQnaResDto> getQnaList(LoyQnaReqDto reqDto);

	public LoyQnaResDto getQnaDetail(LoyQnaReqDto reqDto);

	public LoyQnaResDto getQnaClearMaskMbr(LoyQnaReqDto reqDto);

	public void updateQnaDetail(LoyQnaReqDto reqDto);


}
