package com.icignal.kepler.targetGroup.targetSimple.mapper;

import java.util.List;

import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupColumnListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupColumnListResDto;
import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprGetTargetSimpleGroupNameResDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprGetTargetSimpleListResDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprGetTargetSimpleListTagetGroupResDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprGetTargetSimpleListTargetGroupValueResDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.response.KprLogicalComponentInfoResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupTargetListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupResDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListNewReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListNewSaveDataReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListNewSaveReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListTagetGroupReqDto;
import com.icignal.kepler.targetGroup.targetSimple.dto.request.KprGetTargetSimpleListUpdateTagetGroupReqDto;


	
@Mapper
public interface KprTargetSimpleMapper {
	
		//기존 그룹 컬럼 이름 조회
		public List<KprGetTargetSimpleListResDto> aleadySelectGroupColName (KprGetTargetSimpleListReqDto param); 
		//기존 그룹 이름 조회
		public List<KprGetTargetSimpleGroupNameResDto> aleadySelectGroupName (KprGetTargetSimpleListReqDto param); 		
		//신규 그룹 컬럼 이름 조회
		public List<KprGetTargetSimpleListResDto> selectGroupColNameCondition (KprGetTargetSimpleListNewReqDto param); 
		//신규 그룹 이름 조회
		public List<KprGetTargetSimpleGroupNameResDto> selectGroupTopNameCondition (KprGetTargetSimpleListNewReqDto param); 
		//신규 삽입
		public void insertGroupNameTargetingGroupCondition (KprGetTargetSimpleListNewSaveDataReqDto param); 
		//타겟 그룹 삽입
		public void insertGroupNameTargetingGroupEnRoll (KprGetTargetSimpleListNewSaveReqDto param); 
		//타겟 그룹 조회
		public KprGetTargetSimpleListTagetGroupResDto selectTargetGroup (KprGetTargetSimpleListTagetGroupReqDto param); 
		//타겟 그룹 심플 타겟팅 값 조회
		public List<KprGetTargetSimpleListTargetGroupValueResDto> aleadySelectGroupValue (KprGetTargetSimpleListTagetGroupReqDto param); 		
		//타겟 그룹 수정
		public void tarGetGroupValueUpdate (KprGetTargetSimpleListUpdateTagetGroupReqDto param);
		//심플 타겟팅 수정
		public void tarGetGroupTargetingValueUpdate (KprGetTargetSimpleListNewSaveDataReqDto param);
		////타겟 대상자 목록 조회
		public String selectSimpleTargetingGridList(KprTargetGroupTargetListReqDto param);
		//로지컬컴포넌트 조회
		KprLogicalComponentInfoResDto selectLogicalComponentInfo(String serverType);
		//query 대상수 조회
		Integer selectTargetCountQuery(String param);
		//query 대상자 조회
		List<String> selectTargetQuery(String param);
		//그리드 
		public KprTargetGroupResDto selectTargetGridGroup(KprTargetGroupReqDto tgr);
		//워크플로우 조건추출 목록 조회
		public List<KprTargetGroupListResDto> selectSimpleList(KprTargetGroupListReqDto tglr);
		//컬럼 타겟팅
		public List<KprTargetGroupColumnListResDto> selectSimpleTargetGroupColumnAllList(KprTargetGroupColumnListReqDto tgclr);
		//특정 저장 컬럼 타겟팅
		public List<KprTargetGroupColumnListResDto> selectSimpleTargetGroupColumnList(KprTargetGroupColumnListReqDto tgclr);

}
