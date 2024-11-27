package com.dingfeng.dianba.controller;



import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dingfeng.dianba.entity.Apply;
import com.dingfeng.dianba.entity.Feedback;
import com.dingfeng.dianba.entity.Keeplist;
import com.dingfeng.dianba.service.IFeedbackService;
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
@RequestMapping("/feedback")
public class FeedbackController {
    @Autowired
    private IFeedbackService feedbackService;

    //分页查询
    @RequestMapping("/getByPage")
    public IPage<Feedback> getByPage(int pageNum, int pageSize){
        IPage<Feedback> page = feedbackService.page(new Page<>(pageNum, pageSize));

        return page;
    }
    //按姓名模糊查询用户信息
    @RequestMapping("/getByFeedBack")
    public List<Feedback> getByFeedBack(String feedBack){
        QueryWrapper<Feedback> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("feedBack", feedBack);
        List<Feedback> list = feedbackService.list(queryWrapper);
        return list;
    }
    //修改反馈信息
    @RequestMapping("/update")
    public boolean update(@RequestBody Feedback feedback){
        boolean b = feedbackService.updateById(feedback);
        return b;
    }
    //按完成查询
    @RequestMapping("/getByDone")
    public List<Feedback> getByDone(String done){
        QueryWrapper<Feedback> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("done ", done);
        List<Feedback> list = feedbackService.list(queryWrapper);
        return list;
    }
    //插入
    @RequestMapping("/add")
    public boolean add(@RequestBody Feedback feedback){
        boolean d = feedbackService.save(feedback);
        return d;
    }

}
