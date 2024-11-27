<template>
  <!--写入html代码-->

  <div id="app">

    <!-- 页面内容 -->
    <!-- 导航栏菜单 -->
    <el-menu :default-active="activeIndex2" class="el-menu-demo" mode="horizontal" @select="handleSelect"
      background-color="#409eff" text-color="#fff" active-text-color="#ffd04b">
      <el-row gutter="5">

        <el-col :span='2' offset='0'>

          <img src="../assets/电霸logo.png" alt="logo" width="100%" height="100%">

        </el-col>

        <el-col :span='7'>
          <br>
          <img src="../assets/logo1.png" alt="logo1" width="100%" height=100%>
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
            <el-menu-item index="2-1"><router-link to="/tumb">二轮车充电桩</router-link></el-menu-item>
            <el-menu-item index="2-2"><router-link to="/auto">汽车充电桩</router-link></el-menu-item>
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
              <el-button type="warning" size="mini" icon="el-icon-user" round></el-button>
            </router-link>
          </el-menu-item>
        </el-col>

      </el-row>
    </el-menu>

    <!-- 主页图片 -->
    <img src="../assets/zhuye.jpg" alt="" width="100%" height=550px>
    <br>
    <br>
    <el-carousel :interval="4000" type="card" height="275px">
      <el-carousel-item v-for="(item, index) in imgList" :key="index">
        <img :src="item.imgUrl" alt="图片" width="100%" height="100%">
        <h3 class="medium">{{ item }}</h3>
      </el-carousel-item>
    </el-carousel>





    <!-- 注册弹窗 -->
    <el-dialog title="注册" :visible.sync="dialogVisible2" width="30%" :before-close="handleClose">
      <span>
        <el-form ref="form" :model="zhuCeForm" label-width="80px">
          <!-- 确保注册时用户名不重复 -->
          <el-form-item label="用户名">
            <el-input v-model="zhuCeForm.userName" @input="checkUserName"></el-input>
            <p v-if="userNameError" class="error-message">用户名已存在，请重新输入</p>
          </el-form-item>
          <el-form-item label="手机号">
            <el-input v-model="zhuCeForm.phone" @input="checkPhone"></el-input>
            <p v-if="phoneError" class="error-message">手机号格式不正确，请重新输入</p>
          </el-form-item>

          <!--只有当两个密码一致时，才可以点击确定 
            并且密码不一致时，出现提示
            -->
          <el-form-item label="密码">
            
            <el-input v-model="zhuCeForm.password"></el-input>
          </el-form-item>
          <el-form-item label="确认密码">
            <el-input v-model="confirmPassword" @input="checkPasswords"></el-input>
            <p v-if="passwordError" class="error-message">密码不一致，请重新确认密码</p>
          </el-form-item>
        </el-form>
      </span>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible2 = false">取 消</el-button>
        <el-button :disabled="passwordError || userNameError" type="primary" @click="addUsers()">确 定</el-button>
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

<!--
       1、完整引入
       2、按需引入
  -->

<script>

import axios from 'axios'

//引入组件01Button.vue
//import MyButton from './components/Button-01.vue';
//import MyLayout from './components/Layout-02.vue';
// import MyTable from './components/Table-03.vue';

//import MyTable from './components/MyTable.vue';
//写入js代码
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
      confirmPassword: '',//确认密码
      dialogVisible2: false,//注册弹窗
      dialogVisible3: false,
      passwordError: false, // 用于控制注册时两次密码不一致的显示
      userNameError: false,//用于控制注册时用户名重复的显示
      phoneError: false,//用于控制注册时手机号格式错误的显示
      // 搜索框
      input: '',
      searchVisible: false,//搜索跳转

      imgList: [
        { imgUrl: require('../assets/p0.png') },
        { imgUrl: require('../assets/p1.png') },
        { imgUrl: require('../assets/p2.png') },
        { imgUrl: require('../assets/p3.png') },
        { imgUrl: require('../assets/p4.png') },

      ],


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
          this.$message({
            message: '注册成功',
            type: 'success'
          })
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
            //存储认证状态，用户信息到localStorage
            localStorage.setItem('roleId', res.data);
            localStorage.setItem('isAuthenticated', true);
            localStorage.setItem('userName', this.loginForm.userName);
            localStorage.setItem('password', this.loginForm.password);
            //根据姓名获取用户信息.存储到本地
            axios.get(`${process.env.VUE_APP_API_URL}/users/getByName`, {
              params: {
                userName: localStorage.getItem('userName')
              }
            }).then(res => {
              // console.log(res.data);
              // console.log(this.showForm);
              localStorage.setItem('userId',res.data[0].userId);
              localStorage.setItem('phone',res.data[0].phone);
              
            })
            this.$message({
            message: '登录成功',
            type: 'success'
          })
          } else {
            this.$message({
            message: '用户名或密码错误',
            type: 'error'
          })
            this.dialogVisible3 = true;
          }
        })
      this.dialogVisible3 = false;
    },
    checkPasswords() {
      // 每次密码输入时检查密码是否一致  
      if (this.zhuCeForm.password !== this.confirmPassword) {
        this.passwordError = true;
      } else {
        this.passwordError = false;
      }
      //打印两个密码
      // console.log(this.zhuCeForm.password, this.confirmPassword);
    },
    // 用户注册时用户名不得重复
    checkUserName() {
      // 发送请求到后端检查用户名是否重复  
      axios.post(`${process.env.VUE_APP_API_URL}/users/checkUserName`, this.zhuCeForm)
        .then(response => {
          // 如果用户名已存在，设置userNameError为true
          if (response.data) {
            this.userNameError = true;
          } else {
            this.userNameError = false;
          }
        })
    },
    checkPhone() {
      // 检查手机号格式,应为11位数字
      if (!/^1[3456789]\d{9}$/.test(this.zhuCeForm.phone)) {
        this.phoneError = true;
      } else {
        this.phoneError = false;
      }
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

轮播图-->el-carousel__item h3 {
  color: #475669;
  font-size: 14px;
  opacity: 0.75;
  line-height: 400px;
  margin: 0;
}

.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n+1) {
  background-color: #d3dce6;
}


.el-container {
  height: 1000px;
}

.el-main {
  background-color: #E9EEF3;
  color: #333;
  text-align: center;
  height: 1000px;
}

.el-aside {
  background-color: #D3DCE6;
  color: #333;
  text-align: center;
  line-height: 1000px;
}
.router-link-active {
  color:#333;
  text-decoration: none;
}
a {
  color: rgb(253, 251, 251);
  text-decoration: none;
}
.error-message {  
  color: red; /* 设置为红色文字 */  
  margin-top: 5px; /* 与输入框之间留点空间 */  
}
</style>