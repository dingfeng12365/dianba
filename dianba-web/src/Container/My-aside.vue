<template>
    <div>
        <el-aside width="auto" height="1000px" style="background-color: #545c64">
            <el-menu :default-openeds="['1', '3']" 
            background-color="#545c64"
            text-color="#fff"
            active-text-color="#ffd04b">
              <el-submenu index="1">
                <template slot="title"><i class="el-icon-s-tools"></i>设备管理</template>
                <el-menu-item-group>
                  <el-menu-item index="1-1">
                    <router-link to="/equip">设备信息</router-link>
                  </el-menu-item>
                  <el-menu-item index="1-2">
                    <router-link to="/maintenance">维修日志</router-link>
                  </el-menu-item>
                </el-menu-item-group>
              </el-submenu>

              <el-submenu index="2">
                <template slot="title"><i class="el-icon-user-solid"></i>用户管理</template>
                <el-menu-item-group>
                  <el-menu-item index="2-1">
                    <router-link to="/userinfo">用户信息</router-link>
                  </el-menu-item>
                  <el-menu-item index="2-2">
                    <router-link to="/approve">申请审批</router-link>
                  </el-menu-item>
                </el-menu-item-group>
              </el-submenu>

              

              <el-submenu index="3">
                <template slot="title"><i class="el-icon-star-on"></i>客服管理</template>
                <el-menu-item-group>
                  <el-menu-item index="4-1">
                    <router-link to="/serinfo">客服信息</router-link>
                  </el-menu-item>
                </el-menu-item-group>
              </el-submenu>
           
            </el-menu>
          </el-aside>
    </div>
  </template>

  <style>

  .el-aside {
    background-color: #545c64;
    color: #333;
    text-align: center;
    line-height: 200px;
    width:200px;
  }
  
  .router-link-active {
    color:#ffd04b;
    text-decoration: none;
  }
  a {
    color: rgb(255, 255, 255);
    text-decoration: none;
  }
</style>