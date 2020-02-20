package com.jt.pro.controller;

import com.jt.pro.bean.Analysis;
import com.jt.pro.service.AnalysisService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/ana")
public class AnalysisController {

    @Resource
    private AnalysisService analysisService;
    //条件查询
    @RequestMapping(value = "/tiaojian", method = RequestMethod.GET)
    @ResponseBody
    public List<Analysis> tiaojianAnalysis(Integer cid, String keyword, String orderBy) {
        return analysisService.tiaojianAnalysis(cid,keyword,orderBy);
    }
    //修改项目
    @RequestMapping(value = "/update", method = RequestMethod.PUT)
    public String updateProject(Analysis analysis) {
        analysisService.updateAnalysis(analysis);
        return "redirect:/ana/list";
    }

    //修改时按id查看project列表
    @RequestMapping(value = "/updateAnalysisById",method = RequestMethod.GET)
    public ModelAndView updateProjectById(Integer id){
        Analysis list = analysisService.findAnalysisById(id);
        ModelAndView mv = new ModelAndView("project-need-edit");
        mv.addObject("list",list);
        return mv;
    }

    //按id查看project列表
    @RequestMapping(value = "/findAnalysisById",method = RequestMethod.GET)
    public ModelAndView findAnalysisById(Integer id){
        Analysis list = analysisService.findAnalysisById(id);
        ModelAndView mv = new ModelAndView("project-need-look");
        mv.addObject("list",list);
        return mv;
    }
    //删除项目
    @RequestMapping(value = "/del", method = RequestMethod.DELETE)
    @ResponseBody
    public Map<String,Object> deleteAnalysis(Integer[] ids) {
        Map<String,Object> map = new HashMap<String,Object>();
        try {
            boolean result = analysisService.deleteAnalysis(ids);
            map.put("statusCode", 200);
            map.put("message", "删除成功");

        }catch (Exception e){
            map.put("statusCode", 10000);
            map.put("message", "删除失败");
        }
        return map ;
    }

    //显示列表
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public ModelAndView findAnalysisList(){
        ModelAndView mv = new ModelAndView("project-need");
        List<Analysis> list = analysisService.findAnalysisList();
        mv.addObject("list",list);
        return mv;
    }
    //添加
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> addAnalysis(Analysis analysis){
        Map<String,Object> map = new HashMap<String,Object>();
        try {
            boolean result = analysisService.addAnalysis(analysis);
            map.put("statusCode", 200);
            map.put("message", "添加成功");

        }catch (Exception e){
            map.put("statusCode", 10000);
            map.put("message", "添加失败");
        }
        return map;
    }
}
