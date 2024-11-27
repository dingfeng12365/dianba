package com.dingfeng.dianba.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dingfeng.dianba.entity.Charge;
import com.dingfeng.dianba.service.IChargeService;
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
@RequestMapping("/charge")
public class ChargeController {
    @Autowired
    private IChargeService chargeService;

    //分页查询
    @RequestMapping("/getByPage")
    public IPage<Charge> getByPage(int pageNum, int pageSize){
        System.out.println(pageNum);
        System.out.println(pageSize);

        IPage<Charge> page = chargeService.page(new Page<>(pageNum, pageSize));
        return page;
    }

    //自动id查询
    @RequestMapping("/getByPage1")
    public IPage<Charge> getByPage1(int pageNum, int pageSize, int owningId){
        System.out.println(pageNum);
        System.out.println(pageSize);
        System.out.println(owningId);

        // 构建查询条件
        QueryWrapper<Charge> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("owningId", owningId);
        // 执行分页查询
        IPage<Charge> page = chargeService.page(new Page<>(pageNum, pageSize), queryWrapper);
        return page;
    }

    //自动查询2
    @RequestMapping("/getByPage2")
    public IPage<Charge> getByPage2(int pageNum, int pageSize){
        System.out.println(pageNum);
        System.out.println(pageSize);

        // 构建查询条件
        QueryWrapper<Charge> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("owningId", 0);
        // 执行分页查询
        IPage<Charge> page = chargeService.page(new Page<>(pageNum, pageSize), queryWrapper);
        return page;
    }




    //修改用户信息
    @RequestMapping("/update")
    public boolean update(@RequestBody Charge charge){
        boolean c = chargeService.updateById(charge);
        return c;
    }

    //按位置模糊查询用户信息
    @RequestMapping("/getByPosition")
    public List<Charge> getByPosition(String position){
        QueryWrapper<Charge > queryWrapper = new QueryWrapper<>();
        queryWrapper.like("position ", position);
        List<Charge> list = chargeService.list(queryWrapper);
        return list;
    }

    //按位置模糊查询用户信息2
    @RequestMapping("/getByPosition1")
    public List<Charge> getByPosition1(String position){
        QueryWrapper<Charge > queryWrapper = new QueryWrapper<>();
        // 检查 owningId 为空的条件
        queryWrapper.eq("owningId", 0);

        // 添加模糊查询条件
        queryWrapper.like("position", position);
        List<Charge> list = chargeService.list(queryWrapper);
        return list;
    }
    //按位置模糊查询用户信息3
    @RequestMapping("/getByPosition2")
    public List<Charge> getByPosition2(String position, int userId){
        QueryWrapper<Charge > queryWrapper = new QueryWrapper<>();
        // 检查 owningId 为空的条件
        queryWrapper.eq("owningId", userId);

        // 添加模糊查询条件
        queryWrapper.like("position", position);
        List<Charge> list = chargeService.list(queryWrapper);
        return list;
    }
    //按状态查询
    @RequestMapping("/getByZhuangTai")
    public List<Charge> getByZhuangTai(String zhuangTai){
        QueryWrapper<Charge > queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("zhuangTai ", zhuangTai);
        List<Charge> list = chargeService.list(queryWrapper);
        return list;
    }
    //通过id删除用户信息
    @RequestMapping("/delByChargeId")
    public boolean delByChargeId (Integer chargeId){
        boolean b = chargeService.removeById(chargeId);
        return b;
    }
    //添加用户信息
    @RequestMapping("/add")
    public boolean add(@RequestBody Charge charge){
        boolean d = chargeService.save(charge);
        return d;
    }

    //根据userId查询该用户所属下的设备总耗电量
    @RequestMapping("/getTotalPowerConsumption")
    public List<Charge> getByPowerConsumption(Integer owningId){
        QueryWrapper<Charge> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("owningId", owningId);
        List<Charge> list = chargeService.list(queryWrapper);
        return list;
    }

}
