package com.nutirition.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.nutirition.dao.NuTbl;
import com.nutirition.service.NutritionService;

import lombok.Setter;

@Controller
public class NutritionController {

	@Setter(onMethod_=@Autowired)
	private NutritionService service;
	
	
	@GetMapping("/search")
	public String nutrition(Model model, NuTbl nu, String fegi_name) {
		
	//	model.addAttribute("list", service.itemlist(nu.getFegie_name()));
	//	model.addAttribute("list", service.itemEach(nu.getFegie_name(), nu.getAmount_name(),nu.getAmount()));
		model.addAttribute("row" , service.getType());
		return "result";
	}
	
	@GetMapping("/forStudent")
	public String nutrition2(Model model) {
		model.addAttribute("row" , service.getType());
		model.addAttribute("list", service.AllList());
		return "forstudent";
	}
	
	@PostMapping("/result1")
	@ResponseBody
	public List<NuTbl> result1(@RequestParam("fegie_name") String fegie_name) {
		List<NuTbl> result = service.itemlist(fegie_name);
		
		
		return result;
	}
	
	@PostMapping("/result2")
	@ResponseBody
	public List<NuTbl> result2(@RequestParam("fegie_name") String fegie_name, @RequestParam("amount_name") String amount_name, @RequestParam("amount") int amount) {
		List<NuTbl> result = service.itemEach(fegie_name, amount_name, amount);
		
		return result;
	}
	
	@PostMapping("/addData")
	@ResponseBody
	public List<NuTbl> addData(@RequestParam("fegie_name") String fegie_name, @RequestParam("amount_name") String amount_name, @RequestParam("amount") int amount, @RequestParam("weight") float weight) {
		service.itemAdd(fegie_name, amount_name, amount, weight);
		List<NuTbl> result = service.AllList();
		return result;
	}
	
	@PostMapping("/deleteData")
	@ResponseBody
	public List<NuTbl> deleteData(@RequestParam("bno") int bno){
		service.itemDelete(bno);
		List<NuTbl> result = service.AllList();
		
		return result;
	}

	
}
