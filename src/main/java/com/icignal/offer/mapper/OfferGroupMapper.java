package com.icignal.offer.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.offer.dto.request.ChildOfferReqDto;
import com.icignal.offer.dto.request.OfferGroupReqDto;
import com.icignal.offer.dto.response.ChildOfferResDto;
import com.icignal.offer.dto.response.OfferGroupResDto;

/**
 * 1. FileName	: OfferGroupMapper.java
 * 2. Package	: com.icignal.offer.OfferGroupMapper
 * 3. Comments	:	
 * 4. Author	: 
 * 5. DateTime	: 2020. 6. 10. 오후 4:01:00
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 6. 10.		 | 			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: OfferGroupMapper
 * 2. 파일명	: OfferGroupMapper.java
 * 3. 패키지명	: com.icignal.offer.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 6. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface OfferGroupMapper {

	List<OfferGroupResDto> selectOfferGroupList(OfferGroupReqDto reqDto);
	
	OfferGroupResDto selectOfferGroupDetail(OfferGroupReqDto reqDto);
	
	void updateOfferGroup(OfferGroupReqDto reqDto);
	
	void insertOfferGroup(OfferGroupReqDto reqDto);

	void updateOfferGroupDel(OfferGroupReqDto reqDto);
	
	List<ChildOfferResDto> selectChildOfferList(ChildOfferReqDto reqDto);
	
	ChildOfferResDto selectChildOfferDetail(ChildOfferReqDto reqDto);
	
	void updateChildOffer(ChildOfferReqDto reqDto);
	
	void insertChildOffer(ChildOfferReqDto reqDto);

	void updateChildOfferDel(ChildOfferReqDto reqDto);
	
}
