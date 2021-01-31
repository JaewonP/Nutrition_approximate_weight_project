package com.nutirition.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nutirition.dao.NuTbl;
import com.nutirition.mapper.NutritionMapper;

import lombok.Setter;

@Service
public class NutritionServiceImple implements NutritionService{

	@Setter(onMethod_ = @Autowired)
	private NutritionMapper mapper;
	
	@Override
	public List<NuTbl> itemlist(String fegie_name) {
		// TODO Auto-generated method stub
		return mapper.itemlist(fegie_name);
	}

	@Override
	public List<NuTbl> itemEach(String fegie_name, String amount_name, int amount) {
		// TODO Auto-generated method stub
		return mapper.itemEach(fegie_name, amount_name, amount);
	}

	@Override
	public List<NuTbl> getType() {
		// TODO Auto-generated method stub
		return mapper.getType();
	}

	@Override
	public void itemAdd(String fegie_name, String amount_name, int amount, float weight) {
		// TODO Auto-generated method stub
		mapper.itemAdd(fegie_name, amount_name, amount, weight);
	}

	@Override
	public List<NuTbl> AllList() {
		// TODO Auto-generated method stub
		return mapper.AllList();
	}

	@Override
	public void itemDelete(int bno) {
		mapper.itemDelete(bno);
		
		
	}

}
