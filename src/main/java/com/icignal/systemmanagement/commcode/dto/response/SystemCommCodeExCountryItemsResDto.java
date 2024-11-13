package com.icignal.systemmanagement.commcode.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

public class SystemCommCodeExCountryItemsResDto extends StatusResDto {
	List<SystemCommCodeExCountryItemResDto> items;

	public List<SystemCommCodeExCountryItemResDto> getItems() {
		return items;
	}

	public void setItems(List<SystemCommCodeExCountryItemResDto> items) {
		this.items = items;
	}
}
