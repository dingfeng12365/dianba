<template>

    <div>

      <el-menu :default-active="activeIndex2" class="el-menu-demo" mode="horizontal" @select="handleSelect"
      background-color="#409eff" text-color="#fff" active-text-color="#ffd04b">
      <el-row gutter="5">

        <el-col :span='2' offset='0'>
        
          <img src="../assets/电霸logo.png" alt="logo" width="100%" height="100%">
          
        </el-col>
      
        <el-col :span='7'>
          <br>
          <img src="../assets/logo1.png" alt="logo1" width="100%" height=120%>
        </el-col>
        <el-col :span='2'>
          <br>
          <el-menu-item index="1">
            <router-link to="/zhuye">首页</router-link>
            </el-menu-item>
        </el-col>
        <el-col :span='2'>
          <br>
          <el-submenu index="2">
            <template slot="title">产品中心</template>
            <el-menu-item index="1-1"><router-link to="/tumb">二轮车充电桩</router-link></el-menu-item>
            <el-menu-item index="1-2"><router-link to="/auto">汽车充电桩</router-link></el-menu-item>
          </el-submenu>
        </el-col>

        <el-col :span='2'>
          <br>
          <el-submenu index="3">
            <template slot="title">关于我们</template>
        <!-- 公司简介路由跳转 -->
            <el-menu-item index="1-1"><router-link to="/intro">公司简介</router-link></el-menu-item>
            <el-menu-item index="1-2"><router-link to="/glory">公司荣誉</router-link></el-menu-item>
          </el-submenu>
        </el-col>
        <el-col :span='2'>
          <br>
          <el-menu-item index="4">
            <router-link to="/manage">管理中心</router-link>
            </el-menu-item>
        </el-col>
        <el-col :span='2'>
          <br>
          <el-menu-item index="5">
            <el-link :underline="false" @click="dialogVisible3 = true">登录/注册</el-link>
          </el-menu-item>
        </el-col>
        <el-col :span='4'>
          <br>
          <el-menu-item>
            <el-input placeholder="请输入内容" v-model="input1" class="input-with-select" size="medium">
              <el-button size="mini" slot="append" icon="el-icon-search"></el-button>
            </el-input>
            <router-link to="/info">
              <el-button type="warning" size="mini" icon="el-icon-user" round ></el-button>
            </router-link>
          </el-menu-item>
        </el-col>
      </el-row>
    </el-menu>

    <!-- 展示模块 -->
    <div class="container">  
      <div class="module top-left"> 
        <img src="../assets/二轮1.jpg" alt="" width="50%" height="50%">
        <el-divider direction="vertical"></el-divider>
            <p  class="custom-paragraph">远程控制 <br><br>实时监控<br><br>运行稳定<br><br>多用户管理</p>
      </div>  
      <div class="module top-right">  
        <img src="../assets/二轮2.jpg" alt="" width="50%" height="50%">
        <el-divider direction="vertical"></el-divider>
            <p  class="custom-paragraph">两种充电方式 <br><br>多功率选择 <br><br>过充保护 <br><br>方便快捷，效率提升</p>
      </div>  
      <div class="module bottom-left">  
        <img src="../assets/二轮3.jpg" alt="" width="50%" height="70%">
        <el-divider direction="vertical"></el-divider>
            <p  class="custom-paragraph">单体使用<br><br>无需排队<br><br>安装地点自由</p>
      </div>  
      <div class="module bottom-right">  
        <img src="../assets/二轮4.jpg" alt="" width="50%" height="70%">
        <el-divider direction="vertical"></el-divider>
            <p  class="custom-paragraph">超多接口<br><br>散布安装<br><br>解决突发情况</p>
      </div>  
    </div>

        <!-- 注册弹窗 -->
        <el-dialog title="注册" :visible.sync="dialogVisible2" width="30%" :before-close="handleClose">
            <span>
              <el-form ref="form" :model="zhuCeForm" label-width="80px">
                <el-form-item label="用户名">
                  <el-input v-model="zhuCeForm.userName"></el-input>
                </el-form-item>
                <el-form-item label="手机号">
                  <el-input v-model="zhuCeForm.phone"></el-input>
                </el-form-item>
                <el-form-item label="密码">
                  <el-input v-model="zhuCeForm.password"></el-input>
                </el-form-item>
                <el-form-item label="确认密码">
                  <el-input v-model="password2"></el-input>
                </el-form-item>
              </el-form>
            </span>
            <span slot="footer" class="dialog-footer">
              <el-button @click="dialogVisible2 = false">取 消</el-button>
              <el-button type="primary" @click="addUsers()">确 定</el-button>
            </span>
          </el-dialog>
          <!-- 登录弹窗 -->
          <el-dialog title="登录" :visible.sync="dialogVisible3" width="30%" :before-close="handleClose">
            <span>
              <el-form ref="form" :model="loginForm" label-width="80px">
    
                <el-form-item label="用户名">
                  <el-input v-model="loginForm.userName"></el-input>
                </el-form-item>
                <el-form-item label="密码">
                  <el-input v-model="loginForm.password"></el-input>
                </el-form-item>
              </el-form>
            </span>
            <span slot="footer" class="dialog-footer">
              <el-button @click="handleClick()" type="info" plain>立即注册！</el-button>
              <el-button @click="dialogVisible3 = false">取消</el-button>
              <el-button type="primary" @click="login()">确 定</el-button>
            </span>
          </el-dialog>
    </div>
</template>

<script>
  
  import axios from 'axios'
  export default {
    name: 'App',
    data() {
      return {
        form: {
          user_id: '',
          password: '',
        },
        //登录表单
        loginForm: {
          userName: '',
          password: '',
        },
  
        //注册表单
        zhuCeForm: {
          userName: '',
          password: '',
          phone: '',
          roleId: '1',
          //默认注册用户为普通用户
  
        },
        password2: '',//登录注册弹窗1
        dialogVisible2: false,//注册弹窗
        dialogVisible3: false,
        // 搜索框
        input: '',
        searchVisible: false,//搜索跳转
      }
    },
    methods: {
      // 点击事件
      handleEdit(index, row) {
        console.log(index, row);
  
        this.dialogVisible = true;
  
        this.form = row;
  
      },
      handleClose() {
        this.dialogVisible3 = false;
        this.dialogVisible2 = false;
      },
      handleClick() {
        this.dialogVisible3 = false; // 关闭第一个对话框  
        this.dialogVisible2 = true;  // 打开第二个对话框  
      },
      addUsers() {
        axios.post(`${process.env.VUE_APP_API_URL}/users/addUsers`, this.zhuCeForm)
          .then(response => {
            console.log(response);
          })
          .catch(error => {
            console.log(error);
          })
        this.dialogVisible2 = false;
      },
      login() {
        console.log(this.loginForm);
        axios.post(`${process.env.VUE_APP_API_URL}/users/login`, this.loginForm)
        .then(res => {
          if (res.data) {
            alert('登录成功!');
          } else {
            alert('登录失败，请检查用户名和密码！');
          }
        })
        this.dialogVisible3 = false;
      },
  
    }
  
  }
  </script>
  <style scoped>
  .content::after {
    content: "";
    display: block;
    height: 1600px;
    visibility: hidden;
  }
  
  .el-link {
    color: #f8f9fa;
  }

  .el-divider {
    width: 1px; /* 设置分割线的宽度 */
    height: 200px; /* 控制分割线的高度 */
    background-color: #fefbfb;
  }
  .custom-paragraph {
    font-size: 20px; /* 设置段落字体大小 */
    color: #f5eeee; /* 设置段落颜色 */
}
  .container {  
    display: flex;  
    flex-wrap: wrap;  
    width: auto; /* 100% 的视口宽度 */  
    height: 100vh; /* 100% 的视口高度 */  
    background-image: url('../assets/产品展示背景.png'); /* 替换为你的背景图片路径 */
    background-size: cover;
    background-position: center;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    background-color: rgba(255, 255, 255, 0.1); /* 添加半透明的白色背景 */
    background-blend-mode: overlay; /* 设置混合模式 */
  }
  .module {  
    flex: 1 0 50%; /* 每个模块占据一半的空间 */  
    display: flex;  
    align-items: center;  
    justify-content: center;  
    border: 1px solid #ccc; /* 模块边框 */  
    box-sizing: border-box; /* 计算边框和内边距 */  
    font-size: 24px;
    background-color: transparent; 
  }  
  

  
  .router-link-active {
    color:#333;
    text-decoration: none;
  }
  a {
    color: rgb(253, 251, 251);
    text-decoration: none;
  }
  </style>
  