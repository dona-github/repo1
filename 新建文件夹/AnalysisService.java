package com.jt.pro.service.impl;

import com.jt.pro.bean.Analysis;
import com.jt.pro.bean.AnalysisExample;
import com.jt.pro.dao.AnalysisMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Service
public class AnalysisService implements com.jt.pro.service.AnalysisService {
    @Resource
    private AnalysisMapper analysisMapper;

    @Override
    public boolean addAnalysis(Analysis analysis) {
        analysis.setAddtime(new Date());
        analysis.setUpdatetime(new Date());
        int i = analysisMapper.insertSelective(analysis);
        return i>0?true:false;
    }

    @Override
    public List<Analysis> findAnalysisList() {
        AnalysisExample example = new AnalysisExample();
        return analysisMapper.selectByExample(example);
    }

    @Transactional(rollbackFor = SQLException.class)
    @Override
    public boolean deleteAnalysis(Integer[] ids) {
        AnalysisExample example = new AnalysisExample();
        AnalysisExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(Arrays.asList(ids));
        int i = analysisMapper.deleteByExample(example);
        return i==ids.length;
    }

    @Override
    public Analysis findAnalysisById(Integer id) {
        return analysisMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateAnalysis(Analysis analysis) {
        analysis.setUpdatetime(new Date());
        analysisMapper.updateByPrimaryKeySelective(analysis);
    }

    @Override
    public List<Analysis> tiaojianAnalysis(Integer cid, String keyword, String orderBy) {
        AnalysisExample example = new AnalysisExample();
        AnalysisExample.Criteria criteria = example.createCriteria();
        if(cid==0){
            criteria.andPronameLike("%"+keyword+"%");
            AnalysisExample.Criteria criteria2 = example.createCriteria();
            criteria2.andTitleLike("%"+keyword+"%");
            example.or(criteria2);
            analysisMapper.selectByExample(example);
        }else if(cid == 1){
            criteria.andPronameLike("%"+keyword+"%");
        }else{
            criteria.andTitleLike("%"+keyword+"%");
        }
        //时间排序
        example.setOrderByClause(orderBy);
        List<Analysis> list = analysisMapper.selectByExample(example);
        return list;
    }
}
