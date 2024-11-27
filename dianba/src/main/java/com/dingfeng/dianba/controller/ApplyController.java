package com.dingfeng.dianba.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dingfeng.dianba.entity.Apply;
import com.dingfeng.dianba.entity.Charge;
import com.dingfeng.dianba.service.IApplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author dingfeng
 * @since 2024-08-23
 */
@RestController
@RequestMapping("/apply")
public class ApplyController {
    @Autowired
    private IApplyService applyService;
    //分页查询
    @RequestMapping("/getByPage")
    public IPage<Apply> getByPage(int pageNum, int pageSize){
        System.out.println(pageNum);
        System.out.println(pageSize);

        IPage<Apply> page = applyService.page(new Page<>(pageNum, pageSize));
        return page;
    }

    //条件分页查询
    @RequestMapping("/getByPage1")
    public IPage<Apply> getByPage1(int pageNum, int pageSize, int applicant){
        // 构建查询条件
        QueryWrapper<Apply> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("applicant", applicant);
        // 执行分页查询
        IPage<Apply> page = applyService.page(new Page<>(pageNum, pageSize), queryWrapper);
        return page;
    }
    //插入
    @RequestMapping("/add")
    public boolean add(@RequestBody Apply apply){
        boolean d = applyService.save(apply);
        return d;
    }
    //按申请人查询
    @RequestMapping("/getByApplicant")
    public List<Apply> getByApplicant(String applicant){
        QueryWrapper<Apply> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("applicant", applicant);
        List<Apply> list = applyService.list(queryWrapper);
        return list;
    }
    //有条件按状态查询
    @RequestMapping("/getByApplyStatus")
    public List<Apply> getByApplyStatus(String applyStatus, int applicant){
        QueryWrapper<Apply> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("applicant", applicant);
        queryWrapper.eq("applyStatus", applyStatus);
        List<Apply> list = applyService.list(queryWrapper);
        return list;
    }
    //申请状态查询
    @RequestMapping("/getByApplyStatus1")
    public List<Apply> getByApplyStatus1(String applyStatus){
        QueryWrapper<Apply> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("applyStatus", applyStatus);
        List<Apply> list = applyService.list(queryWrapper);
        return list;
    }

    //修改申请信息
    @RequestMapping("/update")
    public boolean update(@RequestBody Apply apply){
        boolean c = applyService.updateById(apply);
        return c;
    }

}
