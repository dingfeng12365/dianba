package com.dingfeng.dianba.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dingfeng.dianba.entity.Keeplist;
import com.dingfeng.dianba.entity.Users;
import com.dingfeng.dianba.service.IUsersService;
import org.apache.catalina.User;
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
 * @since 2024-08-15
 */
@RestController
@RequestMapping("/users")
public class UsersController {
    @Autowired
    private IUsersService usersService;

    //分页查询
    @RequestMapping("/getByPage")
    public IPage<Users> getByPage(int pageNum, int pageSize){
        IPage<Users> page = usersService.page(new Page<>(pageNum, pageSize));

        return page;
    }

    //通过id删除用户信息
    @RequestMapping("/delByUserId")
    public boolean delByUserId(Integer userId){
        boolean b = usersService.removeById(userId);
        return b;
    }

    //按姓名模糊查询用户信息
    @RequestMapping("/getByName")
    public List<Users> getByUserName(String userName){
        QueryWrapper<Users> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("userName", userName);
        List<Users> list = usersService.list(queryWrapper);
        return list;
    }
    //按类别id查询
    @RequestMapping("/getByRoleId")
    public List<Users> getByRoleId(int roleId){
        QueryWrapper<Users> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("roleId", roleId);
        List<Users> list = usersService.list(queryWrapper);
        return list;
    }
    //修改用户信息
    @RequestMapping("/update")
    public boolean update(@RequestBody Users user){
        boolean b = usersService.updateById(user);
        return b;
    }
    //添加用户信息
    @RequestMapping("addUsers")
    public boolean addUsers(@RequestBody Users users){
        boolean flag = usersService.save(users);

        return flag;
    }

    //登录端口，传入用户数据表单，返回用户类型
    @RequestMapping("/login")
    public int login(@RequestBody Users users){
        QueryWrapper<Users> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("userName",users.getUserName());
        queryWrapper.eq("password",users.getPassword());
        Users user = usersService.getOne(queryWrapper);
        if(user!=null){
            return user.getRoleId();
        }else {
            return 0;
        }
    }

    //根据前端给出的name查询用户信息是否存在，如果存在返回true，不存在返回false
    @RequestMapping("/checkUserName")
    public boolean checkUserName(@RequestBody Users users){
        QueryWrapper<Users> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("userName",users.getUserName());
        Users user = usersService.getOne(queryWrapper);
        if(user!=null){
            return true;
        }else{
            return false;
        }
    }
}
