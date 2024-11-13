package com.icignal.systemmanagement.menu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.menu.dto.request.SystemAuthMenuNameLangReqDto;
import com.icignal.systemmanagement.menu.dto.request.SystemMenuListReqDto;
import com.icignal.systemmanagement.menu.dto.response.SystemAuthMenuNameLangResDto;
import com.icignal.systemmanagement.menu.dto.response.SystemMenuListResDto;

/*
 * 1. 클래스명	: SystemMenuMapper
 * 2. 파일명	: SystemMenuMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.menu.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *		SystemManagement - Menu 관리 Mapper
 * </PRE>
 */ 
@Mapper
public interface SystemMenuMapper {

	List<SystemMenuListResDto> getMenuList(SystemMenuListReqDto reqDto);

	List<SystemAuthMenuNameLangResDto> getMenuNameLang(SystemAuthMenuNameLangReqDto reqDto);

	List<SystemMenuListResDto> getAuthMenuProgList(SystemMenuListReqDto reqDto);

	void deleteMenuList(SystemMenuListReqDto reqDto);

	void deleteMenuProgRel(SystemMenuListReqDto reqDto);

	void deleteMenuImage(SystemMenuListReqDto reqDto);

	void updateMenuList(SystemMenuListReqDto reqDto);

	List<SystemMenuListResDto> getAuthMenuListPop(SystemMenuListReqDto reqDto);

	void addAuthMenuListProg(SystemMenuListReqDto reqDto);

	void delAuthMenuListProg(SystemMenuListReqDto reqDto);

	void updateSortMenu(SystemMenuListReqDto reqDto);

	void addAuthMenuList(SystemMenuListReqDto reqDto);

	void updateMenuIcon(SystemMenuListReqDto mlr);

	void deleteMenuIcon(SystemMenuListReqDto mlr);



}
