<template>
    <div>
        <el-container>
          <el-header style="text-align: left; font-size: 12px">
            <el-row>
              <el-col :span="20 ">
                <h1 style="font-size:30px">可用设备申请</h1>
              </el-col>
              <el-col :span="2">
                <div class="grid-content bg-purple">
                  <br>
                  
                    <span class="el-dropdown-link">
                    <router-link to="/info">
                        <el-button style="background-color:dodgerblue; color:black; border:none" type="primary" >返回</el-button>
                      </router-link>
                    </span>
                </div>
              </el-col>

              <el-col :span="2">
                <div class="grid-content bg-purple">
                  <br>
                  
                    <span class="el-dropdown-link">
                    <router-link to="/">
                        <el-button style="background-color:dodgerblue; color:black; border:none" type="primary" >退出</el-button>
                      </router-link>
                    </span>
                </div>
              </el-col>
            </el-row>
          </el-header>
        <el-container>

            <el-aside width="200px" height="1000px">
                <el-menu
                default-active="2"
                class="el-menu-vertical-demo"
                @open="handleOpen"
                @close="handleClose"
                background-color="#545c64"
                text-color="#fff"
                active-text-color="#ffd04b">
                <el-menu-item index="2">
                  <i class="el-icon-setting"></i>
                  <router-link to="/serviceable">可用设备</router-link>
                </el-menu-item>
                <el-menu-item index="3">
                  <i class="el-icon-document"></i>
                  <router-link to="/record">申请记录</router-link>
                </el-menu-item>
                
              </el-menu>
            </el-aside>
            <el-main>
              <router-link to="/"></router-link>
              <router-view></router-view>
            </el-main>
        </el-container>

        </el-container>
    </div>
</template>


<script>
  export default {
    methods: {
      handleOpen(key, keyPath) {
        console.log(key, keyPath);
      },
      handleClose(key, keyPath) {
        console.log(key, keyPath);
      }
    }
  }
</script>

<style>
.el-header {
  background-color:dodgerblue;
  color: #333;
  text-align: center;
  align-items:center;
  line-height: 10px;
}

.el-aside {
  background-color: #545c64;
  color:#545c64;
  text-align: center;
  line-height: 200px;
  height:1000px;
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