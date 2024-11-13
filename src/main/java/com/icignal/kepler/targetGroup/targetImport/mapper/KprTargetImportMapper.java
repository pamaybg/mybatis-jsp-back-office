package com.icignal.kepler.targetGroup.targetImport.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprSetTargetGroupReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupItemListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupItemReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupItemListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupResDto;

/**
 * @name : infavor.kepler.targetGroup.dao.impl
 * @date : 2019. 11. 11.
 * @author : dg.ryu
 * @description : 타겟 임포트
 */
@Mapper
public interface KprTargetImportMapper {

    /**
     * @programId :
     * @name : getTargetGroupDetail
     * @date : 2019. 11. 11.
     * @author : dg.ryu
     * @table :
     * @description : 타겟그룹 상세 조회
     */
    public KprTargetGroupResDto selectTargetGroupDetail(KprTargetGroupReqDto reqDto);
    
	/**
	 * @programId : 
	 * @name : addTargetGroup
	 * @date : 2019. 11. 11.
     * @author : dg.ryu
	 * @table : anl.anl_tgt_group
	 * @return :
	 * @description : 타겟그룹 등록
	 */
	public void insertTargetGroup(KprSetTargetGroupReqDto reqDto);	
	/**
	 * @programId : 
	 * @name : editTargetGroup
	 * @date : 2019. 11. 11.
     * @author : dg.ryu
	 * @table : anl.anl_tgt_group
	 * @return :
	 * @description : 타겟그룹 수정
	 */
	public void updateTargetGroup(KprSetTargetGroupReqDto reqDto);
    
    /**
     * @programId :
     * @name : deleteTargetGroupItemByTargetGroupId
     * @date : 2019. 11. 11.
     * @author : dg.ryu
     * @table :
     * @description : 타겟그룹 아이템 삭제
     */
    public void deleteTargetGroupItemByTargetGroupId(KprTargetGroupItemReqDto reqDto);
    
    /**
     * @programId :
     * @name : updateTagetGroupCount
     * @date : 2019. 11. 11.
     * @author : dg.ryu
     * @table :
     * @description : 타겟그룹 건수 업데이트 
     */
    public void updateTagetGroupCount(KprSetTargetGroupReqDto reqDto);
    
    /**
     * @programId :
     * @name : getTargetGroupItemList
     * @date : 2019. 11. 11.
     * @author : dg.ryu
     * @table :
     * @description : 타겟그룹 아이템 목록 조회
     */
    public List<KprTargetGroupItemListResDto> selectTargetGroupItemList(KprTargetGroupItemListReqDto reqDto);
    
    /**
     * @programId :
     * @name : selectAllTargetGroupItemList
     * @date : 2019. 11. 11.
     * @author : dg.ryu
     * @table :
     * @description : 타겟그룹 아이템 목록 전체 조회
     */
    public List<KprTargetGroupItemListResDto> selectAllTargetGroupItemList(KprTargetGroupItemListReqDto reqDto);
    
    //워크플로우 조건추출 목록 조회
    public List<KprTargetGroupListResDto> selectImportList(KprTargetGroupListReqDto tglr);

	public KprTargetGroupItemListResDto clearMaskImportTgtList(KprTargetGroupItemListReqDto reqDto);


}
