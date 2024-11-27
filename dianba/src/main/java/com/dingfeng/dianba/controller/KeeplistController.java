package com.dingfeng.dianba.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dingfeng.dianba.entity.Charge;
import com.dingfeng.dianba.entity.Keeplist;
import com.dingfeng.dianba.service.IKeeplistService;
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
 * @since 2024-08-19
 */
@RestController
@RequestMapping("/keeplist")
public class KeeplistController {
    @Autowired
    private IKeeplistService keeplistService;

    //分页查询
    @RequestMapping("/getByPage")
    public IPage<Keeplist> getByPage(int pageNum, int pageSize){
        IPage<Keeplist> page = keeplistService.page(new Page<>(pageNum, pageSize));

        return page;
    }
    //按姓名模糊查询用户信息
    @RequestMapping("/getByPchargeId")
    public List<Keeplist> getByName(String pchargeId){
        QueryWrapper< Keeplist > queryWrapper = new QueryWrapper<>();
        queryWrapper.like("pchargeId ", pchargeId);
        List<Keeplist> list = keeplistService.list(queryWrapper);
        return list;
    }
    //修改用户信息
    @RequestMapping("/update")
    public boolean update(@RequestBody Keeplist keeplist){
        boolean b = keeplistService.updateById(keeplist);
        return b;
    }
    //添加用户信息
    @RequestMapping("/add")
    public boolean add(@RequestBody Keeplist keeplist){
        boolean b = keeplistService.save(keeplist);
        return b;
    }
    //按完成查询
    @RequestMapping("/getByDone")
    public List<Keeplist> getByDone(String done){
        QueryWrapper<Keeplist > queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("done ", done);
        List<Keeplist> list = keeplistService.list(queryWrapper);
        return list;
    }


}
