<template>
  <div>
    <el-header style="text-align: left; font-size: 12px">
      <el-row>
        <el-col :span="22 ">
          <h1 style="font-size:30px">共享充电管理系统</h1>
        </el-col>
        <el-col :span="2">
          <div class="grid-content bg-purple">
              <br>
              <br>
              <br>
            <el-dropdown>
              <span class="el-dropdown-link">
                <router-link to="/">
                 返回主页
                </router-link>
                  
              </span>
              <el-dropdown-menu slot="dropdown">
               
              </el-dropdown-menu>
            </el-dropdown>
            

          </div>
        </el-col>
      </el-row>
    </el-header>


  </div>
</template>

<style>
.el-header {
  background-color:dodgerblue;
  color: #333;
  text-align: center;
  align-items:center;
  line-height: 10px;
}

.el-dropdown-link {
  cursor: pointer;
  color: #333;
}
.el-icon-arrow-down {
  font-size: 12px;
}
</style>